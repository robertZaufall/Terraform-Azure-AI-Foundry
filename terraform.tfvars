build_number   = "1.0"
release_number = "1"

cga_name       = "x4uai"
default_region = "East US 2"

models = [
  {
    name     = "gpt-oss-120b"
    model    = "gpt-oss-120b"
    format   = "OpenAI-OSS"
    capacity = "100"
  },
  {
    name     = "gpt-6-astra"
    model    = "gpt-6-astra"
    version  = "2026-09-03"
    capacity = "100"
  },
  {
    name     = "gpt-6-sol"
    model    = "gpt-6-sol"
    version  = "2026-09-22"
    capacity = "100"
  },
  {
    name     = "gpt-6-luna"
    model    = "gpt-6-luna"
    version  = "2026-09-22"
    capacity = "100"
  },
  {
    name     = "grok-4.6"
    model    = "grok-4.6"
    format   = "xAI"
    capacity = "100"
  },
  {
    name     = "grok-4-20-non-reasoning"
    model    = "grok-4-20-non-reasoning"
    format   = "xAI"
    capacity = "100"
  },
  {
    name     = "grok-4-20-reasoning"
    model    = "grok-4-20-reasoning"
    format   = "xAI"
    capacity = "100"
  },
  {
    name     = "Llama-3.3-70B-Instruct"
    model    = "Llama-3.3-70B-Instruct"
    format   = "Meta"
    version  = "5"
    capacity = "1"
  },
  {
    name     = "Kimi-K2.7-Code"
    model    = "Kimi-K2.7-Code"
    version  = "2026-06-12"
    format   = "MoonshotAI"
    capacity = "100"
  },
  {
    name     = "Kimi-K2.6"
    model    = "Kimi-K2.6"
    version  = "2026-04-20"
    format   = "MoonshotAI"
    capacity = "100"
  },
  {
    name     = "DeepSeek-V4.1-Flash"
    model    = "DeepSeek-V4.1-Flash"
    version  = "2026-09-10"
    format   = "DeepSeek"
    capacity = "1"
  },
  {
    name     = "DeepSeek-V4-Pro"
    model    = "DeepSeek-V4-Pro"
    version  = "2026-04-23"
    format   = "DeepSeek"
    capacity = "1"
  },
  {
    name     = "mistral-medium-3-5"
    model    = "mistral-medium-3-5"
    format   = "Mistral AI"
    capacity = "1"
  },
  {
    name     = "Mistral-Large-3"
    model    = "Mistral-Large-3"
    format   = "Mistral AI"
    capacity = "1"
  },
  {
    name     = "FLUX.2-flex"
    model    = "FLUX.2-flex"
    format   = "Black Forest Labs"
    capacity = "1"
  },
  {
    name     = "FLUX.2-pro"
    model    = "FLUX.2-pro"
    format   = "Black Forest Labs"
    capacity = "1"
  },
  {
    name     = "gpt-image-2.5-flare"
    model    = "gpt-image-2.5-flare"
    version  = "2026-09-08"
    capacity = "1"
  },
  {
    name     = "gpt-image-2.5-sunburst"
    model    = "gpt-image-2.5-sunburst"
    version  = "2026-09-08"
    capacity = "1"
  },
  {
    name     = "gpt-image-2"
    model    = "gpt-image-2"
    version  = "2026-04-21"
    capacity = "1"
  },
  {
    name     = "gpt-image-1.5"
    model    = "gpt-image-1.5"
    version  = "2025-12-16"
    capacity = "1"
  },
  {
    name     = "gpt-image-1-mini"
    model    = "gpt-image-1-mini"
    version  = "2025-10-06"
    capacity = "1"
  },
  {
    name     = "gpt-live-1"
    model    = "gpt-live-1"
    version  = "2026-09-10"
    capacity = "1"
  },
  {
    name     = "gpt-realtime-2.1"
    model    = "gpt-realtime-2.1"
    version  = "2026-07-07"
    capacity = "1"
  },
  {
    name     = "gpt-realtime-2.1-mini"
    model    = "gpt-realtime-2.1-mini"
    version  = "2026-07-07"
    capacity = "1"
  },
  {
    name     = "gpt-audio-1.5"
    model    = "gpt-audio-1.5"
    version  = "2026-02-23"
    capacity = "1"
  },
  {
    name     = "gpt-4o-mini-tts"
    model    = "gpt-4o-mini-tts"
    version  = "2025-12-15"
    capacity = "1"
  },
  {
    name     = "gpt-transcribe"
    model    = "gpt-transcribe"
    version  = "2026-07-28"
    capacity = "1"
  },
  {
    name     = "claude-opus-5-5"
    model    = "claude-opus-5-5"
    version  = "2"
    format   = "Anthropic"
    capacity = "10"
  },
  {
    name     = "claude-sonnet-5"
    model    = "claude-sonnet-5"
    version  = "2"
    format   = "Anthropic"
    capacity = "10"
  },
  {
    name     = "claude-haiku-4-5"
    model    = "claude-haiku-4-5"
    version  = "20251001"
    format   = "Anthropic"
    capacity = "10"
  },
  {
    name     = "FW-DeepSeek-V4.1-Flash"
    model    = "FW-DeepSeek-V4.1-Flash"
    format   = "Fireworks"
    capacity = "1"
    sku_name = "GlobalStandard"
  },
  {
    name     = "FW-GLM-5.3-Flash"
    model    = "FW-GLM-5.3-Flash"
    format   = "Fireworks"
    capacity = "1"
    sku_name = "GlobalStandard"
  },
  {
    name     = "FW-GLM-5.3"
    model    = "FW-GLM-5.3"
    format   = "Fireworks"
    capacity = "1"
    sku_name = "DataZoneStandard"
  },
  {
    name     = "FW-Kimi-K3"
    model    = "FW-Kimi-K3"
    format   = "Fireworks"
    capacity = "1"
    sku_name = "DataZoneStandard"
  },
  {
    name     = "FW-MiniMax-M3"
    model    = "FW-MiniMax-M3"
    format   = "Fireworks"
    capacity = "1"
    sku_name = "DataZoneStandard"
  },
  {
    name     = "MAI-Image-2.6-Flash"
    model    = "MAI-Image-2.6-Flash"
    version  = "2026-07-31"
    format   = "Microsoft"
    capacity = "1"
    region   = "East US"
  },
  {
    name     = "MAI-Image-2.6"
    model    = "MAI-Image-2.6"
    version  = "2026-07-31"
    format   = "Microsoft"
    capacity = "1"
    region   = "East US"
  }
]
