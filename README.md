# AWS S3 Public Bucket and Lambda Setup

This repository provides scaffolding code to set up a public S3 bucket for hosting a simple frontend website and a Lambda function that runs daily using AWS CloudWatch Events.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine.

## Getting Started

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/nrobert-dev/terraform-aws-fe-scaffold.git
   ```

2. Set up your AWS access keys:

   - Open the `main.tf` file.
   - Locate the `provider "aws"` block.
   - Enter your AWS access key ID and secret access key in the appropriate fields.

3. Initialize the Terraform configuration:

   ```bash
   terraform init
   ```

4. Review the Terraform plan to understand the changes:

   ```bash
   terraform plan
   ```

5. Apply the Terraform configuration to create the infrastructure:

   ```bash
   terraform apply
   ```

6. Once the deployment is complete, you will see the output with the website URL and Lambda function details.

## Folder Structure

The repository has the following structure:

- `main.tf`: The main Terraform configuration file that creates the S3 bucket, Lambda function, and CloudWatch Events.
- `lambda.tf`: Module configuration file for the Lambda function.
- `template/`: Contains the frontend website files (HTML, CSS, JS).
- `lambda/`: Contains the Python code for the lambda.

## Customization

Feel free to modify the `template/` folder with your own frontend code. Update the `index.html` file as needed.

## Clean Up

To tear down the infrastructure and remove all resources:

```bash
terraform destroy
```

## Contributing

Contributions are welcome! If you have any improvements, suggestions, or bug fixes, please open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
```
