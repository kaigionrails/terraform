resource "aws_db_subnet_group" "kaigionrails_apne1_private" {
  name = "kaigionrails-apne1-private"
  subnet_ids = [aws_subnet.c_private.id, aws_subnet.d_private.id]
}
