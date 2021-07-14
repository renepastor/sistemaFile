create table base.departamentos (
  id bigserial primary key,
  departamento dtexto,
  sigla dtexto,
  estado destado,
  usuario duser,
  editado dfechahora
);

create table base.multicentros (
  id bigserial primary key,
  id_departamento dllave,
  multicentro dtexto,
  codigo dtexto,
  direccion dtexto,
  coordenadas dpunto,
  estado destado,
  usuario duser,
  editado dfechahora
);

INSERT INTO base.departamentos (departamento,sigla,estado,usuario,editado) VALUES
('LA PAZ', 'LPZ', 'C','admin',now()),
('ORURO', 'ORU', 'C','admin',now());








INSERT INTO base.multicentros (id_departamento, multicentro, codigo, direccion, coordenadas, estado, usuario, editado);
(1, 'SUC ....', 'ORU', 'C','admin',now()),
('ORURO', 'ORU', 'C','admin',now());

