<template>
    <v-list class="pa-2 full">
        <val-obse ref="observer" v-slot="{ invalid }">
            <v-form @submit.prevent="guardarRegistro" ref="form" v-model="valid" lazy-validation dense>
                <v-list-group dense title="titulo 11" link :value="op1" class="mx-0 px-0 m-0 p-0 grey lighten-2">
                    <template v-slot:activator>
                        <v-list-item-title class="text-center">
                            <h3>Simple Ilimitado Elección de Planes y Datos Personales</h3>
                        </v-list-item-title>
                    </template>
                    <v-list-item dense class="white">
                        <v-container>
                            <v-row dense>
                                <v-col cols="5" sm="5" md="3">
                                    <val-prov v-slot="{ errors }" name="Almacen" rules="required">
                                        <v-select :items="listPlan" v-model="simpleIlimitado.planId" 
                                        item-text="descripcion" item-value="id" @change="inputPlanes"
                                        label="Elige tu Plan" :error-messages="errors" dense></v-select>
                                    </val-prov>
                                </v-col>
                                <v-col cols="7" sm="7" md="3">
                                    <val-prov v-slot="{ errors }" name="Números favoritos" :rules="{ digits: 8, regex: '^(7|6)\\d{7}$'}">
                                        <v-text-field label="Número favorito" maxlength="8" v-model="telefonos" dense
                                        append-icon="mdi-phone-plus" :error-messages="errors"
                                        @click:append="addTelefonosPlan"
                                        ></v-text-field>
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="12" md="6">
                                    <val-prov v-slot="{ errors }" name="Nro. Favorito" rules="">
                                        <v-textarea label="Número favoritos" v-model="simpleIlimitado.telefonosPlanes" rows="1" 
                                        @click:append="deleteTelefonosPlan" append-icon="mdi-phone-minus"
                                        readonly :error-messages="errors" dense></v-textarea>
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="6" md="3">
                                    <val-prov v-slot="{ errors }" name="Genero" rules="required">
                                        <v-select :items="listGenero" v-model="simpleIlimitado.generoId" item-text="descripcion" item-value="id" :error-messages="errors" dense label="Género"></v-select>
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="6" md="3">
                                    <val-prov v-slot="{ errors }" name="Estado Civil" rules="required">
                                        <v-select :items="listEstadoCivil" v-model="simpleIlimitado.estadoCivilId" item-text="descripcion" item-value="id" :error-messages="errors" dense label="Estado Civil"></v-select>
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="12" md="6">
                                    <val-prov v-slot="{ errors }" name="Nombre" rules="required">
                                        <v-text-field label="Nombre (s)" v-model="simpleIlimitado.nombres" :error-messages="errors" dense></v-text-field>
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="12" md="6">
                                    <val-prov v-slot="{ errors }" name="Apellido paterno" rules="required">
                                        <v-text-field label="Apellido Paterno" v-model="simpleIlimitado.apellidoPaterno" :error-messages="errors" required dense></v-text-field>
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="12" md="6">
                                    <val-prov v-slot="{ errors }" name="Apellido Materno" rules="">
                                        <v-text-field label="Apellido Materno" v-model="simpleIlimitado.apellidoMaterno" :error-messages="errors" dense></v-text-field>
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="12" md="6" v-if="simpleIlimitado.generoId == 3">
                                    <val-prov v-slot="{ errors }" name="Apellido Marital" rules="">
                                        <v-text-field label="Apellido Marital" v-model="simpleIlimitado.apellidoMarital" :error-messages="errors" dense></v-text-field>
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="6" md="3">
                                    <val-prov v-slot="{ errors }" name="Almacen" rules="required">
                                        <v-select :items="listTipoDocumento" v-model="simpleIlimitado.tipoDocumentoId" item-text="descripcion" item-value="id" label="Tipo de Documento" :error-messages="errors" dense></v-select>        
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="6" md="3">
                                    <val-prov v-slot="{ errors }" name="Almacen" rules="required">
                                        <v-text-field label="Número de Documento" v-model="simpleIlimitado.nroDocumento" :error-messages="errors" dense></v-text-field>
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="4" md="3">
                                    <val-prov v-slot="{ errors }" name="Almacen" rules="required">
                                        <v-select :items="listExpedido" v-model="simpleIlimitado.expedicionId" item-text="nombre" item-value="id" label="Lugar de Expedición" :error-messages="errors" dense></v-select>
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="4" md="3">
                                    <val-prov v-slot="{ errors }" name="Almacen" rules="required">
                                        <v-menu v-model="fechaModal" :close-on-content-click="false" max-width="290px" min-width="auto">
                                            <template v-slot:activator="{ on, attrs }">
                                                <v-text-field v-model="fechaFormat" label="Fecha de Nacimiento" readonly v-bind="attrs" v-on="on" prepend-icon="mdi-calendar" :error-messages="errors" dense></v-text-field>
                                            </template>
                                            <v-date-picker v-model="simpleIlimitado.fechaNacimiento" 
                                                :max="fecNacimientoMax" 
                                                @change="fechaModal = false"
                                                locale="bo-es"
                                                @input="fechaFormat = $moment(simpleIlimitado.fechaNacimiento ).format('DD/MM/YYYY')" 
                                                no-title :error-messages="errors" dense></v-date-picker>
                                        </v-menu>
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="4" md="3">
                                    <val-prov v-slot="{ errors }" name="Correo" rules="required|email">
                                        <v-text-field v-model="simpleIlimitado.correo" label="Correo Electrónico" :error-messages="errors" dense></v-text-field>
                                    </val-prov>
                                </v-col>
                            </v-row>
                            <div class="pa-2 mb-4 headline grey lighten-2  text-center">
                                <h6>Dirección</h6>
                            </div>
                            <v-row dense>
                                <v-col cols="6" sm="4" md="3">
                                    <val-prov v-slot="{ errors }" name="Departamento" rules="required">
                                        <v-select :items="listDepartamento" label="Departamento - Ciudad" v-model="simpleIlimitado.departamentoPersomalId" @input="fnProvincia()" item-text="nombre" item-value="id" :error-messages="errors" dense></v-select>
                                    </val-prov>
                                </v-col>
                                <v-col cols="6" sm="4" md="3">
                                    <val-prov v-slot="{ errors }" name="Provincia" rules="required">
                                        <v-select :items="listProvincia" label="Provincia" v-model="simpleIlimitado.provinciaId" item-text="nombre" item-value="id" :error-messages="errors" dense></v-select>
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="4" md="3">
                                    <val-prov v-slot="{ errors }" name="Zona o Barrio" rules="required">
                                        <v-text-field v-model="simpleIlimitado.zona" label="Zona / Barrio" :error-messages="errors" dense></v-text-field>
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="4" md="3">
                                    <val-prov v-slot="{ errors }" name="Calle o Avenida" rules="required">
                                        <v-text-field v-model="simpleIlimitado.calleAvenida" label="Calle o Avenida"  :error-messages="errors" dense></v-text-field>
                                    </val-prov>
                                </v-col>
                                <v-col cols="6" sm="4" md="3">
                                    <val-prov v-slot="{ errors }" name="Tipo de Vivienda" rules="required">
                                        <v-select :items="listTipoVivienda" label="Tipo de Vivienda" v-model="simpleIlimitado.tipoViviendaId" item-text="descripcion" item-value="id" :error-messages="errors" dense></v-select>
                                    </val-prov>
                                </v-col>
                                <v-col cols="6" sm="4" md="3">
                                    <val-prov v-slot="{ errors }" name="Numero de Vivienda" rules="required">
                                        <v-text-field v-model="simpleIlimitado.nroVivienda" label="Número de Vivienda"  :error-messages="errors" dense></v-text-field>    
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="4" md="3">
                                    <val-prov v-slot="{ errors }" name="Referencia " rules="required">
                                        <v-text-field v-model="simpleIlimitado.referencias" label="Referencias de la Dirección" :error-messages="errors" dense></v-text-field>    
                                    </val-prov>
                                </v-col>
                                <v-col cols="6" sm="6" md="3">
                                    <val-prov v-slot="{ errors }" name="Nro. referencia" :rules="{required: true, digits: 8, regex: '^(7|6)\\d{7}$'}">
                                        <v-text-field label="Numero de Celular de referencia" v-model="simpleIlimitado.celularRef" maxlength="8" :error-messages="errors" dense></v-text-field>
                                    </val-prov>
                                </v-col>
                                <v-col cols="6" sm="6" md="3">
                                    <val-prov v-slot="{ errors }" name="Nro. telefono ref." :rules="{digits: 8, regex: '^(2|3|4)\\d{7}$'}">
                                        <v-text-field label="Numero de Teléfono de referencia" v-model="simpleIlimitado.telefonoRef" maxlength="8" :error-messages="errors" dense></v-text-field>
                                    </val-prov>
                                </v-col>
                            </v-row>

                            <div class="pa-2 mb-4 headline grey lighten-2  text-center">
                                <h6>Elección de nuevo número o migración a Pospago</h6>
                            </div>
                            <v-row dense>
                                <v-col cols="12" sm="6" md="6">
                                    <val-prov v-slot="{ errors }" name="Ciudad" rules="required">
                                        <v-select :items="listCiudad" label="Para que Ciudad requiere su Línea" v-model="simpleIlimitado.ciudadId" @input="fnProvinciaNuevo()" item-text="nombre" item-value="id" :error-messages="errors" dense></v-select>
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="6" md="6">
                                    <val-prov v-slot="{ errors }" name="Provincia" rules="required">
                                        <v-select :items="listProvinciaNuevo" label="Provincia" v-model="simpleIlimitado.provinciaNuevoId" item-text="nombre" item-value="id" :error-messages="errors" dense></v-select>
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="6" md="6">
                                    <val-prov v-slot="{ errors }" name="Linea ENTEL" rules="">
                                        <v-checkbox v-model="simpleIlimitado.checkboxPospagoIlimitado" label="¿Tiene una línea Entel que pasará a pospago Simple Ilimitado?" :error-messages="errors" dense></v-checkbox>
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="6" md="6" v-if="simpleIlimitado.checkboxPospagoIlimitado">
                                    <val-prov v-slot="{ errors }" name="Nro. pospago" :rules="{required: true, digits: 7, regex: '^(71|72|74|76|81|82|84|85|86|87|88|89)\\d{5}$'}">
                                        <v-text-field label="Numero de Celular que pasa a Pospago" v-model="simpleIlimitado.numeroPospago" :error-messages="errors" dense></v-text-field>
                                    </val-prov>
                                </v-col>
                            </v-row>
                            <div class="pa-2 mb-4 headline grey lighten-2  text-center">
                                <h6>Envío de Documentos</h6>
                            </div>
                            <v-row dense>
                                <v-col cols="12" sm="6" md="4">
                                    <v-file-input dense
                                        @change="onFileCi"
                                        accept="image/png, image/jpeg, image/bmp"
                                        placeholder="Foto de documento de identificacion"
                                        prepend-icon="mdi-camera"
                                        label="Foto de su documento de identidad"
                                    ></v-file-input>
                                    <val-prov v-slot="{ errors }" name="Almacen" rules="required">
                                        <input type="hidden" v-model="simpleIlimitado.fotoCi" :error-messages="errors"/> 
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-file-input dense
                                        @change="onFileCi2"
                                        accept="image/png, image/jpeg, image/bmp"
                                        placeholder="Reverso Foto de documento de identificacion"
                                        prepend-icon="mdi-camera"
                                        label="Reverso de su documento de identidad"
                                    ></v-file-input>
                                    <val-prov v-slot="{ errors }" name="Almacen" rules="required">
                                        <input type="hidden" v-model="simpleIlimitado.fotoCi2" :error-messages="errors"/> 
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="6" md="4">
                                    <v-file-input dense
                                        @change="onFileFactura"
                                        accept="image/png, image/jpeg, image/bmp"
                                        placeholder="Foto de Factura se servicio básico"
                                        prepend-icon="mdi-camera"
                                        label="Foto de Factura se servicio básico"
                                    ></v-file-input>
                                    <val-prov v-slot="{ errors }" name="Almacen" rules="required">
                                        <input type="hidden" v-model="simpleIlimitado.fotoFactura" :error-messages="errors"/>
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="12" md="4" v-if="simpleIlimitado.referenciaFinanciera">
                                    <v-row dense>
                                        <v-checkbox v-model="simpleIlimitado.referenciaFinanciera" @input="simpleIlimitado.referenciaFinanciera" dense></v-checkbox>
                                        <v-file-input dense
                                            @change="onFileRefFinanciero"
                                            accept="image/png, image/jpeg, image/bmp"
                                            placeholder="Foto de su referencia financiera"
                                            prepend-icon="mdi-camera"
                                            label="Foto de su referencia financiera"
                                        ></v-file-input>
                                        <val-prov v-slot="{ errors }" name="Almacen" rules="required">
                                            <input type="hidden" v-model="simpleIlimitado.fotoReferenciaFinanciera" :error-messages="errors"/>
                                        </val-prov>
                                    </v-row>
                                </v-col>
                            </v-row>
                            <v-divider></v-divider>
                            <div class="text-center pa-2">
                                <v-btn :disabled="invalid" outlined type="button" color="indigo" @click="fnSiguiente">Siguiente</v-btn>
                            </div>
                        </v-container>
                    </v-list-item>
                </v-list-group>
                <v-list-group dense title="titulo 11" link :value="op2" class="mx-0 px-0 m-0 p-0 grey lighten-2">
                    <template v-slot:activator>
                        <v-list-item-title class="text-center">
                            <h3>AGENDAR HORA</h3>
                        </v-list-item-title>
                    </template>
                    <v-list-item dense class="white">
                        <v-container>
                            <v-row dense>
                                <v-col cols="12" sm="6" md="6">
                                    <val-prov v-slot="{ errors }" name="Almacen" rules="required">
                                        <v-select :items="listCiudad" label="¿En qué ciudad firmará en contrato?" v-model="simpleIlimitado.ciudadAtencionId" @input="fnMulticentro()" item-text="nombre" item-value="id" :error-messages="errors" dense></v-select>
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="6" md="6">
                                    <val-prov v-slot="{ errors }" name="Almacen" rules="required">
                                        <v-select :items="listMulticentro" label="Multicenro mas cercano" v-model="simpleIlimitado.multicentroId" item-text="direccion" item-value="id" :error-messages="errors" dense></v-select>
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="4" md="3">
                                    <val-prov v-slot="{ errors }" name="Hora" rules="required">
                                        <v-menu ref="menu" v-model="horaModal" offset-y :close-on-content-click="false">
                                            <template v-slot:activator="{ on, attrs }">
                                                <v-text-field v-model="simpleIlimitado.horaPropuesta" readonly locale="bo-es" label="Hora Propuesta de atencion" v-bind="attrs" v-on="on" append-icon="mdi-clock-time-four-outline" :error-messages="errors" dense></v-text-field>
                                            </template>
                                            <v-time-picker v-if="horaModal" v-model="simpleIlimitado.horaPropuesta" min="08:00" max="19:00" @click:minute="$refs.menu.save(simpleIlimitado.horaPropuesta)" no-title></v-time-picker>
                                        </v-menu>
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="4" md="4">
                                    <val-prov v-slot="{ errors }" name="1° numero" :rules="{required: true, digits: 8, regex: '^(7|6)\\d{7}$'}">
                                        <v-text-field label="1° Numeros de celular" v-model="simpleIlimitado.primerNumero"  :error-messages="errors" maxlength="8" dense></v-text-field>
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="4" md="4">
                                    <val-prov v-slot="{ errors }" name="2° numero" :rules="{digits: 8, regex: '^(7|6)\\d{7}$'}">
                                        <v-text-field label="2° Numeros de celular" v-model="simpleIlimitado.segundoNumero" :error-messages="errors" maxlength="8" dense></v-text-field>
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="4" md="4">
                                    <val-prov v-slot="{ errors }" name="Almacen" rules="required">
                                        <v-radio-group label="Tipo Atencion Preferencial" v-model="simpleIlimitado.tipoAtencionId">
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
                                <v-btn  :disabled="invalid" outlined type="submit" color="indigo">Guardar</v-btn>
                            </div>
                        </v-container>
                    </v-list-item>
                </v-list-group>
            </v-form>
        </val-obse>
    </v-list>
</template>
<script>
import { required, max, email, digits, regex } from 'vee-validate/dist/rules'
import { extend, ValidationObserver, ValidationProvider, setInteractionMode } from 'vee-validate'
setInteractionMode('eager')
extend('required', {
    ...required,
    message: '{_field_} no puede ser nulo',
})
extend('digits', {
    ...digits,
    message: '{_field_} nro. no validos',
})
extend('regex', {
    ...regex,
    message: '{_field_} no valido',
})

extend('max', {
    ...max,
    message: '{_field_} no puede ser mayor a {length} caracteres',
})

extend('email', {
    ...email,
    message: '{_field_} No es un correo valido',
})

export default {
    components: {
        'val-prov':ValidationProvider,
        'val-obse':ValidationObserver,
    },
    data () {
        return {
            date: (new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString().substr(0, 10),
            menu2: false,
            op1:true,
            op2:false,
            simpleIlimitado:{
                fotoCi:"",
                fotoCi2:"",
                fotoFactura:"",
                fotoReferenciaFinanciera:"",
                referenciaFinanciera:false,
                fechaNacimiento: this.$moment().add(-18, 'y').format("YYYY-MM-DD")
            },
            checkbox: true,
            valid: true,
            fechaModal:false,
            horaModal:false,
            fechaFormat: this.$moment().add(-18, 'y').format("DD/MM/YYYY"),
            disabled:false,
            accept:"*",
            file:'',
            telefonos:'',
            listPlan:[],
            nroInputPlan:'',
            listGenero:[],
            listEstadoCivil:[],
            listTipoDocumento:[],
            listExpedido:[],
            listDepartamento:[],
            listCiudad:[],
            listProvincia:[],
            listProvinciaNuevo:[],
            listTipoVivienda:[],
            listMulticentro:[],
            listTipoAtencion:[],
            fecNacimientoMax : this.$moment().add(-18, 'y').format("YYYY-MM-DD"),
            rules: [
                value => !!value || 'Required.',
                value => (value && value.length >= 3) || 'Min 3 characters',
            ],
        }
    },
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
        async fnSiguiente(evt){
            evt.preventDefault()
            console.log(this.simpleIlimitado)
            this.op1=false;
            this.op2=true;
        },
        async onFileCi(e){
            const fileUpload = await this.onFileChange(e)
            this.simpleIlimitado.fotoCi = fileUpload;
        },
        async onFileCi2(e){
            const fileUpload = await this.onFileChange(e)
            this.simpleIlimitado.fotoCi2 = fileUpload;
        },
        async onFileFactura(e){
            const fileUpload = await this.onFileChange(e)
            this.simpleIlimitado.fotoFactura = fileUpload
        },
        async onFileRefFinanciero(e){
            const fileUpload = await this.onFileChange(e)
            this.simpleIlimitado.fotoReferenciaFinanciera = fileUpload
        },
        async datosIniciales(){
            const q = {query: `{listEstadoCivil:fnTblTipos(_codigo:"EST-CIVIL"){
                                nodes{id valor descripcion}
                            }
                            listPlan:fnTblTipos(_codigo:"PLAN-SIM-ILI"){
                                nodes{id valor descripcion}
                            }
                            listGenero:fnTblTipos(_codigo:"GENERO"){
                                nodes{id valor descripcion}
                            }
                            listTipoDoc:fnTblTipos(_codigo:"TP-DOC-ID"){
                                nodes{id valor descripcion}
                            }
                            listTipoVivi:fnTblTipos(_codigo:"TP-VIVIENDA"){
                                nodes{id valor descripcion}
                            }
                            listDepartamento:allUbicacionGeograficas(condition:{nivel:3}){
                                nodes{id nombre abreviatura}
                            }
                            listTipoAtencion:fnTblTipos(_codigo:"TP-ATN-SOC"){
                                nodes{id valor descripcion}
                            }
                        }`};
            const datos = await this.$axios.$post(`/graphql`, q)
            try {
                this.listPlan = datos.data.listPlan.nodes;
                this.listGenero = datos.data.listGenero.nodes;
                this.listEstadoCivil = datos.data.listEstadoCivil.nodes;
                this.listTipoDocumento = datos.data.listTipoDoc.nodes;
                this.listExpedido = datos.data.listDepartamento.nodes;
                this.listDepartamento = datos.data.listDepartamento.nodes;
                this.listCiudad = datos.data.listDepartamento.nodes;
                //this.listProvincia = datos.data..nodes;
                this.listTipoVivienda = datos.data.listTipoVivi.nodes;
                this.listTipoAtencion = datos.data.listTipoAtencion.nodes;
            } catch (error) {
                console.log('Error', error)
            }
        },
        async fnMulticentro(){
            const q = {query: `{listaMulticentro:fnPMulticentro(ciudadId:"${this.simpleIlimitado.ciudadAtencionId}"){nodes{id direccion}}}`};
            const datos = await this.$axios.$post(`/graphql`, q)
            try {
                this.listMulticentro = datos.data.listaMulticentro.nodes;
            } catch (error) {
                console.log('Error', error)
            }
        },
        async fnProvincia(){
            const q = {query: `{listProvincia:allUbicacionGeograficas(condition:{nivel:4 dependienteId:"${this.simpleIlimitado.departamentoPersomalId}"}){
                                nodes{id nombre abreviatura}
                                }}`};
            const datos = await this.$axios.$post(`/graphql`, q)
            try {
                this.listProvincia = datos.data.listProvincia.nodes;
            } catch (error) {
                console.log('Error', error)
            }
        },
        async fnProvinciaNuevo(){
            const q = {query: `{listProvincia:allUbicacionGeograficas(condition:{nivel:4 dependienteId:"${this.simpleIlimitado.ciudadId}"}){
                                nodes{id nombre abreviatura}
                                }}`};
            const datos = await this.$axios.$post(`/graphql`, q)
            try {
                this.listProvinciaNuevo = datos.data.listProvincia.nodes;
            } catch (error) {
                console.log('Error', error)
            }
        },
        async inputPlanes(){
            const q = {query: `{tblTipoById(id:"${this.simpleIlimitado.planId}"){valor}}`};
            const datos = await this.$axios.$post(`/graphql`, q)
            try {
                this.nroInputPlan = datos.data.tblTipoById.valor;
                this.simpleIlimitado.telefonosPlanes = ""
                if(this.nroInputPlan > 4){
                    this.simpleIlimitado.referenciaFinanciera = true
                }else{
                    this.simpleIlimitado.referenciaFinanciera = false
                }
            } catch (error) {
                console.log('Error', error)
            }
        },
        async addTelefonosPlan(){
            if(this.telefonos.length == 8 && this.telefonos >= 60000000 && this.telefonos <80000000){
                var conComas = [];
                if(this.simpleIlimitado.telefonosPlanes != undefined){
                    conComas = this.simpleIlimitado.telefonosPlanes.toString().split(", ");
                }
                if((this.nroInputPlan) >= conComas.length){
                    conComas.push(this.telefonos);
                    this.simpleIlimitado.telefonosPlanes = conComas.join(", ");
                    this.telefonos = "";
                }else{
                    this.$store.commit('alert/error', `Solo es permitido ${this.nroInputPlan} números`)
                }
            }else{
                this.$store.commit('alert/error', "Número no valido")
            }
        },
        async deleteTelefonosPlan(){
            console.log("-----####--", this.simpleIlimitado.telefonosPlanes)
            this.simpleIlimitado.telefonosPlanes = "";
            console.log("-----####22--", this.simpleIlimitado.telefonosPlanes)
            return false;
        },
        isNull(val, defaul=""){
            if(val===null || val===undefined) val = defaul;
            return val;
        },
        async guardarRegistro(evt){
            evt.preventDefault()
            console.log("######", JSON.stringify(this.simpleIlimitado,0,2))
            var mut ={query: `mutation{addSimpleIlimitado(input:
                {
                    fotoCi: "${this.simpleIlimitado.fotoCi}",
                    fotoCi2: "${this.simpleIlimitado.fotoCi2}",
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
                    apellidoMarital: "${this.isNull(this.simpleIlimitado.apellidoMarital)}",
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
                    checkboxPospagoIlimitado: ${this.isNull(this.simpleIlimitado.checkboxPospagoIlimitado,false)},
                    numeroPospago: "${this.isNull(this.simpleIlimitado.numeroPospago)}",
                    ciudadAtencionId: "${this.simpleIlimitado.ciudadAtencionId}",
                    multicentroId: "${this.simpleIlimitado.multicentroId}",
                    horaPropuesta: "${this.simpleIlimitado.horaPropuesta}",
                    primerNumero: "${this.simpleIlimitado.primerNumero}",
                    segundoNumero: "${this.isNull(this.simpleIlimitado.segundoNumero)}",
                    tipoAtencionId: "${this.simpleIlimitado.tipoAtencionId}"
                }){
                    string
                }
            }`};
            const datos = await this.$axios.$post(`/graphql`, mut)
            try {
                if(datos.errors){
                    this.$store.commit('alert/error', datos.errors.message)
                }else{
                    this.$store.commit('alert/ok', `Su solicitud ya fue registrada. Nuestro personal se contactara mediante esta aplicacion, le sugerimos entre al sistema con su susuario: ${this.simpleIlimitado.correo} y contraseña temporal: ${this.simpleIlimitado.nroDocumento}`)
                    this.$router.push("/")
                }
            } catch (error) {
                this.$store.commit('alert/error', error+""+datos.message)
            }
        }
    }
}
</script>