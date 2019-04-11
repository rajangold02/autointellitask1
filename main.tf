provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "instance" {
  ami                         = "${var.aws_id}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  subnet_id                   = "${var.subnet_id}"
  security_groups             = ["${aws_security_group.allow-ec2.id}"]
  associate_public_ip_address = "true"

  tags {
    Name = "NginxInstance"
  }

  user_data = "${file("./nginx.sh")}"
}

resource "aws_security_group" "allow-ec2" {
  vpc_id      = "${var.vpc_id}"
  name        = "allow-ec2-sg"
  description = "security group that allows ssh,http and all egress traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "allow_sg"
  }
}

resource "aws_eip" "Instance" {
  instance = "${aws_instance.instance.id}"
  vpc      = true
}
