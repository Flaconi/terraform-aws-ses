resource "aws_ses_domain_identity" "this" {
  domain = var.domain
}

resource "aws_route53_record" "this" {
  count   = var.zone_id == "" ? 0 : 1
  zone_id = var.zone_id
  name    = "_amazonses.${var.domain}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.this.verification_token]
}

resource "aws_ses_domain_identity_verification" "this_route53_dns" {
  count  = var.zone_id == "" ? 0 : 1
  domain = aws_ses_domain_identity.this.id

  depends_on = [
    aws_route53_record.this,
  ]
}

resource "aws_ses_domain_identity_verification" "this_other_dns" {
  count  = var.zone_id == "" ? 1 : 0
  domain = aws_ses_domain_identity.this.id
}

resource "aws_ses_domain_dkim" "this" {
  domain = aws_ses_domain_identity.this.domain
}

resource "aws_ses_identity_notification_topic" "bounce" {
  topic_arn                = aws_sns_topic.ses_bounces.arn
  notification_type        = "Bounce"
  identity                 = aws_ses_domain_identity.this.domain
  include_original_headers = true
}

resource "aws_ses_identity_notification_topic" "complaint" {
  topic_arn                = aws_sns_topic.ses_complaints.arn
  notification_type        = "Complaint"
  identity                 = aws_ses_domain_identity.this.domain
  include_original_headers = true
}

resource "aws_ses_identity_notification_topic" "delivery" {
  topic_arn                = aws_sns_topic.ses_delivery.arn
  notification_type        = "Delivery"
  identity                 = aws_ses_domain_identity.this.domain
  include_original_headers = true
}
