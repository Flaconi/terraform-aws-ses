output "verification_token" {
  description = "A code which when added to the domain as a TXT record will signal to SES that the owner of the domain has authorised SES to act on their behalf. If you pass a non-empty string as the value for the 'zone_id' variable, you can ignore this output as the TXT record will be created in the Route 53 zone. Otherwise, you will need to handle the TXT record and use the value of this output."
  value       = aws_ses_domain_identity.this.verification_token
}
