begin;

ALTER TABLE ONLY base.modulo add foreign key (id_aplicacion) references base.aplicacion(id);

ALTER TABLE ONLY base.recurso add foreign key (id_modulo) references base.modulo(id);


ALTER TABLE ONLY base.rol add foreign key (id_aplicacion) references base.aplicacion(id);

ALTER TABLE ONLY base.rol_recurso add foreign key (id_rol) references base.rol(id);
ALTER TABLE ONLY base.rol_recurso add foreign key (id_recurso) references base.recurso(id);


ALTER TABLE ONLY base.usuario_rol add foreign key (id_rol) references base.rol(id);
ALTER TABLE ONLY base.usuario_rol add foreign key (id_usuario) references base.usuario(id);

ALTER TABLE ONLY base.tbl_tipos add foreign key (padre_id) references base.tbl_tipos(id);
ALTER TABLE ONLY base.ubicacion_geografica add foreign key (dependiente_id) references base.ubicacion_geografica(id);


commit;