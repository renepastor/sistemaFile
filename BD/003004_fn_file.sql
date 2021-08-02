
begin;

CREATE OR REPLACE FUNCTION base.fn_servicios() RETURNS SETOF files.servicios AS $$
  SELECT *
  FROM files.servicios
  WHERE activo
$$ language sql stable;
COMMENT ON FUNCTION base.fn_servicios() is 'Buscando Usuario en session';



CREATE OR REPLACE FUNCTION base.add_simple_ilimitado(
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
  numero_pospago text
) returns text as $$
DECLARE
BEGIN
        INSERT INTO files.simple_ilimitado (
          foto_ci,
          foto_factura,
          foto_referencia_financiera,
          referencia_financiera,
          plan_id,
          telefonos_planes,
          genero_id,
          estado_civil_id,
          nombres,
          apellido_paterno,
          apellido_materno,
          apellido_marital,
          tipo_documento_id,
          nro_documento,
          expedicion_id,
          fecha_nacimiento,
          correo,
          departamento_persomal_id,
          provincia_id,
          zona,
          calle_avenida,
          tipo_vivienda_id,
          nro_vivienda,
          referencias,
          celular_ref,
          telefono_ref,
          ciudad_id,
          provincia_nuevo_id,
          checkbox_pospago_ilimitado,
          numero_pospago)
        VALUES(
          foto_ci,
          foto_factura,
          foto_referencia_financiera,
          referencia_financiera,
          plan_id,
          telefonos_planes,
          genero_id,
          estado_civil_id,
          nombres,
          apellido_paterno,
          apellido_materno,
          apellido_marital,
          tipo_documento_id,
          nro_documento,
          expedicion_id,
          fecha_nacimiento,
          correo,
          departamento_persomal_id,
          provincia_id,
          zona,
          calle_avenida,
          tipo_vivienda_id,
          nro_vivienda,
          referencias,
          celular_ref,
          telefono_ref,
          ciudad_id,
          provincia_nuevo_id,
          checkbox_pospago_ilimitado,
          numero_pospago
        );

  IF found THEN
    return 'ok';
  END IF;
  return 'Por favor verifique los datos';
END;
$$ LANGUAGE plpgsql;

--COMMENT ON FUNCTION base.edit_clave(text,text)
--is 'Modificar clave del usuario';

CREATE OR REPLACE FUNCTION base.fn_p_multicentro(ciudad_id dllave) RETURNS SETOF files.multicentros AS $$
  SELECT *
  FROM files.multicentros
  WHERE activo
  AND ciudad_id = $1
$$ language sql stable;
COMMENT ON FUNCTION base.fn_p_multicentro(ciudad_id dllave) is 'Multicentros por ciudad';



commit;
