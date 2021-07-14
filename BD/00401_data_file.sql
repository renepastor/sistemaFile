/*aut: renepastor@gmail.com
  fec: 19/06/2017
*/


/**$$$$$$$$$$******files*****$$$$$*****/
begin;
INSERT INTO files.categoria_servicios(nombre, logo, fecha_inicio, fecha_vigencia, estado, usuario, editado) VALUES
('Telefonía Móvil','mdi-cellphone-play',NOW(),NOW(),'C','admin',NOW()),
('Internet','mdi-wifi-check',NOW(),NOW(),'C','admin',NOW()),
('TV','mdi-laptop',NOW(),NOW(),'C','admin',NOW());



INSERT INTO files.servicios(categoria_id, servicio, promocion, formulario, informacion, fecha_inicio, fecha_vigencia, estado, usuario, editado) VALUES
(1, 'Simple Ilimitados', TRUE,'./solicitud/simpleIlimitado', '/tplinformacion/simpleIlimitado.html', now(), now(),'C','admin',NOW()),
(1, 'Simple', TRUE,'./solicitud/simple', '/tplinformacion/simple.html', now(), now(),'C','admin',NOW()),
(1, 'Corporativos Exacto', TRUE,'./solicitud/corporativo', '/tplinformacion/corporativo.html', now(), now(),'C','admin',NOW()),
(1, 'Corporativos/Instituciones Publicas', TRUE,'./solicitud/institucionPublica', '/tplinformacion/institucionPublica.html', now(), now(),'C','admin',NOW()),
(1, 'Red Privada Empresarial', TRUE,'./solicitud/rpe', '/tplinformacion/rpe.html', now(), now(),'C','admin',NOW()),
(1, 'Portabilidad TIGO, VIVA Postpago', TRUE,'./solicitud/portabilidad', '/tplinformacion/portabilidad.html', now(), now(),'C','admin',NOW()),
(2, 'Fibra Hogar', TRUE,'./solicitud/fibraHogar', '/tplinformacion/fibraHogar.html', now(), now(),'C','admin',NOW()),
(2, 'Fibra + Móvil', TRUE,'./solicitud/fibraMovil', '/tplinformacion/fibraMovil.html', now(), now(),'C','admin',NOW()),
(2, 'Duo', TRUE,'./solicitud/duo', '/tplinformacion/duo.html', now(), now(),'C','admin',NOW()),
(2, 'Multiplay +', TRUE,'./solicitud/multiplay', '/tplinformacion/multiplay.html', now(), now(),'C','admin',NOW()),
(3, 'Televición Satelital Postpago', TRUE,'./solicitud/tvSat', '/tplinformacion/tvSat.html', now(), now(),'C','admin',NOW()),
(3, 'IPTV con Fibra Optica', TRUE,'./solicitud/iptv', '/tplinformacion/iptv.html', now(), now(),'C','admin',NOW());


/*
INSERT INTO files.planes(servicio_id, plan, costo, fecha_inicio, fecha_vigencia, estado, usuario, editado) VALUES
  (1, 'plan 1','234,32BS', now(), now(),'C','admin',NOW()),
  (1, 'plan 2','234,32BS', now(), now(),'C','admin',NOW()),
  (1, 'plan 3','234,32BS', now(), now(),'C','admin',NOW()),
  (2, 'plan 2.1','234,32BS', now(), now(),'C','admin',NOW()),
  (2, 'plan 2.2','234,32BS', now(), now(),'C','admin',NOW()),
  (2, 'plan 2.3','234,32BS', now(), now(),'C','admin',NOW()),
  (2, 'plan 2.4','234,32BS', now(), now(),'C','admin',NOW()),
  (3, 'plan 3.1','234,32BS', now(), now(),'C','admin',NOW()),
  (3, 'plan 3.2','234,32BS', now(), now(),'C','admin',NOW());
*/



INSERT INTO files.requisitos_servicios(servicio_id, descripcion, requerido, estado, usuario, editado) VALUES
(1, 'Fotografía de tu documento de identidad', TRUE,'C','admin',NOW()),
(1, 'Fotografía de factura de agua, luz, gas o teléfono', TRUE,'C','admin',NOW()),
(1, 'Si supera un consumo de Bs. 600, una fotografía de tu respaldo financiero', TRUE,'C','admin',NOW()),
(2, 'Fotografía de tu documento de identidad', TRUE,'C','admin',NOW()),
(2, 'Fotografía de factura de agua, luz, gas o teléfono', TRUE,'C','admin',NOW()),
(2, 'Si supera un consumo de Bs. 600, una fotografía de tu respaldo financiero', TRUE,'C','admin',NOW()),
(3, 'Fotografía de tu documento de identidad', TRUE,'C','admin',NOW()),
(3, 'Fotografía de tu Ultima boleta de Pago', TRUE,'C','admin',NOW()),
(3, 'Si supera un consumo de Bs. 600, una fotografía de tu respaldo financiero', TRUE,'C','admin',NOW()),
(4, 'Fotografía de tu documento de identidad', TRUE,'C','admin',NOW()),
(4, 'Fotografía de tu Ultima boleta de Pago', TRUE,'C','admin',NOW()),
(4, 'Factura de servicio básico', TRUE,'C','admin',NOW()),
(4, 'Si supera un consumo de Bs. 600, una fotografía de tu respaldo financiero.', TRUE,'C','admin',NOW()),
(5, 'Ser parte del plan Simple Ilimitado', TRUE,'C','admin',NOW()),
(5, 'Fotografía de tu documento de identidad', TRUE,'C','admin',NOW()),
(5, 'Fotografía de tu Ultima boleta de Pago', TRUE,'C','admin',NOW()),
(5, 'Fotografía de factura de agua, luz, gas o teléfono', TRUE,'C','admin',NOW()),
(5, 'Si supera un consumo de Bs. 600, una fotografía de tu respaldo financiero.', TRUE,'C','admin',NOW()),
(6, 'Fotografía de tu documento de identidad', TRUE,'C','admin',NOW()),
(6, 'Fotografía de tu Ultima boleta de Pago', TRUE,'C','admin',NOW()),
(6, 'Fotografía de factura de agua, luz, gas o teléfono', TRUE,'C','admin',NOW()),
(6, 'Si supera un consumo de Bs. 600, una fotografía de tu respaldo financiero', TRUE,'C','admin',NOW()),
(6, 'Fecha de Activación en la empresa donante.', TRUE,'C','admin',NOW()),
(7, 'Fotografía de tu documento de identidad', TRUE,'C','admin',NOW()),
(7, 'Fotografía de factura de agua, luz, gas o teléfono', TRUE,'C','admin',NOW()),
(7, 'Si supera un consumo de Bs. 600, una fotografía de tu respaldo financiero', TRUE,'C','admin',NOW()),
(8, 'Fotografía de tu documento de identidad', TRUE,'C','admin',NOW()),
(8, 'Fotografía de factura de agua, luz, gas o teléfono', TRUE,'C','admin',NOW()),
(8, 'Si supera un consumo de Bs. 600, una fotografía de tu respaldo financiero', TRUE,'C','admin',NOW()),
(9, 'Fotografía de tu documento de identidad', TRUE,'C','admin',NOW()),
(9, 'Fotografía de factura de agua, luz, gas o teléfono', TRUE,'C','admin',NOW()),
(9, 'Si supera un consumo de Bs. 600, una fotografía de tu respaldo financiero', TRUE,'C','admin',NOW()),
(10, 'Fotografía de tu documento de identidad', TRUE,'C','admin',NOW()),
(10, 'Fotografía de factura de agua, luz, gas o teléfono', TRUE,'C','admin',NOW()),
(10, 'Si supera un consumo de Bs. 600, una fotografía de tu respaldo financiero', TRUE,'C','admin',NOW()),
(11, 'Fotografía de tu documento de identidad', TRUE,'C','admin',NOW()),
(11, 'Fotografía de factura de agua, luz, gas o teléfono', TRUE,'C','admin',NOW()),
(11, 'Si supera un consumo de Bs. 600, una fotografía de tu respaldo financiero', TRUE,'C','admin',NOW()),
(12, 'Fotografía de tu documento de identidad', TRUE,'C','admin',NOW()),
(12, 'Fotografía de factura de agua, luz, gas o teléfono', TRUE,'C','admin',NOW()),
(12, 'Si supera un consumo de Bs. 600, una fotografía de tu respaldo financiero', TRUE,'C','admin',NOW());

commit;


