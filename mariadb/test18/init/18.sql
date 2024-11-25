CREATE USER 'user18_mariadb'@'%' IDENTIFIED BY '' REQUIRE SSL;
GRANT ALL ON test_mariadb_18.* TO 'user18_mariadb'@'%';
FLUSH PRIVILEGES;
