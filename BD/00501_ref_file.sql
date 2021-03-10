
/*aut: renepastor@gmail.com
  fec: 19/06/2017
*/

/*****DOC ******/

begin;
  alter table only files.servicios add foreign key (categoria_id) references files.categoria_servicios(id);
  alter table only files.requisitos_servicios add foreign key (plan_id) references files.planes(id);
  --alter table only files.documentos_personal add foreign key (tipo_documento_id) references files.tbl_tipos(id);
  --alter table only files.documentos_personal add foreign key (tipo_estado_id) references files.tbl_tipos(id);
  --alter table only files.documentos_personal add foreign key (persona_id) references files.usuarios(pers_id);
commit;

