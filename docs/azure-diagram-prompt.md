# Architecture diagram image prompts

Generated with the built-in imagegen tool. Final asset: `../azure_diagram_dark.png`.

## Initial generation

Use case: infographic-diagram.
Asset type: replacement architecture diagram for a technical GitHub README.
Create a polished, precise, professional DARK MODE Azure AI Foundry + Terraform architecture diagram. Wide landscape 2560x1440, crisp legible typography, generous spacing. Flat technical diagram, no photographic or 3D elements. Deep charcoal/navy background #0d1117, slightly lighter panels #161b22, restrained cool blue and violet accents, high contrast off-white labels, muted blue-gray secondary text. Fine borders, clean right-angle connectors, modest rounded corners, careful alignment. Dark mode everywhere, no white panels. Minimal modern Azure-inspired line icons; avoid ornamental glow, gradients, tiny text, clutter, excessive legends or marketing copy.

Title at top left: "Azure AI Foundry"
Small subtitle: "Terraform architecture"

Architecture is derived from actual repository code and must be accurate:
Terraform creates ONE resource group. Within that group there is ONE AI Services account PER configured region and ONE Foundry project PER account. Model deployments are children of the ACCOUNT, not children of the project. Terraform waits for project creation before creating deployments. Accounts and projects use system-assigned managed identity. Account kind AIServices and SKU S0. Deployment configuration includes model, version, SKU, capacity. State storage is an existing shared Azure Storage backend OUTSIDE this managed resource group.

Composition:
Left vertical rail occupying roughly 22% width: top card with Terraform icon, heading "Terraform", and three short stacked labels "Model definitions", "Regions & capacity", "AzureRM provider". Beneath it a small separate card with storage icon, heading "Shared Azure Storage", subtitle "Terraform state". Connect Terraform to this storage with a thin bidirectional connector labeled "State". This storage MUST remain outside the resource group.
Right main area roughly 72% width: one large rounded outline container heading "Azure resource group". A single blue arrow from Terraform to this outer container labeled "Provision".
Inside the resource group: TWO stacked horizontal region panels, matching geometry.
Upper region label "Default region · East US 2".
Lower region label "Additional regions · as configured". Visually slightly subdued to indicate repeatable optional topology.
Inside EACH region panel, show a large clearly bounded container labeled "AI Services account", with small metadata text "AIServices · S0 · Managed identity".
Inside EACH account container, arrange TWO sibling cards horizontally:
  Left smaller card: "Foundry project", secondary line "Managed identity".
  Right wider card: "Model deployments", secondary line "Model · Version · SKU · Capacity", then two compact pill labels "Global" and "Data Zone".
A thin dashed arrow from the project card to the deployment card labeled "Created after project" communicates Terraform creation dependency only. Both sibling cards are visibly INSIDE the account container.
Do not draw deployments nested inside the project. No connection between regions. No separate resource group for each region. No subscription IDs, tenant IDs, account secrets, model lists, URLs, or private resource names.
The only text should be the short exact labels specified above. Ensure every label is correctly spelled and fits comfortably. All lines must terminate neatly without crossing labels. This should feel like a carefully art-directed documentation diagram with information hierarchy and outstanding readability, not a screenshot or a dashboard.

## Background correction

Edit this architecture diagram. Preserve all wording, icons, panel geometry, arrows, layout, and information exactly. Fix only the background and edge rendering: the ENTIRE canvas must have a uniform, fully OPAQUE solid dark charcoal background #0d1117, including all gaps, the area behind the title and subtitle, the outer margins, and between the Terraform and resource group cards. Remove the bright smoky halo and all mottled/colored noise around title and connectors. Text must remain crisp off-white, subtitle muted blue-gray. Clean antialiased edges. No transparency anywhere, no alpha cutouts, no glow, no white or pale patches. Preserve the dark panels and blue accents. Add a little comfortable solid dark margin around the whole diagram if necessary so the title does not touch the canvas edge. Professional flat dark-mode technical documentation graphic.
