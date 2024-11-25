CREATE USER 'user13_mariadb'@'%' IDENTIFIED BY '' REQUIRE SSL;
GRANT ALL ON test_mariadb_13.* TO 'user13_mariadb'@'%';
FLUSH PRIVILEGES;
