begin;


ALTER TABLE only inv.tabla_tipo ADD FOREIGN KEY (id_predecesor) REFERENCES inv.tabla_tipo(id);
ALTER TABLE only inv.recinto ADD FOREIGN KEY (id_tipo_recinto) REFERENCES inv.tabla_tipo(id);
ALTER TABLE only inv.recinto ADD FOREIGN KEY (id_sub_recinto) REFERENCES inv.tabla_tipo(id);
ALTER TABLE only inv.recinto ADD FOREIGN KEY (id_centro_costo) REFERENCES inv.centro_costo(id);
ALTER TABLE only inv.material_sub_grupo ADD FOREIGN KEY (id_material_grupo) REFERENCES inv.material_grupo(id);
ALTER TABLE only inv.material ADD FOREIGN KEY (id_unidad_medida) REFERENCES inv.unidad_medida(id);
ALTER TABLE only inv.material ADD FOREIGN KEY (id_material_grupo) REFERENCES inv.material_grupo(id);
ALTER TABLE only inv.material ADD FOREIGN KEY (id_material_sub_grupo) REFERENCES inv.material_sub_grupo(id);
ALTER TABLE only inv.ingreso ADD FOREIGN KEY (id_recinto) REFERENCES inv.recinto(id);
ALTER TABLE only inv.ingreso ADD FOREIGN KEY (id_tipo_movimiento) REFERENCES inv.tabla_tipo(id);
ALTER TABLE only inv.ingreso ADD FOREIGN KEY (id_recinto_origen) REFERENCES inv.recinto(id);
ALTER TABLE only inv.ingreso ADD FOREIGN KEY (id_tipo_cambio) REFERENCES inv.tipo_cambio(id);
ALTER TABLE only inv.ingres_detalle ADD FOREIGN KEY (id_ingreso) REFERENCES inv.ingreso(id);
ALTER TABLE only inv.ingres_detalle ADD FOREIGN KEY (id_centro_costo) REFERENCES inv.centro_costo(id);
ALTER TABLE only inv.ingres_detalle ADD FOREIGN KEY (id_condicion_material) REFERENCES inv.tabla_tipo(id);
ALTER TABLE only inv.ingres_detalle ADD FOREIGN KEY (id_material) REFERENCES inv.material(id);
ALTER TABLE only inv.salida ADD FOREIGN KEY (id_recinto) REFERENCES inv.recinto(id);
ALTER TABLE only inv.salida ADD FOREIGN KEY (id_tipo_movimiento) REFERENCES inv.tabla_tipo(id);
ALTER TABLE only inv.salida_detalle ADD FOREIGN KEY (id_salida) REFERENCES inv.salida(id);
ALTER TABLE only inv.salida_detalle ADD FOREIGN KEY (id_material) REFERENCES inv.material(id);
ALTER TABLE only inv.solicitar_item ADD FOREIGN KEY (id_unidad_medida) REFERENCES inv.unidad_medida(id);
ALTER TABLE only inv.solicitar_item ADD FOREIGN KEY (id_material_grupo) REFERENCES inv.material_grupo(id);
ALTER TABLE only inv.solicitar_item ADD FOREIGN KEY (id_material_sub_grupo) REFERENCES inv.material_sub_grupo(id);
ALTER TABLE only inv.existencia ADD FOREIGN KEY (id_recinto) REFERENCES inv.recinto(id);
ALTER TABLE only inv.existencia ADD FOREIGN KEY (id_material) REFERENCES inv.material(id);



commit;