#!/bin/bash

openssl req -x509 -out server.crt -keyout server.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=proyectfin.xyz' -extensions EXT -config <( \
   printf "[dn]\nCN=proyectfin.xyz\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:proyectfin.xyz\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")


