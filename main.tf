resource "aws_ses_domain_identity" "this" {
  domain = var.domain
}

resource "aws_route53_record" "this" {
  count   = var.create_domain_verification_record ? 1 : 0
  zone_id = data.aws_route53_zone.this[0].zone_id
  name    = "_amazonses.${var.domain}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.this.verification_token]
}

resource "aws_ses_domain_identity_verification" "this_route53_dns" {
  count  = var.create_domain_verification_record ? 1 : 0
  domain = aws_ses_domain_identity.this.id

  depends_on = [
    aws_route53_record.this,
  ]
}

resource "aws_ses_domain_identity_verification" "this_other_dns" {
  count  = !var.create_domain_verification_record && var.perform_domain_verification ? 1 : 0
  domain = aws_ses_domain_identity.this.id
}

resource "aws_ses_domain_dkim" "this" {
  domain = aws_ses_domain_identity.this.domain
}

resource "aws_route53_record" "dkim" {
  for_each = var.create_dkim_records ? toset(aws_ses_domain_dkim.this.dkim_tokens) : toset([])
  zone_id  = data.aws_route53_zone.this[0].zone_id
  name     = "${each.value}._domainkey.${var.domain}"
  type     = "CNAME"
  ttl      = "1800"
  records  = ["${each.value}.dkim.amazonses.com"]
}

resource "aws_ses_domain_mail_from" "this" {
  count                  = local.create_mail_from ? 1 : 0
  domain                 = aws_ses_domain_identity.this.domain
  mail_from_domain       = "${var.mail_from_subdomain}.${var.domain}"
  behavior_on_mx_failure = var.mail_from_behavior_on_mx_failure
}

resource "aws_route53_record" "mail_from_mx" {
  count   = local.create_mail_from ? 1 : 0
  zone_id = data.aws_route53_zone.this[0].zone_id
  name    = "${var.mail_from_subdomain}.${var.domain}"
  type    = "MX"
  ttl     = "600"
  records = ["10 feedback-smtp.${data.aws_region.current.region}.amazonses.com"]
}

resource "aws_route53_record" "mail_from_spf" {
  count   = local.create_mail_from ? 1 : 0
  zone_id = data.aws_route53_zone.this[0].zone_id
  name    = "${var.mail_from_subdomain}.${var.domain}"
  type    = "TXT"
  ttl     = "600"
  records = ["v=spf1 include:amazonses.com ~all"]
}

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

resource "aws_ses_identity_notification_topic" "bounce" {
  topic_arn                = local.create_sns_topic_for_bounces ? aws_sns_topic.ses_bounces[0].arn : var.sns_topic_arn_for_ses_bounces
  notification_type        = "Bounce"
  identity                 = aws_ses_domain_identity.this.domain
  include_original_headers = true
}

resource "aws_ses_identity_notification_topic" "complaint" {
  topic_arn                = local.create_sns_topic_for_complaints ? aws_sns_topic.ses_complaints[0].arn : var.sns_topic_arn_for_ses_complaints
  notification_type        = "Complaint"
  identity                 = aws_ses_domain_identity.this.domain
  include_original_headers = true
}

resource "aws_ses_identity_notification_topic" "delivery" {
  topic_arn                = local.create_sns_topic_for_deliveries ? aws_sns_topic.ses_delivery[0].arn : var.sns_topic_arn_for_ses_deliveries
  notification_type        = "Delivery"
  identity                 = aws_ses_domain_identity.this.domain
  include_original_headers = true
}
