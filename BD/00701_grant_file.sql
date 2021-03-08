/*aut: renepastor@gmail.com
  fec: 19/06/2017
*/

/*****ASISTENCIA*****/
begin;
 grant execute on function files.auth(text, text) to publico;
 --grant execute on type base.jwt to files;
  --grant execute on type base.jwt to publico;
 --GRANT SELECT ON nucleo.vw_usuario TO publico;
-- GRANT INSERT ON nucleo.asistencias TO publico;
commit;



