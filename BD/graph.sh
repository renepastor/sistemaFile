#!/bin/bash

postgraphile \
  --connection postgres://localhost:5432/sinergia \
  --schema base \
  --host localhost \
  --port 8005 \
  --enhance-graphiql \
  --secret 123456 \
  --default-role root \
  --cors
#  --token sijp.jwt \
#  --host localhost \
#  --host 192.168.56.101 \
