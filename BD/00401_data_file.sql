/*aut: renepastor@gmail.com
  fec: 19/06/2017
*/
/***$$$****VACACIONES***$$$****/
begin;
-------*****PARAMETROS*****
INSERT INTO nucleo.parametros (campo,valor,sistema,descripcion,usuario)
VALUES('PER-VACA-VAL','9','RRHH', 'PERIODOS VALIDOS DE VACACION',1);

-------******TBL TIPOS******--
INSERT INTO nucleo.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,validador,usuario) VALUES
(1011100000000001,'GRUPO-EDNICO','GRUPO EDNICO','GRUPO EDNICO','','',1);
INSERT INTO nucleo.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,validador,usuario) VALUES
(nucleo.fn_tipo_nombre_id('GRUPO-EDNICO'),'CITADINO','CITADINO','CITADINO','','',1);
INSERT INTO nucleo.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,validador,usuario) VALUES
(nucleo.fn_tipo_nombre_id('GRUPO-EDNICO'),'AYMARA','AYMARA','AYMARA','','',1);
INSERT INTO nucleo.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,validador,usuario) VALUES
(nucleo.fn_tipo_nombre_id('GRUPO-EDNICO'),'QUECHUA','QUECHUA','QUECHUA','','',1);
INSERT INTO nucleo.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,validador,usuario) VALUES
(nucleo.fn_tipo_nombre_id('GRUPO-EDNICO'),'GUARANI','GUARANI','GUARANI','','',1);

INSERT INTO nucleo.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,validador,usuario) VALUES
(1011100000000001,'GRUPO-SANGUINEO','GRUPO SANGUINEO','GRUPO SANGUINEO','','',1);
INSERT INTO nucleo.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,validador,usuario) VALUES
(nucleo.fn_tipo_nombre_id('GRUPO-SANGUINEO'),'O(+)','O POSITIVO','O(+)','','',1);
INSERT INTO nucleo.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,validador,usuario) VALUES
(nucleo.fn_tipo_nombre_id('GRUPO-SANGUINEO'),'A','A','A','','',1);

INSERT INTO nucleo.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,validador,usuario) VALUES
(1011100000000001,'ENTI-FINANCIERA','ENTI FINANCIERA','ENTI FINANCIERA','','',1);
INSERT INTO nucleo.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,validador,usuario) VALUES
(nucleo.fn_tipo_nombre_id('ENTI-FINANCIERA'),'BU','BU','BU','','',1);
INSERT INTO nucleo.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,validador,usuario) VALUES
(nucleo.fn_tipo_nombre_id('ENTI-FINANCIERA'),'BNB','BNB','BNB','','',1);

INSERT INTO nucleo.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,validador,usuario) VALUES
(1011100000000001,'TIPO AUSENCIA','TIPO AUSENCIA','TIPO AUSENCIA','','',1);
INSERT INTO nucleo.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,validador,usuario) VALUES
(nucleo.fn_tipo_nombre_id('TIPO AUSENCIA'),'BAJA MEDICA','BAJA MEDICA','BAJA MEDICA','','',1);
INSERT INTO nucleo.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,validador,usuario) VALUES
(nucleo.fn_tipo_nombre_id('TIPO AUSENCIA'),'SIN GOSE','SIN GOSE DE HAVER','SIN GOSE DE HAVER','','',1);


INSERT INTO nucleo.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,validador,usuario) VALUES
(1011100000000001,'DIAS POR AÑOS','DIAS POR AÑOS','DIAS POR AÑOS','','',1);
INSERT INTO nucleo.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,validador,usuario) VALUES
(nucleo.fn_tipo_nombre_id('DIAS POR AÑOS'),'V >= 0 AND V < 5','15','15 DIAS','','',1);
INSERT INTO nucleo.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,validador,usuario) VALUES
(nucleo.fn_tipo_nombre_id('DIAS POR AÑOS'),'V >= 5 AND V < 10','20','20 DIAS','','',1);
INSERT INTO nucleo.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,validador,usuario) VALUES
(nucleo.fn_tipo_nombre_id('DIAS POR AÑOS'),'V >= 10 AND V < 100','30','30 DIAS','','',1);

-------*****CARGOS*****
---- INSERT INTO nucleo.funciones (padre_id,codigo,funcion,usuario)VALUES(1,'001','ADMINISTRADOR I',1);
---- INSERT INTO nucleo.funciones (padre_id,codigo,funcion,usuario)VALUES(1,'002','TECNICO SOFTWARE',1);

---- INSERT INTO nucleo.direccion_administrativa(nombre,codigo,usuario)VALUES('TECNICO SOFTWARE','002',1);

---- INSERT INTO nucleo.unidades_ejecutoras(direccion_admin_id, sigla,codigo, nombre,usuario)VALUES(1,'CO','001','COLQ',1);

---- INSERT INTO nucleo.unidades_organicas(padre_id,codigo,sigla,descripcion,periodo,usuario)VALUES(1,'003','uc','COLQ',2018,1);

-------*****FERIADOS*****
INSERT INTO nucleo.feriados(region_id,fecha,descripcion,usuario)VALUES
(1,'2018-07-16','Revolucion de La Paz',1),
(1,'2018-08-06','Independencia de Bolivia',1);

--********************************************************************************

-------******PROCESO******--
INSERT INTO nucleo.procesos(proceso,codigo,usuario) VALUES
('SOLICITUD DE VACACIONES','SOL-VAC',1);

-------******ACTIVIDAD******--
INSERT INTO nucleo.actividades(proceso_id,actividad,orden,url,imagen,duracion,destino,usuario) VALUES
((SELECT id FROM nucleo.procesos WHERE proceso='SOLICITUD DE VACACIONES'),'CREAR SOLICITUD',0,'/permisoVacacion/newTram.html','fa-folder-open',8,'{}',1),
((SELECT id FROM nucleo.procesos WHERE proceso='SOLICITUD DE VACACIONES'),'APROVAR POR IMEDIATO SUPERIOR',1,'/permisoVacacion/viewSolicitud.html','fa-code-fork orient',8,'{}',1),
((SELECT id FROM nucleo.procesos WHERE proceso='SOLICITUD DE VACACIONES'),'APROVAR POR RRHH',2,'/permisoVacacion/viewSolicitud.html','fa-code-fork orient',8,'{}',1);

INSERT INTO nucleo.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,validador,usuario) VALUES
(1011100000000001,'TP-PERM-VACA','PERMISO VACACION','TIPOS PERMISO VACACION','','',1);
INSERT INTO nucleo.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,validador,usuario) VALUES
(nucleo.fn_tipo_nombre_id('TP-PERM-VACA'),'LIC. CARGO VACACIÓN','LIC. CARGO VACACIÓN','LICENCIA CON CARGO A VACACIÓN','','',1);

--********************************************************************************


-------******ROLES (PERSONAL)******--
insert into nucleo.roles (sistema, nombre, descripcion,usuario) values ('RRHH','FUNCIONARIO', 'FUNCIONARIO',1);

-------******ENLACES******--
insert into nucleo.enlaces (padre_id,nivel,orden,nombre,imagen,ruta,ayuda,usuario) values 
(1011100000000001,1,2,'FUNCIONARIO','fa-user', '#personal', '',1);

insert into nucleo.enlaces (padre_id,nivel,orden,nombre,imagen,ruta,ayuda,usuario) values 
(1011100000000001,1,2,'ADMIN PERSONAL','fa-users', 'javascript:void(0)', '',1);
insert into nucleo.enlaces (padre_id,nivel,orden,nombre,imagen,ruta,ayuda,usuario) values
((SELECT id FROM nucleo.enlaces WHERE nombre='ADMIN PERSONAL'),2,1,'Admin. Personal','fa-users', '#adminPersonal', '',1);


-------******MENUS******--
insert into nucleo.menues (rol_id, enla_id,usuario) values 
((SELECT id FROM nucleo.roles WHERE nombre='SUPER ADMIN'),(SELECT id FROM nucleo.enlaces WHERE nombre='FUNCIONARIO'),1),

((SELECT id FROM nucleo.roles WHERE nombre='SUPER ADMIN'),(SELECT id FROM nucleo.enlaces WHERE nombre='ADMIN PERSONAL'),1),
((SELECT id FROM nucleo.roles WHERE nombre='SUPER ADMIN'),(SELECT id FROM nucleo.enlaces WHERE nombre='Admin. Personal'),1);


commit;



/**$$$$$$$$$$******DOCUMENTACION RRHH*****$$$$$*****/
begin;
-------******ROLES******--
insert into nucleo.roles (sistema, nombre, descripcion,usuario) values ('RRHH', 'ADMIN VACACIONES', 'Administracion de Vacaciones',1);

-------******ENLACES******--
insert into nucleo.enlaces (padre_id,nivel,orden,nombre,imagen,ruta,ayuda,usuario) values
((SELECT id FROM nucleo.enlaces WHERE nombre='FUNCIONARIO'),2,20,'Sol. Vacacion','fa-vcard', '#solVacacion', '',1),
((SELECT id FROM nucleo.enlaces WHERE nombre='FUNCIONARIO'),2,20,'Prog. Vacaciones','fa-cubes', '#progVacaciones', '',1);


insert into nucleo.enlaces (padre_id,nivel,orden,nombre,imagen,ruta,ayuda,usuario) values
((SELECT id FROM nucleo.enlaces WHERE nombre='ADMIN PERSONAL'),2,20,'Admin. Feriados','fa-calendar-times-o', '#adminFeriados', '',1),
((SELECT id FROM nucleo.enlaces WHERE nombre='ADMIN PERSONAL'),2,20,'Admin. Responsables','fa-user-circle', '#adminResponsables', '',1),
((SELECT id FROM nucleo.enlaces WHERE nombre='ADMIN PERSONAL'),2,20,'Admin. Vacaciones','fa-vcard', '#adminVacaciones', '',1);


-------******MENUS******--
insert into nucleo.menues (rol_id, enla_id,usuario) values 
((SELECT id FROM nucleo.roles WHERE nombre='SUPER ADMIN'),(SELECT id FROM nucleo.enlaces WHERE nombre='Sol. Vacacion'),1),
((SELECT id FROM nucleo.roles WHERE nombre='SUPER ADMIN'),(SELECT id FROM nucleo.enlaces WHERE nombre='Prog. Vacaciones'),1),

((SELECT id FROM nucleo.roles WHERE nombre='SUPER ADMIN'),(SELECT id FROM nucleo.enlaces WHERE nombre='Admin. Feriados'),1),
((SELECT id FROM nucleo.roles WHERE nombre='SUPER ADMIN'),(SELECT id FROM nucleo.enlaces WHERE nombre='Admin. Responsables'),1),
((SELECT id FROM nucleo.roles WHERE nombre='SUPER ADMIN'),(SELECT id FROM nucleo.enlaces WHERE nombre='Admin. Vacaciones'),1);


insert into nucleo.menues (rol_id, enla_id,usuario) values 
((SELECT id FROM nucleo.roles WHERE nombre='FUNCIONARIO'),(SELECT id FROM nucleo.enlaces WHERE nombre='PERSONAL'),1),
((SELECT id FROM nucleo.roles WHERE nombre='FUNCIONARIO'),(SELECT id FROM nucleo.enlaces WHERE nombre='Sol. Vacacion'),1),
((SELECT id FROM nucleo.roles WHERE nombre='FUNCIONARIO'),(SELECT id FROM nucleo.enlaces WHERE nombre='Prog. Vacaciones'),1),

((SELECT id FROM nucleo.roles WHERE nombre='ADMIN VACACIONES'),(SELECT id FROM nucleo.enlaces WHERE nombre='ADMIN PERSONAL'),1),
((SELECT id FROM nucleo.roles WHERE nombre='ADMIN VACACIONES'),(SELECT id FROM nucleo.enlaces WHERE nombre='Admin. Responsables'),1),
((SELECT id FROM nucleo.roles WHERE nombre='ADMIN VACACIONES'),(SELECT id FROM nucleo.enlaces WHERE nombre='Admin. Feriados'),1),
((SELECT id FROM nucleo.roles WHERE nombre='ADMIN VACACIONES'),(SELECT id FROM nucleo.enlaces WHERE nombre='Admin. Vacaciones'),1);


-------******* USUARIOS (PERSONAL)*****----
insert into nucleo.usuarios(pers_id, cuenta, alias, clave,usuario) values 
(1001000000016111, 'sarroyo', 'Sergio Oscar Arroyo Williz', crypt('#$%&sarroyo#$%&', gen_salt('bf')), 'rpmamani');


INSERT INTO nucleo.usr_roles(user_id,rol_id,expira,permiso,usuario) VALUES
(1001000000016111,(SELECT id FROM nucleo.roles WHERE nombre='ADMIN VACACIONES'),'2050-01-01','{}','rpmamani');

insert into nucleo.usuarios(pers_id, cuenta, alias, clave,usuario) values 
(1001000000016114, 'jearce', 'Jose Esteban Arce', crypt('#$%&jearce#$%&', gen_salt('bf')), 'rpmamani');


INSERT INTO nucleo.usr_roles(user_id,rol_id,expira,permiso,usuario) VALUES
(1001000000016114,(SELECT id FROM nucleo.roles WHERE nombre='FUNCIONARIO'),'2050-01-01','{}','rpmamani');

insert into nucleo.usuarios(pers_id, cuenta, alias, clave,usuario) values 
(1001000000016115, 'gramos', 'Gari Ramos', crypt('#$%&gramos#$%&', gen_salt('bf')), 'rpmamani');

INSERT INTO nucleo.usr_roles(user_id,rol_id,expira,permiso,usuario) VALUES
(1001000000016115,(SELECT id FROM nucleo.roles WHERE nombre='FUNCIONARIO'),'2050-01-01','{}','rpmamani');

commit;





/**$$$$$$$$$$******DOCUMENTACION RRHH*****$$$$$*****/
begin;
-------******ROLES******--
insert into nucleo.roles (sistema, nombre, descripcion,usuario) values ('RRHH','ADMIN DOC RRHH', 'Administracion de Documentos Personal',1);

-------******ENLACES******--
insert into nucleo.enlaces (padre_id,nivel,orden,nombre,imagen,ruta,ayuda,usuario) values
((SELECT id FROM nucleo.enlaces WHERE nombre='ADMIN PERSONAL'),2,20,'Admin. Documentos','fa-folder', '#docPersonal', '',1),
((SELECT id FROM nucleo.enlaces WHERE nombre='ADMIN PERSONAL'),2,20,'Documentos RRHH','fa-folder', '#repDocumentosRRHH', '',1);


-------******MENUS******--
insert into nucleo.menues (rol_id, enla_id,usuario) values 
((SELECT id FROM nucleo.roles WHERE nombre='SUPER ADMIN'),(SELECT id FROM nucleo.enlaces WHERE nombre='Admin. Documentos'),1),
((SELECT id FROM nucleo.roles WHERE nombre='SUPER ADMIN'),(SELECT id FROM nucleo.enlaces WHERE nombre='Documentos RRHH'),1);

insert into nucleo.menues (rol_id, enla_id,usuario) values 
((SELECT id FROM nucleo.roles WHERE nombre='ADMIN DOC RRHH'),(SELECT id FROM nucleo.enlaces WHERE nombre='ADMIN PERSONAL'),1),
((SELECT id FROM nucleo.roles WHERE nombre='ADMIN DOC RRHH'),(SELECT id FROM nucleo.enlaces WHERE nombre='Admin. Documentos'),1),
((SELECT id FROM nucleo.roles WHERE nombre='ADMIN DOC RRHH'),(SELECT id FROM nucleo.enlaces WHERE nombre='Documentos RRHH'),1);


-------******* USUARIOS *****----
insert into nucleo.usuarios(pers_id, cuenta, alias, clave,usuario) values 
(1001000000016113, 'llimachi', 'Luis David Limachi Delgado', crypt('#$%&llimachi#$%&', gen_salt('bf')), 'rpmamani');

INSERT INTO nucleo.usr_roles(user_id,rol_id,expira,permiso,usuario) VALUES
(1001000000016113,(SELECT id FROM nucleo.roles WHERE nombre='ADMIN DOC RRHH'),'2050-01-01','{}','rpmamani');

commit;


/**$$$$$$$$$$******BOLETA DE PAGO*****$$$$$*****/
begin;

-------******ENLACES******--
insert into nucleo.enlaces (padre_id,nivel,orden,nombre,imagen,ruta,ayuda,usuario) values
((SELECT id FROM nucleo.enlaces WHERE nombre='FUNCIONARIO'),2,20,'Boletas Pago','fa-file-text-o', '#boletasPago', '',1);

-------******MENUS******--
insert into nucleo.menues (rol_id, enla_id,usuario) values 
((SELECT id FROM nucleo.roles WHERE nombre='SUPER ADMIN'),(SELECT id FROM nucleo.enlaces WHERE nombre='Boletas Pago'),1);

insert into nucleo.menues (rol_id, enla_id,usuario) values 
((SELECT id FROM nucleo.roles WHERE nombre='FUNCIONARIO'),(SELECT id FROM nucleo.enlaces WHERE nombre='Boletas Pago'),1);




commit;
