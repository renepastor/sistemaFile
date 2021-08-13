/*aut: renepastor@gmail.com
  fec: 19/06/2017
*/


-- Aplicacion
INSERT INTO base.aplicacion (instancia, codigo, nombre, web_url, access_token)
VALUES('10', 'FILES', 'FILES', 'ADMINISTRACION DE ARCHIVOS', 'ef8f55fa-8982-43c5-8066-32493d13320c');

-- rol
INSERT INTO base.rol (id_aplicacion, codigo, nombre) VALUES (fsis('FILES'), 'SUPER', 'Superusuario');
INSERT INTO base.rol (id_aplicacion, codigo, nombre) VALUES (fsis('FILES'), 'ADMIN', 'Administrador');
INSERT INTO base.rol (id_aplicacion, codigo, nombre) VALUES (fsis('FILES'), 'ASIG-HORA', 'Asigna Hora y Fecha');
INSERT INTO base.rol (id_aplicacion, codigo, nombre) VALUES (fsis('FILES'), 'VAL-FILE', 'Verificar Archivos');
INSERT INTO base.rol (id_aplicacion, codigo, nombre) VALUES (fsis('FILES'), 'SOL-SER', 'Solicitante de Servicios');

-- MODULOS
INSERT INTO base.modulo (id_aplicacion,  posicion, nombre, icono) VALUES (fsis('FILES'), 1, 'Administración', 'mdi-movie-open-play');
INSERT INTO base.modulo (id_aplicacion,  posicion, nombre, icono) VALUES (fsis('FILES'), 2, 'Configuración', 'mdi-table-cog');
INSERT INTO base.modulo (id_aplicacion,  posicion, nombre, icono) VALUES (fsis('FILES'), 3, 'Reportes', 'mdi-chart-line');
INSERT INTO base.modulo (id_aplicacion,  posicion, nombre, icono) VALUES (fsis('FILES'), 4, 'Reportes', 'mdi-chart-line');
INSERT INTO base.modulo (id_aplicacion,  posicion, nombre, icono) VALUES (fsis('FILES'), 5, 'Perfil', 'mdi-card-account-details');

-- RECURSOS
--INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Configuración','ARGOS'), 6, 'Parametros', 'parametro', true, 'mdi-cogs');

INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Administración','FILES'), 1, 'Asignar Hora', 'asignarHora', true, 'mdi-folder-plus-outline');
INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Administración','FILES'), 2, 'Verificar Documentos', 'verificaDoc', true, 'mdi-folder-multiple-plus-outline');
INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Administración','FILES'), 3, 'Solicitudes', 'solicitudes', true, 'mdi-folder-multiple-plus-outline');
INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Administración','FILES'), 4, 'Perfil de Usuario', 'perfil', true, 'mdi-card-account-details');

INSERT INTO base.recurso (id_modulo, posicion, titulo, uri, es_menu, icono) VALUES (fmodulo('Reportes','FILES'), 1, 'Documentos', 'documentos', true, 'mdi-chart-box-outline');

-- permisos
INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('SUPER'), frecurso('Asignar Hora'), true, true, true, true);
INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('SUPER'), frecurso('Verificar Documentos'), true, true, true, true);
INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('SUPER'), frecurso('Documentos'), true, true, true, true);


INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('ASIG-HORA'), frecurso('Asignar Hora'), true, true, true, true);
INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('ASIG-HORA'), frecurso('Documentos'), true, true, true, true);

INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('VAL-FILE'), frecurso('Verificar Documentos'), true, true, true, true);
INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('VAL-FILE'), frecurso('Documentos'), true, true, true, true);

INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('SOL-SER'), frecurso('Solicitudes'), true, true, true, true);
INSERT INTO base.rol_recurso (id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (frol('SOL-SER'), frecurso('Perfil de Usuario'), true, true, true, true);


--INSERT INTO base.rol_recurso (id, id_rol, id_recurso, lectura, creacion, modificacion, eliminacion) VALUES (nextval('base.seq_rol_recurso'), frol('SUPER'), frecurso(''), true, true, true, true);

-- usuario

-- usuarios rol
INSERT INTO base.usuario_rol(id_rol, id_usuario,creado, creador) VALUES(frol('SUPER'), fuser('rpmamani'), now(), 'admin');
INSERT INTO base.usuario_rol(id_rol, id_usuario,creado, creador) VALUES(frol('ASIG-HORA'), fuser('jtorrez'), now(), 'admin');
INSERT INTO base.usuario_rol(id_rol, id_usuario,creado, creador) VALUES(frol('VAL-FILE'), fuser('abel'), now(), 'admin');





/**$$$$$$$$$$******files*****$$$$$*****/
begin;
INSERT INTO files.categoria_servicios(nombre, logo, fecha_inicio, fecha_vigencia, activo, creador, creado) VALUES
('Telefonía Móvil','mdi-cellphone-play',NOW(),NOW(),true,'admin',NOW()),
('Internet','mdi-wifi-check',NOW(),NOW(),true,'admin',NOW()),
('TV','mdi-laptop',NOW(),NOW(),true,'admin',NOW());



INSERT INTO files.servicios(categoria_id, servicio, promocion, formulario, informacion, fecha_inicio, fecha_vigencia, activo, creador, creado) VALUES
(1, 'Simple Ilimitado', TRUE,'./solicitud/simpleIlimitado', '/tplinformacion/simpleIlimitado.html', now(), now(),true,'admin',NOW()),
(1, 'Simple', TRUE,'./solicitud/simple', '/tplinformacion/simple.html', now(), now(),true,'admin',NOW()),
(1, 'Corporativo Exacto', TRUE,'./solicitud/corporativo', '/tplinformacion/corporativo.html', now(), now(),true,'admin',NOW()),
(1, 'Institución Pública', TRUE,'./solicitud/institucionPublica', '/tplinformacion/institucionPublica.html', now(), now(),true,'admin',NOW()),
(1, 'Red Privada Empresarial', TRUE,'./solicitud/rpe', '/tplinformacion/rpe.html', now(), now(),true,'admin',NOW()),
(1, 'Portabilidad TIGO, VIVA Postpago', TRUE,'./solicitud/portabilidad', '/tplinformacion/portabilidad.html', now(), now(),true,'admin',NOW()),
(2, 'Fibra Hogar', TRUE,'./solicitud/fibraHogar', '/tplinformacion/fibraHogar.html', now(), now(),true,'admin',NOW()),
(2, 'Fibra + Móvil', TRUE,'./solicitud/fibraMovil', '/tplinformacion/fibraMovil.html', now(), now(),true,'admin',NOW()),
(2, 'Duo', TRUE,'./solicitud/duo', '/tplinformacion/duo.html', now(), now(),true,'admin',NOW()),
(2, 'Multiplay +', TRUE,'./solicitud/multiplay', '/tplinformacion/multiplay.html', now(), now(),true,'admin',NOW()),
(3, 'Televisión Satelital Postpago', TRUE,'./solicitud/tvSat', '/tplinformacion/tvSat.html', now(), now(),true,'admin',NOW()),
(3, 'IPTV con Fibra Óptica', TRUE,'./solicitud/iptv', '/tplinformacion/iptv.html', now(), now(),true,'admin',NOW());


/*
INSERT INTO files.planes(servicio_id, plan, costo, fecha_inicio, fecha_vigencia, estado, usuario, editado) VALUES
  (1, 'plan 1','234,32BS', now(), now(),true,'admin',NOW()),
  (1, 'plan 2','234,32BS', now(), now(),true,'admin',NOW()),
  (1, 'plan 3','234,32BS', now(), now(),true,'admin',NOW()),
  (2, 'plan 2.1','234,32BS', now(), now(),true,'admin',NOW()),
  (2, 'plan 2.2','234,32BS', now(), now(),true,'admin',NOW()),
  (2, 'plan 2.3','234,32BS', now(), now(),true,'admin',NOW()),
  (2, 'plan 2.4','234,32BS', now(), now(),true,'admin',NOW()),
  (3, 'plan 3.1','234,32BS', now(), now(),true,'admin',NOW()),
  (3, 'plan 3.2','234,32BS', now(), now(),true,'admin',NOW());
*/



INSERT INTO files.requisitos_servicios(servicio_id, descripcion, requerido, activo, creador, creado) VALUES
(1, 'Fotografía de tu documento de identidad', TRUE,true,'admin',NOW()),
(1, 'Fotografía de factura de agua, luz, gas o teléfono', TRUE,true,'admin',NOW()),
(1, 'Si supera un consumo de Bs. 600, una fotografía de tu respaldo financiero', TRUE,true,'admin',NOW()),
(2, 'Fotografía de tu documento de identidad', TRUE,true,'admin',NOW()),
(2, 'Fotografía de factura de agua, luz, gas o teléfono', TRUE,true,'admin',NOW()),
(2, 'Si supera un consumo de Bs. 600, una fotografía de tu respaldo financiero', TRUE,true,'admin',NOW()),
(3, 'Fotografía de tu documento de identidad', TRUE,true,'admin',NOW()),
(3, 'Fotografía de tu Ultima boleta de Pago', TRUE,true,'admin',NOW()),
(3, 'Si supera un consumo de Bs. 600, una fotografía de tu respaldo financiero', TRUE,true,'admin',NOW()),
(4, 'Fotografía de tu documento de identidad', TRUE,true,'admin',NOW()),
(4, 'Fotografía de tu Ultima boleta de Pago', TRUE,true,'admin',NOW()),
(4, 'Factura de servicio básico', TRUE,true,'admin',NOW()),
(4, 'Si supera un consumo de Bs. 600, una fotografía de tu respaldo financiero.', TRUE,true,'admin',NOW()),
(5, 'Ser parte del plan Simple Ilimitado', TRUE,true,'admin',NOW()),
(5, 'Fotografía de tu documento de identidad', TRUE,true,'admin',NOW()),
(5, 'Fotografía de tu Ultima boleta de Pago', TRUE,true,'admin',NOW()),
(5, 'Fotografía de factura de agua, luz, gas o teléfono', TRUE,true,'admin',NOW()),
(5, 'Si supera un consumo de Bs. 600, una fotografía de tu respaldo financiero.', TRUE,true,'admin',NOW()),
(6, 'Fotografía de tu documento de identidad', TRUE,true,'admin',NOW()),
(6, 'Fotografía de tu Ultima boleta de Pago', TRUE,true,'admin',NOW()),
(6, 'Fotografía de factura de agua, luz, gas o teléfono', TRUE,true,'admin',NOW()),
(6, 'Si supera un consumo de Bs. 600, una fotografía de tu respaldo financiero', TRUE,true,'admin',NOW()),
(6, 'Fecha de Activación en la empresa donante.', TRUE,true,'admin',NOW()),
(7, 'Fotografía de tu documento de identidad', TRUE,true,'admin',NOW()),
(7, 'Fotografía de factura de agua, luz, gas o teléfono', TRUE,true,'admin',NOW()),
(7, 'Si supera un consumo de Bs. 600, una fotografía de tu respaldo financiero', TRUE,true,'admin',NOW()),
(8, 'Fotografía de tu documento de identidad', TRUE,true,'admin',NOW()),
(8, 'Fotografía de factura de agua, luz, gas o teléfono', TRUE,true,'admin',NOW()),
(8, 'Si supera un consumo de Bs. 600, una fotografía de tu respaldo financiero', TRUE,true,'admin',NOW()),
(9, 'Fotografía de tu documento de identidad', TRUE,true,'admin',NOW()),
(9, 'Fotografía de factura de agua, luz, gas o teléfono', TRUE,true,'admin',NOW()),
(9, 'Si supera un consumo de Bs. 600, una fotografía de tu respaldo financiero', TRUE,true,'admin',NOW()),
(10, 'Fotografía de tu documento de identidad', TRUE,true,'admin',NOW()),
(10, 'Fotografía de factura de agua, luz, gas o teléfono', TRUE,true,'admin',NOW()),
(10, 'Si supera un consumo de Bs. 600, una fotografía de tu respaldo financiero', TRUE,true,'admin',NOW()),
(11, 'Fotografía de tu documento de identidad', TRUE,true,'admin',NOW()),
(11, 'Fotografía de factura de agua, luz, gas o teléfono', TRUE,true,'admin',NOW()),
(11, 'Si supera un consumo de Bs. 600, una fotografía de tu respaldo financiero', TRUE,true,'admin',NOW()),
(12, 'Fotografía de tu documento de identidad', TRUE,true,'admin',NOW()),
(12, 'Fotografía de factura de agua, luz, gas o teléfono', TRUE,true,'admin',NOW()),
(12, 'Si supera un consumo de Bs. 600, una fotografía de tu respaldo financiero', TRUE,true,'admin',NOW());


INSERT INTO base.tbl_tipos(padre_id,codigo,valor,descripcion,ayuda,creador) VALUES
(ftptbl('--'),'PLAN-SIM-ILI','PLAN-SIM-ILI','PLAN SIMPLE ILIMITADO','',1);
INSERT INTO base.tbl_tipos(padre_id,codigo,valor,descripcion,ayuda,creador) VALUES
(ftptbl('PLAN-SIM-ILI'),'PLNA-','2','Simple 30','',1),
(ftptbl('PLAN-SIM-ILI'),'PLNA-','2','Simple 50','',1),
(ftptbl('PLAN-SIM-ILI'),'PLNA-','3','Simple 100','',1),
(ftptbl('PLAN-SIM-ILI'),'PLNA-','3','Simple 150','',1),
(ftptbl('PLAN-SIM-ILI'),'PLNA-','4','Simple 200','',1),
(ftptbl('PLAN-SIM-ILI'),'PLNA-','4','Simple 250','',1),
(ftptbl('PLAN-SIM-ILI'),'PLNA-','5','Simple 350','',1),
(ftptbl('PLAN-SIM-ILI'),'PLNA-','5','Simple 500','',1),
(ftptbl('PLAN-SIM-ILI'),'PLNA-','100','Simple 750','',1);


INSERT INTO base.tbl_tipos(padre_id,codigo,valor,descripcion,ayuda,creador) VALUES
(ftptbl('--'),'TP-ATN-SOC','TP ATN SOC','TIPO DE ATENCION SOCIAL','',1);
INSERT INTO base.tbl_tipos(padre_id,codigo,valor,descripcion,ayuda,creador) VALUES
(ftptbl('TP-ATN-SOC'),'TP-ATN-SOC-1','1','ADULTO MAYOR','',1),
(ftptbl('TP-ATN-SOC'),'TP-ATN-SOC-2','2','DISCAPACITADO','',1),
(ftptbl('TP-ATN-SOC'),'TP-ATN-SOC-3','3','EMBARAZADA','',1),
(ftptbl('TP-ATN-SOC'),'TP-ATN-SOC-4','4','NINGUNO','',1);


-------******PROCESO******--
INSERT INTO base.procesos (proceso, codigo, secuenciador, activo, creador) VALUES
('SOLICITUD DE SERVICIO', 'SOL-SER', 1, true, 'admin');


-------******ACTIVIDAD******--
INSERT INTO base.actividades (id_proceso, actividad, orden, url, imagen, duracion, destino, permisos, criterio, activo, creador) VALUES
('1005000000000001', 'Solicitar Servicio', 1, '/files/inicio', 'fa-folder-open', 8, '{}', '[]', 'I', true, 'admin'),
('1005000000000001', 'Asignar Hora', 1, '/files/asignarHora', 'fa-folder-open', 8, '{}', '{"fn":"fnInmSuperior()"}', 'I', true, 'admin'),
('1005000000000001', 'Verificacion Documentos', 1, '/files/verificarDoc', 'fa-folder-open', 8, '{}', '{"fn":"fnResRRHHVacacion()"}', 'I', true, 'admin'),
('1005000000000001', 'Facturar Servicio', 1, '/files/facturar', 'fa-folder-open', 8, '{}', '{"fn":"fnResRRHHVacacion()"}', 'I', true, 'admin'),
('1005000000000001', 'Archivar Solicitud', 4, '/files/archivar', 'fa-archive bg-info', 8, '{"fn":"fnArchivarVacacion()"}', '[]', 'F', true, 'admin');

INSERT INTO files.multicentros(ciudad_id, nombre, direccion, coordenada, creador, creado) VALUES
(flocgeo('La Paz', 3)    , 'ISLA AEROPUERTO EL ALTO', 'AEROPUERTO INTERNACIONAL EL ALTO', '[]','admin',NOW()),
(flocgeo('La Paz', 3)    , 'ISLA UMSA', 'FACULTAD DE DERECHO CALLE LOAYZA ESQ. C. POTOSI', '[]','admin',NOW()),
(flocgeo('La Paz', 3)    , 'ISLA ESTACION CENTRAL', 'AV. MANCO KAPAC ZONA SAN SEBASTIAN (EX ESTACION CENTRAL?MI TELEFERICO LINEA ROJA)', '[]','admin',NOW()),
(flocgeo('La Paz', 3)    , 'ISLA SOPOCACHI', 'CALLE MENDEZ ARCOS ESQ. MIGUEL DE CERVANTES (ESTACION DE MI TELEFERICO - LINEA AMARILLA)', '[]','admin',NOW()),
(flocgeo('La Paz', 3)    , 'MC ELOY SALMON', 'CALLE PEDRO DE LA GASCA # 635 CASI ESQ. CALLE SEBASTIAN SEGUROLA. SHOPING VILLAVERDE. ZONA GRAN PODER', '[]','admin',NOW()),
(flocgeo('La Paz', 3)    , 'MC VILLA FATIMA', 'FINAL AV. TEJADA SORZANO #393 ENTRE AV. LAS AMERICAS Y CALLE UNDUAVI. EDIFICIO WENSYS ', '[]','admin',NOW()),
(flocgeo('La Paz', 3)    , 'MC VILLA ADELA', 'ZONA BOLIVAR MUNICIPAL. AV. CARRETERA A VIACHA. CRUCE VILLA ADELA #16', '[]','admin',NOW()),
(flocgeo('La Paz', 3)    , 'MC VIACHA', 'AV. PANDO ENTRE C. CAPITAN ORELLANA E ILLIMANI. GALERIA ACUARIO', '[]','admin',NOW()),
(flocgeo('La Paz', 3)    , 'MC TOWER', 'CALLE FEDERICO ZUAZO # 1771', '[]','admin',NOW()),
(flocgeo('La Paz', 3)    , 'MC RIO SECO', 'AV. PANAMERICANA S/N. ZONA EX TRANCA RIO SECO', '[]','admin',NOW()),
(flocgeo('La Paz', 3)    , 'MC LA CEJA', 'AV. 6 DE MARZO NRO 200 CASI ESQUINA CALLE 2. ZONA CEJA. (EX ELECTROPAZ)', '[]','admin',NOW()),
(flocgeo('La Paz', 3)    , 'MC COPACABANA', 'CALLE MURILLO S/N INGRESO A PLAZA CENTRAL COPACABANA', '[]','admin',NOW()),
(flocgeo('La Paz', 3)    , 'MC CARANAVI', 'CALLE BOLIVAR ESQ. TOCOPILLA S/N. PLAZA PRINCIPAL SIMON BOLIVAR', '[]','admin',NOW()),
(flocgeo('La Paz', 3)    , 'MC CALACOTO', 'AV. BALLIVIAN NRO 7896. EDIF. MONTECRISTO ESQ. CALLE 22', '[]','admin',NOW()),
(flocgeo('La Paz', 3)    , 'MC AYACUCHO LPZ', 'CALLE AYACUCHO # 267. EDIF. ENTEL (1/2 CUADRA DEL OBELISCO)', '[]','admin',NOW()),
(flocgeo('La Paz', 3)    , 'MC 16 DE JULIO', 'AV. ALFONSO UGARTE #132. ENTRE AV. VICTOR GUTIERREZ Y AV. ARTURO VALLE', '[]','admin',NOW()),
(flocgeo('Chuquisaca', 3), 'MC CAMARGO','CALLE POTOSI #76', '[]','admin',NOW()),
(flocgeo('Chuquisaca', 3), 'MC VICTORIA','AV. DEL MAESTRO #586 ESQ. AV. JAIME MENDOZA', '[]','admin',NOW()),
(flocgeo('Chuquisaca', 3), 'MC SUCRE', 'C. ESPANA # 271 ENTRE C. CAMARGO Y URCULLO','[]','admin',NOW()),
(flocgeo('Chuquisaca', 3), 'MC MONTEAGUDO','CALLE SUCRE #966 ESQ. C. GEORGINA WARNES', '[]','admin',NOW()),
(flocgeo('Cochabamba', 3), 'ISLA AEROPUERTO CBBA','AV. GUILLERMO KILLMAN S/N. ZONA CHIMBA', '[]','admin',NOW()),
(flocgeo('Cochabamba', 3), 'MC TERMINAL CBBA','AV. AYACUCHO # 1634. EDIFICIO MAFUME. ENTRE C. CLIZA Y ARANI FINAL C. ESTEBAN ARCE.', '[]','admin',NOW()),
(flocgeo('Cochabamba', 3), 'MC SUECIA','AVENIDA SUECIA # 777. ZONA HUAYRA KASA', '[]','admin',NOW()),
(flocgeo('Cochabamba', 3), 'MC SHINAHOTA','AV. PANAMERICANA S/N. ENTRE C. GERMAN BUSCH Y TAJIBOS ', '[]','admin',NOW()),
(flocgeo('Cochabamba', 3), 'MC SACABA','AV. BARRIENTOS ESQUINA C. BENEMERITOS', '[]','admin',NOW()),
(flocgeo('Cochabamba', 3), 'MC QUILLACOLLO','CALLE COCHABAMBA ACERA NORTE. ENTRE C. 6 DE AGOSTO Y C. PACHECO.', '[]','admin',NOW()),
(flocgeo('Cochabamba', 3), 'MC PUNATA','CALLE SUCRE S/N', '[]','admin',NOW()),
(flocgeo('Cochabamba', 3), 'MC LA CANCHA','CALLE SAN MARTIN #1129 ENTRE HONDURAS Y PUNATA (NUEVA DIRECCION)', '[]','admin',NOW()),
(flocgeo('Cochabamba', 3), 'MC IVIRGARZAMA','AV. MORTHENSON S/N ENTRE C. TARIJA Y C. CHUQUISACA ', '[]','admin',NOW()),
(flocgeo('Cochabamba', 3), 'MC ETERAZAMA','AV. RESISTENCIA S/N ', '[]','admin',NOW()),
(flocgeo('Cochabamba', 3), 'MC ENTRE RIOS CBBA','AV. PANAMERICANA S/N. ESQUINA CALLE SUCRE ', '[]','admin',NOW()),
(flocgeo('Cochabamba', 3), 'MC AYACUCHO CBBA','AV. AYACUCHO ESQUINA C. GENERAL ACHA', '[]','admin',NOW()),
(flocgeo('Cochabamba', 3), 'MC AMERICA','AV. AMERICA ESQ C. ADELA ZAMUDIO EDIF. SANTA ANA', '[]','admin',NOW()),
(flocgeo('Cochabamba', 3), 'MC AIQUILE','AV. TERAN S/N ENTRE AV. BOLIVAR Y AV. SUCRE', '[]','admin',NOW()),
(flocgeo('Oruro', 3)     , 'MC ESTACION DE AUTOBUSES', 'AV. CIRCUNVALACION ENTRE PROLONGACION CAMPO JORDAN (AL INTERIOR DE LA ESTACION DE AUTOBUSES)', '[]','admin',NOW()),
(flocgeo('Oruro', 3)     , 'ISLA TERMINAL ORURO', 'AV. BRASIL ESQUINA C. 21 DE ENERO ', '[]','admin',NOW()),
(flocgeo('Oruro', 3)     , 'MC CHALLAPATA', 'C. LA BANDERA ENTRE C. EJERCITO Y C. MURILLO DORADO S/N', '[]','admin',NOW()),
(flocgeo('Oruro', 3)     , 'MC YOUNG', 'AV. ESPAÑA #2063 ENTRE C. GENERAL ACHA Y AV. AVAROA', '[]','admin',NOW()),
(flocgeo('Oruro', 3)     , 'MC ORURO', 'CALLE BOLIVAR S/N ESQ. C. SORIA GALVARRO EDIF. ENTEL', '[]','admin',NOW()),
(flocgeo('Oruro', 3)     , 'MC NORTE SEBASTIAN PAGADOR', 'AV. BUSCH # 101 ESQUINA C. BENI ', '[]','admin',NOW()),
(flocgeo('Oruro', 3)     , 'MC HUANUNI', 'CALLE BOLIVAR S/N ZONA CENTRAL ESQ. PASAJE PLAZA FERMIN LOPEZ', '[]','admin',NOW()),
(flocgeo('Potosí', 3)    , 'MC VILLAZON', 'AV. ANTOFAGASTA S/N. ESQUINA CALLE ORURO','[]','admin',NOW()),
(flocgeo('Potosí', 3)    , 'MC UYUNI', 'AV. ARCE S/N. ESQUINA AV. POTOSI','[]','admin',NOW()),
(flocgeo('Potosí', 3)    , 'MC TUPIZA','CALLE GUALBERTO VILLARROEL S/N.', '[]','admin',NOW()),
(flocgeo('Potosí', 3)    , 'MC LLALLAGUA','AV. 10 DE NOVIEMBRE S/N. ESQUINA CALLE POTOS?.', '[]','admin',NOW()),
(flocgeo('Potosí', 3)    , 'MC MERCADO UYUNI','CALLE PANDO #211. ENTRE AV. SANTA CRUZ Y AV. ARCE', '[]','admin',NOW()),
(flocgeo('Potosí', 3)    , 'ISLA TERMINAL POTOSI','AV. LAS BANDERAS S/N.', '[]','admin',NOW()),
(flocgeo('Potosí', 3)    , 'MC POTOSI','CALLE COCHABAMBA S/N. CASI ESQ. CALLE BOLIVAR', '[]','admin',NOW()),
(flocgeo('Tarija', 3)    , 'MC ENTRE RIOS TARIJA','CALLE AYACUCHO S/N ENTRE C. FROILAN TEJERINA Y SUCRE ', '[]','admin',NOW()),
(flocgeo('Tarija', 3)    , 'ISLA SEDE SINDICAL','AV. POTOSI #376 ENTRE CALLES MENDEZ Y SANTA CRUZ', '[]','admin',NOW()),
(flocgeo('Tarija', 3)    , 'MC YACUIBA','CALLE COCHABAMBA #318 ESQ. C. COMERCIO ', '[]','admin',NOW()),
(flocgeo('Tarija', 3)    , 'MC VILLAMONTES','CALLE COCHABAMBA S/N ENTRE C. ORURO E INGAVI', '[]','admin',NOW()),
(flocgeo('Tarija', 3)    , 'MC BERMEJO','AV. BARRIENTOS ORTU?O S/N ESQUINA C. COCHABAMBA ', '[]','admin',NOW()),
(flocgeo('Tarija', 3)    , 'MC VIRGEN DE FATIMA','AV. LA PAZ #495. ENTRE C. BELGRANO Y DELFIN PINO ', '[]','admin',NOW()),
(flocgeo('Tarija', 3)    , 'MC TARIJA','CALLE VIRGINIO LEMA #231. ESQUINA CALLE DANIEL CAMPOS ', '[]','admin',NOW()),
(flocgeo('Tarija', 3)    , 'MC MERCADO CAMPESINO','AV. PANAMERICANA #1606. EDIFICIO SHOPING SUR. ESQUINA CALLE TIMOTEO RAZA ', '[]','admin',NOW()),
(flocgeo('Santa Cruz', 3), 'MC 24 DE SEPTIEMBRE', 'CALLE 24 DE SEPTIEMBRE S/N. ESQUINA CALLE BOLIVAR (PLAZA PRINCIPAL 24 DE SEPTIEMBRE)', '[]','admin',NOW()),
(flocgeo('Santa Cruz', 3), 'MC COMARAPA', 'CALLE COCHABAMBA S/N. ENTRE AV. ESCALANTE MENDOZA Y MANUEL MARIA CABALLERO.', '[]','admin',NOW()),
(flocgeo('Santa Cruz', 3), 'MC VENTURA MALL', 'BARRIO 2 DE ABRIL 4TO ANILLO. AV. COSTANERA.', '[]','admin',NOW()),
(flocgeo('Santa Cruz', 3), 'MC ASCENSION DE GUARAYOS', 'CALLE BOLIVAR S/N', '[]','admin',NOW()),
(flocgeo('Santa Cruz', 3), 'MC EL CHULITO', 'MC EL CHULITO', '[]','admin',NOW()),
(flocgeo('Santa Cruz', 3), 'MC SAN JULIAN', 'PLAZA PRINCIPAL 24 DE JUNIO', '[]','admin',NOW()),
(flocgeo('Santa Cruz', 3), 'MC TERMINAL BIMODAL', 'AV. INTERRADIAL 3ER ANILLO INTERNO', '[]','admin',NOW()),
(flocgeo('Santa Cruz', 3), 'ISLA AEROPUERTO VIRU VIRU', 'AV. 677. AEROPUERTO INTERNACIONAL VIRU VIRU', '[]','admin',NOW()),
(flocgeo('Santa Cruz', 3), 'MC NORTE WARNES', 'AV. 25 DE MAYO S/N. ESQ. C. JOSE MOLINA CAMPOS? ZONA NORTE', '[]','admin',NOW()),
(flocgeo('Santa Cruz', 3), 'MC EL BAJIO', 'KM 6. AV. GRIGOTA (DOBLE VIA A LA GUARDIA). ENTRE CALLES TAJIBO Y CAFETAL ', '[]','admin',NOW()),
(flocgeo('Santa Cruz', 3), 'MC PAMPA DE LA ISLA', 'AV. VIRGEN DE COTOCA ESQ. AV. MONTECRISTO ZONA ESTE ', '[]','admin',NOW()),
(flocgeo('Santa Cruz', 3), 'MC ROBORE', 'CALLE RICARDO MULLER S/N. ESQUINA C. 25 DE OCTUBRE ZONA CENTRAL', '[]','admin',NOW()),
(flocgeo('Santa Cruz', 3), 'MC CINE CENTER', 'AV. MONSEÑOR JOSE BELISARIO SANTIESTEVAN ESQ. AV. EL TROMPILLO', '[]','admin',NOW()),
(flocgeo('Santa Cruz', 3), 'MC VALLEGRANDE', 'C. SIMON BOLIVAR #106 ', '[]','admin',NOW()),
(flocgeo('Santa Cruz', 3), 'MC PUERTO SUAREZ', 'FINAL CALLE LA PAZ S/N. ', '[]','admin',NOW()),
(flocgeo('Santa Cruz', 3), 'MC SAN IGNACIO DE VELASCO', 'C. BOLIVAR S/N. ESQ. C. COCHABAMBA', '[]','admin',NOW()),
(flocgeo('Santa Cruz', 3), 'MC SAN JOSE DE CHIQUITOS', 'C. OBISPO SANTIESTEBAN S/N ', '[]','admin',NOW()),
(flocgeo('Santa Cruz', 3), 'MC YAPACANI', 'C. JUNIN S/N ESQ. BUENOS AIRES', '[]','admin',NOW()),
(flocgeo('Santa Cruz', 3), 'MC PLAN 3000', 'AV. PAURITO # 6065', '[]','admin',NOW()),
(flocgeo('Santa Cruz', 3), 'MC 1 DE MAYO', 'CIUDADELA VILLA 1 DE MAYO S/N ENTRE CALLES 3 Y 4', '[]','admin',NOW()),
(flocgeo('Santa Cruz', 3), 'MC CAMIRI', 'CALLE TTE. CORONEL SANCHEZ S/N. ESQ. C. COMERCIO', '[]','admin',NOW()),
(flocgeo('Santa Cruz', 3), 'MC MONTERO', 'C. LITORAL #14. ESQ. C. ISAIAS PARADA', '[]','admin',NOW()),
(flocgeo('Santa Cruz', 3), 'MC BANZER', 'AV. BANZER. KM 3 1/2 PASANDO 4TO ANILLO CARRETERA AL NORTE', '[]','admin',NOW()),
(flocgeo('Santa Cruz', 3), 'MC LA RAMADA', 'AV. GRIGOTA S/N ESQ. C. OMAR CHÁVEZ', '[]','admin',NOW()),
(flocgeo('Santa Cruz', 3), 'MC WARNES', 'CALLE WARNES #50 CASI ESQ. C. RENE MORENO', '[]','admin',NOW()),
(flocgeo('Beni', 3)      , 'MC SAN BORJA', 'ZONA CENTRAL. ENTRE CALLE LA PAZ Y AV. SELIM MAJLUF S/N ', '[]','admin',NOW()),
(flocgeo('Beni', 3)      , 'ISLA TERMINAL EDMUNDO VACA', 'CARRETERA A SANTA CRUZ KM 5. S/N', '[]','admin',NOW()),
(flocgeo('Beni', 3)      , 'ISLA AEROPUERTO JORGE HENRICH', 'AVENIDA LAUREANO VILLAR GARCIA', '[]','admin',NOW()),
(flocgeo('Beni', 3)      , 'MC GUAYARAMERIN', 'AV. 25 DE MAYO S/N ENTRE AV. GRAL. FEDERICO ROMAN Y C. MARISCAL SANTA CRUZ', '[]','admin',NOW()),
(flocgeo('Beni', 3)      , 'MC RURRENABAQUE', 'AV. COMERCIO ESQUINA C. SANTA CRUZ', '[]','admin',NOW()),
(flocgeo('Beni', 3)      , 'MC RIBERALTA', 'AV. ANTENOR VASQUEZ ESQ. C. DR. MARTINEZ ', '[]','admin',NOW()),
(flocgeo('Beni', 3)      , 'MC TRINIDAD', 'AV. CIPRIANO BARACE # 20', '[]','admin',NOW()),
(flocgeo('Pando', 3)     , 'MC PERLA DEL ACRE', 'CALLE MARISCAL ANTONIO JOSE DE SUCRE S/N. ENTRE CALLES NICOLAS SUAREZ LIBERTADOR SIMON BOLIVAR', '[]','admin',NOW()),
(flocgeo('Pando', 3)     , 'MC COBIJA', 'AV. JOSE MANUEL PANDO S/N. ESQUINA C. FEDERICO ROMAN (A UNA CUADRA DEL BANCO SOL)', '[]','admin',NOW());




commit;

