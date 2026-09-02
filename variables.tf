variable "domain" {
  description = "Domain name for which SES will be configured"
  type        = string
}

variable "zone_id" {
  description = "Route 53 zone ID where the verification TXT record will be created. If this remains as an empty string, it means that the verification DNS record has been handled outside of Terraform."
  type        = string
  default     = ""
}

variable "create_dkim_records" {
  description = "Whether to create the DKIM CNAME records in Route 53. Requires zone_id to be set. Set to false when managing the DNS records outside of Terraform."
  type        = bool
  default     = false
}

variable "create_domain_verification_record" {
  description = "Whether to create the _amazonses TXT record in Route 53 for domain verification. Requires zone_id to be set. Set to false when managing the DNS record outside of Terraform."
  type        = bool
  default     = false
}

variable "perform_domain_verification" {
  description = "Boolean flag for performing the domain identity verification. This is useful when the DNS zone is not handled by Route 53 and once the module outputs the TXT records, the user can create those records elsewhere and return to this module to flip this toggle."
  type        = bool
  default     = false
}

variable "mail_from_subdomain" {
  description = "Subdomain to use as the MAIL FROM domain (e.g. \"mail\" produces mail.<domain>). Leave empty to disable custom MAIL FROM."
  type        = string
  default     = ""
}

variable "mail_from_behavior_on_mx_failure" {
  description = "Action to take if the MAIL FROM domain's MX record is not found. Valid values: UseDefaultValue, RejectMessage."
  type        = string
  default     = "UseDefaultValue"
  validation {
    condition     = contains(["UseDefaultValue", "RejectMessage"], var.mail_from_behavior_on_mx_failure)
    error_message = "mail_from_behavior_on_mx_failure must be either UseDefaultValue or RejectMessage."
  }
}

variable "sns_topic_name_for_ses_bounces" {
  description = "Name of the SNS topic where the bounces are recorded"
  type        = string
  default     = ""
}

variable "sns_topic_arn_for_ses_bounces" {
  description = "ARN of the SNS topic where the bounces are recorded"
  type        = string
  default     = ""
}

variable "sns_topic_name_for_ses_complaints" {
  description = "Name of the SNS topic where the complaints are recorded"
  type        = string
  default     = ""
}

variable "sns_topic_arn_for_ses_complaints" {
  description = "ARN of the SNS topic where the complaints are recorded"
  type        = string
  default     = ""
}

variable "sns_topic_name_for_ses_deliveries" {
  description = "Name of the SNS topic where the delivery are recorded"
  type        = string
  default     = ""
}

variable "sns_topic_arn_for_ses_deliveries" {
  description = "ARN of the SNS topic where the delivery are recorded"
  type        = string
  default     = ""
}
