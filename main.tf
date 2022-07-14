resource "aws_rds_cluster" "default" {
  cluster_identifier      = "aurora-cluster-demo"
  engine                  = "aurora-mysql"
  engine_version          = "8.0.mysql_aurora.3.02.0"
  availability_zones      = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  database_name           = "mydb"
  master_username         = "kozocom"
  master_password         = "kozo7878"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "aurora-cluster-demo-${count.index}"
  cluster_identifier = aws_rds_cluster.default.id
  publicly_accessible=true
  instance_class     = "db.t3.medium"
  engine             = aws_rds_cluster.default.engine
  engine_version     = aws_rds_cluster.default.engine_version
}
output "name" {
  value=aws_rds_cluster.default.endpoint
}