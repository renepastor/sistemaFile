
/*aut: renepastor@gmail.com
  fec: 19/06/2017
*/

/*****DOC PERSONAL******/
begin;
  alter table only nucleo.documentos_personal add foreign key (tipo_documento_id) references nucleo.tbl_tipos(id);
  alter table only nucleo.documentos_personal add foreign key (tipo_estado_id) references nucleo.tbl_tipos(id);
  --alter table only nucleo.documentos_personal add foreign key (persona_id) references nucleo.usuarios(pers_id);
commit;

