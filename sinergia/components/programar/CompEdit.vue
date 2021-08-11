<template>
    <v-dialog v-model="dialog" width="500">
        <template v-slot:activator="{ on, attrs }">
            <v-hover>
                <template v-slot:default="{ hover }">
                    <v-btn icon color="btedit" @click="verEdicion()" :elevation="hover ? 10 : 0" fab small v-bind="attrs" v-on="on">
                        <v-icon >mdi-book-edit-outline</v-icon>
                    </v-btn>
                </template>
            </v-hover>
        </template>

        <v-card>
            <v-card-title class="headline grey lighten-2">
                Agendar Hora
            </v-card-title>
            <val-obse ref="observer" v-slot="{ invalid }">
                <v-form @submit.prevent="editRegistro" ref="form" v-model="valid" lazy-validation>
                    <v-card-text>
                        <v-container>
                            <v-row>
                                <v-col cols="12" sm="6" md="6">
                                    <b>Nombre :</b>{{ agenda.nombres }} {{agenda.apellidoPaterno}} {{agenda.apellidoPaterno }}
                                </v-col>
                                <v-col cols="12" sm="6" md="12">
                                    <b>Hora Propuesta :</b>{{agenda.horaPropuesta}}
                                </v-col>
                                
                                <v-col cols="12" sm="6" md="6">
                                    <val-prov v-slot="{ errors }" name="Fecha Programada" rules="required">
                                        <v-menu v-model="fechaModal" :close-on-content-click="false" max-width="290px" min-width="auto">
                                            <template v-slot:activator="{ on, attrs }">
                                                <v-text-field v-model="fechaFormat" readonly required label="Fecha de Programada" v-bind="attrs" v-on="on" append-icon="mdi-calendar" :error-messages="errors" dense></v-text-field>
                                            </template>
                                            <v-date-picker v-model="agenda.fechaProgramada"  locale="bo-es" :min="minFecha" @change="fechaModal = false" @input="fechaFormat = $moment(agenda.fechaProgramada ).format('DD/MM/YYYY')" no-title  :error-messages="errors" dense></v-date-picker>
                                        </v-menu>
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="6" md="6">
                                    <val-prov v-slot="{ errors }" name="Hora programada" rules="required">
                                        <v-menu ref="menu" v-model="horaModal" offset-y :close-on-content-click="false">
                                            <template v-slot:activator="{ on, attrs }">
                                                <v-text-field v-model="agenda.horaProgramada" readonly required label="Hora Programada de atención" v-bind="attrs" v-on="on" append-icon="mdi-clock-time-four-outline" :error-messages="errors" dense></v-text-field>
                                            </template>
                                            <v-time-picker v-if="horaModal" v-model="agenda.horaProgramada"  locale="bo-es" min="08:00" max="19:00" @click:minute="$refs.menu.save(agenda.horaProgramada)" no-title></v-time-picker>
                                        </v-menu>
                                    </val-prov>
                                </v-col>
                            </v-row>
                        </v-container>
                        
                    </v-card-text>

                    <v-divider></v-divider>

                    <v-card-actions>
                        <small>*Datos requeridos</small>
                        <v-spacer></v-spacer>
                        <v-btn color="primary" @click="dialog = false">Cancelar</v-btn>
                        <v-btn color="primary" type="submit" :disabled="invalid">
                            Guardar
                        </v-btn>
                    </v-card-actions>
                </v-form>
             </val-obse>
        </v-card>
    </v-dialog>
</template>


<script>
import { required, max } from 'vee-validate/dist/rules'
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
            invalid:false,
            fechaFormat: this.$moment().format("DD/MM/YYYY"),
            valid: true,
            dialog: false,
            agenda:{
                fechaProgramada:this.$moment().format("YYYY-MM-DD")
            },
            minFecha: this.$moment().format("YYYY-MM-DD")
        }
    },
    methods:{
        async verEdicion(){
            try {
                const q = {query: `{allVwSimpleIlimitados(condition:{id:"${this.paramId}"}) {
                                    nodes {
                                        id
                                        correo
                                        nombres
                                        primerNumero
                                        segundoNumero
                                        apellidoMarital
                                        apellidoMaterno
                                        calleAvenida
                                        nroDocumento
                                        multicentroId
                                        ciudadAtencionId
                                        horaPropuesta
                                    }}}`};
                const lista = await this.$axios.$post(`/graphql`, q)
                this.agenda = lista.data.allVwSimpleIlimitados.nodes[0]
                
            } catch (error) {
                this.$store.commit('alert/error', error.message)
            }
        },
        async editRegistro(evt){
            this.$refs.observer.validate()
            evt.preventDefault()
            try {
                if(this.agenda.horaProgramada && this.agenda.fechaProgramada){
                    const q = {query: `mutation{
                                            fnProgramar(input:{pId:"${this.paramId}" pHoraProgramada:"${this.agenda.horaProgramada}" pFechaProgramada:"${this.agenda.fechaProgramada}"}){
                                                string
                                            }
                                            }`};
                    const lista = await this.$axios.$post(`/graphql`, q)
                    const ql = {query: `{allVwSimpleIlimitados(condition:{estadoSolicitado:"S"}) {
                                    nodes {
                                        id
                                        correo
                                        nombres
                                        primerNumero
                                        segundoNumero
                                        apellidoMarital
                                        apellidoMaterno
                                        apellidoPaterno
                                        calleAvenida
                                        nroDocumento
                                        multicentro
                                        ciudadAtencion
                                        horaPropuesta
                                    }}}`};
                    this.$store.commit('reformarLista/lista', ql)
                    this.$store.commit('alert/ok', "Se a registrado la programacion")
                    this.dialog = false;
                    this.$router.push('/asignarHora')
                }else{
                    this.$store.commit('alert/error', "Fecha y hora son obligatorios")
                }
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
        title:{
            type:String,
            default:''
        },
        anular:{
            type:Boolean,
            default:false
        }
    }
}
</script>
