# Create EKS cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_worker_nodes_role.arn
  vpc_config {
    subnet_ids = [var.subnet_id]
  }
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
  ]
}

# Create EKS node group
resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "eks_node_group"
  node_role_arn   = aws_iam_role.eks_worker_nodes_role.arn
  subnet_ids      = [var.subnet_id]

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

resource "aws_launch_template" "eks-launch-template" {
  name_prefix              = "${var.cluster_name}-launch-template"
  image_id                 = var.image_id
  instance_type            = var.instance_type
  key_name                 = "example-key-pair"
  vpc_security_group_ids   = ["${aws_security_group.eks-node-sg.id}"]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "example-instance"
    }
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

# Create IAM role for EKS worker nodes
resource "aws_iam_role" "eks_worker_nodes_role" {
  name = "eks_worker_nodes_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Attach IAM policies to EKS worker nodes role
resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_worker_nodes_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_worker_nodes_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_worker_nodes_role.name
}



