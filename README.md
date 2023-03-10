# Terraform AWS SES module

[![lint](https://github.com/flaconi/terraform-aws-ses/workflows/lint/badge.svg)](https://github.com/flaconi/terraform-aws-ses/actions?query=workflow%3Alint)
[![test](https://github.com/flaconi/terraform-aws-ses/workflows/test/badge.svg)](https://github.com/flaconi/terraform-aws-ses/actions?query=workflow%3Atest)
[![Tag](https://img.shields.io/github/tag/flaconi/terraform-aws-ses.svg)](https://github.com/flaconi/terraform-aws-ses/releases)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Terraform module to handle the SES resources.

<!-- TFDOCS_HEADER_START -->


<!-- TFDOCS_HEADER_END -->

<!-- TFDOCS_PROVIDER_START -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.57 |

<!-- TFDOCS_PROVIDER_END -->

<!-- TFDOCS_REQUIREMENTS_START -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.57 |

<!-- TFDOCS_REQUIREMENTS_END -->

<!-- TFDOCS_INPUTS_START -->
## Required Inputs

The following input variables are required:

### <a name="input_domain"></a> [domain](#input\_domain)

Description: Domain name for which SES will be configured

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id)

Description: Route 53 zone ID where the verification TXT record will be created. If this remains as an empty string, it means that the verification DNS record has been handled outside of Terraform.

Type: `string`

Default: `""`

### <a name="input_perform_domain_verification"></a> [perform\_domain\_verification](#input\_perform\_domain\_verification)

Description: Boolean flag for performing the domain identity verification. This is useful when the DNS zone is not handled by Route 53 and once the module outputs the TXT records, the user can create those records elsewhere and return to this module to flip this toggle.

Type: `bool`

Default: `false`

### <a name="input_sns_topic_name_for_ses_bounces"></a> [sns\_topic\_name\_for\_ses\_bounces](#input\_sns\_topic\_name\_for\_ses\_bounces)

Description: Name of the SNS topic where the bounces are recorded

Type: `string`

Default: `""`

### <a name="input_sns_topic_arn_for_ses_bounces"></a> [sns\_topic\_arn\_for\_ses\_bounces](#input\_sns\_topic\_arn\_for\_ses\_bounces)

Description: ARN of the SNS topic where the bounces are recorded

Type: `string`

Default: `""`

### <a name="input_sns_topic_name_for_ses_complaints"></a> [sns\_topic\_name\_for\_ses\_complaints](#input\_sns\_topic\_name\_for\_ses\_complaints)

Description: Name of the SNS topic where the complaints are recorded

Type: `string`

Default: `""`

### <a name="input_sns_topic_arn_for_ses_complaints"></a> [sns\_topic\_arn\_for\_ses\_complaints](#input\_sns\_topic\_arn\_for\_ses\_complaints)

Description: ARN of the SNS topic where the complaints are recorded

Type: `string`

Default: `""`

### <a name="input_sns_topic_name_for_ses_deliveries"></a> [sns\_topic\_name\_for\_ses\_deliveries](#input\_sns\_topic\_name\_for\_ses\_deliveries)

Description: Name of the SNS topic where the delivery are recorded

Type: `string`

Default: `""`

### <a name="input_sns_topic_arn_for_ses_deliveries"></a> [sns\_topic\_arn\_for\_ses\_deliveries](#input\_sns\_topic\_arn\_for\_ses\_deliveries)

Description: ARN of the SNS topic where the delivery are recorded

Type: `string`

Default: `""`

### <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags)

Description: A map of tags to apply to all AWS resources

Type: `map(string)`

Default: `{}`

<!-- TFDOCS_INPUTS_END -->

<!-- TFDOCS_OUTPUTS_START -->
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_verification_token"></a> [verification\_token](#output\_verification\_token) | A code which when added to the domain as a TXT record will signal to SES that the owner of the domain has authorised SES to act on their behalf. If you pass a non-empty string as the value for the 'zone\_id' variable, you can ignore this output as the TXT record will be created in the Route 53 zone. Otherwise, you will need to handle the TXT record and use the value of this output. |

<!-- TFDOCS_OUTPUTS_END -->

## License

**[MIT License](LICENSE)**

Copyright (c) 2023 **[flaconi](https://github.com/Flaconi)**
