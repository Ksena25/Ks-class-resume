name: build push and Deploy image

on:
  Push:
    branches: [main]
  pull_request:
    branches: [main]

permissions:
  id-token: write
  contents: read

env:
  AWS_REGION: us-east-1
  AWS_ROLE: ${{ secrets.AWS_ACTIONS_ROLE }}


jobs:
  build:
    runs-on: ubuntu-latest  #github runner or share runner
    steps:
      - name: clone repo
        uses: actions/checkout@v3
      - name: Aws creds config  # aws account credentials configuration
        uses: aws-actions/configuration-aws-credentials@v4
        with:
          role-to-assume: ${{env.AWS_ROLE}} # OIDC Open ID Connect which is more secure than github sercet and variables
          aws-region: ${{env.AWS_REGION}}
      - name: Login to amazon ECR # AWS Elastic Container Registry
        uses: aws-actions/amazon-ecr-login@v1


