# Deploy Azure AI Foundry models with Terraform

The goal is to deploy all desired models. Not all models are available in every region. The deployment is now simplified to a Cognitive Account, Cognitive Account Project, and Cognitive Deployments. A dedicated resource group is created once in the default region, and accounts/projects are created per model region.  

This project uses AzureRM provider `5.7.0` (latest verified on 2026-09-25), constrained to the `5.7.x` series. Terraform, Azure CLI, and access to the target subscription are required. AzureRM 5.x no longer registers Azure resource providers by default, so `provider.tf` explicitly registers `Microsoft.CognitiveServices` for the accounts, projects, and deployments used here.

![Azure Diagram](azure_diagram.png)  

Result (here: region East US 2):  

![Foundry Deployments](foundry_deployments.png)

## Anthropic

Native Anthropic consent is still unavailable in AzureRM `5.7.0` (checked on 2026-09-25). `azurerm_cognitive_deployment` does not expose `modelProviderData` or its organization, country, and industry attestation fields; [the provider support issue remains open](https://github.com/hashicorp/terraform-provider-azurerm/issues/31140).

For the current AzureRM-only configuration, complete the consent prompt in the Azure AI Foundry UI. After completing that manual deployment (and deleting the temporary model), Terraform deployments for Anthropic models succeed. Automated onboarding is available through AzAPI with `modelProviderData`; see [the proposed implementation in handover.md](handover.md) and [Microsoft's deployment guide](https://learn.microsoft.com/en-us/azure/developer/ai/how-to/deploy-claude-foundry).

![Anthropic](anthropic.png)  

Recommended workflow:
- Comment out the Anthropic models in `terraform.tfvars`.
- Deploy the project.
- Deploy one Anthropic model manually in the UI and answer the industry prompt.
- Delete the temporary manual model (after deployment shows up as succeeded).
- Uncomment the Anthropic models in `terraform.tfvars`.
- Deploy the project again.


## What gets created
- Resource group in the default region.
- Cognitive Account (`AIServices`) per model region, with project management enabled.
- Cognitive Account Project per Cognitive Account.
- Cognitive Deployment per model defined in `terraform.tfvars`, depending on the project.

## Configure and deploy

### Login
```bash
az login

# Login with a specific tenant ID
az login --tenant {tenant}

# Set the active subscription
az account set --subscription "{subscription}"
```

### Create Service Principal and write to file
```bash
# Create a service principal with the Owner role
az ad sp create-for-rbac --role="Owner" --scopes="/subscriptions/{subscription}" --sdk-auth > azure_credentials.json

# Alternatively, create a service principal with the Contributor role
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/{subscription}" --sdk-auth > azure_credentials.json
```

### Initialize Terraform and remote state (if applicable)
```bash
terraform init -backend-config="config.azurerm.tfbackend" -upgrade
```
- State is stored in a central/global (non-RG-specific) Azure Storage Account configured in `config.azurerm.tfbackend`. Adjust that file to match your shared Storage Account and container.
- For simple local state, remove the `-backend-config="config.azurerm.tfbackend"` flag and re-run `terraform init` (optionally after `rm -rf .terraform`) so state stays in the workspace.

### Configure variables
Set model definitions, regions, and names in `terraform.tfvars` before planning/applying.

### Plan and apply
```bash
terraform plan
terraform apply -auto-approve
```

### Get the Cognitive Services endpoints and access keys
```bash
terraform output endpoint
terraform output primary_access_key
```

## Common Terraform commands
```bash
terraform init
terraform init -backend-config="config.azurerm.tfbackend" -upgrade
terraform validate
terraform plan
terraform apply -auto-approve
terraform destroy
terraform show
terraform state list
terraform state
terraform output <output_definition>
```

## Troubleshooting
``` powershell
# get soft deleted cognitive services accounts
az rest --method get --url "https://management.azure.com/subscriptions/a0fe57e5-df87-4e20-875a-9958172c30b1/providers/Microsoft.CognitiveServices/deletedAccounts?api-version=2021-04-30"

# from the cloud console
Get-AzResource -ResourceId /subscriptions/{subscription}/providers/Microsoft.CognitiveServices/deletedAccounts -ApiVersion 2021-04-30

# delete selective instances
az resource delete --ids ...
```

## Models
Check model avilabilities and format names (!):
```
az cognitiveservices account list-models -g x4u-ai -n x4uai  --query "[?contains(name, 'opus')]"
```

[Model availability and regions](https://learn.microsoft.com/en-us/azure/ai-foundry/openai/concepts/models?tabs=global-standard%2Cstandard-chat-completions)
