
begin;

CREATE OR REPLACE FUNCTION base.fn_servicios() RETURNS SETOF files.servicios AS $$
  SELECT *
  FROM files.servicios
  WHERE activo
$$ language sql stable;
COMMENT ON FUNCTION base.fn_servicios() is 'Buscando Usuario en session';

create or replace function base.fn_programar(
  p_id dllave,
  p_fecha_programada text,
  p_hora_programada text
) returns text as $$
declare
  v_clave text;
begin

  UPDATE files.simple_ilimitado
  SET
     fecha_programada = p_fecha_programada,
     hora_programada = p_hora_programada,
     estado_solicitado = 'P'
  WHERE id= p_id;
  IF found THEN
    return 'ok';
  END IF;
  return 'Por favor verifique los datos';
end;
$$ language plpgsql; -- strict security definer;


create or replace function base.fn_aprobar(
  p_id dllave,
  p_mensaje dtexto,
  p_cliente_contactado dbool
) returns text as $$
declare
  v_clave text;
begin
  UPDATE files.simple_ilimitado
  SET
     mensaje = p_mensaje,
     cliente_contactado = p_cliente_contactado,
     estado_solicitado = 'A'
  WHERE id= p_id;
  IF found THEN
    return 'ok';
  END IF;
  return 'Por favor verifique los datos';
end;
$$ language plpgsql; -- strict security definer;

create or replace function base.fn_rechazar(
  p_id dllave,
  p_mensaje dtexto,
  p_cliente_contactado dbool
) returns text as $$
declare
  v_clave text;
begin
  UPDATE files.simple_ilimitado
  SET
     mensaje = p_mensaje,
     cliente_contactado = p_cliente_contactado,
     estado_solicitado = 'R'
  WHERE id= p_id;
  IF found THEN
    return 'ok';
  END IF;
  return 'Por favor verifique los datos';
end;
$$ language plpgsql; -- strict security definer;



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
  numero_pospago text,
  ciudad_atencion_id dllave,
  multicentro_id dllave,
  hora_propuesta dhora,
  primer_numero text,
  segundo_numero text,
  tipo_atencion_id dllave

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
          numero_pospago,
          ciudad_atencion_id,
          multicentro_id,
          hora_propuesta,
          primer_numero,
          segundo_numero,
          tipo_atencion_id,
          estado_solicitado
       )VALUES(
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
          numero_pospago,
          ciudad_atencion_id,
          multicentro_id,
          hora_propuesta,
          primer_numero,
          segundo_numero,
          tipo_atencion_id,
          'S'
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


CREATE OR REPLACE FUNCTION base.add_agenda(
  ciudad_id dllave,
  servicio_id dllave,
  registro_id dllave,
  multicentro_id dllave,
  tipo_atencion_id dllave,
  hora_propuesta dhora,
  primer_numero dtexto,
  segundo_numero dtexto
) returns text as $$
DECLARE
BEGIN
  INSERT INTO files.agenda (servicio_id,registro_id,ciudad_id, multicentro_id, tipo_atencion_id, hora_propuesta, primer_numero, segundo_numero)
  VALUES(servicio_id,registro_id,ciudad_id, multicentro_id, tipo_atencion_id, hora_propuesta, primer_numero, segundo_numero);
  IF found THEN
    return 'ok';
  END IF;
  return 'Por favor verifique los datos';
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION base.add_agenda(dllave, dllave, dllave, dllave, dllave, dhora, dtexto, dtexto) is 'Registrar en agenda';


CREATE OR REPLACE FUNCTION files.new_usr_sol() RETURNS "trigger"
    AS $$
declare
  _alias text:= COALESCE(NEW.nombres,'')||' '||COALESCE(NEW.apellido_paterno,'')||' '||COALESCE(NEW.apellido_materno,'');
  _id_user dllave := 0;
  _usuario base.usuario;
begin
--Sacamos el codigo del rubro
  SELECT id INTO _id_user
  FROM base.usuario
  WHERE username = NEW.correo;
  IF not found THEN
     INSERT INTO base.usuario(username, clave, alias,correo, creado, creador)
     VALUES (NEW.correo,crypt(NEW.nro_documento, gen_salt('bf')), _alias, NEW.correo, now(), NEW.correo) returning * into _usuario;
     INSERT INTO base.usuario_rol(id_rol, id_usuario,creado, creador) VALUES(frol('SOL-SER'), _usuario.id, now(), _usuario.username);
  END IF;
  return NEW;
end;
$$
LANGUAGE plpgsql;


--DROP TRIGGER IF EXISTS tgg_new_usr_sol ON files.simple_ilimitado;-- [ CASCADE | RESTRICT ];

CREATE TRIGGER tgg_new_usr_sol
    BEFORE INSERT OR UPDATE ON files.simple_ilimitado
    FOR EACH ROW EXECUTE PROCEDURE files.new_usr_sol();

commit;
