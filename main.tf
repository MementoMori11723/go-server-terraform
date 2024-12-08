terraform {
  required_providers {
    render = {
      source  = "render-oss/render"
      version = "~> 1.3.6"
    }
  }
}

provider "render" {
  api_key  = var.render_api_key
  owner_id = var.render_owner_id
}

resource "render_web_service" "Default" {
  name          = "go-terraform-server"
  plan          = "starter"
  region        = "oregon"
  start_command = "./app"

  runtime_source = {
    native_runtime = {
      auto_deploy   = true
      branch        = "master"
      build_command = "go build -o app"
      repo_url      = "https://github.com/MementoMori11723/go-terraform-server"
      runtime       = "go"
    }
  }
}

variable "render_api_key" {
  description = "API key for Render"
  type        = string
  sensitive   = true
}

variable "render_owner_id" {
  description = "Render owner ID"
  type        = string
  sensitive   = true
}
