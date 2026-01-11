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
  # quota error (???)
  # {
  #   name     = "model-router"
  #   model    = "model-router"
  #   version  = "2025-11-18"
  #   capacity = "10"
  # },
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
    name     = "gpt-5"
    model    = "gpt-5"
    version  = "2025-08-07"
    capacity = "100"
  },
  # too expensive ($15/$120)
  # {
  #   name     = "gpt-5-pro"
  #   model    = "gpt-5-pro"
  #   version  = "2025-10-06"
  #   capacity = "10"
  # },
  {
    name     = "gpt-5-mini"
    model    = "gpt-5-mini"
    version  = "2025-08-07"
    capacity = "100"
  },
  {
    name     = "gpt-5-nano"
    model    = "gpt-5-nano"
    version  = "2025-08-07"
    capacity = "100"
  },
  {
    name     = "o3-pro"
    model    = "o3-pro"
    version  = "2025-06-10"
    capacity = "10"
  },
  {
    name     = "o3"
    model    = "o3"
    version  = "2025-04-16"
    capacity = "50"
  },
  {
    name     = "o3-mini"
    model    = "o3-mini"
    version  = "2025-01-31"
    capacity = "100"
  },
  {
    name     = "o4-mini"
    model    = "o4-mini"
    version  = "2025-04-16"
    capacity = "100"
  },
  # {
  #   name     = "grok-3"
  #   model    = "grok-3"
  #   format   = "xAI"
  #   capacity = "100"
  # },
  # {
  #   name     = "grok-3-mini"
  #   model    = "grok-3-mini"
  #   format   = "xAI"
  #   capacity = "100"
  # },
  # deploys forever
  # {
  #   name     = "grok-4"
  #   model    = "grok-4"
  #   format   = "xAI"
  #   capacity = "100"
  # },
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
  # {
  #   name     = "DeepSeek-R1-0528"
  #   model    = "DeepSeek-R1-0528"
  #   format   = "DeepSeek"
  #   capacity = "1"
  # },
  # {
  #   name     = "mistral-medium-2505"
  #   model    = "mistral-medium-2505"
  #   format   = "Mistral AI"
  #   capacity = "1"
  # },
  # {
  #   name     = "mistral-document-ai-2505"
  #   model    = "mistral-document-ai-2505"
  #   format   = "Mistral AI"
  #   capacity = "1"
  # },
  {
    name     = "whisper"
    model    = "whisper"
    version  = "001"
    capacity = "1"
    sku_name = "Standard"
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
    name     = "gpt-image-1"
    model    = "gpt-image-1"
    version  = "2025-04-15"
    capacity = "1"
    region   = "West US 3"
  },
  {
    name     = "sora"
    model    = "sora"
    version  = "2025-05-02"
    capacity = "10"
    sku_name = "Standard"
  },
  # {
  #   name     = "cohere-command-a"
  #   model    = "cohere-command-a"
  #   format   = "Cohere"
  #   capacity = "1"
  # },
  {
    name     = "claude-opus-4-5"
    model    = "claude-opus-4-5"
    version  = "20251101"
    format   = "Anthropic"
    capacity = "250"
  },
  {
    name     = "claude-sonnet-4-5"
    model    = "claude-sonnet-4-5"
    version  = "20250929"
    format   = "Anthropic"
    capacity = "250"
  },
  {
    name     = "claude-haiku-4-5"
    model    = "claude-haiku-4-5"
    version  = "20251001"
    format   = "Anthropic"
    capacity = "250"
  }
]
