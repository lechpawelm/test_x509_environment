#!/bin/bash

hostname=$1
start_date=$2
end_date=$3
past_start_date=$(date '+%Y-%m-%dT%H:%M:%SZ' -d "$start_date-365 days")
past_end_date=$(date '+%Y-%m-%dT%H:%M:%SZ' -d "$start_date-1 days")
future_start_date=$(date '+%Y-%m-%dT%H:%M:%SZ' -d "$end_date+1 days")
future_end_date=$(date '+%Y-%m-%dT%H:%M:%SZ' -d "$end_date+365 days")

# NGINX

#----------------
#CASE 1 - VALID
#----------------
cp csr_config.conf csr_config_temp.conf
cp openssl_ca.conf openssl_ca_temp.conf
cp extensions.conf extensions_temp.conf
sed -i 's/Type CN/'$hostname'/' csr_config_temp.conf
openssl req -set_serial 50 -new -out $hostname.csr -config csr_config_temp.conf 
sed -i 's/Type DNS Name/'$hostname'/' extensions_temp.conf
openssl ca -config openssl_ca_temp.conf -out $hostname.crt -extfile extensions_temp.conf -extensions x509_ext -in $hostname.csr -batch -startdate $(echo "$start_date" | tr -cd [:digit:]Z) -enddate $(echo "$end_date" | tr -cd [:digit:]Z)
rm -Rf csr_config_temp.conf , openssl_ca_temp.conf , extensions_temp.conf
cat $hostname.crt /etc/ssl/certs/<path_to_InterCA_file> > nginx_chain_#1.crt
mkdir CASE1_VALID
mv nginx_chain_#1.crt $hostname.crt $hostname.csr private_key.pem CASE1_VALID
mv CASE1_VALID /tmp/
rm -rf nginx_chain_#1.crt $hostname.crt $hostname.csr private_key.pem 


#------------------
#CASE 2 - EXPIRED
#------------------
cp csr_config.conf csr_config_temp.conf
cp openssl_ca.conf openssl_ca_temp.conf
cp extensions.conf extensions_temp.conf
sed -i 's/Type CN/'$hostname'/' csr_config_temp.conf
openssl req -set_serial 50 -new -out $hostname.csr -config csr_config_temp.conf 
sed -i 's/Type DNS Name/'$hostname'/' extensions_temp.conf
openssl ca -config openssl_ca_temp.conf -out $hostname.crt -extfile extensions_temp.conf -extensions x509_ext -in $hostname.csr -batch -startdate $(echo "$past_start_date" | tr -cd [:digit:]Z) -enddate $(echo "$past_end_date" | tr -cd [:digit:]Z)
rm -Rf csr_config_temp.conf , openssl_ca_temp.conf , extensions_temp.conf
cat $hostname.crt /etc/ssl/certs/<path_to_InterCA_file> > nginx_chain_#2.crt
mkdir CASE2_EXPIRED
mv nginx_chain_#2.crt $hostname.crt $hostname.csr private_key.pem CASE2_EXPIRED
mv CASE2_EXPIRED /tmp/
rm -rf nginx_chain_#2.crt $hostname.crt $hostname.csr private_key.pem 


#-----------------
#CASE3 - NOT YET VALID
#-----------------
cp csr_config.conf csr_config_temp.conf
cp openssl_ca.conf openssl_ca_temp.conf
cp extensions.conf extensions_temp.conf
sed -i 's/Type CN/'$hostname'/' csr_config_temp.conf
openssl req -set_serial 50 -new -out $hostname.csr -config csr_config_temp.conf 
sed -i 's/Type DNS Name/'$hostname'/' extensions_temp.conf
openssl ca -config openssl_ca_temp.conf -out $hostname.crt -extfile extensions_temp.conf -extensions x509_ext -in $hostname.csr -batch -startdate $(echo "$future_start_date" | tr -cd [:digit:]Z) -enddate $(echo "$future_end_date" | tr -cd [:digit:]Z)
rm -Rf csr_config_temp.conf , openssl_ca_temp.conf , extensions_temp.conf
cat $hostname.crt /etc/ssl/certs/<path_to_InterCA_file> > nginx_chain_#3.crt
mkdir CASE3_NOT_YET_VALID
mv nginx_chain_#3.crt $hostname.crt $hostname.csr private_key.pem CASE3_NOT_YET_VALID
mv CASE3_NOT_YET_VALID /tmp/
rm -rf nginx_chain_#3.crt $hostname.crt $hostname.csr private_key.pem 


#-------------------
#CASE4 - INVALID SubjectAltName
#-------------------

cp csr_config.conf csr_config_temp.conf
cp openssl_ca.conf openssl_ca_temp.conf
cp extensions.conf extensions_temp.conf
sed -i 's/Type CN/'$hostname'/' csr_config_temp.conf 
openssl req -set_serial 50 -new -out $hostname.csr -config csr_config_temp.conf
sed -i 's/Type DNS Name/'invalid.$hostname'/' extensions_temp.conf
openssl ca -config openssl_ca_temp.conf -out $hostname.crt -extfile extensions_temp.conf -extensions x509_ext -in $hostname.csr -batch -startdate $(echo "$start_date" | tr -cd [:digit:]Z) -enddate $(echo "$end_date" | tr -cd [:digit:]Z)
rm -Rf csr_config_temp.conf , openssl_ca_temp.conf , extensions_temp.conf
cat $hostname.crt /etc/ssl/certs/<path_to_InterCA_file> > nginx_chain_#4.crt
mkdir CASE4_INVALID_SAN
mv nginx_chain_#4.crt $hostname.crt $hostname.csr private_key.pem CASE4_INVALID_SAN
mv CASE4_INVALID_SAN /tmp/
rm -rf nginx_chain_#4.crt $hostname.crt $hostname.csr private_key.pem 


#-------------------
#CASE5 - INVALID commonName
#-------------------

cp csr_config.conf csr_config_temp.conf
cp openssl_ca.conf openssl_ca_temp.conf
cp extensions.conf extensions_temp.conf
sed -i 's/Type CN/'invalid.$hostname'/' csr_config_temp.conf
openssl req -set_serial 50 -new -out $hostname.csr -config csr_config_temp.conf 
sed -i 's/Type DNS Name/'$hostname'/' extensions_temp.conf
openssl ca -config openssl_ca_temp.conf -out $hostname.crt -extfile extensions_temp.conf -extensions x509_ext -in $hostname.csr -batch -startdate $(echo "$start_date" | tr -cd [:digit:]Z) -enddate $(echo "$end_date" | tr -cd [:digit:]Z)
rm -Rf csr_config_temp.conf , openssl_ca_temp.conf , extensions_temp.conf
cat $hostname.crt /etc/ssl/certs/<path_to_InterCA_file> > nginx_chain_#5.crt
mkdir CASE5_INVALID_CN
mv nginx_chain_#5.crt $hostname.crt $hostname.csr private_key.pem CASE5_INVALID_CN
mv CASE5_INVALID_CN /tmp/
rm -rf nginx_chain_#5.crt $hostname.crt $hostname.csr private_key.pem 


#------------------
#CASE6 - REVOKED (CRL)
#------------------
cp csr_config.conf csr_config_temp.conf
cp openssl_ca.conf openssl_ca_temp.conf
cp extensions.conf extensions_temp.conf
sed -i 's/Type CN/'$hostname'/' csr_config_temp.conf
openssl req -set_serial 50 -new -out $hostname.csr -config csr_config_temp.conf 
sed -i 's/Type DNS Name/'$hostname'/' extensions_temp.conf
openssl ca -config openssl_ca_temp.conf -out $hostname.crt -extfile extensions_temp.conf -extensions x509_ext -in $hostname.csr -batch -startdate $(echo "$start_date" | tr -cd [:digit:]Z) -enddate $(echo "$end_date" | tr -cd [:digit:]Z)
openssl ca -config openssl_ca_temp.conf -revoke $hostname.crt -crl_reason superseded
openssl ca -config openssl_ca.conf -gencrl -out crl/CRL_file.crl
rm -Rf csr_config_temp.conf , openssl_ca_temp.conf , extensions_temp.conf
cat $hostname.crt /etc/ssl/certs/<path_to_InterCA_file> > nginx_chain_#6.crt
mkdir CASE6_REVOKED
mv nginx_chain_#6.crt $hostname.crt $hostname.csr private_key.pem CASE6_REVOKED
mv CASE6_REVOKED /tmp/
rm -rf nginx_chain_#6.crt $hostname.crt $hostname.csr private_key.pem 


#-------------
#CASE7 - INVALID basicConstraints
#-------------

cp csr_config.conf csr_config_temp.conf
cp openssl_ca.conf openssl_ca_temp.conf
cp extensions.conf extensions_temp.conf
sed -i 's/Type CN/'$hostname'/' csr_config_temp.conf
openssl req -set_serial 50 -new -out $hostname.csr -config csr_config_temp.conf 
sed -i 's/Type DNS Name/'$hostname'/' extensions_temp.conf
sed -i 's/critical,CA:FALSE/critical,CA:TRUE, pathlen:1/' extensions_temp.conf
openssl ca -config openssl_ca_temp.conf -out $hostname.crt -extfile extensions_temp.conf -extensions x509_ext -in $hostname.csr -batch -startdate $(echo "$start_date" | tr -cd [:digit:]Z) -enddate $(echo "$end_date" | tr -cd [:digit:]Z)
rm -Rf csr_config_temp.conf , openssl_ca_temp.conf , extensions_temp.conf
cat $hostname.crt /etc/ssl/certs/<path_to_InterCA_file> > nginx_chain_#7.crt
mkdir CASE7_INVALID_BC
mv nginx_chain_#7.crt $hostname.crt $hostname.csr private_key.pem CASE7_INVALID_BC
mv CASE7_INVALID_BC /tmp/
rm -rf nginx_chain_#7.crt $hostname.crt $hostname.csr private_key.pem 


#--------------
#CASE8 - SELFSIGNED
#--------------

cp csr_config.conf csr_config_temp.conf
cp openssl_ca.conf openssl_ca_temp.conf
cp extensions.conf extensions_temp.conf
sed -i 's/Type CN/'$hostname'/' csr_config_temp.conf
openssl genrsa -out private_key.pem 2048
openssl req -set_serial 50 -new -key private_key.pem -out $hostname.csr -config csr_config_temp.conf 
sed -i 's/Type DNS Name/'$hostname'/' extensions_temp.conf
openssl ca -config openssl_ca_temp.conf -keyfile private_key.pem -selfsign -out $hostname.crt -extfile extensions_temp.conf -extensions x509_ext -in $hostname.csr -batch -startdate $(echo "$start_date" | tr -cd [:digit:]Z) -enddate $(echo "$end_date" | tr -cd [:digit:]Z)
rm -Rf csr_config_temp.conf , openssl_ca_temp.conf , extensions_temp.conf
mkdir CASE8_SELFSIGNED
mv $hostname.crt $hostname.csr private_key.pem CASE8_SELFSIGNED
mv CASE8_SELFSIGNED /tmp/
rm -rf  nginx8.pem $hostname.csr private_key.pem 

#-------------
#CASE9 - INVALID extendedKeyUsage
#-------------

cp csr_config.conf csr_config_temp.conf
cp openssl_ca.conf openssl_ca_temp.conf
cp extensions.conf extensions_temp.conf
sed -i 's/Type CN/'$hostname'/' csr_config_temp.conf
openssl req -set_serial 50 -new -out $hostname.csr -config csr_config_temp.conf 
sed -i 's/Type DNS Name/'$hostname'/' extensions_temp.conf
sed -i 's/^extendedKeyUsage/#&/' extensions_temp.conf
openssl ca -config openssl_ca_temp.conf -out $hostname.crt -extfile extensions_temp.conf -extensions x509_ext -in $hostname.csr -batch -startdate $(echo "$start_date" | tr -cd [:digit:]Z) -enddate $(echo "$end_date" | tr -cd [:digit:]Z)
rm -Rf csr_config_temp.conf , openssl_ca_temp.conf , extensions_temp.conf
cat $hostname.crt /etc/ssl/certs/<path_to_InterCA_file> > nginx_chain_#9.crt
mkdir CASE9_INVALID_EKU
mv nginx_chain_#9.crt $hostname.crt $hostname.csr private_key.pem CASE9_INVALID_EKU
mv CASE9_INVALID_EKU /tmp/
rm -rf nginx_chain_#9.crt $hostname.crt $hostname.csr private_key.pem 

#----------
#CASE10 - Signed by end entity cert
#----------

cp csr_config.conf csr_config_temp.conf
cp openssl_ca.conf openssl_ca_temp.conf
cp extensions.conf extensions_temp.conf
sed -i 's/Type CN/'$hostname'/' csr_config_temp.conf
openssl req -set_serial 50 -new -out $hostname.csr -config csr_config_temp.conf 
sed -i 's/Type DNS Name/'$hostname'/' extensions_temp.conf
openssl ca -config openssl_ca_temp.conf -out $hostname-cert.crt -extfile extensions_temp.conf -extensions x509_ext -in $hostname.csr -batch -startdate $(echo "$start_date" | tr -cd [:digit:]Z) -enddate $(echo "$end_date" | tr -cd [:digit:]Z)
mkdir CASE10_SIGNED_END
sed -i 's/private_key.pem/private_key_end.pem/' csr_config_temp.conf
sed -i 's/Type CN/'$hostname'/' csr_config_temp.conf
openssl req -set_serial 50 -new -out $hostname-end.csr -config csr_config_temp.conf
openssl ca -config openssl_ca_temp.conf -keyfile private_key.pem -cert $hostname-cert.crt -out $hostname.crt -extfile extensions_temp.conf -extensions x509_ext -in $hostname-end.csr -batch -startdate $(echo "$start_date" | tr -cd [:digit:]Z) -enddate $(echo "$end_date" | tr -cd [:digit:]Z)
rm -Rf csr_config_temp.conf , openssl_ca_temp.conf, extensions_temp.conf
cat $hostname.crt $hostname-cert.crt > nginx_chain_#10.crt
mv nginx_chain_#10.crt $hostname.crt $hostname-end.csr private_key_end.pem CASE10_SIGNED_END
mv CASE10_SIGNED_END /tmp/
rm -rf nginx_chain_#10.crt $hostname-cert.crt $hostname.csr private_key.pem


#------------
#CASE11 - Unaccessible CRL
#------------

cp csr_config.conf csr_config_temp.conf
cp openssl_ca.conf openssl_ca_temp.conf
cp extensions.conf extensions_temp.conf
sed -i 's/Type CN/'$hostname'/' csr_config_temp.conf
openssl req -set_serial 50 -new -out $hostname.csr -config csr_config_temp.conf 
sed -i 's/Type DNS Name/'$hostname'/' extensions_temp.conf
sed -i 's/CRL_file.crl/invalid_CRL_file.crl/' extensions_temp.conf
openssl ca  -config openssl_ca_temp.conf -out $hostname.crt -extfile extensions_temp.conf -extensions x509_ext -in $hostname.csr -batch -startdate $(echo "$start_date" | tr -cd [:digit:]Z) -enddate $(echo "$end_date" | tr -cd [:digit:]Z)
rm -Rf csr_config_temp.conf , openssl_ca_temp.conf , extensions_temp.conf
cat $hostname.crt /etc/ssl/certs/<path_to_InterCA_file> > nginx_chain_#11.crt
mkdir CASE11_INVALID_CRL
mv nginx_chain_#11.crt $hostname.crt $hostname.csr private_key.pem CASE11_INVALID_CRL
mv CASE11_INVALID_CRL /tmp/
rm -rf nginx_chain_#11.crt $hostname.crt $hostname.csr private_key.pem 


#--------------
#CASE12 - Expired CRL
#--------------

cp csr_config.conf csr_config_temp.conf
cp openssl_ca.conf openssl_ca_temp.conf
cp extensions.conf extensions_temp.conf
sed -i 's/Type CN/'$hostname'/' csr_config_temp.conf
openssl req -set_serial 50 -new -out $hostname.csr -config csr_config_temp.conf 
sed -i 's/Type DNS Name/'$hostname'/' extensions_temp.conf
sed -i 's/^default_crl_days = 365/#&/' openssl_ca_temp.conf
sed -i 's/CRL_file.crl/Outdated_CRL_file.crl/' extensions_temp.conf
openssl ca -config openssl_ca_temp.conf -out $hostname.crt -extfile extensions_temp.conf -extensions x509_ext -in $hostname.csr -batch -startdate $(echo "$start_date" | tr -cd [:digit:]Z) -enddate $(echo "$end_date" | tr -cd [:digit:]Z)
openssl ca -config openssl_ca.conf -gencrl -out crl/Outdated_CRL_file.crl -crlhours 1
rm -Rf csr_config_temp.conf , openssl_ca_temp.conf , extensions_temp.conf
cat $hostname.crt /etc/ssl/certs/<path_to_InterCA_file> > nginx_chain_#12.crt
mkdir CASE12_EXPIRED_CRL
mv nginx_chain_#12.crt $hostname.crt $hostname.csr private_key.pem CASE12_EXPIRED_CRL
mv CASE12_EXPIRED_CRL /tmp/
rm -rf nginx_chain_#12.crt $hostname.crt $hostname.csr private_key.pem 

rm -rf newcerts/*.crt
mkdir /tmp/nginx_test_x509_env
mv /tmp/CASE* /tmp/nginx_test_x509_env 
mv /tmp/nginx_test_x509_env  /tmp/nginx_test_x509_env_$(date +%Y%m%d_%H_%M_%S)
chmod -R +r /tmp/nginx_test_x509_env_$(date +%Y%m%d_%H_%M_%S)
rm -rf /tmp/nginx_test_x509_env


