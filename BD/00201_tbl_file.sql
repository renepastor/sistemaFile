/*aut: renepastor@gmail.com
  fec: 19/06/2017
*/
begin;

/******DOCUMENTOS PERSONALES*******/



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

CREATE TABLE files.servicios (
    id bigserial primary key,
    promocion dtexto,
    fecha_inicio dfecha,
    fecha_vigencia dfecha,
    estado destado,
    usuario duser,
    editado dfechahora
);
CREATE TABLE files.requisitos_servicios (
    id bigserial primary key,
    servicio_id dllave,
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
