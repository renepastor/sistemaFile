
/*aut: renepastor@gmail.com
  fec: 19/06/2017
*/

/*****DOC PERSONAL******/
begin;
  --alter table only files.documentos_personal add foreign key (tipo_documento_id) references files.tbl_tipos(id);
  --alter table only files.documentos_personal add foreign key (tipo_estado_id) references files.tbl_tipos(id);
  --alter table only files.documentos_personal add foreign key (persona_id) references files.usuarios(pers_id);
commit;

