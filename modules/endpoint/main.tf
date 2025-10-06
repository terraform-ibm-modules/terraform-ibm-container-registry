##############################################################################
# terraform-ibm-container-registry
#
# Returns the IBM Cloud Container Registry Endpoint
##############################################################################

# map endpoints found from 'ibmcloud cr region-set'
locals {
  endpoints = {
    "ap-north"   = "jp.icr.io"
    "jp-tok"     = "jp.icr.io"
    "ap-south"   = "au.icr.io"
    "au-syd"     = "au.icr.io"
    "us-south"   = "us.icr.io"
    "br-sao"     = "br.icr.io"
    "ca-tor"     = "ca.icr.io"
    "eu-central" = "de.icr.io"
    "eu-es"      = "es.icr.io"
    "eu-fr2"     = "fr2.icr.io"
    "jp-osa"     = "jp2.icr.io"
    "uk-south"   = "uk.icr.io"
    "global"     = "icr.io"
  }
}
