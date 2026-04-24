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
    name     = "model-router"
    model    = "model-router"
    version  = "2025-11-18"
    capacity = "10"
  },
  {
    name     = "gpt-5.4"
    model    = "gpt-5.4"
    version  = "2026-03-05"
    capacity = "100"
  },
  {
    name     = "gpt-5.4-mini"
    model    = "gpt-5.4-mini"
    version  = "2026-03-17"
    capacity = "100"
  },
  {
    name     = "gpt-5.4-nano"
    model    = "gpt-5.4-nano"
    version  = "2026-03-17"
    capacity = "100"
  },
  {
    name     = "gpt-5.3-codex"
    model    = "gpt-5.3-codex"
    version  = "2026-02-24"
    capacity = "100"
  },
  {
    name     = "gpt-5.2"
    model    = "gpt-5.2"
    version  = "2025-12-11"
    capacity = "100"
  },
  {
    name     = "gpt-5.1"
    model    = "gpt-5.1"
    version  = "2025-11-13"
    capacity = "100"
  },
  {
    name     = "gpt-5.1-codex-mini"
    model    = "gpt-5.1-codex-mini"
    version  = "2025-11-13"
    capacity = "100"
  },
  {
    name     = "gpt-5.1-codex"
    model    = "gpt-5.1-codex"
    version  = "2025-11-13"
    capacity = "100"
  },
  {
    name     = "o4-mini"
    model    = "o4-mini"
    version  = "2025-04-16"
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
    name     = "grok-4-fast-non-reasoning"
    model    = "grok-4-fast-non-reasoning"
    format   = "xAI"
    capacity = "100"
  },
  {
    name     = "grok-4-fast-reasoning"
    model    = "grok-4-fast-reasoning"
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
    name     = "Kimi-K2.6"
    model    = "Kimi-K2.6"
    version  = "2026-04-20"
    format   = "MoonshotAI"
    capacity = "100"
  },
  {
    name     = "DeepSeek-V3.2"
    model    = "DeepSeek-V3.2"
    format   = "DeepSeek"
    capacity = "1"
  },
  {
    name     = "Mistral-Large-3"
    model    = "Mistral-Large-3"
    format   = "Mistral AI"
    capacity = "1"
  },
  {
    name     = "whisper"
    model    = "whisper"
    version  = "001"
    capacity = "1"
    sku_name = "Standard"
  },
  {
    name     = "FLUX.2-pro"
    model    = "FLUX.2-pro"
    format   = "Black Forest Labs"
    capacity = "1"
  },
  {
    name     = "FLUX.1-Kontext-pro"
    model    = "FLUX.1-Kontext-pro"
    format   = "Black Forest Labs"
    capacity = "1"
  },
  {
    name     = "FLUX-1.1-pro"
    model    = "FLUX-1.1-pro"
    format   = "Black Forest Labs"
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
    name     = "sora-2"
    model    = "sora-2"
    version  = "2025-10-06"
    capacity = "10"
  },
  # quota error (???)
  # {
  #   name     = "claude-opus-4-6"
  #   model    = "claude-opus-4-6"
  #   version  = "1"
  #   format   = "Anthropic"
  #   capacity = "1"
  # },
  {
    name     = "claude-opus-4-5"
    model    = "claude-opus-4-5"
    version  = "20251101"
    format   = "Anthropic"
    capacity = "100"
  },
  {
    name     = "claude-sonnet-4-5"
    model    = "claude-sonnet-4-5"
    version  = "20250929"
    format   = "Anthropic"
    capacity = "100"
  },
  {
    name     = "claude-haiku-4-5"
    model    = "claude-haiku-4-5"
    version  = "20251001"
    format   = "Anthropic"
    capacity = "100"
  }
]
