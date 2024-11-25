CREATE USER 'user17_mariadb'@'%' IDENTIFIED BY '' REQUIRE SSL;
GRANT ALL ON test_mariadb_17.* TO 'user17_mariadb'@'%';
FLUSH PRIVILEGES;
