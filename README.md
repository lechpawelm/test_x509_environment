X.509 certificate validation testing environment. 
The environment includes : 
1. docker container with Nginx server instance with TLS / mTLS on separate ports
2. instances of MariaDB with 2 variant authentication plugin - auth_plugin_ed25519 / mysql_native_password
3. script that generates X.509 certificates + configuration
