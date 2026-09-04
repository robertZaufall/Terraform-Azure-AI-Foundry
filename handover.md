# Handover: Terraform deployment of Azure-hosted Claude models

## Status

This document records a proposed change for later evaluation. No Terraform implementation has been made as part of this handover.

The current configuration uses `azurerm_cognitive_deployment` for every model. That resource can set the model name, format, version, SKU, and capacity, but it does not currently expose the `modelProviderData` required for automated Claude Marketplace onboarding.

The existing manual workaround in `README.md` is therefore valid: deploy one Claude model in the Foundry UI, accept the Marketplace terms, select the industry, wait for the deployment to succeed, delete the temporary deployment, and then run Terraform. This is a one-time subscription/onboarding bootstrap rather than a property of the model format.

## Required Claude values

For `claude-opus-5` hosted end-to-end on Azure, retain:

```hcl
format  = "Anthropic"
version = "2"
```

`format = "Anthropic"` identifies the publisher/API family. It does not mean that version 2 runs on Anthropic infrastructure.

- Version `2`: hosted on Azure infrastructure.
- Version `1`: hosted on Anthropic infrastructure.
- `GlobalStandard` supports Azure-hosted version 2.
- `DataZoneStandard` can be considered when its US data-zone boundary is required and the live catalog shows it as available.

## Proposed fully automated approach

Use `azapi_resource` only for Anthropic/Claude deployments. Continue using `azurerm_cognitive_deployment` for all other models.

Microsoft's current official Claude starter kit uses this approach because the AzureRM resource does not expose `modelProviderData`. The proposed REST resource type is:

```text
Microsoft.CognitiveServices/accounts/deployments@2025-10-01-preview
```

### 1. Add the AzAPI provider

Extend `required_providers` in `provider.tf`:

```hcl
azapi = {
  source  = "azure/azapi"
  version = ">= 2.0"
}
```

Configure it with the same subscription used by AzureRM:

```hcl
provider "azapi" {
  subscription_id = local.azure_creds.subscriptionId
  client_id       = local.azure_creds.clientId
  client_secret   = local.azure_creds.clientSecret
  tenant_id       = local.azure_creds.tenantId
}
```

The exact provider constraint should be reviewed against the lock file and current provider releases before implementation.

### 2. Add attestation inputs

Add variables for the real organization using Claude:

```hcl
variable "claude_organization_name" {
  description = "Legal entity name used for Claude Marketplace attestation."
  type        = string
}

variable "claude_country_code" {
  description = "Two-letter ISO country code used for Claude Marketplace attestation."
  type        = string

  validation {
    condition     = length(var.claude_country_code) == 2
    error_message = "claude_country_code must be a two-letter ISO country code."
  }
}

variable "claude_industry" {
  description = "Lowercase industry value from the current Foundry consent dialog."
  type        = string

  validation {
    condition = contains([
      "technology",
      "finance",
      "healthcare",
      "education",
      "retail",
      "manufacturing",
      "government",
      "media",
      "consulting",
      "other",
    ], var.claude_industry)
    error_message = "claude_industry must match a lowercase value offered by the current Foundry consent dialog."
  }
}
```

The live Foundry UI currently includes `consulting`; therefore `consulting` must be accepted even though Microsoft's static starter-kit documentation still shows an older list. The portal/Marketplace metadata should be rechecked before implementation because its options can change independently of the sample.

Do not invent or silently default the organization attestation. Set values explicitly in a protected `.tfvars` input or CI variable source, for example:

```hcl
claude_organization_name = "<legal entity name>"
claude_country_code      = "DE"
claude_industry          = "consulting"
```

### 3. Split Claude and non-Claude deployment maps

Prevent the same Claude deployment from being managed by both providers:

```hcl
locals {
  anthropic_models = {
    for key, model in local.models_map : key => model
    if model.format == "Anthropic"
  }

  non_anthropic_models = {
    for key, model in local.models_map : key => model
    if model.format != "Anthropic"
  }
}
```

Change the existing deployment resource to:

```hcl
resource "azurerm_cognitive_deployment" "cgd" {
  for_each = local.non_anthropic_models

  # Existing resource body remains unchanged.
}
```

### 4. Create Claude deployments through AzAPI

Proposed resource:

```hcl
resource "azapi_resource" "anthropic_deployment" {
  for_each = local.anthropic_models

  type                      = "Microsoft.CognitiveServices/accounts/deployments@2025-10-01-preview"
  name                      = each.value.model
  parent_id                 = azurerm_cognitive_account.cga[each.value.region].id
  schema_validation_enabled = false

  body = {
    sku = {
      name     = each.value.sku_name
      capacity = tonumber(each.value.capacity)
    }

    properties = {
      model = {
        format  = each.value.format
        name    = each.value.model
        version = each.value.version
      }

      modelProviderData = {
        organizationName = var.claude_organization_name
        countryCode      = var.claude_country_code
        industry         = var.claude_industry
      }

      versionUpgradeOption = "OnceNewDefaultVersionAvailable"
      raiPolicyName        = "Microsoft.DefaultV2"
    }
  }

  depends_on = [azurerm_cognitive_account_project.cap]
}
```

Confirm whether `versionUpgradeOption` and `raiPolicyName` should be fixed as above or exposed as model inputs before adopting the proposal.

## Consent and legal effect

The `modelProviderData` values are not ordinary descriptive tags. Azure's Cognitive Services resource provider uses them to subscribe to the Anthropic Marketplace offer and accept its terms on behalf of the deploying subscription. Applying this resource therefore has the same consent significance as selecting **Agree and proceed** in the portal.

Before applying:

1. Review the live Marketplace terms for the selected Claude offer.
2. Confirm that the deployer is authorized to accept those terms.
3. Supply the real legal organization name, two-letter country code, and current lowercase industry value.
4. Confirm the identity has the required Marketplace agreement and SaaS registration permissions.

Explicitly accepting an offer with `az term accept` is not a substitute for `modelProviderData` when the Claude deployment API requires the three attestation fields.

## State-migration concern

Changing a deployment from `azurerm_cognitive_deployment.cgd[<key>]` to `azapi_resource.anthropic_deployment[<key>]` changes its Terraform resource address and provider type.

Before applying, inspect both Azure and Terraform state:

```bash
terraform state list
terraform plan
az cognitiveservices account deployment list \
  --resource-group x4u-ai \
  --name x4uai \
  --output table
```

If a Claude deployment already exists and is managed in state, evaluate an import/state-migration procedure rather than allowing Terraform to delete and recreate it. Do not use a blind `terraform state mv` across different resource types without verifying provider compatibility; importing the existing ARM resource into the AzAPI resource may be safer.

## Evaluation checklist

1. Recheck the live catalog entry for each requested Claude model, version, SKU, and region.
2. Verify that `claude-opus-5` version `2` is selected for Azure-hosted execution.
3. Verify the current UI machine value for Consulting remains lowercase `consulting`.
4. Check current AzureRM release notes for native `modelProviderData` support. Prefer the native resource if support has landed by implementation time.
5. Review the preview API version and the latest official Azure sample before adopting it.
6. Decide how organization, country, and industry values will be supplied without committing inappropriate organizational data.
7. Ensure Claude entries are excluded from the AzureRM `for_each` before adding the AzAPI resource.
8. Review the plan carefully for unintended replacement of existing accounts, projects, or model deployments.
9. Run:

   ```bash
   terraform fmt -check
   terraform init -upgrade
   terraform validate
   terraform plan
   ```

10. After an authorized apply, verify the deployment reports `Succeeded`, version `2`, the intended SKU, and a working inference request through the Foundry endpoint.

## References

- Microsoft Learn: <https://learn.microsoft.com/en-us/azure/developer/ai/how-to/deploy-claude-foundry>
- Microsoft Learn, Claude deployment: <https://learn.microsoft.com/en-us/azure/foundry/foundry-models/how-to/use-foundry-models-claude>
- Microsoft official Claude starter kit: <https://github.com/Azure-Samples/claude>
- AzureRM provider tracking issue referenced by the official sample: <https://github.com/hashicorp/terraform-provider-azurerm/issues/31140>
