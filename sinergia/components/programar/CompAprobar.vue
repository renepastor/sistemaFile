<template>
    <v-dialog v-model="dialog" persistent width="700">
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
            <v-card-title class="headline grey lighten-2" dense>Aprobar Solicitud</v-card-title>
            <val-obse ref="observer" v-slot="{ invalid }">
                <v-form @submit.prevent="guardarRegistro" ref="form" v-model="valid" lazy-validation>
                    <v-card-text>
                        <v-container>
                            <v-row no-gutters >
                                <v-col cols="12" sm="5">
                                  <v-text-field dense
                                    v-model="revision.ciudadAtencion"
                                    label="Ciudad Contrato"
                                    readonly
                                  ></v-text-field>
                                </v-col>
                                <v-col cols="1" sm="1" md="1"></v-col>
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
                                  <v-text-field dense
                                    v-model="revision.tipoAtencion"
                                    label="Tipo de Atención"
                                    readonly
                                  ></v-text-field>
                                </v-col>
                                <v-col cols="12" sm="6" md="6">
                                                <v-text-field v-model="fechaFormat" required readonly
                                                label="Fecha de Programada" append-icon="mdi-calendar"
                                                dense></v-text-field>
                                </v-col>
                                <v-col cols="1" sm="1" md="1"></v-col>
                                <v-col cols="12" sm="6" md="5">
                                                <v-text-field v-model="revision.horaProgramada" readonly
                                                required label="Hora Programada de atención"
                                                append-icon="mdi-clock-time-four-outline" dense></v-text-field>
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
                            Aprobar y enviar a APP
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
            fechaModal:false,
            horaModal:false,
            valid: true,
            dialog: false,
            revision:{
              fechaProgramada:''
            },
            fechaFormat: '',
            minFecha: this.$moment().format("YYYY-MM-DD")
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
                this.fechaFormat = this.$moment(this.revision.fechaProgramada).format("DD/MM/YYYY") 
            },500)
        },
        async guardarRegistro(evt){
            this.$refs.observer.validate()
            evt.preventDefault()
            if(this.revision.fechaProgramada != "" && this.revision.horaProgramada != ""){
            console.log("######", this.revision.fechaProgramada, this.revision.horaProgramada, this.revision)
            try {
                this.revision.mensaje = `Estimado usuario su solicitud fue Programado, presente sus documentos el dia ${this.revision.fechaProgramada} a horas ${this.revision.horaProgramada} en el multicentro ${this.revision.multicentro}, ${this.revision.multicentroDireccion}`
                this.revision.clienteContactado =this.revision.clienteContactado?true:false;
                const q = {query: `mutation{
                                        fnAprobar(input:{pId:"${this.paramId}" pMensaje:"${this.revision.mensaje}" pClienteContactado:${this.revision.clienteContactado}
                                        pFechaProgramada:"${this.revision.fechaProgramada}"  pHoraProgramada:"${this.revision.horaProgramada}"
                                        }){
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
            }else{
                this.$store.commit('alert/error', "La Fecha y Hora de programación son obligarorios")
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