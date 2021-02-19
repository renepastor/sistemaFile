package com.abit.base.domain;


import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(schema="base", name = "usuarios")
public class Usuarios {

    private Integer personaId;
    private String alias;
    private String cuenta;
    private String clave;

    public Usuarios(Integer personaId, String alias, String cuenta, String clave) {
        this.personaId = personaId;
        this.alias = alias;
        this.cuenta = cuenta;
        this.clave = clave;
    }

    public Integer getPersonaId() {
        return personaId;
    }

    public void setPersonaId(Integer personaId) {
        this.personaId = personaId;
    }

    public String getAlias() {
        return alias;
    }

    public void setAlias(String alias) {
        this.alias = alias;
    }

    public String getCuenta() {
        return cuenta;
    }

    public void setCuenta(String cuenta) {
        this.cuenta = cuenta;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }
}
