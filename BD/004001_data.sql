begin;

-- Aplicacion
INSERT INTO base.aplicacion (instancia, codigo, nombre, web_url, access_token)
VALUES('00', 'RRHH', 'RRHH', 'Talento Humano', 'ef8f55fa-8982-43c5-8066-32493d13320c');

-- rol
INSERT INTO base.rol (id_aplicacion, codigo, nombre) VALUES (fsis('RRHH'), 'SUPER', 'Superusuario');
INSERT INTO base.rol (id_aplicacion, codigo, nombre) VALUES (fsis('RRHH'), 'ADMIN', 'Administrador');
INSERT INTO base.rol (id_aplicacion, codigo, nombre) VALUES (fsis('RRHH'), 'RESP-VAC', 'Responsable Vacaciones');

-- MODULOS
INSERT INTO base.modulo (id_aplicacion,  posicion, nombre, icono) VALUES (fsis('RRHH'), 1, 'Administración', 'mdi-movie-open-play');
INSERT INTO base.modulo (id_aplicacion,  posicion, nombre, icono) VALUES (fsis('RRHH'), 2, 'Configuración', 'mdi-table-cog');
INSERT INTO base.modulo (id_aplicacion,  posicion, nombre, icono) VALUES (fsis('RRHH'), 3, 'Reportes', 'mdi-chart-line');

-- RECURSOS
INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Configuración','RRHH'), 1, 'Tipo Cambio', 'tipoCambio', true, 'mdi-cash-multiple');
INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Configuración','RRHH'), 5, 'Almacenes', 'recinto', true, 'mdi-home-group');
INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Configuración','RRHH'), 7, 'Empresa Trasportadora', 'empresaTrasportadora', true, 'mdi-tanker-truck');
INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Configuración','RRHH'), 7, 'Materiales', 'materiales', true, 'mdi-warehouse');
INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Configuración','RRHH'), 3, 'Sub Brupo de Material', 'materialSubGrupo', true, 'mdi-group');
INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Configuración','RRHH'), 2, 'Grupo de Material', 'materialGrupo', true, 'mdi-ungroup');
INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Configuración','RRHH'), 4, 'Unidad Medida', 'unidadMedida', true, 'mdi-gauge');
INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Configuración','RRHH'), 6, 'Parametros', 'parametro', true, 'mdi-cogs');

INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Administración','RRHH'), 1, 'Personas', 'ingresoInicial', true, 'mdi-folder-plus-outline');
INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Administración','RRHH'), 2, 'Funcionarios', 'ingreso', true, 'mdi-folder-multiple-plus-outline');
INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Administración','RRHH'), 3, 'Cas', 'solicitarSalida', true, 'mdi-dolly');
INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Administración','RRHH'), 4, 'Vacaciones', 'salidas', true, 'mdi-clipboard-edit-outline');

INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Reportes','RRHH'), 1, 'Rep. Vacaciones', 'existencia', true, 'mdi-chart-box-outline');

-- permisos
INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('SUPER'), frecurso('Personas'), true, true, true, true);
INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('SUPER'), frecurso('Funcionarios'), true, true, true, true);
INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('SUPER'), frecurso('Cas'), true, true, true, true);
INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('SUPER'), frecurso('Vacaciones'), true, true, true, true);
INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('SUPER'), frecurso('Rep. Vacaciones'), true, true, true, true);

-- usuario
--insert into base.usuario(username, nombre_completo,correo_electronico,documento_identidad,numero_celular, eliminado, fecha_registro, usuario_aplicacion) 
--values ('rpmamani','Rene Pastor Mamani Flores', 'rpmamani@ypfb.gob.bo', 'aasd', '234234',false, now(), 'superadmin');

insert into base.usuario(username, clave, alias,correo, creado, creador)
values ('rpmamani',crypt('123456', gen_salt('bf')),'Rene Pastor Mamani Flores', 'rpmamani@gmail.com', now(), 'superadmin');
insert into base.usuario(username, clave, alias,correo, creado, creador) 
values ('jtorrez',crypt('123456', gen_salt('bf')),'Josue Torres', 'jtorrez@gmail.com', now(), 'superadmin');
insert into base.usuario(username, clave, alias,correo, creado, creador) 
values ('abel',crypt('123456', gen_salt('bf')),'Abel Adalid', 'abeladil@gmail.com', now(), 'superadmin');


-- usuarios rol
INSERT INTO base.usuario_rol(id_rol, id_usuario,creado, creador) VALUES(frol('SUPER'), fuser('rpmamani'), now(), 'admin');
INSERT INTO base.usuario_rol(id_rol, id_usuario,creado, creador) VALUES(frol('ADMIN'), fuser('rpmamani'), now(), 'admin');
INSERT INTO base.usuario_rol(id_rol, id_usuario,creado, creador) VALUES(frol('RESP-VAC'), fuser('rpmamani'), now(), 'admin');

commit;


begin;

INSERT INTO base.ubicacion_geografica(dependiente_id, nombre, abreviatura, nivel, activo, creador, creado) VALUES
(1, '-Mundo-', 'UNI', 0, true,'admin',NOW());

INSERT INTO base.ubicacion_geografica(dependiente_id, nombre, abreviatura, nivel, creador, creado) VALUES
(flocgeo('-Mundo-', 0), 'SUD AMERICA', 'SAM', 1,'admin',NOW());

INSERT INTO base.ubicacion_geografica(dependiente_id, nombre, abreviatura, nivel, creador, creado) VALUES
(flocgeo('SUD AMERICA', 1), 'BOLIVIA', 'BOL', 2,'admin',NOW());

INSERT INTO base.ubicacion_geografica(dependiente_id, nombre, abreviatura, nivel, creador, creado) VALUES
(flocgeo('BOLIVIA', 2), 'Chuquisaca', 'CHQ', 3,'admin',NOW()),
(flocgeo('BOLIVIA', 2), 'La Paz', 'LP', 3,'admin',NOW()),
(flocgeo('BOLIVIA', 2), 'Cochabamba', 'CB', 3,'admin',NOW()),
(flocgeo('BOLIVIA', 2), 'Oruro', 'OR', 3,'admin',NOW()),
(flocgeo('BOLIVIA', 2), 'Potosí', 'PT', 3,'admin',NOW()),
(flocgeo('BOLIVIA', 2), 'Tarija', 'TJ', 3,'admin',NOW()),
(flocgeo('BOLIVIA', 2), 'Santa Cruz', 'SCZ', 3,'admin',NOW()),
(flocgeo('BOLIVIA', 2), 'Beni', 'BN', 3,'admin',NOW()),
(flocgeo('BOLIVIA', 2), 'Pando', 'PN', 3,'admin',NOW());

INSERT INTO base.ubicacion_geografica(dependiente_id, nombre, abreviatura, nivel, creador, creado) VALUES
(flocgeo('Chuquisaca', 3), 'Oropeza', '101', 4,'admin',NOW()),
(flocgeo('Chuquisaca', 3), 'Azurduy', '102', 4,'admin',NOW()),
(flocgeo('Chuquisaca', 3), 'Zudañez', '103', 4,'admin',NOW()),
(flocgeo('Chuquisaca', 3), 'Tomina', '104', 4,'admin',NOW()),
(flocgeo('Chuquisaca', 3), 'Hernando Siles', '105', 4,'admin',NOW()),
(flocgeo('Chuquisaca', 3), 'Yamparaez', '106', 4,'admin',NOW()),
(flocgeo('Chuquisaca', 3), 'Nor Cinti', '107', 4,'admin',NOW()),
(flocgeo('Chuquisaca', 3), 'Belisario Boeto', '108', 4,'admin',NOW()),
(flocgeo('Chuquisaca', 3), 'Sud Cinti', '109', 4,'admin',NOW()),
(flocgeo('Chuquisaca', 3), 'Luis Calvo', '110', 4,'admin',NOW());

INSERT INTO base.ubicacion_geografica(dependiente_id, nombre, abreviatura, nivel, creador, creado) VALUES
(flocgeo('La Paz', 3), 'Murillo', '201', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Omasuyos', '202', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Pacajes', '203', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Camacho', '204', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Muñecas', '205', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Larecaja', '206', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Franz Tamayo', '207', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Ingavi', '208', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Loayza', '209', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Inquisivi', '210', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Sur Yungas', '211', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Los Andes', '212', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Aroma', '213', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Nor Yungas', '214', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Abel Iturralde', '215', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Bautista Saavedra', '216', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Manco Kapac', '217', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Gualberto Villarroel', '218', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Gral. J. Manuel Pando', '219', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Caranavi', '220', 4,'admin',NOW());

INSERT INTO base.ubicacion_geografica(dependiente_id, nombre, abreviatura, nivel, creador, creado) VALUES
(flocgeo('Cochabamba', 3), 'Cercado', '301', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'Campero', '302', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'Ayopaya', '303', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'Esteban Arce', '304', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'Arani', '305', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'Arque', '306', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'Capinota', '307', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'German Jordan', '308', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'Quillacollo', '309', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'Chapare', '310', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'Tapacari', '311', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'Carrasco', '312', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'Mizque', '313', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'Punata', '314', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'Bolivar', '315', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'Tiraque', '316', 4,'admin',NOW());

INSERT INTO base.ubicacion_geografica(dependiente_id, nombre, abreviatura, nivel, creador, creado) VALUES
(flocgeo('Oruro', 3), 'Cercado', '401', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'Abaroa', '402', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'Carangas', '403', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'Sajama', '404', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'Litoral', '405', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'Poopo', '406', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'Pantaleon Dalence', '407', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'Ladislao Cabrera', '408', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'Sabaya', '409', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'Saucari', '410', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'Tomas Barron', '411', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'Sur Carangas', '412', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'S. Pedro de Totora', '413', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'Sebastian Pagador', '414', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'Mejillones', '415', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'Nor Carangas', '416', 4,'admin',NOW());

INSERT INTO base.ubicacion_geografica(dependiente_id, nombre, abreviatura, nivel, creador, creado) VALUES
(flocgeo('Potosí', 3), 'Tomas Frias', '501', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Rafael Bustillo', '502', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Cornelio Saavedra', '503', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Chayanta', '504', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Charcas', '505', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Nor Chichas', '506', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Alonzo de Ibañez', '507', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Sur Chichas', '508', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Nor Lipez', '509', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Sur Lipez', '510', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Jose Maria Linares', '511', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Antonio Quijarro', '512', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Gral. B. Bilbao', '513', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Daniel Campos', '514', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Modesto Omiste', '515', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Enrique Baldiviezo','516', 4,'admin',NOW());

INSERT INTO base.ubicacion_geografica(dependiente_id, nombre, abreviatura, nivel, creador, creado) VALUES
(flocgeo('Tarija', 3), 'Cercado', '601', 4,'admin',NOW()),
(flocgeo('Tarija', 3), 'Arce', '602', 4,'admin',NOW()),
(flocgeo('Tarija', 3), 'Gran Chaco', '603', 4,'admin',NOW()),
(flocgeo('Tarija', 3), 'Avilez', '604', 4,'admin',NOW()),
(flocgeo('Tarija', 3), 'Mendez', '605', 4,'admin',NOW()),
(flocgeo('Tarija', 3), 'Burnet O Connor', '606', 4,'admin',NOW());

INSERT INTO base.ubicacion_geografica(dependiente_id, nombre, abreviatura, nivel, creador, creado) VALUES
(flocgeo('Santa Cruz', 3), 'Andres Ibañez', '701', 4,'admin',NOW()),
(flocgeo('Santa Cruz', 3), 'Warnes', '702', 4,'admin',NOW()),
(flocgeo('Santa Cruz', 3), 'Velasco', '703', 4,'admin',NOW()),
(flocgeo('Santa Cruz', 3), 'Ichilo', '704', 4,'admin',NOW()),
(flocgeo('Santa Cruz', 3), 'Chiquitos', '705', 4,'admin',NOW()),
(flocgeo('Santa Cruz', 3), 'Sara', '706', 4,'admin',NOW()),
(flocgeo('Santa Cruz', 3), 'Cordillera', '707', 4,'admin',NOW()),
(flocgeo('Santa Cruz', 3), 'Vallegrande', '708', 4,'admin',NOW()),
(flocgeo('Santa Cruz', 3), 'Florida', '709', 4,'admin',NOW()),
(flocgeo('Santa Cruz', 3), 'Obispo Santiestevan', '710', 4,'admin',NOW()),
(flocgeo('Santa Cruz', 3), 'Ñuflo de Chavez', '711', 4,'admin',NOW()),
(flocgeo('Santa Cruz', 3), 'Angel Sandoval', '712', 4,'admin',NOW()),
(flocgeo('Santa Cruz', 3), 'Caballero', '713', 4,'admin',NOW()),
(flocgeo('Santa Cruz', 3), 'German Busch', '714', 4,'admin',NOW()),
(flocgeo('Santa Cruz', 3), 'Guarayos', '715', 4,'admin',NOW());

INSERT INTO base.ubicacion_geografica(dependiente_id, nombre, abreviatura, nivel, creador, creado) VALUES
(flocgeo('Beni', 3), 'Cercado', '801', 4,'admin',NOW()),
(flocgeo('Beni', 3), 'Vaca Diez', '802', 4,'admin',NOW()),
(flocgeo('Beni', 3), 'Gral. J. Ballivian', '803', 4,'admin',NOW()),
(flocgeo('Beni', 3), 'Yacuma', '804', 4,'admin',NOW()),
(flocgeo('Beni', 3), 'Moxos', '805', 4,'admin',NOW()),
(flocgeo('Beni', 3), 'Marban', '806', 4,'admin',NOW()),
(flocgeo('Beni', 3), 'Mamore', '807', 4,'admin',NOW()),
(flocgeo('Beni', 3), 'Itenez', '808', 4,'admin',NOW());

INSERT INTO base.ubicacion_geografica(dependiente_id, nombre, abreviatura, nivel, creador, creado) VALUES
(flocgeo('Pando', 3), 'Nicolas Suarez', '901', 4,'admin',NOW()),
(flocgeo('Pando', 3), 'Manuripi', '902', 4,'admin',NOW()),
(flocgeo('Pando', 3), 'Madre de Dios', '903', 4,'admin',NOW()),
(flocgeo('Pando', 3), 'Abuna', '904', 4,'admin',NOW()),
(flocgeo('Pando', 3), 'Gral. Federico Roman', '905', 4,'admin',NOW());



INSERT INTO base.tbl_tipos(padre_id,codigo,valor,descripcion,ayuda,creador) VALUES
(1,'--','0','Inicio','Es el origen de la tabla',1);

INSERT INTO base.tbl_tipos(padre_id,codigo,valor,descripcion,ayuda,creador) VALUES
(ftptbl('--'),'GENERO','GENEROS','Tipos de Genero','',1);

INSERT INTO base.tbl_tipos(padre_id,codigo,valor,descripcion,ayuda,creador) VALUES
(ftptbl('GENERO'),'FEMENINO','F','FEMENINO','',1);
INSERT INTO base.tbl_tipos(padre_id,codigo,valor,descripcion,ayuda,creador) VALUES
(ftptbl('GENERO'),'MASCULINO','M','MASCULINO','',1);

INSERT INTO base.tbl_tipos(padre_id,codigo,valor,descripcion,ayuda,creador) VALUES
(ftptbl('--'),'EST-CIVIL','ESTADO CIVIL','ESTADO CIVIL','',1);
INSERT INTO base.tbl_tipos(padre_id,codigo,valor,descripcion,ayuda,creador) VALUES
(ftptbl('EST-CIVIL'),'SOLTERA(O)','S','SOLTERA(O)','',1),
(ftptbl('EST-CIVIL'),'CASADA(O)','C','CASADA(O)','',1),
(ftptbl('EST-CIVIL'),'DIVORCIADA(O)','D','DIVORCIADA(O)','',1),
(ftptbl('EST-CIVIL'),'VIUDA(O)','V','VIUDA(O)','',1);

INSERT INTO base.tbl_tipos(padre_id,codigo,valor,descripcion,ayuda,creador) VALUES
(ftptbl('--'),'TP-DOC-ID','TP-DOC-ID','TIPO DOCUMENTOS DE IDENTIDAD','',1);
INSERT INTO base.tbl_tipos(padre_id,codigo,valor,descripcion,ayuda,creador) VALUES
(ftptbl('TP-DOC-ID'),'DOCUMENTO DE IDENTIDAD','CI','DOCUMENTO DE IDENTIDAD','',1),
(ftptbl('TP-DOC-ID'),'PASAPORTE','PT','PASAPORTE','',1);


INSERT INTO base.tbl_tipos(padre_id,codigo,valor,descripcion,ayuda,creador) VALUES
(ftptbl('--'),'TP-VIVIENDA','TP-VIVI','TIPO TIPO VIVIVIENDA','',1);
INSERT INTO base.tbl_tipos(padre_id,codigo,valor,descripcion,ayuda,creador) VALUES
(ftptbl('TP-VIVIENDA'),'CASA','CASA','CASA','',1),
(ftptbl('TP-VIVIENDA'),'EDIFICIO','EDIFICIO','EDIFICIO','',1),
(ftptbl('TP-VIVIENDA'),'GALERIA','GALERIA','GALERIA','',1);

commit;
