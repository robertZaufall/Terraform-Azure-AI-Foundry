# Azure AI Foundry with Terraform

Deploy chat, coding, image, and audio models to Azure AI Foundry from a single Terraform configuration. Choose each model’s version, region, deployment type, and capacity in `terraform.tfvars`.

Terraform creates one resource group, an AI Services account and Foundry project for each configured region, and the model deployments within those accounts. State lives in a shared Azure Storage backend.

![Azure AI Foundry architecture in dark mode](azure_diagram_dark.png)

## Deployed models and pricing

**2026-09-25 · 35 deployments · East US 2 · USD per 1M tokens unless stated otherwise.**

Strongest first (approximate). `—` = unavailable/not applicable; MP = megapixel.

### Chat / multipurpose / code (22 models)

#### OpenAI

| Deployed model | Focus | Version | Type | Retirement | Input | Cached input | Output / other | Source |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `gpt-6-astra` | reasoning/code | `2026-09-03` | Global | 2028-01-11 | Short: $10; long: $20 | Short: $1; long: $2 | Short: $50; long: $75 | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20OpenAI%20GPT6%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |
| `gpt-6-sol` | multipurpose/code | `2026-09-22` | Global | 2028-03-11 | Short: $2; long: $4 | Short: $0.20; long: $0.40 | Short: $10; long: $15 | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20OpenAI%20GPT6%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |
| `gpt-6-luna` | economy | `2026-09-22` | Global | 2028-03-11 | Short: $0.10; long: $0.20 | Short: $0.01; long: $0.02 | Short: $0.50; long: $0.75 | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20OpenAI%20GPT6%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |
| `gpt-oss-120b` | older reasoning | `1` | Global | 2099-12-31 | $0.15 | — | $0.60 | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20OpenAI%20OSS%20Models%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |

#### Anthropic

| Deployed model | Focus | Version | Type | Retirement | Input | Cached input | Output / other | Source |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `claude-opus-5-5` | reasoning/code | `2` | Global | 2027-09-18 | $4 | $0.20 | $20 | [Claude](https://platform.claude.com/docs/en/about-claude/pricing) |
| `claude-sonnet-5` | chat/code | `2` | Global | 2027-06-30 | $2 | $0.20 | $10 | [Claude](https://platform.claude.com/docs/en/about-claude/pricing) |
| `claude-haiku-4-5` | economy | `20251001` | Global | 2026-11-15 | $1 | $0.10 | $5 | [Claude](https://platform.claude.com/docs/en/about-claude/pricing) |

#### Z.ai

| Deployed model | Focus | Version | Type | Retirement | Input | Cached input | Output / other | Source |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `FW-GLM-5.3` | reasoning/code | `1` | Data Zone | 2027-09-01 | $2.10 | $0.39 | $6.60 | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20Fireworks%20Models%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |
| `FW-GLM-5.3-Flash` | economy | `1` | Global | 2027-09-13 | $0.188 | $0.038 | $0.625 | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20Fireworks%20Models%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |

#### xAI

| Deployed model | Focus | Version | Type | Retirement | Input | Cached input | Output / other | Source |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `grok-4.6` | multipurpose | `1` | Global | 2027-08-24 | Base: $2; long: $4 | Base: $0.50; long: $1 | Base: $6; long: $12 | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20Grok%20Models%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |
| `grok-4-20-reasoning` | older reasoning | `1` | Global | 2027-04-06 | $1.25 | — | $2.50 | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20Grok%20Models%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |
| `grok-4-20-non-reasoning` | older chat | `1` | Global | 2027-04-06 | $1.25 | — | $2.50 | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20Grok%20Models%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |

#### Moonshot AI

| Deployed model | Focus | Version | Type | Retirement | Input | Cached input | Output / other | Source |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `FW-Kimi-K3` | reasoning/code | `1` | Data Zone | 2027-07-27 | $3.30 | $0.33 | $16.50 | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20Fireworks%20Models%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |
| `Kimi-K2.7-Code` | code specialist | `2026-06-12` | Global | 2026-10-03 | $0.95 | $0.19 | $4 | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20Kimi%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |
| `Kimi-K2.6` | older reasoning | `2026-04-20` | Global | 2027-04-16 | $0.95 | $0.16 | $4 | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20Kimi%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |

#### DeepSeek

| Deployed model | Focus | Version | Type | Retirement | Input | Cached input | Output / other | Source |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `DeepSeek-V4.1-Flash` | reasoning/code | `2026-09-10` | Global | 2026-12-15 | — | — | — | [Catalog](https://ai.azure.com/catalog/models/DeepSeek-V4.1-Flash?publisher=DeepSeek) |
| `FW-DeepSeek-V4.1-Flash` | reasoning/code | `1` | Global | 2027-09-15 | $0.375 | $0.008 | $1.50 | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20Fireworks%20Models%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |
| `DeepSeek-V4-Pro` | older reasoning | `2026-04-23` | Global | 2028-02-20 | $1.74 | $0.145 | $3.48 | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20Deepseek%20Models%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |

#### MiniMax

| Deployed model | Focus | Version | Type | Retirement | Input | Cached input | Output / other | Source |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `FW-MiniMax-M3` | economy/code | `1` | Data Zone | 2027-08-01 | $0.33 | $0.066 | $1.32 | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20Fireworks%20Models%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |

#### Mistral AI

| Deployed model | Focus | Version | Type | Retirement | Input | Cached input | Output / other | Source |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `mistral-medium-3-5` | general chat/code | `1` | Global | 2027-10-01 | $1.50 | — | $7.50 | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20Mistral%20Models%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |
| `Mistral-Large-3` | general chat | `1` | Global | 2099-12-31 | $0.50 | — | $1.50 | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20Mistral%20Models%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |

#### Meta

| Deployed model | Focus | Version | Type | Retirement | Input | Cached input | Output / other | Source |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `Llama-3.3-70B-Instruct` | older chat | `5` | Global | 2099-12-31 | $0.71 | — | $0.71 | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20Llama%20Models%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |

### Image generation (7 models)

#### OpenAI

| Deployed model | Focus | Version | Type | Retirement | Input | Cached input | Output / other | Source |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `gpt-image-2.5-sunburst` | quality/editing | `2026-09-08` | Global | 2027-09-08 | Text: $5; image: $8 | Text: $1.25; image: $2 | Image: $30 | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20OpenAI%20Media%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |
| `gpt-image-2.5-flare` | speed | `2026-09-08` | Global | 2027-09-08 | Text: $5; image: $8 | Text: $1.25; image: $2 | Image: $30 | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20OpenAI%20Media%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |
| `gpt-image-2` | previous generation | `2026-04-21` | Global | 2027-10-21 | Text: $5; image: $8 | Text: $1.25; image: $2 | Image: $30 | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20OpenAI%20Media%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |
| `gpt-image-1.5` | older generation | `2025-12-16` | Global | 2026-12-16 | Text: $5; image: $8 | Text: $1.25; image: $2 | Image: $32; text: $10 | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20OpenAI%20Media%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |
| `gpt-image-1-mini` | economy | `2025-10-06` | Global | 2027-04-07 | Text: $2; image: $2.50 | Text: $0.20; image: $0.25 | Image: $8 | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20OpenAI%20Media%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |

#### Black Forest Labs

| Deployed model | Focus | Version | Type | Retirement | Input | Cached input | Output / other | Source |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `FLUX.2-pro` | image specialist | `1` | Global | 2099-12-31 | Reference image: $0.015/MP | — | First output MP: $0.03; each additional MP: $0.015 | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20BFL%20Flux%20Models%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |
| `FLUX.2-flex` | image specialist | `1` | Global | 2099-12-31 | Reference image: $0.05/MP | — | $0.05/MP | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20BFL%20Flux%20Models%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |

### Audio (6 models)

#### OpenAI

| Deployed model | Focus | Version | Type | Retirement | Input | Cached input | Output / other | Source |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| `gpt-live-1` | natural voice interaction | `2026-09-10` | Global | 2027-09-10 | — | — | $3/hour (Azure `Live 1 Gl Unit`) | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20OpenAI%20Media%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |
| `gpt-realtime-2.1` | voice reasoning/tools | `2026-07-07` | Global | 2027-07-31 | Text: $4; audio: $32; image: $5 | Text: $0.40; audio: $0.40; image: $0.50 | Text: $24; audio: $64 | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20OpenAI%20Media%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |
| `gpt-audio-1.5` | audio chat | `2026-02-23` | Global | 2027-08-24 | Text: $2.50; audio: $32 | — | Text: $10; audio: $64 | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20OpenAI%20Media%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |
| `gpt-realtime-2.1-mini` | economy voice | `2026-07-07` | Global | 2027-07-31 | Text: $0.60; audio: $10; image: $0.80 | Text: $0.06; audio: $0.30; image: $0.08 | Text: $2.40; audio: $20 | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20OpenAI%20Media%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |
| `gpt-transcribe` | speech to text | `2026-07-28` | Global | 2028-02-01 | — | — | $0.27/hour (Azure `gpt-transcribe Gl Unit`) | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20OpenAI%20Media%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |
| `gpt-4o-mini-tts` | text to speech | `2025-12-15` | Global | 2027-06-15 | Text: $0.60 | — | Audio: $12 | [Azure](https://prices.azure.com/api/retail/prices?currencyCode=USD&%24filter=serviceName%20eq%20%27Foundry%20Models%27%20and%20productName%20eq%20%27Azure%20OpenAI%20Media%27%20and%20armRegionName%20eq%20%27eastus2%27%20and%20priceType%20eq%20%27Consumption%27) |

These figures are approximate and may be incomplete; accuracy is not guaranteed.

## Deploy

You need Terraform, Azure CLI, an Azure subscription with model access and quota, and an existing Azure Storage account and container for state. The configuration uses AzureRM `5.7.x` and registers `Microsoft.CognitiveServices` through the provider.

### 1. Set up credentials

Sign in and select the subscription:

```bash
az login
az account set --subscription "<subscription-id>"
```

The provider reads `clientId`, `clientSecret`, `subscriptionId`, and `tenantId` from `azure_credentials.json`. To create a service principal with Contributor access:

```bash
az ad sp create-for-rbac \
  --name "foundry-terraform" \
  --role Contributor \
  --scopes "/subscriptions/<subscription-id>" \
  --json-auth > azure_credentials.json
```

`azure_credentials.json` and the backend configuration are excluded from Git.

### 2. Configure state

For a new checkout, copy the backend template:

```bash
cp config.azurerm.empty.tfbackend config.azurerm.tfbackend
```

Fill in the storage resource group, account, container, access key, and a state-file key unique to this deployment. The storage account is shared infrastructure and is not created by this configuration.

### 3. Choose models and regions

Edit `terraform.tfvars`. Each entry defines a model deployment; for example:

```hcl
{
  name     = "gpt-6-astra"
  model    = "gpt-6-astra"
  version  = "2026-09-03"
  format   = "OpenAI"
  region   = "East US 2"
  sku_name = "GlobalStandard"
  capacity = "100"
}
```

Use the publisher’s exact model name, format, and version. Choose `GlobalStandard` or `DataZoneStandard` where supported, and set capacity within the model’s regional quota. `name` is the unique Terraform entry key; `model` also becomes the Azure deployment name.

`cga_name` controls the account-name prefix. Accounts outside `default_region` receive a region suffix. The resource group name is set in `main.tf`.

### 4. Plan and apply

```bash
terraform init -backend-config="config.azurerm.tfbackend"
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
```

For a first Claude deployment, complete the consent setup below before applying the full model list.

### 5. Retrieve endpoints and keys

Both outputs are maps keyed by region:

```bash
terraform output -json ai_services_endpoint
terraform output -json ai_services_primary_access_key
```

The second command prints the access keys.

## Claude consent

This configuration uses a manual Foundry consent step for Anthropic models. On a new setup:

1. Temporarily omit the Anthropic entries from `terraform.tfvars` and deploy the accounts and projects.
2. Deploy one Claude model in [Microsoft Foundry](https://ai.azure.com/), completing the organization, country, industry, and terms prompts.
3. Once the temporary deployment succeeds, delete it in Foundry.
4. Restore the Anthropic entries, create a new Terraform plan, and apply it.

![Anthropic consent setup](anthropic.png)

[handover.md](handover.md) documents the AzureRM `5.7.0` consent limitation checked on 2026-09-25 and a proposed AzAPI implementation. See also [Microsoft’s Claude deployment guide](https://learn.microsoft.com/en-us/azure/developer/ai/how-to/deploy-claude-foundry).

## Update deployments

Change the model entries in `terraform.tfvars`, then run `terraform plan -out=tfplan` and `terraform apply tfplan` again. Review replacements and removals in the plan, especially when changing entry keys, deployment names, or regions.

To inspect the models available to an account:

```bash
az cognitiveservices account list-models \
  --resource-group "<resource-group>" \
  --name "<account-name>" \
  --query "[?contains(name, 'opus')]"
```

Availability depends on the model, version, deployment type, and region. Consult the [model availability documentation](https://learn.microsoft.com/en-us/azure/ai-foundry/openai/concepts/models?tabs=global-standard%2Cstandard-chat-completions) and the account’s quota before adding a deployment. Refresh the inventory above using the instructions in [AGENTS.md](AGENTS.md).

## Troubleshooting

**Account name still reserved after deletion:** list soft-deleted accounts in the selected subscription:

```bash
az cognitiveservices account list-deleted --output table
```

**Use local state:** remove the `backend "azurerm"` block from `provider.tf` before initializing a new local setup. To move an existing deployment’s state, remove that block and run `terraform init -migrate-state`.

**Inspect managed resources:**

```bash
terraform state list
terraform show
```

To remove the infrastructure managed by this configuration, run `terraform destroy`. The shared backend storage remains separate.
