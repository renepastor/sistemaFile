

begin;

CREATE TABLE base.aplicacion (
  id bigserial PRIMARY KEY,
  instancia dtexto,
  codigo dtexto,
  nombre dtexto,
  descripcion dtexto,
  web_url dtexto,
  access_token dtexto,
  activo dactivo,
  creador duser,
  editor duser,
  editado dfechahora,
  creado dfechahora
);

CREATE TABLE base.modulo (
  id bigserial PRIMARY KEY,
  id_aplicacion dllave,
  posicion dentero,
  nombre dtexto,
  icono dtexto,
  activo dactivo,
  creador duser,
  editor duser,
  editado dfechahora,
  creado dfechahora
);

CREATE TABLE base.recurso (
  id bigserial PRIMARY KEY,
  id_modulo dllave,
  posicion dentero,
  titulo dtexto,
  uri dtexto,
  es_menu dbool,
  icono dtexto,
  activo dactivo,
  creador duser,
  editor duser,
  editado dfechahora,
  creado dfechahora
);

CREATE TABLE base.rol (
  id bigserial PRIMARY KEY,
  id_aplicacion dllave,
  codigo dtexto,
  nombre dtexto,
  activo dactivo,
  creador duser,
  editor duser,
  editado dfechahora,
  creado dfechahora
);

CREATE TABLE base.rol_recurso (
  id bigserial PRIMARY KEY,
  id_rol dllave,
  id_recurso dllave,
  lectura dbool,
  creacion dbool,
  modificacion dbool,
  eliminacion dbool,
  activo dactivo,
  creador duser,
  editor duser,
  editado dfechahora,
  creado dfechahora
);

CREATE TABLE base.usuario (
  id bigserial PRIMARY KEY,
  username dtexto,
  clave dtexto,
  alias dtexto,
  correo dtexto,
  activo dactivo,
  creador duser,
  editor duser,
  editado dfechahora,
  creado dfechahora
);

CREATE TABLE base.usuario_rol (
  id bigserial PRIMARY KEY,
  id_rol dllave,
  id_usuario dllave,
  activo dactivo,
  creador duser,
  editor duser,
  editado dfechahora,
  creado dfechahora
);

CREATE TABLE base.tbl_tipos (
  id bigserial primary key,
  padre_id dllave,
  codigo dtexto,
  valor dtexto,
  descripcion dtexto,
  ayuda dtexto,
  activo dactivo,
  creador duser,
  editor duser,
  editado dfechahora,
  creado dfechahora
);



create type base.jwt as (
  role dtexto,
  id_usuario dllave,
  username dtexto,
  alias dtexto
);



 ------------
-- VISTAS --
------------
CREATE OR REPLACE VIEW base.vw_permiso
AS
SELECT DISTINCT --ROW_NUMBER () OVER (ORDER BY rec.id) id,
       usu.username,
       modu.id_aplicacion ,
       modu.posicion posicion_modulo,
       modu.nombre modulo,
       modu.icono icono_modulo,
       rec.posicion posicion_recurso,
       rec.titulo recurso,
       rec.uri,
       rec.es_menu,
       rec.icono icono_recurso,
       rolrec.lectura,
       rolrec.creacion,
       rolrec.modificacion,
       rolrec.eliminacion
  FROM base.modulo  modu,
       base.recurso  rec,
       base.rol      rol,
       base.rol_recurso  rolrec,
       base.usuario_rol  usrrol,
       base.usuario usu
 WHERE usrrol.id_rol = rol.id
   AND usrrol.id_usuario = usu.id
   AND rolrec.id_rol = rol.id
   AND rolrec.id_recurso = rec.id
   AND rec.id_modulo = modu.id
   AND modu.activo
   AND rec.activo
   AND rol.activo
   AND rolrec.activo
   AND usrrol.activo
   AND usu.activo
   AND rolrec.lectura;

-- select * from cerbero.aplicacion;

commit;

BEGIN;

/***TRAMITES****/
create table base.procesos (
    id bigserial primary key,
    proceso dtexto2,
    codigo dtexto2,
    secuenciador dentero4,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);




create table base.actividades (
    id bigserial primary key,
    id_proceso dllave,
    actividad dtexto,
    orden dentero,
    url dtexto,
    imagen dtexto2,
    duracion dentero,
    destino json,
    permisos djson not null default '[]',
    criterio dtexto not null default 'C',
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);


create table base.tramites (
    id bigserial primary key,
    id_proceso dllave2,
    id_padre dllave2,
    id_actividad dllave2,
    id_remitente dllave2,
    id_receptor dllave2,
    codigo dtexto2,
    archivos djson default '[]',
    proveido dtexto2,
    envio dfechahora,
    recepcion dfechahora,
    estado dtexto default 'I',
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);

create table base.tramites_log (
    id bigserial primary key,
    id_tramite dllave2,
    id_proceso dllave2,
    id_padre dllave2,
    id_actividad dllave2,
    id_remitente dllave2,
    id_receptor dllave2,
    codigo dllave2,
    archivos djson default '[]',
    proveido dtexto2,
    envio dfechahora,
    recepcion dfechahora,
    estado dtexto default 'I',
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);

COMMIT;

begin;
CREATE TABLE base.ubicacion_geografica (
    id bigserial primary key,
    dependiente_id dllave,
    abreviatura dtexto,
    nombre dtexto,
    nivel dentero,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);

commit;
