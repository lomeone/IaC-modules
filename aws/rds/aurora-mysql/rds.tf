data "aws_subnet" "db_subnets" {
  count = length(var.vpc.db_subnet_ids)
  id    = var.vpc.db_subnet_ids[count.index]
}

resource "aws_rds_cluster" "aurora_mysql" {
  cluster_identifier              = var.name.db_cluster
  engine                          = "aurora-mysql"
  engine_version                  = "8.0.mysql_aurora.3.05.2"
  database_name                   = var.name.db
  manage_master_user_password     = true
  master_username                 = var.db_info.admin_username
  db_subnet_group_name            = var.vpc.db_subnet_group
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.use_outbox.name
  vpc_security_group_ids          = var.vpc.security_groups
  backup_retention_period         = 7
  storage_encrypted               = true
  skip_final_snapshot             = false
}

resource "aws_rds_cluster_instance" "reader" {
  count                = 3
  identifier           = "${var.name.db_cluster}-instance-reader-${count.index}"
  cluster_identifier   = aws_rds_cluster.aurora_mysql.id
  instance_class       = var.db_info.instance_type
  engine               = aws_rds_cluster.aurora_mysql.engine
  engine_version       = aws_rds_cluster.aurora_mysql.engine_version
  db_subnet_group_name = var.vpc.db_subnet_group
  apply_immediately    = true

  availability_zone = data.aws_subnet.db_subnets[count.index].availability_zone
}

resource "aws_rds_cluster_instance" "writer" {
  count                = 1
  identifier           = "${var.name.db_cluster}-instance-writer"
  cluster_identifier   = aws_rds_cluster.aurora_mysql.id
  instance_class       = var.db_info.instance_type
  engine               = aws_rds_cluster.aurora_mysql.engine
  engine_version       = aws_rds_cluster.aurora_mysql.engine_version
  db_subnet_group_name = var.vpc.db_subnet_group
  apply_immediately    = true

  depends_on = [aws_rds_cluster_instance.reader]
}
