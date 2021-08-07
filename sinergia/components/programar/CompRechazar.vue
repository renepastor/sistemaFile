<template>
    <v-dialog v-model="dialog" persistent width="500">
        <template v-slot:activator="{ on, attrs }">
            <v-hover>
                <template v-slot:default="{ hover }">
                    <v-btn outlined color="btnew" :elevation="hover ? 10 : 0" v-bind="attrs" v-on="on">
                        Rechazar
                    </v-btn>
                </template>
            </v-hover>
        </template>
        <v-card>
            <v-card-title class="headline grey lighten-2">Rechazar Solicitud</v-card-title>
            <val-obse ref="observer" v-slot="{ invalid }">
                <v-form @submit.prevent="guardarRegistro" ref="form" v-model="valid" lazy-validation>
                    <v-card-text>
                        <v-container>

                        <v-row no-gutters>
                            <v-col cols="12" sm="12">
                                <v-textarea dense
                                label="Introduzca los motivos del Rechazo"
                                v-model="revision.mensaje"
                                rows="3"
                                ></v-textarea>
                            </v-col>
                            <v-col cols="12" sm="12">
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
                            Rechazar y enviar a APP
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
            revision:{}
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
                const q = {query: `mutation{
                                        fnRechazar(input:{pId:"${this.paramId}" pMensaje:"${this.revision.mensaje}" pClienteContactado:${this.revision.clienteContactado}}){
                                            string
                                        }
                                        }`};
                const lista = await this.$axios.$post(`/graphql`, q)
                this.$store.commit('alert/ok', "Se a Rechazado y enviado el mensaje")
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
            default:[]
        },
    },
}
</script>