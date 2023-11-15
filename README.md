# aws-secret-updater
### AWS ECR Secret updater for linux/arm64
#### this image is for create / update Kubernetes docker login secret for AWS ECR, in arm64 Kubernetes system.
#### fork and modify .github/workflows/main.yml to build amd64 image.

## ENV variables and mounts
these variables are **REQUIRED**! If these variables are not given, image won't start or job will not be successful.

| variable name       | variable description          | sample value                                    |
|---------------------|-------------------------------|-------------------------------------------------|
| ACCESS_KEY          | AWS access key                | i-am-access-key...                              |
| SECRET_KEY          | AWS secret key                | i-am-secret-key...                              |
| REGION              | AWS region                    | ap-northeast-2                                  |
| NAMESPACE           | kubernetes secret's namespace | default                                         |
| SECRET_NAME         | kubernetes secret name        | aws-ecr-secret                                  |
| REPOSITORY_URL      | AWS ECR URL                   | arn:aws:ecr:ap-northeast-2:123456789:repository |
