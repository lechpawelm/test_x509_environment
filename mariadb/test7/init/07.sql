CREATE USER 'user7_mariadb'@'%' IDENTIFIED VIA ed25519 USING PASSWORD ('') REQUIRE SSL;
GRANT ALL ON test_mariadb_7.* TO 'user7_mariadb'@'%';
FLUSH PRIVILEGES;