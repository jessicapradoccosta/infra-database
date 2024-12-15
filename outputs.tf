output "rds_hostname" {
  value = aws_db_instance.lanchonete_fiap.address
}

output "rds_port" {
  value = aws_db_instance.lanchonete_fiap.port
}

output "rds_username" {
  value = aws_db_instance.lanchonete_fiap.username
}
