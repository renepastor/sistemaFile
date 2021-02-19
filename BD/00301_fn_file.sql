/*aut: renepastor@gmail.com
  fec: 19/06/2017
*/
begin;

commit;

/****DOCUMENTOS***/
begin;

  create or replace function nucleo.fn_guardar_documentos(
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
    from nucleo.documentos_personal
    where persona_id = p_persona_id
    and tipo_documento_id = p_tipo_documento_id;
    if (p_fecha_vigencia = 'null' or p_fecha_vigencia = '') then p_fecha_vigencia = null; end if;
  
    if _id != 0 then
      UPDATE nucleo.documentos_personal
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
      INSERT INTO nucleo.documentos_personal
      (persona_id, tipo_documento_id, tipo_estado_id, observacion, archivo, fecha_vigencia)
      VALUES(p_persona_id, p_tipo_documento_id, p_tipo_estado_id, p_observacion, p_archivo, p_fecha_vigencia::dfecha2)
      returning id into _id;
    end if;
    return _id;
  end;
  $$ language plpgsql strict security definer;
  comment on function nucleo.fn_guardar_documentos(dllave, dllave, dllave2, dllave2, dtexto2, djson, dtexto2)
  is 'Registro de datos de los registro docupemtos del personal';

commit;
