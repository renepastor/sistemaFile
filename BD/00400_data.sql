/*aut: renepastor@gmail.com
  fec: 19/06/2017
*/
begin;


-------******ROLES******--
SELECT setval('base.roles_id_seq', 1);
insert into base.roles (sistema, nombre, descripcion,usuario) values ('SUPERADMIN','SUPER ADMIN', 'RESPONSABLE',1);

-------******ENLACES******--
SELECT setval('base.enlaces_id_seq', 1);

insert into base.enlaces (id, padre_id,nivel,orden,nombre,imagen,ruta,ayuda,usuario) values 
(1,1,1,2,'MENU','fa-bars', '', '',1);
insert into base.enlaces (padre_id,nivel,orden,nombre,imagen,ruta,ayuda,usuario) values 
((SELECT id FROM base.enlaces WHERE nombre='MENU'),1,2,'Configuracion','mdi-notebook-check', 'javascript:void(0)', '',1);

insert into base.enlaces (padre_id,nivel,orden,nombre,imagen,ruta,ayuda,usuario) values 
((SELECT id FROM base.enlaces WHERE nombre='Configuracion'),2,6,'Parametros','mdi-notebook-edit-outline', '/parametros', '',1),
((SELECT id FROM base.enlaces WHERE nombre='Configuracion'),2,7,'Tbl Tipos','mdi-collapse-all', '/tblTipos', '',1),
((SELECT id FROM base.enlaces WHERE nombre='Configuracion'),2,7,'Generador','mdi-nutrition', '/generador', '',1);

insert into base.enlaces (padre_id,nivel,orden,nombre,imagen,ruta,ayuda,usuario) values 
((SELECT id FROM base.enlaces WHERE nombre='MENU'),1,3,'Administracion','mdi-account-multiple-check', 'javascript:void(0)', '',1);
insert into base.enlaces (padre_id,nivel,orden,nombre,imagen,ruta,ayuda,usuario) values 
((SELECT id FROM base.enlaces WHERE nombre='Administracion'),2,8,'Usuarios','mdi-account-check', '/usuario', '',1),
((SELECT id FROM base.enlaces WHERE nombre='Administracion'),2,9,'Roles','mdi-account-box-multiple', '/roles', '',1),
((SELECT id FROM base.enlaces WHERE nombre='Administracion'),2,10,'Accesos','mdi-sort-variant-lock-open', '/accesos', '',1);


-------******MENUS******--
SELECT setval('base.menues_id_seq', 1);
insert into base.menues (rol_id, enla_id,usuario) values 
((SELECT id FROM base.roles WHERE nombre='SUPER ADMIN'),(SELECT id FROM base.enlaces WHERE nombre='Configuracion'),1),
((SELECT id FROM base.roles WHERE nombre='SUPER ADMIN'),(SELECT id FROM base.enlaces WHERE nombre='Parametros'),1),
((SELECT id FROM base.roles WHERE nombre='SUPER ADMIN'),(SELECT id FROM base.enlaces WHERE nombre='Tbl Tipos'),1),
((SELECT id FROM base.roles WHERE nombre='SUPER ADMIN'),(SELECT id FROM base.enlaces WHERE nombre='Generador'),1),
((SELECT id FROM base.roles WHERE nombre='SUPER ADMIN'),(SELECT id FROM base.enlaces WHERE nombre='Administracion'),1),
((SELECT id FROM base.roles WHERE nombre='SUPER ADMIN'),(SELECT id FROM base.enlaces WHERE nombre='Usuarios'),1),
((SELECT id FROM base.roles WHERE nombre='SUPER ADMIN'),(SELECT id FROM base.enlaces WHERE nombre='Roles'),1),
((SELECT id FROM base.roles WHERE nombre='SUPER ADMIN'),(SELECT id FROM base.enlaces WHERE nombre='Accesos'),1);



-------******* USUARIOS *****----

insert into base.usuarios(pers_id, cuenta, alias, clave,usuario) values 
(1, 'rpmamani', 'Rene Pastor Mamani Flores', crypt('123456', gen_salt('bf')), 'rpmamani'),
(2, 'abel', 'Abel', crypt('123456', gen_salt('bf')), 'rpmamani');


SELECT setval('base.usr_roles_id_seq', 1);
INSERT INTO base.usr_roles(user_id,rol_id,expira,permiso,usuario) VALUES
(1,(SELECT id FROM base.roles WHERE nombre='SUPER ADMIN'),'2050-01-01','{}','rpmamani'),
(2,(SELECT id FROM base.roles WHERE nombre='SUPER ADMIN'),'2050-01-01','{}','rpmamani');


-------******* PARAMETROS *****----
SELECT setval('base.parametros_id_seq', 1);
INSERT INTO base.parametros (campo,valor,sistema,descripcion,usuario)
VALUES('TIME-SESSION','30','SESSION', 'TIEMPO DE SESSION DEL USUARIO',1);

-------******* TBL TIPOS *****----
SELECT setval('base.tbl_tipos_id_seq', 1);
INSERT INTO base.tbl_tipos(id, padre_id,nombre,valor,descripcion,ayuda,validador,usuario) VALUES
(1,1,'--','0','Inicio','Es el origen de la tabla','null',1);

-------******PROCESO******--
SELECT setval('base.procesos_id_seq', 1);
INSERT INTO base.procesos(id, proceso,codigo,usuario) VALUES
(1, 'Correspondencia','CORR',1);

-------******ACTIVIDAD******--
SELECT setval('base.actividades_id_seq', 1);
INSERT INTO base.actividades(proceso_id,actividad,orden,url,imagen,duracion,destino,usuario) VALUES
(1,'Crear Corresp',0,'/corresp/index.html','fa-folder-open',8,'{"url":"./tem.html", "fn":"function(res){return (res.nombre)}"}',1);


commit;

