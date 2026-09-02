output "verification_token" {
  description = "A code which when added to the domain as a TXT record will signal to SES that the owner of the domain has authorised SES to act on their behalf. If you pass a non-empty string as the value for the 'zone_id' variable, you can ignore this output as the TXT record will be created in the Route 53 zone. Otherwise, you will need to handle the TXT record and use the value of this output."
  value       = aws_ses_domain_identity.this.verification_token
}

output "mail_from_domain" {
  description = "The custom MAIL FROM domain. Null when 'mail_from_subdomain' is not set. When 'zone_id' is empty, you must create the MX and SPF records for this domain externally using the 'mail_from_mx_record' and 'mail_from_spf_record' outputs."
  value       = local.create_mail_from ? aws_ses_domain_mail_from.this[0].mail_from_domain : null
}

output "mail_from_mx_record" {
  description = "MX record value to set on the MAIL FROM domain when DNS is managed outside Route 53. Null when 'mail_from_subdomain' is not set."
  value       = local.create_mail_from ? "10 feedback-smtp.${data.aws_region.current.region}.amazonses.com" : null
}

output "mail_from_spf_record" {
  description = "SPF TXT record value to set on the MAIL FROM domain when DNS is managed outside Route 53. Null when 'mail_from_subdomain' is not set."
  value       = local.create_mail_from ? "v=spf1 include:amazonses.com ~all" : null
}
