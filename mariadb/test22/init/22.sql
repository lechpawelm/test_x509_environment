CREATE USER 'user22_mariadb'@'%' IDENTIFIED BY '' REQUIRE SSL;
GRANT ALL ON test_mariadb_22.* TO 'user22_mariadb'@'%';
FLUSH PRIVILEGES;
