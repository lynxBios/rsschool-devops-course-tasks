# rsschool-devops-course-tasks

commands:
terraform init
terraform plan
terraform applay

vpc.tf
Defines the VPC, subnets, and main networking components. Create public and private subnets within the VPC in separate availability zones. Creates the NAT instance with appropriate security groups and routing to allow internet access from private instances as well as Internet Gateway for the Internet connection

bastion_host.tf
Creates the Bastion host in a public subnet to provide SSH access to private instances.

security_groups.tf
Configure the security groups to manage traffic between the NAT instance, private instances, and the internet and to control traffic between the private instance and the Bastion host.

routing.tf
Creates a route table for private subnets, routing traffic through the NAT instance for internet access. Configures route tables for the public subnets, routing traffic through the Internet Gateway (IGW).

network_acls.tf
Define the private and public NACL rules to control access to and from the subnets. Associates network ACLs (NACLs) with private and public subnets to manage inbound and outbound traffic.


Настроить OpenIDConnect провайдер в аккаунте AWS:
https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-idp_oidc.html#idp_oidc_Create_GitHub

Откройте консоль AWS и перейдите в раздел IAM.
Нажмите на Identity providers.
Create Identity Provider
В поле "Тип идентификатора" (Identity type) выберите "OpenID Connect" (OpenID Connect).
Введите URL-адрес провайдера в поле "URL-адрес провайдера OpenID Connect" (OpenID Connect provider URL). В данном случае URL-адрес провайдера - https://token.actions.githubusercontent.com.
Нажмите на "Создать идентификатор" (Create identity).
В поле "Audience" необходимо указать значение ```sts.amazonaws.com```.

После выполнения этих шагов, Terraform должен успешно настроить доступ к вашему аккаунту AWS с помощью GitHub Actions.
