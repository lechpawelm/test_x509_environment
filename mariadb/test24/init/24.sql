CREATE USER 'user24_mariadb'@'%' IDENTIFIED BY '' REQUIRE SSL;
GRANT ALL ON test_mariadb_24.* TO 'user24_mariadb'@'%';
FLUSH PRIVILEGES;
