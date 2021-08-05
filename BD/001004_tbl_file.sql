/*aut: renepastor@gmail.com
  fec: 19/06/2017
*/
begin;
create schema publico;
commit;

begin;
drop schema files CASCADE;
commit;

begin;
create schema files;
commit;


begin;

/******DOCUMENTOS PERSONALES*******/

/*
create type files.jwt as (
  role dtexto,
  pers_id dllave,
  cuenta dtexto
);
*/

CREATE TABLE files.ciudades (
    id bigserial primary key,
    nombre dtexto,
    sigla dtexto,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);


CREATE TABLE files.multicentros (
    id bigserial primary key,
    ciudad_id dllave,
    nombre dtexto,
    direccion dtexto,
    coordenada dpunto,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);


CREATE TABLE files.categoria_servicios (
    id bigserial primary key,
    nombre dtexto,
    logo dtexto,
    fecha_inicio dfecha,
    fecha_vigencia dfecha,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);
CREATE TABLE files.servicios (
    id bigserial primary key,
    categoria_id dllave,
    --requisitos dtexto,
    servicio dtexto,
    promocion dbool,
    formulario dtexto,
    informacion dtexto,
    fecha_inicio dfecha,
    fecha_vigencia dfecha,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);

CREATE TABLE files.planes (
    id bigserial primary key,
    servicio_id dllave,
    plan dtexto,
    costo dtexto,
    requisito dtexto,
    con_requisito dbool2,
    fecha_inicio dfecha,
    fecha_vigencia dfecha,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);
CREATE TABLE files.requisitos_servicios (
    id bigserial primary key,
    servicio_id dllave,
    descripcion dtexto,
    requerido dbool,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);


/*
CREATE TABLE files.documento_personal (
    id bigserial primary key,
    persona_id dllave,
    tipo_documento_id dllave,
    tipo_estado_id dllave,
    archivo djson,
    fecha_vigencia dfecha2,
    estado destado,
    usuario duser,
    editado dfechahora
);
*/
CREATE TABLE files.documento_personal (
    id bigserial primary key,
    persona_id dllave,
    requisito_servicio_id dllave,
    tipo_documento_id dllave,
    tipo_estado_id dllave,
    archivo djson,
    fecha_vigencia dfecha2,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);


CREATE VIEW base.vw_categoria_servicios AS
SELECT * FROM files.categoria_servicios;

CREATE VIEW base.vw_servicios AS
SELECT s.*, cs.logo, cs.nombre 
FROM files.servicios s, files.categoria_servicios cs
WHERE s.categoria_id = cs.id
AND s.activo AND cs.activo;

CREATE VIEW base.vw_requisitos_servicios AS
SELECT * FROM files.requisitos_servicios;

CREATE TABLE files.simple_ilimitado (
    id bigserial primary key,
    foto_ci dtexto,
    foto_factura dtexto,
    foto_referencia_financiera dtexto,
    referencia_financiera dbool,
    plan_id dllave,
    telefonos_planes dtexto,
    genero_id dllave,
    estado_civil_id dllave,
    nombres dtexto,
    apellido_paterno dtexto,
    apellido_materno dtexto,
    apellido_marital dtexto,
    tipo_documento_id dllave,
    nro_documento dtexto,
    expedicion_id dllave,
    fecha_nacimiento dfecha,
    correo dtexto,
    departamento_persomal_id dllave,
    provincia_id dllave,
    zona dtexto,
    calle_avenida dtexto,
    tipo_vivienda_id dllave,
    nro_vivienda dtexto,
    referencias dtexto,
    celular_ref dtexto,
    telefono_ref dtexto,
    ciudad_id dllave,
    provincia_nuevo_id dllave,
    checkbox_pospago_ilimitado dbool,
    numero_pospago dtexto,
    
    ciudad_atencion_id dllave,
    multicentro_id dllave,
    tipo_atencion_id dllave,
    hora_propuesta dhora,
    primer_numero dtexto,
    segundo_numero dtexto,
    estado_solicitado destado,
    fecha_programada dfecha2,
    hora_programada dhora,
    
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);

create VIEW base.vw_simple_ilimitado AS
  SELECT * FROM files.simple_ilimitado;

commit;


