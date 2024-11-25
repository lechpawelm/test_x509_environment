X.509 certificate validation testing environment. 
The environment includes : 
1. docker container with Nginx server instance with TLS / mTLS on separate ports
2. instances of MariaDB
3. a script that generates X.509 certificates + configuration

First Header  | Second Header
------------- | -------------
CASE 1        | VALID
CASE 2        | EXPIRED
CASE 3        | NOT YET VALID
CASE 4        | INVALID SAN
CASE 5        | INVALID CN
CASE 6        | REVOKED (CRL)
CASE 7        | INVALID basicConstraints
CASE 8        | SELFSIGNED
CASE 9        | INVALID extendedKeyUsage
CASE 10       | SIGNED BY END ENTITY
CASE 11       | INVALID URL TO CRL
CASE 12       | EXPIRED CRL
CASE 13       | RSA 6144
CASE 14       | RSA 8192 SHA3
CASE 15       | ECDSA SECP521r1
CASE 16       | ECDSA SECP384r1
