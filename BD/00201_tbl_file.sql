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


create type files.jwt as (
  role dtexto,
  pers_id dllave,
  cuenta dtexto
);


CREATE TABLE base.personas (
    id bigserial primary key,
    nombres dtexto,
    primer_apellido dtexto2,
    segundo_apellido dtexto2,
    ci dtexto,
    direccion dtexto,
    coordenadas djson,
    fecha_nacimiento dfecha,
    nacionalidad dtexto,
    ciudad_poblacion dtexto,
    correo dtexto,
    telefonos djson,
    estado destado,
    usuario duser,
    editado dfechahora
);

CREATE TABLE files.categoria_servicios (
    id bigserial primary key,
    nombre dtexto,
    logo dtexto,
    fecha_inicio dfecha,
    fecha_vigencia dfecha,
    estado destado,
    usuario duser,
    editado dfechahora
);
CREATE TABLE files.planes (
    id bigserial primary key,
    categoria_id dllave,
    plan dtexto,
    costo dtexto,
    fecha_inicio dfecha,
    fecha_vigencia dfecha,
    estado destado,
    usuario duser,
    editado dfechahora
);
CREATE TABLE files.servicios (
    id bigserial primary key,
    categoria_id dllave,
    requisitos dtexto,
    servicio dtexto,
    promocion dbool,
    descripcion dtexto,
    fecha_inicio dfecha,
    fecha_vigencia dfecha,
    estado destado,
    usuario duser,
    editado dfechahora
);
CREATE TABLE files.requisitos_servicios (
    id bigserial primary key,
    plan_id dllave,
    descripcion dtexto,
    requerido dbool,
    estado destado,
    usuario duser,
    editado dfechahora
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
    estado destado,
    usuario duser,
    editado dfechahora
);

commit;
