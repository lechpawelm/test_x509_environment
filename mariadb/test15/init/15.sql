CREATE USER 'user15_mariadb'@'%' IDENTIFIED BY '' REQUIRE SSL;
GRANT ALL ON test_mariadb_15.* TO 'user15_mariadb'@'%';
FLUSH PRIVILEGES;
