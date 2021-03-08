
/*aut: renepastor@gmail.com
  fec: 19/06/2017
*/
begin;
--alter table only base. add foreign key (_id) references base.(id);
alter table only base.tbl_tipos add foreign key (padre_id) references base.tbl_tipos(id);
--alter table only base.usuarios add foreign key (pers_id) references base.personas(id);

alter table only base.enlaces add foreign key (padre_id) references base.enlaces(id);
--alter table only base.usr_roles add foreign key (user_id) references base.personas(id);
alter table only base.usr_roles add foreign key (user_id) references base.usuarios(pers_id);
alter table only base.usr_roles add foreign key (rol_id) references base.roles(id);
alter table only base.menues add foreign key (rol_id) references base.roles(id);
alter table only base.menues add foreign key (enla_id) references base.enlaces(id);

alter table only base.actividades add foreign key (proceso_id) references base.procesos(id);


alter table only base.tramites add foreign key (proceso_id) references base.procesos(id);
alter table only base.tramites add foreign key (actividad_id) references base.actividades(id);
alter table only base.tramites add foreign key (remitente_id) references base.usuarios(pers_id);
alter table only base.tramites add foreign key (receptor_id) references base.usuarios(pers_id);
--alter table only base.tramites add foreign key (receptor_id) references base.usuarios(pers_id);


alter table only base.tramites_log add foreign key (proceso_id) references base.procesos(id);
alter table only base.tramites_log add foreign key (actividad_id) references base.actividades(id);
alter table only base.tramites_log add foreign key (remitente_id) references base.usuarios(pers_id);
alter table only base.tramites_log add foreign key (receptor_id) references base.usuarios(pers_id);
--alter table only base.tramites_log add foreign key (receptor_id) references base.usuarios(pers_id);
alter table only base.tramites_log add foreign key (tramite_id) references base.tramites(id);


commit;

