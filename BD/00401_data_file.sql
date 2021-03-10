/*aut: renepastor@gmail.com
  fec: 19/06/2017
*/


/**$$$$$$$$$$******files*****$$$$$*****/
begin;
INSERT INTO files.categoria_servicios(nombre, logo, fecha_inicio, fecha_vigencia, estado, usuario, editado) VALUES
('Telefonía Móvil','mdi-cellphone-play',NOW(),NOW(),'C','admin',NOW()),
('Internet','mdi-wifi-check',NOW(),NOW(),'C','admin',NOW()),
('TV','mdi-laptop',NOW(),NOW(),'C','admin',NOW());
INSERT INTO files.planes(categoria_id, plan, costo, fecha_inicio, fecha_vigencia, estado, usuario, editado) VALUES
(1, 'plan 1','234,32BS', now(), now(),'C','admin',NOW()),
(1, 'plan 2','234,32BS', now(), now(),'C','admin',NOW()),
(1, 'plan 3','234,32BS', now(), now(),'C','admin',NOW()),
(2, 'plan 2.1','234,32BS', now(), now(),'C','admin',NOW()),
(2, 'plan 2.2','234,32BS', now(), now(),'C','admin',NOW()),
(2, 'plan 2.3','234,32BS', now(), now(),'C','admin',NOW()),
(2, 'plan 2.4','234,32BS', now(), now(),'C','admin',NOW()),
(3, 'plan 3.1','234,32BS', now(), now(),'C','admin',NOW()),
(3, 'plan 3.2','234,32BS', now(), now(),'C','admin',NOW());

INSERT INTO files.requisitos_servicios(servicio_id, descripcion, requerido, estado, usuario, editado) VALUES
(1, 'Fotocopia de CI', TRUE,'C','admin',NOW()),
(1, 'Factura de Luz o Agua', TRUE,'C','admin',NOW()),
(2, 'Fotocopia de CI', TRUE,'C','admin',NOW()),
(2, 'Factura de Luz o Agua', TRUE,'C','admin',NOW()),
(3, 'Fotocopia de CI', TRUE,'C','admin',NOW()),
(3, 'Factura de Luz o Agua', TRUE,'C','admin',NOW()),
(4, 'Fotocopia de CI', TRUE,'C','admin',NOW()),
(4, 'Factura de Luz o Agua', TRUE,'C','admin',NOW()),
(5, 'Fotocopia de CI', TRUE,'C','admin',NOW()),
(5, 'Factura de Luz o Agua', TRUE,'C','admin',NOW()),
(6, 'Fotocopia de CI', TRUE,'C','admin',NOW()),
(6, 'Factura de Luz o Agua', TRUE,'C','admin',NOW()),
(7, 'Fotocopia de CI', TRUE,'C','admin',NOW()),
(7, 'Factura de Luz o Agua', TRUE,'C','admin',NOW()),
(8, 'Fotocopia de CI', TRUE,'C','admin',NOW()),
(8, 'Factura de Luz o Agua', TRUE,'C','admin',NOW()),
(9, 'Fotocopia de CI', TRUE,'C','admin',NOW()),
(9, 'Factura de Luz o Agua', TRUE,'C','admin',NOW());



INSERT INTO files.servicios(categoria_id, servicio, promocion, requisitos, descripcion, fecha_inicio, fecha_vigencia, estado, usuario, editado) VALUES
(1, 'Simple Ilimitados', TRUE,'Fotocopia de CI, Fotocopia de Luz', 'Simple Ilimitados ....... .... .......... ....... .....', now(), now(),'C','admin',NOW()),
(1, 'Simple', TRUE,'Fotocopia de CI, Fotocopia de Luz', 'Simple ....... .... .......... ....... .....', now(), now(),'C','admin',NOW()),
(1, 'Corporativos/Instituciones Publicas', TRUE,'Fotocopia de CI, Fotocopia de Luz', 'Corporativos/Instituciones Publicas ....... .... .......... ....... .....', now(), now(),'C','admin',NOW()),
(1, 'Red Privada Empresarial', TRUE,'Fotocopia de CI, Fotocopia de Luz', 'Red Privada Empresarial ....... .... .......... ....... .....', now(), now(),'C','admin',NOW()),
(1, 'Portabilidad TIGO, VIVA Postpago', TRUE,'Fotocopia de CI, Fotocopia de Luz', 'Portabilidad TIGO, VIVA Postpago ....... .... .......... ....... .....', now(), now(),'C','admin',NOW()),
(2, 'Multiplay', TRUE,'Fotocopia de CI, Fotocopia de Luz', 'Detalles ....... .... .......... ....... .....', now(), now(),'C','admin',NOW());

commit;


