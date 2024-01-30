# Configuração de regras de entrada e saida de trafego
resource "aws_security_group" "conexao" {
  name = var.securetGroup
    ingress{
        cidr_blocks = [ "0.0.0.0/0" ]
        ipv6_cidr_blocks = [ "::/0" ]
        from_port = 0
        to_port = 0
        protocol = "-1"
    }
    egress{
        cidr_blocks = [ "0.0.0.0/0" ]
        ipv6_cidr_blocks = [ "::/0" ]
        from_port = 0
        to_port = 0
        protocol = "-1"
    }
    tags = {
        name = "conexao"
    }
}
# Configuração de regras de entrada apenas do Load Balancer
resource "aws_security_group" "loadBalancer" {
  name = "loadBalancerSecurityGroup"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.conexao.id]
  }
  tags = {
    name = "loadBalancer"
  }
}