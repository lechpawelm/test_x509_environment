CREATE USER 'user20_mariadb'@'%' IDENTIFIED BY '' REQUIRE SSL;
GRANT ALL ON test_mariadb_20.* TO 'user20_mariadb'@'%';
FLUSH PRIVILEGES;
