resource "aws_sns_topic" "ses_bounces" {
  name         = var.sns_topic_name_for_ses_bounces
  display_name = "SES Bounces"
}

resource "aws_sns_topic" "ses_complaints" {
  name         = var.sns_topic_name_for_ses_complaints
  display_name = "SES Complaints"
}

resource "aws_sns_topic" "ses_delivery" {
  name         = var.sns_topic_name_for_ses_deliveries
  display_name = "SES Delivery"
}
