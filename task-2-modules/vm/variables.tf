// Define empty variable blocks – values inherited from module blocks

variable "project_name" {}
variable "group_name" {}
variable "location" {}
variable "interface_ids" {}

// Define project variables

// VM Size
variable "vm_size" {
    default = "standard_B1ms"
}

// VM Storage size
variable "storage_size" {
    default = "Standard_LRS"
}