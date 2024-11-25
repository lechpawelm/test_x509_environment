CREATE USER 'user14_mariadb'@'%' IDENTIFIED BY '' REQUIRE SSL;
GRANT ALL ON test_mariadb_14.* TO 'user14_mariadb'@'%';
FLUSH PRIVILEGES;
