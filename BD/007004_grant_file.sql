/*aut: renepastor@gmail.com
  fec: 19/06/2017
*/

/*****ASISTENCIA*****/

begin;
   grant usage on schema files to protegido;
commit;

begin;
   grant select ON files.categoria_servicios to protegido;
   grant select ON files.servicios to protegido;
   grant select ON files.requisitos_servicios to protegido;
   grant select ON base.vw_categoria_servicios to protegido;
   grant select ON base.vw_servicios to protegido;
   grant select ON base.vw_requisitos_servicios to protegido;
   grant EXECUTE ON FUNCTION base.fn_servicios to protegido;
   grant SELECT ON base.ubicacion_geografica to protegido;
   grant EXECUTE ON FUNCTION base.fn_tbl_tipos(text) to protegido;
   grant SELECT ON base.tbl_tipos to protegido;
   grant SELECT ON files.multicentros to protegido;
   grant EXECUTE ON FUNCTION base.fn_p_multicentro(dllave) to protegido;
   grant INSERT ON files.simple_ilimitado to protegido;
   grant all ON base.usuario_rol to protegido;
   grant all ON base.usuario to protegido;
   grant SELECT ON base.rol to protegido;
   GRANT USAGE ON SEQUENCE base.usuario_id_seq TO protegido;
   GRANT USAGE ON SEQUENCE base.usuario_rol_id_seq TO protegido;
   GRANT USAGE ON SEQUENCE files.simple_ilimitado_id_seq TO protegido;
   grant EXECUTE ON FUNCTION base.add_simple_ilimitado(
  foto_ci text,
  foto_factura text,
  foto_referencia_financiera text,
  referencia_financiera boolean,
  plan_id dllave,
  telefonos_planes text,
  genero_id dllave,
  estado_civil_id dllave,
  nombres text,
  apellido_paterno text,
  apellido_materno text,
  apellido_marital text,
  tipo_documento_id dllave,
  nro_documento text,
  expedicion_id dllave,
  fecha_nacimiento date,
  correo text,
  departamento_persomal_id dllave,
  provincia_id dllave,
  zona text,
  calle_avenida text,
  tipo_vivienda_id dllave,
  nro_vivienda text,
  referencias text,
  celular_ref text,
  telefono_ref text,
  ciudad_id dllave,
  provincia_nuevo_id dllave,
  checkbox_pospago_ilimitado boolean,
  numero_pospago text,
  ciudad_atencion_id dllave,
  multicentro_id dllave,
  hora_propuesta dhora,
  primer_numero text,
  segundo_numero text,
  tipo_atencion_id dllave
) to protegido;
  grant select ON base.vw_simple_ilimitado to protegido;
 --grant execute on type base.jwt to files;
  --grant execute on type base.jwt to publico;
 --GRANT SELECT ON nucleo.vw_usuario TO publico;
-- GRANT INSERT ON nucleo.asistencias TO publico;
commit;



