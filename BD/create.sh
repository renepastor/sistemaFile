#!/bin/bash
#####name_bd="BDSTORE"
##name_bd="YPFBPTI -h 172.16.0.55 -U postgres "
name_bd="sinergia"
echo "Borrar $name_bd"
dropdb $name_bd
echo "Host BD: $host_bd"
createdb $name_bd

echo '************ INICIO *******' > error
echo '    ******* Tablas ....' >> error
psql $name_bd < 000000_domain.sql 2>> error > log
psql $name_bd < 001001_tbl_ini.sql 2>> error >> log
psql $name_bd < 001002_tbl_rrhh.sql 2>> error >> log
psql $name_bd < 001003_tbl_inv.sql 2>> error >> log
psql $name_bd < 001004_tbl_file.sql 2>> error >> log
psql $name_bd < 003001_fn_ini.sql 2>> error >> log
psql $name_bd < 003004_fn_file.sql 2>> error >> log
psql $name_bd < 004001_data.sql 2>> error >> log
psql $name_bd < 004003_data_inv.sql 2>> error >> log
psql $name_bd < 004004_data_file.sql 2>> error >> log
psql $name_bd < 005001_ref_init.sql 2>> error >> log
psql $name_bd < 005003_ref_init.sql 2>> error >> log
psql $name_bd < 005004_ref_file.sql 2>> error >> log
psql $name_bd < 007001_grant.sql 2>> error >> log
psql $name_bd < 007004_grant_file.sql 2>> error >> log

##psql $name_bd < 00701_grant_app.sql 2>> error >> log



echo '************ FIN ************' >> error
