
begin;
/******
* 
*/

CREATE OR REPLACE FUNCTION fsis(_codigo text) RETURNS bigint
AS $$ SELECT id FROM base.aplicacion WHERE codigo = $1 LIMIT 1;
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION frol(_codigo text) RETURNS bigint
AS $$ SELECT id FROM base.rol WHERE codigo = $1 limit 1;
$$LANGUAGE sql;

CREATE OR REPLACE FUNCTION fmodulo(_codigo text, _apl text) RETURNS bigint
AS $$ SELECT id FROM base.modulo WHERE nombre = $1 AND id_aplicacion=fsis(_apl) limit 1;
$$LANGUAGE sql;

CREATE OR REPLACE FUNCTION frecurso(_titulo text) RETURNS bigint
AS $$ SELECT id FROM base.recurso WHERE titulo = $1 limit 1;
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION fuser(_username text) RETURNS bigint
AS $$ SELECT id FROM base.usuario WHERE username = $1 limit 1;
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION flocgeo(_nombre text, _nivel integer) RETURNS bigint
AS $$ SELECT id FROM base.ubicacion_geografica WHERE nombre = $1 AND nivel = $2 LIMIT 1;
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION ftptbl(_codigo text) RETURNS bigint
AS $$ SELECT id FROM base.tbl_tipos WHERE codigo = $1 LIMIT 1;
$$ LANGUAGE sql;


/******
* ADMIN USUARIO
*/

CREATE OR REPLACE FUNCTION base.aud_user() returns TRIGGER AS $$
BEGIN
  --NEW.fec_registro := OLD.fec_registro;
  --NEW.estado := 'C';
  NEW.editado := now();
  NEW.usuario := current_setting('jwt.claims.cuenta')::text;
  return NEW;
END;
$$ LANGUAGE plpgsql;

--create trigger aud_user before insert on nucleo.personas for each row execute procedure nucleo.aud_user();
--create trigger aud_user before insert on nucleo.parametros for each row execute procedure nucleo.aud_user();




--grant execute on function nucleo.add_usuario(text, text, text, text, text, integer) to root;
/*
CREATE OR REPLACE FUNCTION base.add_usuario(
  p_alias text,
  p_usuario text,
  p_rol_id dllave,
  p_permiso json,
  p_expira dfecha2
) returns base.usuarios as $$
declare
  usuario base.usuario;
  v_pers_id dentero;
  v_clave dtexto;
begin
  --if p_expira = '' then p_expira := '2050-12-31'::date; end if;

  INSERT INTO base.usuario(id, username, password, ) VALUES
  ((select max(pers_id)+1 from nucleo.usuarios), split_part(p_usuario, '@', 1), crypt('#$%&'||p_usuario||'#$%&', gen_salt('bf')), p_alias)
   returning * into usuarios;

  INSERT INTO nucleo.usr_roles(user_id, rol_id, expira, permiso) VALUES
  (usuarios.pers_id, p_rol_id, p_expira, p_permiso::json);

  return usuarios;
end;
$$ language plpgsql; -- strict security definer;


create or replace function nucleo.edit_usuario(
  p_pers_id dllave2,
  p_alias text,
  p_cuenta text,
  p_roles_id djson,
  p_estado text
) returns nucleo.usuarios as $$
declare
  usuarios nucleo.usuarios;
  v_pers_id dllave2;
  v_rol_id dllave2;
  v_clave text;
  v_estado text := 'C';
  _resultado record;
begin

  --buscamos si existe usuario
  SELECT * into usuarios FROM nucleo.usuarios WHERE cuenta = p_cuenta;
  if (usuarios is null) then
    --registramos nuevo usuario
    INSERT INTO nucleo.usuarios(pers_id, cuenta, clave, alias, usuario) VALUES
    (p_pers_id, split_part(p_cuenta, '@', 1), crypt('#$%&'||p_cuenta||'#$%&', gen_salt('bf')), p_alias,'rpmamani')
     returning * into usuarios;
  end if;
    
  FOR _resultado IN
     SELECT * FROM json_to_recordset(p_roles_id::json)
      AS x("rolId" dllave, "select" dbooleano2)
  LOOP
     --buscamos uno a uno el rol del usuario
      v_rol_id := (SELECT id FROM nucleo.usr_roles 
                   WHERE user_id = usuarios.pers_id 
                   AND rol_id = _resultado."rolId");
      
      IF(v_rol_id is null) then
        -- REGISTRAR SI NO CUENTA
        INSERT INTO nucleo.usr_roles(user_id,rol_id,expira,permiso,usuario) VALUES
        (usuarios.pers_id, _resultado."rolId",'2050-01-01','{}','rpmamani');
      ELSE
         --Modificamos o registramos todos los reles
         IF _resultado.select then
           v_estado = 'C';
         ELSE
           v_estado = 'X';
         END IF;
         UPDATE nucleo.usr_roles SET estado = v_estado 
         WHERE user_id = usuarios.pers_id AND rol_id = _resultado."rolId";
      END IF;
      
  END LOOP;

  return usuarios;
end;
$$ language plpgsql; -- strict security definer;

*/

/** Aut: renepastor@gmail.com AGO2017
*  Autenticacion del usuario
*   **/
CREATE OR REPLACE FUNCTION base.auth(
  p_usuario text,
  p_clave text
) returns base.jwt as $$
DECLARE
  users base.usuario;
  roles json;
BEGIN
  SELECT a.* INTO users
  FROM base.usuario as a
  WHERE a.username = $1
  AND a.activo;
  
  roles := (SELECT array_to_json(array_agg(t.*)) FROM (
     SELECT r.id, r.nombre
     FROM base.usuario_rol ur, base.rol r
     WHERE ur.id_usuario = users.id
     AND ur.id_rol = r.id
     AND r.activo
     AND ur.activo
     GROUP BY r.id, r.nombre) t);

  IF users.clave = crypt(p_clave, users.clave) THEN
    return ('root', users.id, users.username, users.alias)::base.jwt;
  ELSE
    return null;
  END IF;
END;
$$ LANGUAGE plpgsql strict security definer;
COMMENT ON FUNCTION base.auth(text, text) is 'Autenticacion de usuario por el nombre de usuario y la clave encriptada';

/** Aut: renepastor@gmail.com AGO2017
*  Buscar datos del usuario loqueado
*   **/
CREATE OR REPLACE FUNCTION base.mi_usuario() RETURNS base.usuario AS $$
  SELECT *
  FROM base.usuario
  WHERE id = current_setting('jwt.claims.id_usuario')::dllave
  AND activo
$$ language sql stable;
COMMENT ON FUNCTION base.mi_usuario() is 'Buscando Usuario en session';

--drop function base.mi_menu(dllave);
CREATE OR REPLACE FUNCTION base.mi_menu(dllave) RETURNS SETOF base.vw_permiso AS $$
  SELECT *
  FROM base.vw_permiso
  WHERE username = current_setting('jwt.claims.username')
  AND id_aplicacion = $1
$$ language sql stable;
COMMENT ON FUNCTION base.mi_menu(dllave) is 'Buscando menu de usuario logueado';


CREATE OR REPLACE FUNCTION base.edit_clave(
  p_clave text,
  p_clave2 text
) returns text as $$
DECLARE
  v_id integer:=1;
  --current_setting('jwt.claims.id_usuario')::integer
BEGIN

  UPDATE base.usuario
  SET clave = crypt(p_clave2, gen_salt('bf'))
  WHERE id = current_setting('jwt.claims.id_usuario')::integer
  AND clave = crypt(p_clave, clave);
  --p_clave = p_clave
  
  IF found THEN
    return 'ok';
  END IF;
  return 'Por favor verifique los datos';
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION base.edit_clave(text,text)
is 'Modificar clave del usuario';




CREATE OR REPLACE FUNCTION base.fn_tipo_nombre(integer) RETURNS text
-- id tbl_tipos
AS $$
  SELECT codigo
    FROM base.tbl_tipos
    WHERE id = $1;
$$
    LANGUAGE sql;



CREATE OR REPLACE FUNCTION base.fn_tipo_nombre_id(text) RETURNS bigint
-- nombre 
AS $$
  SELECT id
    FROM base.tbl_tipos
    WHERE codigo = $1;
$$
    LANGUAGE sql;

/** Aut: renepastor@gmail.com AGO2017
*  Crear y Editar Tabla Tipos
*   **/
CREATE OR REPLACE FUNCTION base.edit_tbl_tipos(
  p_id integer,
  p_padre_id integer,
  p_nombre text,
  p_valor text,
  p_descripcion text,
  p_ayuda text,
  p_estado text,
  p_validador text
) returns integer as $$
DECLARE
  r_id integer;
  v_user integer := current_setting('jwt.claims.id')::integer;
BEGIN

  IF p_id is null THEN
    INSERT INTO base.tbl_tipos(nombre,valor,descripcion,ayuda,validador,padre_id,usuario)
    VALUES(p_nombre,p_valor,p_descripcion,p_ayuda,'',p_padre_id, v_user)
    returning id into r_id;
  ELSE
    UPDATE base.tbl_tipos
    SET nombre = p_nombre,
    valor=p_valor,
    descripcion=p_descripcion,
    ayuda=p_ayuda,
    padre_id=p_padre_id,
    --validador=p_validador,
    estado=p_estado,
    usuario=v_user
    WHERE id=p_id;
    r_id := p_id;
  END IF;

  return r_id;
END;
$$ LANGUAGE plpgsql;
COMMENT ON FUNCTION base.edit_tbl_tipos(integer,integer,text,text,text,text,text,text)
is 'Crear y Editar tablas tipos';


CREATE OR REPLACE FUNCTION fn_objeto(text, text) RETURNS text
-- $1=squema, $2=tabla
AS $$
  SELECT d.description
  FROM pg_class As c
  LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
  LEFT JOIN pg_tablespace t ON t.oid = c.reltablespace
  LEFT JOIN pg_description As d ON (d.objoid = c.oid AND d.objsubid = 0)
  WHERE nspname = $1
  AND c.relname = $2
  LIMIT 1;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION fn_columna(text, text, text) RETURNS text
-- $1=squema, $2=tabla, $3=columna
AS $$
  SELECT d.description
  FROM pg_class As c
  INNER JOIN pg_attribute As a ON c.oid = a.attrelid
  LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
  LEFT JOIN pg_tablespace t ON t.oid = c.reltablespace
  LEFT JOIN pg_description As d ON (d.objoid = c.oid AND d.objsubid = a.attnum)
  WHERE c.relkind IN('r', 'v') 
  AND n.nspname = $1
  AND c.relname = $2
  AND a.attname = $3
  LIMIT 1;
$$
LANGUAGE sql;


--DROP VIEW base.vw_table;
CREATE VIEW base.vw_table AS 
SELECT table_catalog "base", table_schema::text "squema", table_name::text "table", table_type "type",
fn_objeto(table_schema::text, table_name::text) title
FROM information_schema.tables
WHERE table_schema not in ('pg_catalog', 'information_schema');

--select * from nucleo.vw_table;

CREATE VIEW base.vw_column AS 
SELECT 
  c.table_name::text "table",
  c.column_name::text "label",
  c.column_name::text "id",
  c.column_name::text "name",
  c.ordinal_position::text orden,
  CASE WHEN(k.constraint_name like '%_pkey') THEN 'pkey'
       WHEN(k.constraint_name like '%_fkey') THEN 'fkey' ELSE k.constraint_name::text END pkey,
  udt_name::text "type",
  udt_name::text "clas",
  f.table_name::text tabla_fkey,
  f.column_name::text id_fkey,
  f.column_name::text column_fkey,
  '1'::text "row",
  c.character_maximum_length::text size,
  CASE WHEN(column_default::text like '%_seq%') THEN '+++' ELSE column_default::text END "value",
  CASE WHEN(is_nullable::text = 'NO') THEN 'required="required"'::text
       WHEN(k.constraint_name like '%_pkey' or k.constraint_name like '%_fkey') THEN 'required="required"'::text ELSE '' END  required,
  fn_columna(c.table_schema, c.table_name, c.column_name) title,
  domain_name dominio 
FROM information_schema.columns c LEFT JOIN  information_schema.key_column_usage k
ON (c.column_name = k.column_name AND c.table_name = k.table_name)
LEFT JOIN information_schema.constraint_column_usage f 
ON (k.constraint_name = f.constraint_name)
--where c.table_name = 'empleados'
ORDER BY c.table_name::text, c.ordinal_position::int;










CREATE OR REPLACE FUNCTION base.fn_tbl_tipos(_codigo text) RETURNS SETOF base.tbl_tipos AS $$
  SELECT *
  FROM base.tbl_tipos tt
  WHERE tt.padre_id in (SELECT ttt.id FROM base.tbl_tipos ttt WHERE ttt.codigo=$1 AND ttt.activo)
  AND tt.activo
$$ language sql stable;
COMMENT ON FUNCTION base.fn_tbl_tipos(_codigo text) is 'Tabla tipos dependientes';







commit;
