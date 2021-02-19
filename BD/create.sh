#!/bin/bash
host_bd="localhost"
name_bd="BDYPFB"
echo "Borrar $name_bd"
echo "Host BD: $host_bd"
dropdb $name_bd


createdb $name_bd
echo "Crear BD $name_bd"

echo '************ INICIO *******' > error
echo '    ******* Tablas ....' >> error
psql $name_bd < 00100_domain.sql 2>> error > log
psql $name_bd < 00200_tbl.sql 2>> error >> log
psql $name_bd < 00201_tbl_rrhh.sql 2>> error >> log
psql $name_bd < 00203_tbl_eess.sql 2>> error >> log
psql $name_bd < 00204_tbl_dom.sql 2>> error >> log


echo '    ******* Funciones....' >> error
psql $name_bd < 00300_fn.sql 2>> error >> log
psql $name_bd < 00301_fn_rrhh.sql 2>> error >> log
psql $name_bd < 00303_fn_eess.sql 2>> error >> log

echo '    ******* Datos....' >> error
psql $name_bd < 00400_data.sql 2>> error >> log
psql $name_bd < 00401_data_rrhh.sql 2>> error >> log
psql $name_bd < 00403_data_eess.sql 2>> error >> log
psql $name_bd < 00404_data_dom.sql 2>> error >> log

echo '    ******* Referencias....' >> error
psql $name_bd < 00500_ref.sql 2>> error >> log
psql $name_bd < 00501_ref_rrhh.sql 2>> error >> log
psql $name_bd < 00503_ref_eess.sql 2>> error >> log
psql $name_bd < 00504_ref_dom.sql 2>> error >> log

echo '    ******* Grant....' >> error
psql $name_bd < 00700_grant.sql 2>> error >> log
psql $name_bd < 00701_grant_rrhh.sql 2>> error >> log
##psql $name_bd < 00703_grant_eess.sql 2>> error >> log


##psql $name_bd < 00701_grant_app.sql 2>> error >> log



echo '************ FIN ************' >> error
