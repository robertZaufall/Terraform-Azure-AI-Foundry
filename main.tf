locals {
  resource_tags = {
    build   = var.build_number
    release = var.release_number
  }

  models_map = { for ca in var.models : ca.name => ca }

  cga_name       = var.cga_name
  default_region = var.default_region

  ai_regions = distinct([
    for ca in local.models_map : ca.region
  ])
}

resource "azurerm_resource_group" "rg" {
  name     = "x4u-ai"
  location = local.default_region
}


# foundry
resource "azurerm_cognitive_account" "cga" {
  for_each = toset(local.ai_regions)

  name                = each.value == local.default_region ? local.cga_name : "${local.cga_name}-${lower(replace(each.value, " ", ""))}"
  location            = each.value
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "AIServices"
  sku_name            = "S0"

  custom_subdomain_name         = each.value == local.default_region ? local.cga_name : "${local.cga_name}-${lower(replace(each.value, " ", ""))}"
  project_management_enabled    = true
  public_network_access_enabled = true
  tags                          = local.resource_tags

  network_acls {
    default_action = "Allow"
  }

  identity {
    type = "SystemAssigned"
  }
}


resource "azurerm_cognitive_account_project" "cap" {
  for_each = toset(local.ai_regions)

  name                 = each.value == local.default_region ? "${local.cga_name}-project" : "${local.cga_name}-${lower(replace(each.value, " ", ""))}-project"
  display_name         = each.value == local.default_region ? "${local.cga_name}-project" : "${local.cga_name}-${lower(replace(each.value, " ", ""))}-project"
  location             = each.value
  cognitive_account_id = azurerm_cognitive_account.cga[each.value].id
  tags                 = local.resource_tags

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_cognitive_deployment" "cgd" {
  for_each             = local.models_map
  name                 = each.value.model
  cognitive_account_id = azurerm_cognitive_account.cga[each.value.region].id
  depends_on           = [azurerm_cognitive_account_project.cap]

  model {
    format  = each.value.format
    name    = each.value.model
    version = each.value.version
  }

  sku {
    name     = each.value.sku_name
    capacity = tonumber(each.value.capacity)
  }
}
