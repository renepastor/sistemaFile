# sistemaFile
# api File
   Api de acceso de usuario y file
   git clone https://github.com/renepastor/sistemaFile.git
   45.79.7.33
   Abelidal..2021

   Compilar
   ./mvnw spring-boot:run




Enter PEM pass phrase:Abelidal..2021
Verifying - Enter PEM pass phrase: Abelidal..2021
Country Name (2 letter code) [AU]:BO
State or Province Name (full name) [Some-State]:LA-PAZ
Locality Name (eg, city) []:LA-PAZ
Organization Name (eg, company) [Internet Widgits Pty Ltd]:ABIT
Organizational Unit Name (eg, section) []:TI
Common Name (e.g. server FQDN or YOUR name) []:FILE-SERVER
Email Address []:renepastor@gmail.com


AbelAdalid


openssl req -x509 -out localhost.crt -keyout localhost.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=localhost' -extensions EXT -config <( \
   printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")

openssl req -x509 -out proyectfin.xyz.crt -keyout proyectfin.xyz.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=proyectfin.xyz' -extensions EXT -config <( \
   printf "[dn]\nCN=proyectfin.xyz\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:proyectfin.xyz\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")



