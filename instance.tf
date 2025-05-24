resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  key_name                    = aws_key_pair.my_key.key_name

  tags = {
    Name = "bastion"
  }
}

resource "aws_instance" "private_instance" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = module.vpc.private_subnets[0]
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.private_sg.id]
  key_name                    = aws_key_pair.my_key.key_name

  tags = {
    Name = "private-instance"
  }
}