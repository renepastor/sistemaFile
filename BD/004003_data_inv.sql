begin;

-- Aplicacion
INSERT INTO base.aplicacion (instancia, codigo, nombre, web_url, access_token)
VALUES('100', 'ARGOS', 'ARGOS', 'Gestion de Inventario de Almacenes', 'ef8f55fa-8982-43c5-8066-32493d13320c');

-- rol
INSERT INTO base.rol (id_aplicacion, codigo, nombre) VALUES (fsis('ARGOS'), 'SUPER', 'Superusuario');
INSERT INTO base.rol (id_aplicacion, codigo, nombre) VALUES (fsis('ARGOS'), 'ADMIN', 'Administrador');
INSERT INTO base.rol (id_aplicacion, codigo, nombre) VALUES (fsis('ARGOS'), 'ADMIN-FIS', 'Admbaserador Fisico');
INSERT INTO base.rol (id_aplicacion, codigo, nombre) VALUES (fsis('ARGOS'), 'ADMIN-VAL', 'Admbaserador Valorado');
INSERT INTO base.rol (id_aplicacion, codigo, nombre) VALUES (fsis('ARGOS'), 'RESP-FIS', 'Responsable Fisico');
INSERT INTO base.rol (id_aplicacion, codigo, nombre) VALUES (fsis('ARGOS'), 'RESP-VAL', 'Responsable Valorado');
INSERT INTO base.rol (id_aplicacion, codigo, nombre) VALUES (fsis('ARGOS'), 'RESP-SOL', 'Responsable Solicitud');

-- MODULOS
INSERT INTO base.modulo (id_aplicacion,  posicion, nombre, icono) VALUES (fsis('ARGOS'), 1, 'Administración', 'mdi-movie-open-play');
INSERT INTO base.modulo (id_aplicacion,  posicion, nombre, icono) VALUES (fsis('ARGOS'), 2, 'Configuración', 'mdi-table-cog');
INSERT INTO base.modulo (id_aplicacion,  posicion, nombre, icono) VALUES (fsis('ARGOS'), 3, 'Reportes', 'mdi-chart-line');

-- RECURSOS
INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Configuración','ARGOS'), 1, 'Tipo Cambio', 'tipoCambio', true, 'mdi-cash-multiple');
INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Configuración','ARGOS'), 5, 'Almacenes', 'recinto', true, 'mdi-home-group');
INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Configuración','ARGOS'), 7, 'Empresa Trasportadora', 'empresaTrasportadora', true, 'mdi-tanker-truck');
INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Configuración','ARGOS'), 7, 'Materiales', 'materiales', true, 'mdi-warehouse');
INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Configuración','ARGOS'), 3, 'Sub Brupo de Material', 'materialSubGrupo', true, 'mdi-group');
INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Configuración','ARGOS'), 2, 'Grupo de Material', 'materialGrupo', true, 'mdi-ungroup');
INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Configuración','ARGOS'), 4, 'Unidad Medida', 'unidadMedida', true, 'mdi-gauge');
INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Configuración','ARGOS'), 6, 'Parametros', 'parametro', true, 'mdi-cogs');

INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Administración','ARGOS'), 1, 'Ingreso Inicial', 'ingresoInicial', true, 'mdi-folder-plus-outline');
INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Administración','ARGOS'), 2, 'Ingreso', 'ingreso', true, 'mdi-folder-multiple-plus-outline');
INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Administración','ARGOS'), 3, 'Solicitar Salidas', 'solicitarSalida', true, 'mdi-dolly');
INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Administración','ARGOS'), 4, 'Salidas', 'salidas', true, 'mdi-clipboard-edit-outline');
INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Administración','ARGOS'), 5, 'Solicitar Trasferencia', 'trasferencia', true, 'mdi-home-edit-outline');
INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Administración','ARGOS'), 6, 'Aprobar Trasferencia', 'aprobarTrasferencia', true, 'mdi-home-export-outline');
INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Administración','ARGOS'), 7, 'Cirres', 'cierre', true, 'mdi-package-variant-closed');

INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Reportes','ARGOS'), 1, 'Existencias', 'existencia', true, 'mdi-chart-box-outline');

-- permisos
INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('SUPER'), frecurso('Tipo Cambio'), true, true, true, true);
INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('SUPER'), frecurso('Almacenes'), true, true, true, true);
INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('SUPER'), frecurso('Empresa Trasportadora'), true, true, true, true);
INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('SUPER'), frecurso('Materiales'), true, true, true, true);
INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('SUPER'), frecurso('Sub Brupo de Material'), true, true, true, true);
INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('SUPER'), frecurso('Grupo de Material'), true, true, true, true);
INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('SUPER'), frecurso('Unidad Medida'), true, true, true, true);
INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('SUPER'), frecurso('Parametros'), true, true, true, true);
INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('SUPER'), frecurso('Ingreso Inicial'), true, true, true, true);
INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('SUPER'), frecurso('Ingreso'), true, true, true, true);
INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('SUPER'), frecurso('Solicitar Salidas'), true, true, true, true);
INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('SUPER'), frecurso('Salidas'), true, true, true, true);
INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('SUPER'), frecurso('Solicitar Trasferencia'), true, true, true, true);
INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('SUPER'), frecurso('Aprobar Trasferencia'), true, true, true, true);
INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('SUPER'), frecurso('Cirres'), true, true, true, true);
INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('SUPER'), frecurso('Existencias'), true, true, true, true);

--INSERT INTO base.rol_recurso (id, id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (nextval('base.seq_rol_recurso'), frol('SUPER'), frecurso(''), true, true, true, true);

-- usuario

-- usuarios rol
INSERT INTO base.usuario_rol(id_rol, id_usuario,creado, creador) VALUES(frol('SUPER'), fuser('rpmamani'), now(), 'admin');
INSERT INTO base.usuario_rol(id_rol, id_usuario,creado, creador) VALUES(frol('ADMIN'), fuser('rpmamani'), now(), 'admin');
INSERT INTO base.usuario_rol(id_rol, id_usuario,creado, creador) VALUES(frol('ADMIN-FIS'), fuser('rpmamani'), now(), 'admin');
INSERT INTO base.usuario_rol(id_rol, id_usuario,creado, creador) VALUES(frol('ADMIN-VAL'), fuser('rpmamani'), now(), 'admin');
INSERT INTO base.usuario_rol(id_rol, id_usuario,creado, creador) VALUES(frol('RESP-FIS'), fuser('rpmamani'), now(), 'admin');
INSERT INTO base.usuario_rol(id_rol, id_usuario,creado, creador) VALUES(frol('RESP-VAL'), fuser('rpmamani'), now(), 'admin');
INSERT INTO base.usuario_rol(id_rol, id_usuario,creado, creador) VALUES(frol('RESP-SOL'), fuser('rpmamani'), now(), 'admin');

commit;

