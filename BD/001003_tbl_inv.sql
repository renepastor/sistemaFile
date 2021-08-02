begin;
DROP schema "inv" CASCADE;
commit;

begin;
create schema "inv";
commit;

begin;


CREATE TABLE inv.tabla_tipo(
    id bigserial PRIMARY KEY,
    id_predecesor dllave,
    codigo dtexto,
    valor dtexto,
    descripcion dtexto,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);

CREATE TABLE inv.responsable(
    id bigserial PRIMARY KEY,
    id_unidad dllave2,
    id_recinto dllave2,
    id_usuario_rol dllave2,
    --responsable VARCHAR(50),
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);


CREATE TABLE inv.centro_costo(
    id bigserial PRIMARY KEY,
    codigo dtexto,
    descripcion dtexto,
    para_consolidar dbool,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);

CREATE TABLE inv.recinto(
    id bigserial PRIMARY KEY,
    id_unidad dtexto,
    id_tipo_recinto dllave2, --El Almacen es Independiente, El Almacen tiene Sub Almacenes, El Almacen o Recinto pertenece a otro Almacén 
    id_centro_costo dllave2,
    id_sub_recinto dllave2,
    --_solicitud bool DEFAULT false,
    codigo dtexto,
    nombre dtexto,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);

CREATE TABLE inv.unidad_medida(
    id bigserial PRIMARY KEY,
    abreviatura dtexto,
    unidad_medida dtexto,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto,
    UNIQUE(abreviatura)
);

CREATE TABLE inv.material_grupo(
    id bigserial PRIMARY KEY,
    codigo dtexto,
    descripcion_general dtexto,
    descripcion_abreviada dtexto,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);

CREATE TABLE inv.material_sub_grupo(
    id bigserial PRIMARY KEY,
    id_material_grupo dllave2,
    codigo dtexto,
    descripcion_general dtexto,
    descripcion_abreviada dtexto,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);

CREATE TABLE inv.material(
    id bigserial PRIMARY KEY,
    id_unidad_medida dllave2,
    id_material_grupo dllave2,
    id_material_sub_grupo dllave2,
    id_aprovador dtexto,
    codigo dtexto,
    nombre dtexto,
    especificacion_tecnica dtexto,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);

CREATE TABLE inv.ingreso(
    id bigserial PRIMARY KEY,
    correlativo dtexto,
    id_recinto dllave2,
    id_proveedor dtexto,
    id_tipo_movimiento dllave2,
    id_recinto_origen dllave2 null,
    id_tipo_cambio dllave2,
    periodo dtexto,
    fecha_ingreso dfecha,
    nro_factura dtexto,
    fecha_factura dfecha,
    justificacion dtexto,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);

CREATE TABLE inv.ingres_detalle(
    id bigserial PRIMARY KEY,
    id_ingreso dllave2,
    id_centro_costo dllave2,
    id_condicion_material dllave2,
    id_material dllave2,
    cantidad dmoneda2,
    codigo_presupuestario dtexto,
    precio_unitario dmoneda3,
    precio_unitario_ext dmoneda3,
    precio_unitario_ufv dmoneda3,
    precio_total dmoneda3,
    precio_total_ext dmoneda3,
    precio_total_ufv dmoneda3,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);

CREATE TABLE inv.salida(
    id bigserial PRIMARY KEY,
    id_recinto dllave2,
    id_tipo_movimiento dllave2,
    id_unidad_solicitante dllave2,
    id_trasporte dllave2,
    id_conductor dllave2,
    id_unidad dtexto,
    id_solicitante dtexto,
    correlativo dtexto,
    fecha_salida dfecha,
    periodo dtexto,
    justificar dtexto,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);
CREATE TABLE inv.salida_detalle(
    id bigserial PRIMARY KEY,
    id_salida dllave2,
    id_material dllave2,
    cantidad dmoneda2,
    precio_unitario dmoneda3,
    precio_unitario_ufv dmoneda3,
    precio_unitario_ext dmoneda3,
    precio_total dmoneda3,
    precio_total_ufv dmoneda3,
    precio_total_ext dmoneda3,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);

CREATE TABLE inv.tipo_cambio(
    id bigserial PRIMARY KEY,
    fecha dfecha,
    ufv dmoneda3,
    usd dmoneda2,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);

CREATE TABLE inv.solicitar_item(
    id bigserial PRIMARY KEY,
    id_unidad_medida dllave2,
    id_material_grupo dllave2,
    id_material_sub_grupo dllave2,
    id_solicitante dtexto,
    justificar_rechazo dtexto,
    codigo dtexto,
    nombre dtexto,
    especificacion_tecnica dtexto,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);

CREATE TABLE inv.existencia(
    id bigserial PRIMARY KEY,
    id_recinto dllave2,
    id_material dllave2,
    saldo dmoneda2,
    reservado dmoneda2,
    minimo dmoneda2,
    maximo dmoneda2,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);



/*
CREATE TABLE inv.(
    id bigserial PRIMARY KEY,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);

CREATE TABLE inv.(
    id bigserial PRIMARY KEY,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);

CREATE TABLE inv.(
    id bigserial PRIMARY KEY,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);

CREATE TABLE inv.(
    id bigserial PRIMARY KEY,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);

CREATE TABLE inv.(
    id bigserial PRIMARY KEY,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);
*/


commit;
