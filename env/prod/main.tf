module "amb_prod"{
  source = "../../infra"
  instancia = "t2.micro"
  chave = "dev_code_key"
  region_aws = "us-east-2"
  securetGroup = "DEV"
  groupName = "prod"
  max = "1"
  min = "1"
  producao = true
}