output "rds_hostname" {
  value = aws_db_instance.lanchonete_fiap_2.address
}

output "rds_port" {
  value = aws_db_instance.lanchonete_fiap_2.port
}

output "rds_username" {
  value = aws_db_instance.lanchonete_fiap_2.username
}
