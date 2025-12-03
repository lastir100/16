locals {
    web_name = "${var.org}-${var.env}-${var.project}-${var.role_web}"
    db_name = "${var.org}-${var.env}-${var.project}-${var.role_db}"
}