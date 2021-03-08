/*aut: renepastor@gmail.com
  fec: 19/06/2017
*/
begin;

commit;

/****DOCUMENTOS***/
begin;

  
/** Aut: renepastor@gmail.com AGO2017
*  Autenticacion del usuario
*   **/
create or replace function files.auth(
  p_usuario text,
  p_clave text
) returns files.jwt as $$
declare
  users base.usuarios;
begin
  select a.* into users
  from base.usuarios as a
  where a.cuenta = $1
  AND a.estado != 'X';

  if users.clave = crypt(p_clave, users.clave) then
    return ('root', users.pers_id, users.cuenta)::files.jwt;
  else
    return null;
  end if;
end;
$$ language plpgsql strict security definer;
comment on function files.auth(text, text) is 'Autenticacion de usuario por el nombre de usuario y la clave encriptada';

CREATE or replace FUNCTION files.mi_usuario() RETURNS base.usuarios AS $$
  SELECT *
  FROM base.usuarios
  WHERE pers_id = current_setting('jwt.claims.pers_id')::dllave
  AND estado != 'X'
$$ language sql stable;
comment on function files.mi_usuario() is 'Buscando Usuario en session';

CREATE or replace FUNCTION files.mi_menu() RETURNS SETOF base.enlaces AS $$
  SELECT e.*
    FROM base.menues m inner JOIN base.enlaces e ON(m.enla_id = e.id)
    INNER JOIN base.usr_roles ur ON(m.rol_id = ur.rol_id)
    WHERE user_id = current_setting('jwt.claims.pers_id')::dllave
    AND 'X' not in (m.estado, e.estado, ur.estado)
$$ language sql stable;
comment on function files.mi_menu() is 'Los accesos de mis usuario';




  create or replace function files.fn_guardar_documentos(
    p_id dllave,
    p_persona_id dllave,
    p_tipo_documento_id dllave2,
    p_tipo_estado_id dllave2,
    p_observacion dtexto2,
    p_archivo djson,
    p_fecha_vigencia dtexto2
  ) returns dentero as $$
  declare
  _id integer = 0;
 
  begin
    select id into _id
    from files.documentos_personal
    where persona_id = p_persona_id
    and tipo_documento_id = p_tipo_documento_id;
    if (p_fecha_vigencia = 'null' or p_fecha_vigencia = '') then p_fecha_vigencia = null; end if;
  
    if _id != 0 then
      UPDATE files.documentos_personal
      SET tipo_estado_id= p_tipo_estado_id,
          observacion= p_observacion,
          fecha_vigencia= p_fecha_vigencia::dfecha2,
          archivo= p_archivo,
          estado = 'M',
          usuario = 'admin', --current_setting('jwt.claims.cuenta')::text,
          editado = now()
      WHERE tipo_documento_id=p_tipo_documento_id
      and persona_id= p_persona_id;
    else
      INSERT INTO files.documentos_personal
      (persona_id, tipo_documento_id, tipo_estado_id, observacion, archivo, fecha_vigencia)
      VALUES(p_persona_id, p_tipo_documento_id, p_tipo_estado_id, p_observacion, p_archivo, p_fecha_vigencia::dfecha2)
      returning id into _id;
    end if;
    return _id;
  end;
  $$ language plpgsql strict security definer;
  comment on function files.fn_guardar_documentos(dllave, dllave, dllave2, dllave2, dtexto2, djson, dtexto2)
  is 'Registro de datos de los registro docupemtos del personal';

commit;
