#Declara a versão mínima do provedor AWS necessária para este código Terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.16, < 5.0"
    }
  }
  
}
# Define o provedor AWS e especifica a região onde as operações serão realizadas
provider "aws" {
  profile = "default"
  region  = var.region_aws
  }
# Resource para criar uma instância AWS usando uma AMI específica
resource "aws_launch_template" "machine_code_iac" {
  image_id           = "ami-0e83be366243f524a"
  instance_type = var.instancia
  key_name      = var.chave
  tags = {
    Name = "Terraform ansible python"
  }
  security_group_names = [ var.securetGroup ]
  user_data = var.producao ? filebase64("ansible.sh") : ""
}
# Recurso para buscar a chave SSH publica criada
resource "aws_key_pair" "chaveSSH" {
  key_name = var.chave
  public_key = file("${var.chave}.pub")
}
# Cria um grupo de Auto Scaling (ASG) para gerenciar instâncias EC2 automaticamente.
resource "aws_autoscaling_group" "grupo"{
      availability_zones = ["${var.region_aws}a","${var.region_aws}b"]
      name                      = var.groupName
      max_size                  = var.max
      min_size                  = var.min
  target_group_arns = var.producao ? [aws_lb_target_group.targetLb[0].arn] : []
  launch_template {
    id      = aws_launch_template.machine_code_iac.id
    version = "$Latest"
  }
  
}
# Cria uma subnet padrão em uma zona de disponibilidade
resource "aws_default_subnet" "subnet_1" {
  availability_zone = "${var.region_aws}a"
}
# Cria outra subnet padrão em uma zona de disponibilidade diferente.
resource "aws_default_subnet" "subnet_2" {
  availability_zone = "${var.region_aws}b"
}
# Cria um Load Balancer para distribuir o tráfego entre instâncias EC2 (ativado apenas em ambiente de produção).
resource "aws_lb" "loadBalancer" {
  internal = false
  subnets = [aws_default_subnet.subnet_1.id, aws_default_subnet.subnet_2.id]
  count = var.producao ? 1 : 0
}
# Cria um Target Group para receber informações do Load Balancer.
resource "aws_lb_target_group" "targetLb" {
  name = "targetMachine"
  port = "8000"
  protocol = "HTTP"
  vpc_id = aws_default_vpc.default.id
  count = var.producao ? 1 : 0
}
# Cria uma Virtual Private Cloud (VPC) padrão.
resource "aws_default_vpc" "default" {
}

# Configura um listener no Load Balancer para encaminhar o tráfego às instâncias no Target Group.
resource "aws_lb_listener" "enterLoadBalancer" {
  load_balancer_arn = aws_lb. loadBalancer[0].arn
  port = "8000"
  protocol = "HTTP"
    default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.targetLb[0].arn
  }
  count = var.producao ? 1 : 0
}
# Define uma política de Auto Scaling baseada na utilização média da CPU (aplicável apenas em ambiente de produção).
resource "aws_autoscaling_policy" "autoScaling_dev" {
  name = "terraform_scaling"
  autoscaling_group_name = var.groupName
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAvarageCPUUtilization"
    }
  target_value = 50.0
  }
  count = var.producao ? 1 : 0
}