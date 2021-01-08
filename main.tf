terraform {
  required_providers {
    mysql = {
      source  = "terraform-providers/mysql"
      version = "~> 1.6"
    }
  }
}


provider "mysql" {
  endpoint = "54.82.49.98:3306"
  username = "root"
  password = "root@123"
}

# Create a Database
resource "mysql_database" "terra_db" {
  name = "terra_db"
}

resource "mysql_user" "db_user" {
  user = "rajnikant"
  host               = "54.82.49.98"
  plaintext_password = "password123"
}

resource "mysql_grant" "jdoe" {
  user       = "${mysql_user.db_user.user}"
  host       = "${mysql_user.db_user.host}"
  database   = "${mysql_database.terra_db.name}"
  privileges = ["ALL"]
}
