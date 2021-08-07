<template>
    <v-dialog v-model="dialog" persistent width="500">
        <template v-slot:activator="{ on, attrs }">
            <v-hover>
                <template v-slot:default="{ hover }">
                    <v-btn outlined color="btnew" :elevation="hover ? 10 : 0" v-bind="attrs" v-on="on">
                        Aprobar
                    </v-btn>
                </template>
            </v-hover>
        </template>

        <v-card>
            <v-card-title class="headline grey lighten-2">Aprobar Solicitud</v-card-title>
            <val-obse ref="observer" v-slot="{ invalid }">
                <v-form @submit.prevent="guardarRegistro" ref="form" v-model="valid" lazy-validation>
                    <v-card-text>
                        <v-container>
                            <v-row no-gutters dense>
                                <v-col cols="12" sm="6">
                                  <v-text-field dense
                                    v-model="revision.ciudadAtencion"
                                    label="Ciudad Contrato"
                                    readonly
                                  ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6">
                                  <v-text-field dense
                                    v-model="revision.multicentro"
                                    label="Multicentro elegido por el Cliente"
                                    readonly
                                  ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6">
                                  <v-text-field dense
                                    v-model="revision.horaPropuesta"
                                    label="Hora elegida por el cliente"
                                    readonly
                                  ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6">
                                  <div class="text-center pa-2">
                                    <nuxt-link to="/publico/categoriaServ">
                                      <v-btn outlined color="indigo">Disponibilidad</v-btn>
                                    </nuxt-link>
                                  </div>
                                </v-col>
                                <v-col cols="12" sm="6">
                                  <v-text-field dense
                                    v-model="revision.fechaProgramada"
                                    label="Fecha Programada"
                                    readonly
                                  ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6">
                                  <v-text-field dense
                                    v-model="revision.horaProgramada"
                                    label="Hora Programada"
                                    readonly
                                  ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6">
                                  <v-text-field dense
                                    v-model="revision.tipoAtencion"
                                    label="Tipo de Atención"
                                    readonly
                                  ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6">
                                  <v-switch dense v-model="revision.clienteContactado" color="primary" :value="revision.clienteContactado"
                                                  :label="`Cliente Contactado: `+(revision.clienteContactado?'Si':'No')" dense
                                                  ></v-switch>
                                </v-col>
                              
                            
                            </v-row>
                        </v-container>
                    </v-card-text>

                    <v-divider></v-divider>

                    <v-card-actions>
                        <small>*Datos requeridos</small>
                        <v-spacer></v-spacer>
                        <v-btn color="primary" @click="dialog = false">Cancelar</v-btn>
                        <v-btn color="primary" :disabled="invalid" type="submit">
                            Programar y enviar a APP
                        </v-btn>
                    </v-card-actions>
                </v-form>
            </val-obse>
        </v-card>
    </v-dialog>
</template>


<script>
import { required, digits, email, max, regex } from 'vee-validate/dist/rules'
import { extend, ValidationObserver, ValidationProvider, setInteractionMode } from 'vee-validate'
setInteractionMode('eager')
extend('required', {
    ...required,
    message: '{_field_} no puede ser nulo',
})

extend('max', {
    ...max,
    message: '{_field_} no puede ser mayor a {length} caracteres',
})

export default {
    components: {
        'val-prov':ValidationProvider,
        'val-obse':ValidationObserver,
    },
    data () {
        return {
            valid: true,
            dialog: false,
            revision:{},
        }
    },
    created(){
        this.datosInciales()
    },
    methods:{
        datosInciales(){
            setTimeout(()=>{
                console.log("--###--", this.paramId)
                this.revision = this.datosRow
            },500)
        },
        async guardarRegistro(evt){
          this.$refs.observer.validate()
            evt.preventDefault()
            try {
                this.revision.mensaje = `Estimado usuario su solicitud fue Aprobada, presente sus documentos en dia ${this.revision.fechaProgramacion} a horas ${this.revision.horaProgramacion} en el multicentro de  ${this.revision.multicentro}`
                this.revision.clienteContactado =this.revision.clienteContactado?true:false;
                const q = {query: `mutation{
                                        fnAprobar(input:{pId:"${this.paramId}" pMensaje:"${this.revision.mensaje}" pClienteContactado:${this.revision.clienteContactado}}){
                                            string
                                        }
                                        }`};
                const lista = await this.$axios.$post(`/graphql`, q)
                this.$store.commit('alert/ok', "Se a Aprobado y enviado el mensaje")
                this.dialog = false;
                this.$router.push('/verificaDoc')
            } catch (error) {
                this.$store.commit('alert/error', error.message)
            }
        }
    },
    props:{
        paramId:{
            type:String,
            default:"..."
        },
        datosRow:{
            type:[],
            default:false
        },
    },
}
</script>