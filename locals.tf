locals {
  create_sns_topic_for_bounces    = var.sns_topic_arn_for_ses_bounces == "" ? true : false
  create_sns_topic_for_complaints = var.sns_topic_arn_for_ses_complaints == "" ? true : false
  create_sns_topic_for_deliveries = var.sns_topic_arn_for_ses_deliveries == "" ? true : false
}
