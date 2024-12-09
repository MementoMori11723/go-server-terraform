terraform {
  required_providers {
    render = {
      source  = "render-oss/render"
      version = "~> 1.3.6"
    }
  }

  backend "s3" {
    bucket     = "terraform-test-11723"
    key        = "terraform.tfstate"
    region     = "eu-north-1"
  }
}

provider "render" {
  api_key  = var.render_api_key
  owner_id = var.render_owner_id
}

resource "render_web_service" "Default" {
  name          = "terraform-go-server"
  plan          = "starter"
  region        = "oregon"
  start_command = "./app"

  runtime_source = {
    native_runtime = {
      auto_deploy   = true
      branch        = "master"
      build_command = "go build -ldflags='-s -w' -o app"
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

variable "aws_access_key" {
  description = "AWS access key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
  sensitive   = true
}
