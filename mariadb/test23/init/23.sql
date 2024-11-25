CREATE USER 'user23_mariadb'@'%' IDENTIFIED BY '' REQUIRE SSL;
GRANT ALL ON test_mariadb_23.* TO 'user23_mariadb'@'%';
FLUSH PRIVILEGES;
