CREATE USER 'user19_mariadb'@'%' IDENTIFIED BY '' REQUIRE SSL;
GRANT ALL ON test_mariadb_19.* TO 'user19_mariadb'@'%';
FLUSH PRIVILEGES;
