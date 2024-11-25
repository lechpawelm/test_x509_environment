CREATE USER 'user16_mariadb'@'%' IDENTIFIED BY '' REQUIRE SSL;
GRANT ALL ON test_mariadb_16.* TO 'user16_mariadb'@'%';
FLUSH PRIVILEGES;
