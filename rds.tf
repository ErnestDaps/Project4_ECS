
 resource "aws_db_instance" "project4-mysql" {
  allocated_storage         = 5
  multi_az                  = true
  engine                    = "mysql"
  instance_class            = "db.t2.micro"
  username                  = "project4"
  password                  = "dapsrocks"
  port                      = "3306"
  db_subnet_group_name      = aws_db_subnet_group.project4_rds_instance_subnet.name 
  vpc_security_group_ids    = [aws_security_group.rds_sg.id, aws_security_group.ecs_sg.id]
  skip_final_snapshot       = true
  publicly_accessible       = true
}


# RDS instance subnet
resource "aws_db_subnet_group" "project4_rds_instance_subnet" {
  name       = "project4_rds_instance_subnet"
  subnet_ids = [aws_subnet.Project4_Public_Sub1.id, aws_subnet.Project4_Public_Sub2.id]
  description = "rds instance subnet"

  tags = {
    Name = "project4 database subnet"
  }
}  