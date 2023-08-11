variable "path" {
  type = string
}

variable "message" {
  type = string
}

provider "local" {}

resource "local_file" "hello" {
    content = var.message
    filename =  var.path
}

output "filepath" {
  value = local_file.hello.filename
}