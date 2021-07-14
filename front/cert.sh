#!/bin/bash

openssl req -x509 -out front.crt -keyout front.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=localhost:8080' -extensions EXT -config <( \
   printf "[dn]\nCN=proyectfin.xyz\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost:8080\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")

