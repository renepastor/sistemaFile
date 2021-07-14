#!/bin/bash

openssl req -x509 -out server.crt -keyout server.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=localhost:8004' -extensions EXT -config <( \
   printf "[dn]\nCN=proyectfin.xyz\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost:8004\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")


