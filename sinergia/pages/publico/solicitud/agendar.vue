<template>
    <v-app class="pa-2 full">
        <v-card>
            <div class="pa-2 my-1 headline grey lighten-2  text-center">
                <h5>AGENDAR HORA</h5>
            </div>
            <val-obse ref="observer" v-slot="{ invalid }">
                <v-container>
                    <v-form @submit.prevent="guardarRegistro" ref="form" v-model="valid" lazy-validation dense>
                        <v-row dense>

                            <v-col cols="12" sm="6" md="6">
                                <val-prov v-slot="{ errors }" name="Almacen" rules="required">
                                    <v-select :items="listCiudad" label="Para que Ciudad requiere su Línea" v-model="agenda.ciudadId" @input="fnMulticentro()" item-text="nombre" item-value="id" :error-messages="errors" dense></v-select>
                                </val-prov>
                            </v-col>
                            <v-col cols="12" sm="6" md="6">
                                <val-prov v-slot="{ errors }" name="Almacen" rules="required">
                                    <v-select :items="listMulticentro" label="Multicenro mas cercano" v-model="agenda.multicentroId" item-text="nombre" item-value="id" :error-messages="errors" dense></v-select>
                                </val-prov>
                            </v-col>
                            <v-col cols="12" sm="4" md="3">
                                <val-prov v-slot="{ errors }" name="Almacen" rules="required">
                                    <v-menu v-model="fechaModal" :close-on-content-click="false" max-width="290px" min-width="auto">
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field v-model="fechaFormat" label="Fecha de Nacimiento" v-bind="attrs" v-on="on" prepend-icon="mdi-calendar" :error-messages="errors" dense></v-text-field>
                                        </template>
                                        <v-date-picker v-model="agenda.hora" @change="fechaModal = false" @input="fechaFormat = $moment(agenda.fechaNacimiento ).format('DD/MM/YYYY')" no-title :error-messages="errors" dense></v-date-picker>
                                    </v-menu>
                                </val-prov>
                            </v-col>

                            <v-col cols="12" sm="6" md="6">
                                <val-prov v-slot="{ errors }" name="Almacen" rules="required">
                                    <v-checkbox v-model="agenda.adultomayor" label="Tercera edad" :error-messages="errors" dense></v-checkbox>
                                </val-prov>
                            </v-col>
                            <v-col cols="12" sm="6" md="6">
                                <val-prov v-slot="{ errors }" name="Almacen" rules="required">
                                    <v-checkbox v-model="agenda.discapacitado" label="Persona con discapacidad" :error-messages="errors" dense></v-checkbox>
                                </val-prov>
                            </v-col>
                            <v-col cols="12" sm="6" md="6">
                                <val-prov v-slot="{ errors }" name="Almacen" rules="required">
                                    <v-checkbox v-model="agenda.embarazada" label="Persona embarazada" :error-messages="errors" dense></v-checkbox>
                                </val-prov>
                            </v-col>
                            <v-col cols="12" sm="12" md="6">
                                <val-prov v-slot="{ errors }" name="Almacen" rules="required">
                                    <v-textarea label="1° Numeros de celular" v-model="agenda.primerNumero" rows="1" readonly :error-messages="errors" dense></v-textarea>
                                </val-prov>
                            </v-col>
                            <v-col cols="12" sm="12" md="6">
                                <val-prov v-slot="{ errors }" name="Almacen" rules="required">
                                    <v-textarea label="2° Numeros de celular" v-model="agenda.segundoNumero" rows="1" readonly :error-messages="errors" dense></v-textarea>
                                </val-prov>
                            </v-col>
                        </v-row>
                        <v-divider></v-divider>
                        <div class="text-center pa-2">
                            <v-btn  :disabled="invalid" outlined type="submit" color="indigo">SERVICIOS</v-btn>
                        </div>
                    </v-form>
                </v-container>
            </val-obse>
        </v-card>
    </v-app>
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
    data: () => ({
        date: (new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString().substr(0, 10),
        menu2: false,
        agenda:{
            ciudadId:0
        },
        checkbox: true,
        valid: true,
        fechaModal:false,
        fechaFormat:'01/01/1990',
        disabled:false,
        accept:"*",
        file:'',
        telefonos:'',
        listCiudad:[],
        listMulticentro:[],
        rules: [
            value => !!value || 'Required.',
            value => (value && value.length >= 3) || 'Min 3 characters',
        ],
    }),
    auth: false,
    prefetchLinks: false,
    async created(){
        this.datosIniciales()
    },
    methods:{
        async onFileChange(e){
            if(e){
                let formData = new FormData()
                formData.append('miFile',  e)
                let config = {headers: {'content-type': 'multipart/form-data'}}
                const resultFile = await this.$axios({
                    method: 'post',
                    url: './upload',
                    data:  formData,
                    config: config
                });
                return resultFile.data.url;
            }
        },
        async datosIniciales(){
            const q = {query: `{
                            listDepartamento:allUbicacionGeograficas(condition:{nivel:3}){
                                nodes{id nombre abreviatura}
                            }
                        }`};
            const datos = await this.$axios.$post(`/graphql`, q)
            try {
                this.listCiudad = datos.data.listDepartamento.nodes;
            } catch (error) {
                console.log('Error', error)
            }
        },
        async fnMulticentro(){
            const q = {query: `{listProvincia:allUbicacionGeograficas(condition:{nivel:4 dependienteId:"${this.agenda.ciudadId}"}){
                                nodes{id nombre abreviatura}
                                }}`};
            const datos = await this.$axios.$post(`/graphql`, q)
            try {
                this.listProvincia = datos.data.listProvincia.nodes;
            } catch (error) {
                console.log('Error', error)
            }
        },
        async guardarRegistro(evt){
            evt.preventDefault()
            console.log("######", JSON.stringify(this.simpleIlimitado,0,2))
            var mut ={query: `mutation{addSimpleIlimitado(input:
                {
                    fotoCi: "${this.simpleIlimitado.fotoCi}",
                    fotoFactura: "${this.simpleIlimitado.fotoFactura}",
                    fotoReferenciaFinanciera: "${this.simpleIlimitado.fotoReferenciaFinanciera}",
                    referenciaFinanciera: ${this.simpleIlimitado.referenciaFinanciera},
                    planId: "${this.simpleIlimitado.planId}",
                    telefonosPlanes: "${this.simpleIlimitado.telefonosPlanes}",
                    generoId: "${this.simpleIlimitado.generoId}",
                    estadoCivilId: "${this.simpleIlimitado.estadoCivilId}",
                    nombres: "${this.simpleIlimitado.nombres}",
                    apellidoPaterno: "${this.simpleIlimitado.apellidoPaterno}",
                    apellidoMaterno: "${this.simpleIlimitado.apellidoMaterno}",
                    apellidoMarital: "${this.simpleIlimitado.apellidoMarital}",
                    tipoDocumentoId: "${this.simpleIlimitado.tipoDocumentoId}",
                    nroDocumento: "${this.simpleIlimitado.nroDocumento}",
                    expedicionId: "${this.simpleIlimitado.expedicionId}",
                    fechaNacimiento: "${this.simpleIlimitado.fechaNacimiento}",
                    correo: "${this.simpleIlimitado.correo}",
                    departamentoPersomalId: "${this.simpleIlimitado.departamentoPersomalId}",
                    provinciaId: "${this.simpleIlimitado.provinciaId}",
                    zona: "${this.simpleIlimitado.zona}",
                    calleAvenida: "${this.simpleIlimitado.calleAvenida}",
                    tipoViviendaId: "${this.simpleIlimitado.tipoViviendaId}",
                    nroVivienda: "${this.simpleIlimitado.nroVivienda}",
                    referencias: "${this.simpleIlimitado.referencias}",
                    celularRef: "${this.simpleIlimitado.celularRef}",
                    telefonoRef: "${this.simpleIlimitado.telefonoRef}",
                    ciudadId: "${this.simpleIlimitado.ciudadId}",
                    provinciaNuevoId: "${this.simpleIlimitado.provinciaNuevoId}",
                    checkboxPospagoIlimitado: ${this.simpleIlimitado.checkboxPospagoIlimitado},
                    numeroPospago: "${this.simpleIlimitado.numeroPospago}"
                }){
                    string
                }
            }`};
            const datos = await this.$axios.$post(`/graphql`, mut)
            try {

                this.$store.commit('alert/ok', "Su solicitud ya fue registrada. Nuestro personal se contactara con usted")
                this.$router.push("/publico")
            } catch (error) {
                this.$store.commit('alert/error', error+""+datos.message)
            }
        }
    }
}
</script>