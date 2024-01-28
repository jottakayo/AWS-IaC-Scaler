# Projeto de Infraestrutura na AWS com Terraform e Ansible

## Provisionamento de Instância EC2 com Terraform e Configuração com Ansible voltado para escalabilidade e automação

## 🚀 Descrição do Projeto

Este repositório contém a infraestrutura como código (IaC) para implantar e gerenciar uma aplicação na AWS. O projeto utiliza Terraform para provisionar recursos na nuvem, Ansible para automação de configuração, e recursos da AWS para criar um ambiente escalável e balanceado.

Consulte **[Terraform](https://developer.hashicorp.com/terraform?product_intent=terraform)** **[Ansible](hhttps://www.ansible.com)** para saber como implantar o projeto.

### 📋 Objetivo do Projeto

O principal objetivo deste projeto é criar uma infraestrutura robusta e escalável para hospedar uma aplicação na AWS. As principais características incluem:

```
Auto Scaling
```
Utilizamos um Auto Scaling Group (ASG) para gerenciar automaticamente a quantidade de instâncias EC2 com base na demanda. Isso garante que a aplicação possa lidar com variações de tráfego de forma eficiente.
```
Load Balancing
```
Implementamos um Load Balancer para distribuir o tráfego entre as instâncias EC2. Isso melhora a disponibilidade da aplicação, evitando sobrecarga em um único servidor.
```
Infraestrutura como Código
```
Toda a infraestrutura é definida no arquivo main.tf usando Terraform, permitindo uma implantação consistente e repetível.
```
Automatização de Configuração
```
Utilizamos Ansible para automatizar a configuração das instâncias EC2. Isso inclui a instalação de dependências, como o pip e o Ansible, e a execução de playbooks para configurar a máquina para produção.

### 🔧 Estrutura do Projeto

```
Main.tf
```

Define a infraestrutura básica, incluindo Launch Template, Auto Scaling Group, Subnets, Load Balancer e política de escalonamento automático.

```
Dev/main.tf
```

Configurações específicas para o ambiente de desenvolvimento, permitindo uma flexibilidade maior durante o desenvolvimento.
```
Ansible/setup.yml
```

Playbook Ansible para configurar automaticamente uma instância EC2 para produção.

## Instruções de Uso

# Pré-requisitos

Certifique-se de ter os seguintes pré-requisitos instalados antes de prosseguir:

* Terraform (versão recomendada: >= 0.12.0)
* Ansible
* Credenciais AWS configuradas localmente (chaves de acesso ou profile configurado).


# Configurações

Clone este repositório:

```
git clone git@github.com:jottakayo/AWS-IaC-Scaler.git
```
Inicialize o Terraform para configurar o ambiente:
```
terraform init
```
Abra o arquivo variables.tf e ajuste os valores padrão das variáveis conforme necessário.


### ⌨️ Contribuições são bem-vindas! Se encontrar problemas ou tiver sugestões de melhoria, abra uma issue ou envie um pull request.