CREATE USER 'user21_mariadb'@'%' IDENTIFIED BY '' REQUIRE SSL;
GRANT ALL ON test_mariadb_21.* TO 'user21_mariadb'@'%';
FLUSH PRIVILEGES;
