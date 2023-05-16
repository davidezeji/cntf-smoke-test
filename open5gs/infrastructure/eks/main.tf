# Create EKS cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = var.marketplace-eks-role
  vpc_config {
    subnet_ids = var.subnet_ids [*]
  }
}

# Create EKS node group
resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "eks_node_group"
  node_role_arn   = var.marketplace-eks-role
  subnet_ids      = var.subnet_ids [*]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

  capacity_type = "ON_DEMAND"
  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }
}

# Create VPC security group for EKS worker nodes
resource "aws_security_group" "eks-node-sg" {
  name_prefix = "eks-node-sg-"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-node-sg"
  }
}

resource "aws_launch_template" "eks-launch-template" {
  name_prefix            = "${var.cluster_name}-launch-template"
  image_id               = var.image_id
  instance_type          = var.instance_type
  key_name               = "example-key-pair"
  vpc_security_group_ids = ["${aws_security_group.eks-node-sg.id}"]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "example-instance"
    }
  }
}

module "aws_ebs_csi_driver_resources" {
  source                           = "github.com/andreswebs/terraform-aws-eks-ebs-csi-driver//modules/resources"
  cluster_name                     = var.cluster_name
  iam_role_arn                     = var.aws_ebs_csi_driver_iam_role_arn
  chart_version_aws_ebs_csi_driver = var.chart_version_aws_ebs_csi_driver
}

