CREATE USER 'user1_mariadb'@'%' IDENTIFIED VIA ed25519 USING PASSWORD ('') REQUIRE SSL;
GRANT ALL ON test_mariadb_1.* TO 'user1_mariadb'@'%';
FLUSH PRIVILEGES;
