locals {
  create_sns_topic_for_bounces    = var.sns_topic_arn_for_ses_bounces == "" ? true : false
  create_sns_topic_for_complaints = var.sns_topic_arn_for_ses_complaints == "" ? true : false
  create_sns_topic_for_deliveries = var.sns_topic_arn_for_ses_deliveries == "" ? true : false
  create_mail_from                = var.mail_from_subdomain != ""
  create_route53_records          = var.create_domain_verification_record || var.create_dkim_records || local.create_mail_from
}
