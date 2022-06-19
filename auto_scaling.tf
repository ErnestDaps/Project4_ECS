
resource "aws_launch_configuration" "project4_ecs_launch_config" {
    name               = "project4_ecs_launch_configuration"
  image_id             = "ami-05a8c865b4de3b127"
  iam_instance_profile = aws_iam_instance_profile.ecs-instance-profile.name
  security_groups      = [aws_security_group.ecs_sg.id]
  instance_type        = "t2.micro"
}

resource "aws_autoscaling_group" "project4_ecs_asg" {
  name                 = "project4_ecs_asg"
  vpc_zone_identifier  = [aws_subnet.Project4_Public_Sub1.id, aws_subnet.Project4_Public_Sub2.id]
  launch_configuration = aws_launch_configuration.project4_ecs_launch_config.name

  desired_capacity          = 2
  min_size                  = 1
  max_size                  = 5
  health_check_grace_period = 300
  health_check_type         = "EC2"
}







