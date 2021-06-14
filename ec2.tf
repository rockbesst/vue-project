provider "aws" {
	region = var.region
}

variable "region" {
  default = "eu-central-1"
}
variable "tags" {
  default = {
      Owner = "Rockbesst"
  }
}
variable "ssh_key" {
  default = "AWS-Frankfurt-test1"
}
variable "instance_type" {
  default = "t2.micro"
}

resource "aws_instance" "VueServer" {
	ami = data.aws_ami.amazon_linux.id
	instance_type = var.instance_type
	availability_zone = "eu-central-1a"
	vpc_security_group_ids = [data.aws_security_group.mainSecGroup.id]
	key_name = var.ssh_key
	tags = merge(var.tags, {Name = "VueServer"})
}

data "aws_security_group" "mainSecGroup" {
 id = "sg-0ef96a12de408930c"
}

# AMI Search
data "aws_ami" "amazon_linux" {
	owners = ["amazon"]
	most_recent = true
	filter {
		name = "name"
		values = ["amzn2-ami-hvm-*-x86_64-gp2"]
	}
}
