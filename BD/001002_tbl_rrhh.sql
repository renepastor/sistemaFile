begin;
DROP schema "rrhh" CASCADE;
commit;

begin;
create schema "rrhh";
commit;

begin;

CREATE TABLE rrhh.personas (
    id bigserial PRIMARY KEY,
    primier_nombre dtexto,
    segundo_nombre dtexto,
    primier_apellido dtexto,
    segundo_apellido dtexto,
    ci dtexto,
    direccion dtexto,
    coordenadas djson,
    fecha_nacimiento dfecha,
    nacionalidad dtexto,
    ciudad_poblacion dtexto,
    correo dtexto,
    telefonos djson,
    activo dactivo,
    creador duser,
    editor duser,
    editado dfechahora,
    creado dfechahora
);

CREATE TABLE rrhh.funcionario (
  id bigserial PRIMARY KEY,
  id_unidad_organica dllave,
  id_funcion dllave,
  id_cargo dllave,
  ingreso dfecha,
  conclucion dfecha,
  rescision dfecha,
  codigo dtexto,
  activo dactivo,
  creador duser,
  editor duser,
  editado dfechahora,
  creado dfechahora
);

CREATE TABLE rrhh.adenda (
  id bigserial PRIMARY KEY,
  id_funcionario dllave,
  inicio dfecha,
  fin dfecha,
  codigo dtexto,
  activo dactivo,
  creador duser,
  editor duser,
  editado dfechahora,
  creado dfechahora
);

CREATE TABLE rrhh.unidad_organizacional (
  id bigserial PRIMARY KEY,
  id_predecesor dllave,
  sigla dtexto,
  codigo dtexto,
  nombre dtexto,
  activo dactivo,
  creador duser,
  editor duser,
  editado dfechahora,
  creado dfechahora
);


CREATE TABLE rrhh.funcion (
  id bigserial PRIMARY KEY,
  nivel dentero,
  funcion dtexto,
  activo dactivo,
  creador duser,
  editor duser,
  editado dfechahora,
  creado dfechahora
);

CREATE TABLE rrhh.cargo (
  id bigserial PRIMARY KEY,
  nivel dentero,
  abreviatura dtexto,
  cargo dtexto,
  activo dactivo,
  creador duser,
  editor duser,
  editado dfechahora,
  creado dfechahora
);


CREATE TABLE rrhh.vacaciones_otorgados(
  id bigserial PRIMARY KEY,
  id_cas dllave,
  id_funcionario dllave,
  solicitado dentero,
  saldo dentero,
  dias_vacacion dentero,
  fecha_inicio dfecha,
  fecha_fin dfecha,
  activo dactivo,
  creador duser,
  editor duser,
  editado dfechahora,
  creado dfechahora
);

CREATE TABLE rrhh.vacaciones_solicitados(
  id bigserial PRIMARY KEY,
  id_otorgado varchar[] default array[]::varchar[],
  otorgado_solicitado integer[] default array[]::integer[],
  id_tramite dllave,
  id_funcionario dllave,
  id_tipo_ausencia dllave,
  solicitado dentero,
  saldo dentero,
  fecha_inicio dfecha,
  fecha_fin dfecha,
  incorporacion dfecha,
  motivo dtexto,
  observacion dtexto,
  dato_reporte djson default '{}',
  activo dactivo,
  creador duser,
  editor duser,
  editado dfechahora,
  creado dfechahora
);

CREATE TABLE rrhh.cas(
  id bigserial PRIMARY KEY,
  id_funcionario dllave,
  a_fecha dfecha,
  fecha_entrega dfecha,
  codigo_verificacion dtexto,
  codigo_cas dtexto,
  anio dentero,
  mes dentero,
  dia dentero,
  observacion dtexto,
  activo dactivo,
  creador duser,
  editor duser,
  editado dfechahora,
  creado dfechahora
);

CREATE TABLE rrhh.feriados(
  id bigserial PRIMARY KEY,
  id_localizacion dllave,
  gestion dentero,
  fecha dfecha,
  descripcion dtexto,
  activo dactivo,
  creador duser,
  editor duser,
  editado dfechahora,
  creado dfechahora
);


commit;