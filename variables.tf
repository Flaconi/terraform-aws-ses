variable "domain" {
  description = "Domain name for which SES will be configured"
  type        = string
}

variable "zone_id" {
  description = "Route 53 zone ID where the verification TXT record will be created. If this remains as an empty string, it means that the verification DNS record has been handled outside of Terraform."
  type        = string
  default     = ""
}

variable "perform_domain_verification" {
  description = "Boolean flag for performing the domain identity verification. This is useful when the DNS zone is not handled by Route 53 and once the module outputs the TXT records, the user can create those records elsewhere and return to this module to flip this toggle."
  type        = bool
  default     = false
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

variable "default_tags" {
  description = "A map of tags to apply to all AWS resources"
  default     = {}
  type        = map(string)
}
