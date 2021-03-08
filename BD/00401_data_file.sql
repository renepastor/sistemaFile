/*aut: renepastor@gmail.com
  fec: 19/06/2017
*/


/**$$$$$$$$$$******files*****$$$$$*****/
begin;
INSERT INTO files.categoria_servicios(nombre, logo, fecha_inicio, fecha_vigencia, estado, usuario, editado) VALUES
('Telefonía Móvil','mdi-cellphone-play',NOW(),NOW(),'C','admin',NOW()),
('Internet','mdi-wifi-check',NOW(),NOW(),'C','admin',NOW()),
('TV','mdi-laptop',NOW(),NOW(),'C','admin',NOW());
INSERT INTO files.servicios(categoria_id, servicio, promocion, descripcion, fecha_inicio, fecha_vigencia, estado, usuario, editado) VALUES
(1, 'Simple Ilimitadp', TRUE, 'Simple Ilimitadp ....... .... .......... ....... .....', now(), now(),'C','admin',NOW()),
(1, 'Simple', TRUE, 'Simple ....... .... .......... ....... .....', now(), now(),'C','admin',NOW()),
(1, 'Corporativos/Instituciones Publicas', TRUE, 'Corporativos/Instituciones Publicas ....... .... .......... ....... .....', now(), now(),'C','admin',NOW()),
(1, 'Red Privada Empresarial', TRUE, 'Red Privada Empresarial ....... .... .......... ....... .....', now(), now(),'C','admin',NOW()),
(1, 'Portabilidad TIGO, VIVA Postpago', TRUE, 'Portabilidad TIGO, VIVA Postpago ....... .... .......... ....... .....', now(), now(),'C','admin',NOW());
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
(5, 'Factura de Luz o Agua', TRUE,'C','admin',NOW());

commit;


