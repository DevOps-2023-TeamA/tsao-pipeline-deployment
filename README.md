# TSAO Pipeline Deployment
This repository covers the process of deploying the code onto DigitalOcean (and updating Cloudflare).

> [!Important]
> To run, make sure you have the DigitalOcean token, a private key path to the SSH private key, the backend service secret key, a Cloudflare API token, and the Cloudflare Zone ID.

## set up terraform
Follow [this guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) to installing the Terraform CLI. 

For macOS, if Homebrew is available, brew is the easiest method of installation.
```
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

## deploying
1. Initialize Terraform
```
terraform init
```
2. To deploy, run the following command, replacing the variables below.
```
terraform apply \
  -var "do_token=DO TOKEN" \
  -var "pvt_key=$HOME/.ssh/..." \
  -var "cloudflare_api_token=CLOUDFLARE API TOKEN" \
  -var "cloudflare_zone_id=CLOUDFLARE ZONE ID"
```

## self-hosting
Self-hosting will require amending custom scripts to ensure it works with your environment and domain. Specifically `backend-setup.sh`, and `backend.tf`. You may need to change the cURL URL on line 37 to change the deployment script.

## hosted instance
The hosted instance will be kept online for 1 month after the assignment submission date.

It will terminate on 16 March 2024.

The instance does not support HTTPS and requires HTTP in order to work. 
- Make sure your browser does not automatically redirect you to the HTTPS site
- Firefox has been tested to work well, you may have to fiddle with the security settings
- Have not gotten Chrome, Edge, or Safari to work.
- It is accessible at [http://tsao.hotchocolate.app](http://tsao.hotchocolate.app)

## maintainers
- [Yee Jia Chen](https://github.com/jiachenyee) S10219344C
- [Isabelle Pak Yi Shan](https://github.com/isabellepakyishan) S10222456J
- [Ho Kuan Zher](https://github.com/Kuan-Zher) S10223870D
- [Cheah Seng Jun](https://github.com/DanielCheahSJ) S10227333K
- [Chua Guo Jun](https://github.com/GuojunLoser) S10227743H
