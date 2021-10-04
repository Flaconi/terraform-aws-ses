resource "aws_sns_topic" "ses_bounces" {
  count        = local.create_sns_topic_for_bounces ? 1 : 0
  name         = var.sns_topic_name_for_ses_bounces
  display_name = "SES Bounces"
}

resource "aws_sns_topic" "ses_complaints" {
  count        = local.create_sns_topic_for_complaints ? 1 : 0
  name         = var.sns_topic_name_for_ses_complaints
  display_name = "SES Complaints"
}

resource "aws_sns_topic" "ses_delivery" {
  count        = local.create_sns_topic_for_deliveries ? 1 : 0
  name         = var.sns_topic_name_for_ses_deliveries
  display_name = "SES Delivery"
}
