data "aws_iam_policy_document" "custom_policy" {
  version = "2012-10-17"

  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeRouteTables",
      "ec2:CreateRoute",
      "ec2:ReplaceRoute",
      "ec2:DeleteRoute"
    ]
    resources = ["*"]
  }
}


resource "aws_iam_role" "pritunl" {
  name = "pritunl_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "pritunl_vpc" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
  role       = aws_iam_role.pritunl.name
}

resource "aws_iam_role_policy_attachment" "pritunl_route53" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
  role       = aws_iam_role.pritunl.name
}

resource "aws_iam_policy" "custom_policy" {
  name   = "PritunlPolicyCustom"
  policy = data.aws_iam_policy_document.custom_policy.json
}

resource "aws_iam_role_policy_attachment" "pritunl_custom" {
  policy_arn = aws_iam_policy.custom_policy.arn
  role       = aws_iam_role.pritunl.name
}

resource "aws_iam_instance_profile" "pritunl" {
  name = "pritunl_profile"
  role = aws_iam_role.pritunl.name

}

# Etapa 1: Gerar um par de chaves
resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "keypair" {
  key_name   = var.key_name
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" {
    command = <<-EOT
      echo "${tls_private_key.pk.private_key_pem}" > ./${var.key_name}.pem
      chmod 400 /Users/luismartorano/.ssh/id_rsa
    EOT
  }
}


# Etapa 3: Criar a instância EC2
resource "aws_instance" "wordpress_instance" {
  #ami                         = "ami-04fee7e1c5dd87e59"
  ami                         = var.ami
  instance_type               = var.instance_type
  iam_instance_profile        = aws_iam_instance_profile.pritunl.name
  key_name                    = aws_key_pair.keypair.key_name
  security_groups             = [aws_security_group.bitnami_wordpress_ami_sg.id]
  associate_public_ip_address = true
  #ebs_optimized               = true
  subnet_id = module.vpc.public_subnets[0]
  root_block_device {
    volume_size = 8
  }



  tags = {
    Name = var.instance_name
  }
}


