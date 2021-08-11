
begin;
/*
CREATE TABLE files.localizacion_geografica (
    id bigserial primary key,
    dependiente_id dllave,
    abreviatura dtexto,
    nombre dtexto,
    nivel dentero,
    activo dbool,
    creado dfechahora,
    creador dtexto,
    editado dfechahora,
    editor dtexto
);

CREATE OR REPLACE FUNCTION flocgeo(_nombre text, _nivel integer) RETURNS bigint
AS $$ SELECT id FROM files.localizacion_geografica WHERE nombre = $1 AND nivel = $2 LIMIT 1;
$$ LANGUAGE sql;


INSERT INTO files.localizacion_geografica(dependiente_id, nombre, abreviatura, nivel, activo, creador, creado) VALUES
(1, '-Mundo-', 'UNI', 0, true,'admin',NOW());

INSERT INTO files.localizacion_geografica(dependiente_id, nombre, abreviatura, nivel, creador, creado) VALUES
(flocgeo('-Mundo-', 0), 'SUD AMERICA', 'SAM', 1,'admin',NOW());

INSERT INTO files.localizacion_geografica(dependiente_id, nombre, abreviatura, nivel, creador, creado) VALUES
(flocgeo('SUD AMERICA', 1), 'BOLIVIA', 'BOL', 2,'admin',NOW());

INSERT INTO files.localizacion_geografica(dependiente_id, nombre, abreviatura, nivel, creador, creado) VALUES
(flocgeo('BOLIVIA', 2), 'Chuquisaca', 'CHQ', 3,'admin',NOW()),
(flocgeo('BOLIVIA', 2), 'La Paz', 'LP', 3,'admin',NOW()),
(flocgeo('BOLIVIA', 2), 'Cochabamba', 'CB', 3,'admin',NOW()),
(flocgeo('BOLIVIA', 2), 'Oruro', 'OR', 3,'admin',NOW()),
(flocgeo('BOLIVIA', 2), 'Potosí', 'PT', 3,'admin',NOW()),
(flocgeo('BOLIVIA', 2), 'Tarija', 'TJ', 3,'admin',NOW()),
(flocgeo('BOLIVIA', 2), 'Santa Cruz', 'SCZ', 3,'admin',NOW()),
(flocgeo('BOLIVIA', 2), 'Beni', 'BN', 3,'admin',NOW()),
(flocgeo('BOLIVIA', 2), 'Pando', 'PN', 3,'admin',NOW());

INSERT INTO files.localizacion_geografica(dependiente_id, nombre, abreviatura, nivel, creador, creado) VALUES
(flocgeo('Chuquisaca', 3), 'Oropeza', '101', 4,'admin',NOW()),
(flocgeo('Chuquisaca', 3), 'Azurduy', '102', 4,'admin',NOW()),
(flocgeo('Chuquisaca', 3), 'Zudañez', '103', 4,'admin',NOW()),
(flocgeo('Chuquisaca', 3), 'Tomina', '104', 4,'admin',NOW()),
(flocgeo('Chuquisaca', 3), 'Hernando Siles', '105', 4,'admin',NOW()),
(flocgeo('Chuquisaca', 3), 'Yamparaez', '106', 4,'admin',NOW()),
(flocgeo('Chuquisaca', 3), 'Nor Cinti', '107', 4,'admin',NOW()),
(flocgeo('Chuquisaca', 3), 'Belisario Boeto', '108', 4,'admin',NOW()),
(flocgeo('Chuquisaca', 3), 'Sud Cinti', '109', 4,'admin',NOW()),
(flocgeo('Chuquisaca', 3), 'Luis Calvo', '110', 4,'admin',NOW());

INSERT INTO files.localizacion_geografica(dependiente_id, nombre, abreviatura, nivel, creador, creado) VALUES
(flocgeo('La Paz', 3), 'Murillo', '201', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Omasuyos', '202', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Pacajes', '203', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Camacho', '204', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Muñecas', '205', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Larecaja', '206', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Franz Tamayo', '207', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Ingavi', '208', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Loayza', '209', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Inquisivi', '210', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Sur Yungas', '211', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Los Andes', '212', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Aroma', '213', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Nor Yungas', '214', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Abel Iturralde', '215', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Bautista Saavedra', '216', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Manco Kapac', '217', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Gualberto Villarroel', '218', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Gral. J. Manuel Pando', '219', 4,'admin',NOW()),
(flocgeo('La Paz', 3), 'Caranavi', '220', 4,'admin',NOW());

INSERT INTO files.localizacion_geografica(dependiente_id, nombre, abreviatura, nivel, creador, creado) VALUES
(flocgeo('Cochabamba', 3), 'Cercado', '301', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'Campero', '302', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'Ayopaya', '303', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'Esteban Arce', '304', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'Arani', '305', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'Arque', '306', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'Capinota', '307', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'German Jordan', '308', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'Quillacollo', '309', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'Chapare', '310', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'Tapacari', '311', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'Carrasco', '312', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'Mizque', '313', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'Punata', '314', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'Bolivar', '315', 4,'admin',NOW()),
(flocgeo('Cochabamba', 3), 'Tiraque', '316', 4,'admin',NOW());

INSERT INTO files.localizacion_geografica(dependiente_id, nombre, abreviatura, nivel, creador, creado) VALUES
(flocgeo('Oruro', 3), 'Cercado', '401', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'Abaroa', '402', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'Carangas', '403', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'Sajama', '404', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'Litoral', '405', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'Poopo', '406', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'Pantaleon Dalence', '407', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'Ladislao Cabrera', '408', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'Sabaya', '409', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'Saucari', '410', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'Tomas Barron', '411', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'Sur Carangas', '412', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'S. Pedro de Totora', '413', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'Sebastian Pagador', '414', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'Mejillones', '415', 4,'admin',NOW()),
(flocgeo('Oruro', 3), 'Nor Carangas', '416', 4,'admin',NOW());

INSERT INTO files.localizacion_geografica(dependiente_id, nombre, abreviatura, nivel, creador, creado) VALUES
(flocgeo('Potosí', 3), 'Tomas Frias', '501', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Rafael Bustillo', '502', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Cornelio Saavedra', '503', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Chayanta', '504', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Charcas', '505', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Nor Chichas', '506', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Alonzo de Ibañez', '507', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Sur Chichas', '508', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Nor Lipez', '509', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Sur Lipez', '510', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Jose Maria Linares', '511', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Antonio Quijarro', '512', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Gral. B. Bilbao', '513', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Daniel Campos', '514', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Modesto Omiste', '515', 4,'admin',NOW()),
(flocgeo('Potosí', 3), 'Enrique Baldiviezo','516', 4,'admin',NOW());

INSERT INTO files.localizacion_geografica(dependiente_id, nombre, abreviatura, nivel, creador, creado) VALUES
(flocgeo('Tarija', 3), 'Cercado', '601', 4,'admin',NOW()),
(flocgeo('Tarija', 3), 'Arce', '602', 4,'admin',NOW()),
(flocgeo('Tarija', 3), 'Gran Chaco', '603', 4,'admin',NOW()),
(flocgeo('Tarija', 3), 'Avilez', '604', 4,'admin',NOW()),
(flocgeo('Tarija', 3), 'Mendez', '605', 4,'admin',NOW()),
(flocgeo('Tarija', 3), 'Burnet O Connor', '606', 4,'admin',NOW());

INSERT INTO files.localizacion_geografica(dependiente_id, nombre, abreviatura, nivel, creador, creado) VALUES
(flocgeo('Santa Cruz', 3), 'Andres Ibañez', '701', 4,'admin',NOW()),
(flocgeo('Santa Cruz', 3), 'Warnes', '702', 4,'admin',NOW()),
(flocgeo('Santa Cruz', 3), 'Velasco', '703', 4,'admin',NOW()),
(flocgeo('Santa Cruz', 3), 'Ichilo', '704', 4,'admin',NOW()),
(flocgeo('Santa Cruz', 3), 'Chiquitos', '705', 4,'admin',NOW()),
(flocgeo('Santa Cruz', 3), 'Sara', '706', 4,'admin',NOW()),
(flocgeo('Santa Cruz', 3), 'Cordillera', '707', 4,'admin',NOW()),
(flocgeo('Santa Cruz', 3), 'Vallegrande', '708', 4,'admin',NOW()),
(flocgeo('Santa Cruz', 3), 'Florida', '709', 4,'admin',NOW()),
(flocgeo('Santa Cruz', 3), 'Obispo Santiestevan', '710', 4,'admin',NOW()),
(flocgeo('Santa Cruz', 3), 'Ñuflo de Chavez', '711', 4,'admin',NOW()),
(flocgeo('Santa Cruz', 3), 'Angel Sandoval', '712', 4,'admin',NOW()),
(flocgeo('Santa Cruz', 3), 'Caballero', '713', 4,'admin',NOW()),
(flocgeo('Santa Cruz', 3), 'German Busch', '714', 4,'admin',NOW()),
(flocgeo('Santa Cruz', 3), 'Guarayos', '715', 4,'admin',NOW());

INSERT INTO files.localizacion_geografica(dependiente_id, nombre, abreviatura, nivel, creador, creado) VALUES
(flocgeo('Beni', 3), 'Cercado', '801', 4,'admin',NOW()),
(flocgeo('Beni', 3), 'Vaca Diez', '802', 4,'admin',NOW()),
(flocgeo('Beni', 3), 'Gral. J. Ballivian', '803', 4,'admin',NOW()),
(flocgeo('Beni', 3), 'Yacuma', '804', 4,'admin',NOW()),
(flocgeo('Beni', 3), 'Moxos', '805', 4,'admin',NOW()),
(flocgeo('Beni', 3), 'Marban', '806', 4,'admin',NOW()),
(flocgeo('Beni', 3), 'Mamore', '807', 4,'admin',NOW()),
(flocgeo('Beni', 3), 'Itenez', '808', 4,'admin',NOW());

INSERT INTO files.localizacion_geografica(dependiente_id, nombre, abreviatura, nivel, creador, creado) VALUES
(flocgeo('Pando', 3), 'Nicolas Suarez', '901', 4,'admin',NOW()),
(flocgeo('Pando', 3), 'Manuripi', '902', 4,'admin',NOW()),
(flocgeo('Pando', 3), 'Madre de Dios', '903', 4,'admin',NOW()),
(flocgeo('Pando', 3), 'Abuna', '904', 4,'admin',NOW()),
(flocgeo('Pando', 3), 'Gral. Federico Roman', '905', 4,'admin',NOW());


CREATE OR REPLACE FUNCTION ftptbl(_codigo text) RETURNS bigint
AS $$ SELECT id FROM base.tbl_tipos WHERE codigo = $1 LIMIT 1;
$$ LANGUAGE sql;


INSERT INTO base.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,creador) VALUES
(1,'--','0','Inicio','Es el origen de la tabla',1);

INSERT INTO base.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,creador) VALUES
(ftptbl('--'),'GENERO','GENEROS','Tipos de Genero','',1);

INSERT INTO base.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,creador) VALUES
(ftptbl('GENERO'),'FEMENINO','F','FEMENINO','',1);
INSERT INTO base.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,creador) VALUES
(ftptbl('GENERO'),'MASCULINO','M','MASCULINO','',1);

INSERT INTO base.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,creador) VALUES
(ftptbl('--'),'EST-CIVIL','ESTADO CIVIL','ESTADO CIVIL','',1);
INSERT INTO base.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,creador) VALUES
(ftptbl('EST-CIVIL'),'SOLTERA(O)','S','SOLTERA(O)','',1),
(ftptbl('EST-CIVIL'),'CASADA(O)','C','CASADA(O)','',1),
(ftptbl('EST-CIVIL'),'DIVORCIADA(O)','D','DIVORCIADA(O)','',1),
(ftptbl('EST-CIVIL'),'VIUDA(O)','V','VIUDA(O)','',1);

INSERT INTO base.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,creador) VALUES
(ftptbl('--'),'TP-DOC-FILE','TP-DOC','TIPO DOCUMENTOS FILE','',1);
INSERT INTO base.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,creador) VALUES
(ftptbl('TP-DOC-FILE'),'DOCUMENTO DE IDENTIDAD','CI','DOCUMENTO DE IDENTIDAD','',1),
(ftptbl('TP-DOC-FILE'),'PASAPORTE','PT','PASAPORTE','',1);


INSERT INTO base.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,creador) VALUES
(ftptbl('--'),'TP-VIVIENDA','TP-VIVI','TIPO TIPO VIVIVIENDA','',1);
INSERT INTO base.tbl_tipos(padre_id,nombre,valor,descripcion,ayuda,creador) VALUES
(ftptbl('TP-VIVIENDA'),'CASA','CASA','CASA','',1),
(ftptbl('TP-VIVIENDA'),'EDIFICIO','EDIFICIO','','',1),
(ftptbl('TP-VIVIENDA'),'GALERIA','GALERIA','GALERIA','',1);



DROP  FUNCTION base.add_simple_ilimitado(
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
);

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
  numero_pospago text
) to protegido;

GRANT USAGE, SELECT ON SEQUENCE files.simple_ilimitado_id_seq TO protegido;




CREATE OR REPLACE VIEW base.vw_permiso
AS
SELECT ROW_NUMBER () OVER (ORDER BY rec.id) id,
       usu.username,
       modu.id_aplicacion ,
       modu.posicion posicion_modulo,
       modu.nombre modulo,
       modu.icono icono_modulo,
       rec.posicion posicion_recurso,
       rec.titulo recurso,
       rec.uri,
       rec.es_menu,
       rec.icono icono_recurso,
       rolrec.lectura,
       rolrec.creacion,
       rolrec.modificacion,
       rolrec.eliminacion
  FROM base.modulo  modu,
       base.recurso  rec,
       base.rol      rol,
       base.rol_recurso  rolrec,
       base.usuario_rol  usrrol,
       base.usuario usu
 WHERE usrrol.id_rol = rol.id
   AND usrrol.id_usuario = usu.id
   AND rolrec.id_rol = rol.id   
   AND rolrec.id_recurso = rec.id
   AND rec.id_modulo = modu.id
   AND modu.activo
   AND rec.activo
   AND rol.activo
   AND rolrec.activo
   AND usrrol.activo
   AND usu.activo
   AND rolrec.lectura;
*/

--create VIEW base.vw_simple_ilimitado AS
--  SELECT * FROM files.simple_ilimitado;
/*
drop VIEW base.vw_simple_ilimitado;
create VIEW base.vw_simple_ilimitado AS
SELECT id, foto_ci, foto_factura, foto_referencia_financiera, referencia_financiera, telefonos_planes, nombres, apellido_paterno, apellido_materno, 
apellido_marital, nro_documento, expedicion_id, fecha_nacimiento, correo,
 zona, calle_avenida, tipo_vivienda_id, nro_vivienda, referencias, celular_ref, telefono_ref,  checkbox_pospago_ilimitado, numero_pospago, 
 hora_propuesta, primer_numero, segundo_numero, estado_solicitado, fecha_programada, hora_programada, activo, creado, creador, editado, editor, mensaje, cliente_contactado,
 si.multicentro_id, si.ciudad_atencion_id,
(select direccion from files.multicentros tt where tt.id = si.plan_id) plan, 
(select descripcion from base.tbl_tipos tt where tt.id = si.genero_id) genero, 
(select descripcion from base.tbl_tipos tt where tt.id = si.estado_civil_id) estado_civil,
(select descripcion from base.tbl_tipos tt where tt.id = si.tipo_documento_id) tipo_documento,
(select nombre from base.ubicacion_geografica ug where ug.id = si.expedicion_id) expedicion,
(select nombre from base.ubicacion_geografica ug where ug.id = si.ciudad_atencion_id) ciudad_atencion,
(select direccion from files.multicentros tt where tt.id = si.multicentro_id) multicentro,
(select descripcion from base.tbl_tipos tt where tt.id = si.tipo_atencion_id) tipo_atencion,
(select nombre from base.ubicacion_geografica ug where ug.id = si.departamento_persomal_id) departamento_persomal
FROM files.simple_ilimitado si;


   
   
--drop  function base.fn_programar(p_id text, p_fecha_programada text, p_hora_programada text);
--drop  function base.fn_programar(p_id dllave, p_fecha_programada text, p_hora_programada text);

create or replace function base.fn_programar(p_id dllave, p_fecha_programada dfecha2, p_hora_programada dhora) returns text as $$
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


--drop function base.fn_aprobar(p_id text,p_mensaje dtexto,p_cliente_contactado dbool);
--drop function base.fn_aprobar(p_id dllave,p_mensaje dtexto,p_cliente_contactado dbool);
create or replace function base.fn_aprobar(p_id dllave,p_mensaje dtexto,p_cliente_contactado dbool) returns text as $$
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

--drop function base.fn_rechazar(p_id text, p_mensaje dtexto, p_cliente_contactado dbool);
--drop function base.fn_rechazar(p_id dllave, p_mensaje dtexto, p_cliente_contactado dbool);
create or replace function base.fn_rechazar(p_id dllave,p_mensaje dtexto,p_cliente_contactado dbool) returns text as $$
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
*/
--ALTER TABLE files.simple_ilimitado ADD COLUMN mensaje dtexto;
--ALTER TABLE files.simple_ilimitado ADD COLUMN cliente_contactado dbool;

drop VIEW base.vw_simple_ilimitado;
create VIEW base.vw_simple_ilimitado AS
SELECT id, foto_ci, foto_factura, foto_referencia_financiera, referencia_financiera, telefonos_planes, nombres, apellido_paterno, apellido_materno, 
apellido_marital, nro_documento, expedicion_id, fecha_nacimiento, correo, 
 zona, calle_avenida, tipo_vivienda_id, nro_vivienda, referencias, celular_ref, telefono_ref,  checkbox_pospago_ilimitado, numero_pospago, 
 hora_propuesta, primer_numero, segundo_numero, estado_solicitado, fecha_programada, hora_programada, activo, creado, creador, editado, editor, mensaje, cliente_contactado,
(select direccion from files.multicentros tt where tt.id = si.plan_id) plan, 
(select descripcion from base.tbl_tipos tt where tt.id = si.genero_id) genero, 
(select descripcion from base.tbl_tipos tt where tt.id = si.estado_civil_id) estado_civil,
(select descripcion from base.tbl_tipos tt where tt.id = si.tipo_documento_id) tipo_documento,
(select nombre from base.ubicacion_geografica ug where ug.id = si.expedicion_id) expedicion,
(select nombre from base.ubicacion_geografica ug where ug.id = si.ciudad_atencion_id) ciudad_atencion,
(select direccion from files.multicentros tt where tt.id = si.multicentro_id) multicentro_direccion,
(select nombre from files.multicentros tt where tt.id = si.multicentro_id) multicentro,
(select descripcion from base.tbl_tipos tt where tt.id = si.tipo_atencion_id) tipo_atencion,
(select nombre from base.ubicacion_geografica ug where ug.id = si.departamento_persomal_id) departamento_persomal
FROM files.simple_ilimitado si;

CREATE OR REPLACE FUNCTION base.fn_p_multicentro(ciudad_id dllave) RETURNS SETOF files.multicentros AS $$
  SELECT id, ciudad_id, nombre, (nombre||' - '||direccion)::dtexto direccion, coordenada, activo, creado, creador, editado, editor
  FROM files.multicentros
  WHERE activo
  AND ciudad_id = $1
$$ language sql stable;


grant SELECT ON base.rol to protegido;

commit;

