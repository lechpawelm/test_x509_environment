CREATE USER 'user12_mariadb'@'%' IDENTIFIED VIA ed25519 USING PASSWORD ('') REQUIRE SSL;
GRANT ALL ON test_mariadb_12.* TO 'user12_mariadb'@'%';
FLUSH PRIVILEGES;