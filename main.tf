# main.tf
# Provider configuration
provider "kubernetes" {
  config_path = "../kubeconfig"  # Path to your kubeconfig file
}

variable "my_namespace" {
  description = "The namespace for the virtual machine"
  type        = string
  default     = "chrisj2"
}


variable "my_vm_name" {
  description = "The names of the virtual machine"
  type        = string
  default     = "terraform-vm"
}


#resource "kubernetes_manifest" "deployment" {
#  manifest = yamldecode(file("./manifests/vm.yaml"))
#}

resource "kubernetes_manifest" "deployment" {
  manifest = yamldecode(
    templatefile("./manifests/vm.yaml",
      {
        my_namespace = var.my_namespace,
        my_vm_name   = var.my_vm_name
    })
  )
}
