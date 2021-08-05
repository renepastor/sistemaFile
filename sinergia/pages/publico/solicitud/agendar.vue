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
                                    <v-select :items="listMulticentro" label="Multicenro mas cercano" v-model="agenda.multicentroId" item-text="direccion" item-value="id" :error-messages="errors" dense></v-select>
                                </val-prov>
                            </v-col>
                            <v-col cols="12" sm="4" md="3">
                                <val-prov v-slot="{ errors }" name="Almacen" rules="required">
                                    <v-menu ref="menu" v-model="fechaModal" offset-y :close-on-content-click="false">
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-text-field v-model="agenda.hora" label="Fecha de Nacimiento" v-bind="attrs" v-on="on" append-icon="mdi-clock-time-four-outline" :error-messages="errors" dense></v-text-field>
                                        </template>
                                        <v-time-picker v-if="fechaModal" v-model="agenda.hora" full-width  @click:minute="$refs.menu.save(time)" no-title></v-time-picker>
                                    </v-menu>
                                </val-prov>
                            </v-col>
                            <v-col cols="12" sm="4" md="4">
                                <val-prov v-slot="{ errors }" name="Almacen" rules="required">
                                    <v-text-field label="1° Numeros de celular" v-model="agenda.primerNumero" rows="1" :error-messages="errors" maxlength="8" dense></v-text-field>
                                </val-prov>
                            </v-col>
                            <v-col cols="12" sm="4" md="4">
                                <val-prov v-slot="{ errors }" name="Almacen" rules="required">
                                    <v-text-field label="2° Numeros de celular" v-model="agenda.segundoNumero" rows="1" :error-messages="errors" maxlength="8" dense></v-text-field>
                                </val-prov>
                            </v-col>
                            <v-col cols="12" sm="4" md="4">
                                <val-prov v-slot="{ errors }" name="Almacen" rules="required">
                                    <v-radio-group label="Tipo Atencion Preferencial" v-model="agenda.tipoAtencionId">
                                        <v-radio dense
                                            v-for="row in listTipoAtencion"
                                            :key="row.id"
                                            :label="`${row.descripcion}`"
                                            :value="row.id"
                                            :error-messages="errors"
                                        ></v-radio>
                                    </v-radio-group>
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
            ciudadId:0,
            hora:'00:00'
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
        listTipoAtencion:[],
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
                            listTipoAtencion:fnTblTipos(_codigo:"TP-ATN-SOC"){
                                nodes{id valor descripcion}
                            }
                        }`};
            const datos = await this.$axios.$post(`/graphql`, q)
            try {
                this.listCiudad = datos.data.listDepartamento.nodes;
                this.listTipoAtencion = datos.data.listTipoAtencion .nodes;
            } catch (error) {
                console.log('Error', error)
            }
        },
        async fnMulticentro(){
            const q = {query: `{listaMulticentro:fnPMulticentro(ciudadId:"${this.agenda.ciudadId}"){nodes{id direccion}}}`};
            const datos = await this.$axios.$post(`/graphql`, q)
            try {
                this.listMulticentro = datos.data.listaMulticentro.nodes;
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