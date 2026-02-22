resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.ubuntu_24.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.public_sg.id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  tags = { 
    Name = "bastion" 
    }

  user_data = templatefile("${path.module}/bastion_user_data.sh", {
    private_key = tls_private_key.ansible.private_key_pem
  })
}

resource "aws_instance" "nodes" {
  for_each = var.node_name
  ami                    = data.aws_ami.ubuntu_24.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  key_name               = aws_key_pair.ansible.key_name

  tags = {
     Name    =  each.key 
     Role    =  each.value
     Project = "bedrock"
     }
}


data "aws_ami" "ubuntu_24" {
  most_recent = true
  owners      = ["099720109477"] 

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}