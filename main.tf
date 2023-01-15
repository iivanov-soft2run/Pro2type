terraform {
  cloud {
    organization = "Pro2type"

    workspaces {
      name = "Pro2type-Telerik"
    }
  }
  #An example resource that does nothing.
     resource "null_resource" "example" {
       triggers = {
         value = "A example resource that does nothing!"
       }
     }
}