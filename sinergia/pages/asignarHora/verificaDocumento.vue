    <template>
        <v-card>
            <v-toolbar color="purple" dark dense >
            <template >
                <v-tabs v-model="tabs" dense>
                    <v-tab>Datos Personales</v-tab>
                    <v-tab>Plan Suscrito</v-tab>
                    <v-tab>CI</v-tab>
                    <v-tab>Facturas Bs</v-tab>
                    <v-tab>Ubicación</v-tab>
                    <v-tab>Referencia Financiera</v-tab>
                </v-tabs>
            </template>
            </v-toolbar>

            <v-tabs-items v-model="tabs">

            <v-tab-item>
                <v-card flat>
                    <v-card-title class="text-h5">Revisión de Datos Personales</v-card-title>
                    <v-card-text>
                        <v-row>
                        <v-col cols="12" sm="6" md="6">
                            <v-text-field dense
                              v-model="revision.genero"
                              label="Género"
                              readonly
                            ></v-text-field>
                        </v-col>
                        <v-col cols="12" sm="6" md="6">
                            <v-text-field dense
                              v-model="revision.estadoCivil"
                              label="Estado Civil"
                              readonly
                            ></v-text-field>
                        </v-col>
                        <v-col cols="12" sm="6" md="6">
                            <v-text-field dense
                              v-model="revision.nombres"
                              label="Nombre (s)"
                              readonly
                            ></v-text-field>
                        </v-col>
                        <v-col cols="12" sm="6" md="6">
                            <v-text-field dense
                              v-model="revision.apellidoPaterno"
                              label="Apellido Paterno"
                              readonly
                            ></v-text-field>
                        </v-col>
                        <v-col cols="12" sm="6" md="6">
                          <v-text-field dense
                            v-model="revision.apellidoMaterno"
                            label="Apellido Materno"
                            readonly
                          ></v-text-field>
                        </v-col>
                        <v-col cols="12" sm="6" md="6">
                          <v-text-field dense
                            v-model="revision.apellidoMarital"
                            label="ApellidoMarital"
                            readonly
                          ></v-text-field>
                        </v-col>
                        <v-col cols="12" sm="6" md="6">
                          <v-text-field dense
                            v-model="revision.tipoDocumentoId"
                            label="Tipo de Documento"
                            readonly
                          ></v-text-field>
                        </v-col>
                        <v-col cols="12" sm="6" md="6">
                          <v-text-field dense
                            v-model="revision.nroDocumento"
                            label="Número de Documento"
                            readonly
                          ></v-text-field>
                        </v-col>
                        <v-col cols="12" sm="6" md="6">
                          <v-text-field dense
                            v-model="revision.expedicion"
                            label="Lugar de Expedición"
                            readonly
                          ></v-text-field>
                        </v-col>
                        <v-col cols="12" sm="6" md="6">
                          <v-text-field dense
                            v-model="revision.fechaNacimiento"
                            label="Fecha de Nacimiento"
                            readonly
                          ></v-text-field>
                        </v-col>
                        <v-col cols="12" sm="6" md="6">
                          <v-text-field dense
                            v-model="revision.correo"
                            label="Correo Electrónico"
                            readonly
                          ></v-text-field>
                        </v-col>
                    </v-row>
                    </v-card-text>
                </v-card>
            </v-tab-item>

            <v-tab-item>
                <v-card flat>
                    <v-card-title class="text-h5">Plan Suscrito</v-card-title>
                    <v-card-text>
                        <v-row>
                            <v-col cols="12" sm="6" md="6">
                              <v-text-field dense
                                v-model="revision.plan"
                                label="Nombre del Plan"
                                readonly
                              ></v-text-field>
                            </v-col>
                            <v-col cols="12" sm="6" md="6">
                              <v-text-field dense
                                v-model="revision.numeroPospago"
                                label="Número de Instancia"
                                readonly
                              ></v-text-field>
                            </v-col>
                            <v-col cols="12" sm="6" md="6">
                              <v-text-field dense
                                v-model="revision.telefonosPlanes"
                                label="Números Favoritos"
                                readonly
                              ></v-text-field>
                            </v-col>
                            <v-col cols="12" sm="6" md="6">
                              <v-text-field dense
                                v-model="revision.creado"
                                label="Fecha de Solicitud"
                                readonly
                              ></v-text-field>
                            </v-col>
                        </v-row>
                    </v-card-text>
                </v-card>
            </v-tab-item>

            <v-tab-item>
                <v-carousel>
                    <v-carousel-item
                        :src="'../'+revision.fotoCi"
                        reverse-transition="fade-transition"
                        transition="fade-transition"
                    ></v-carousel-item>
                    <v-carousel-item
                        :src="'../'+revision.fotoCi2"
                        reverse-transition="fade-transition"
                        transition="fade-transition"
                    ></v-carousel-item>
                </v-carousel>
            </v-tab-item>
            <v-tab-item>
                <v-carousel v-model="model">
                    <v-carousel-item
                        :src="'../'+revision.fotoFactura" :lazy-src="'../'+revision.fotoFactura"
                        reverse-transition="fade-transition"
                        transition="fade-transition"
                    ></v-carousel-item>
                </v-carousel>
            </v-tab-item>
            <v-tab-item>
                <v-card flat>
                    <v-card-title class="text-h5">Ubicación del domicilio</v-card-title>
                    <v-card-text>
                        <v-carousel v-model="model" v-if="revision.coordenada">
                            <v-carousel-item v-for="(color, i) in colors" :key="color" >
                                <v-sheet :color="color" height="100%" tile>
                                    <v-row class="fill-height" align="center" justify="center">
                                        <div class="text-h2">
                                            <div class="text-h2">
                                                <v-img :src="'../'+revision.fotoFactura" :lazy-src="'../'+revision.fotoFactura" :aspect-ratio="16/9" width="50rem" class="grey lighten-2">
                                                    <template v-slot:placeholder>
                                                        <v-row class="fill-height ma-0" align="center" justify="center">
                                                          <v-progress-circular indeterminate color="grey lighten-5"></v-progress-circular>
                                                        </v-row>
                                                    </template>
                                                </v-img>
                                            </div>
                                        </div>
                                    </v-row>
                                </v-sheet>
                            </v-carousel-item>
                        </v-carousel>
                        <v-row v-esle>
                            <v-col cols="6" sm="4" md="3">
                                <v-text-field label="Departamento - Ciudad" v-model="revision.departamentoPersomal" dense></v-text-field>
                            </v-col>
                            <v-col cols="12" sm="4" md="3">
                                <v-text-field v-model="revision.zona" label="Zona / Barrio" dense></v-text-field>
                            </v-col>
                            <v-col cols="12" sm="4" md="3">
                                <v-text-field v-model="revision.calleAvenida" label="Calle o Avenida" dense></v-text-field>
                            </v-col>
                            <v-col cols="6" sm="4" md="3">
                                <v-text-field v-model="revision.nroVivienda" label="Número de Vivienda" dense></v-text-field>
                            </v-col>
                            <v-col cols="12" sm="4" md="3">
                                <v-text-field v-model="revision.referencias" label="Referencias de la Dirección" dense></v-text-field>
                            </v-col>
                        </v-row>
                    </v-card-text>
                </v-card>
            </v-tab-item>
            <v-tab-item>
                <v-carousel v-model="model" color="primary">
                    <v-carousel-item v-if="revision.fotoReferenciaFinanciera" 
                        :src="'../'+revision.fotoReferenciaFinanciera"
                        :lazy-src="'../'+revision.fotoReferenciaFinanciera"
                        reverse-transition="fade-transition"
                        transition="fade-transition"
                    ></v-carousel-item>
                    <v-sheet else color="primary" height="100%" tile class="fill-height text-h5" align="center" justify="center">
                        <br/><br/>No adjunto documento
                    </v-sheet>
                </v-carousel>
            </v-tab-item>
        </v-tabs-items>
        <v-row no-gutters>
                <v-col cols="12" sm="6" md="6">
                    <div class="text-center pa-2">
                        <comp-programar :paramId="revision.id" :datosRow="revision"></comp-programar>
                    </div>
                </v-col>
                <v-col cols="12" sm="6" md="6">
                    <div class="text-center pa-2">
                        <comp-rechazar :paramId="revision.id" :datosRow="revision"></comp-rechazar>
                    </div>
                </v-col>
              </v-row>
    </v-card>
</template>
<script>
import compProgramar from '@/components/programar/CompProgramar'
import compRechazar from '@/components/programar/CompRechazar'
export default {
    components:{
        'comp-programar':compProgramar,
        'comp-rechazar':compRechazar,
    },
    data () {
        return {
            revision:{},
            simpleIlimitado:{},
            tabs: null,
            text: '',
            date: new Date(Date.now() - new Date().getTimezoneOffset() * 60000)
      .toISOString()
      .substr(0, 10),
    menu2: false,
    solicitud: {},
    checkbox: true,
    rules: [
      (value) => !!value || "Required.",
      (value) => (value && value.length >= 3) || "Min 3 characters",
    ],
    model: 0,
    colors: ["primary", "yellow darken-2"],
        }
    },
    async created(){
        this.reformarLista(1)
    },
    methods:{
        async reformarLista(pg) {
            var URLactual = this.$route.fullPath;
            var arrayUri = URLactual.split("?");
            const q = {query: `{allVwSimpleIlimitados(condition:{estadoSolicitado:"S" id:"${arrayUri[1]}"}) {
                                    nodes {
                                        id
                                        correo
                                        nombres
                                        primerNumero
                                        segundoNumero
                                        apellidoMarital
                                        apellidoMaterno
                                        apellidoPaterno
                                        fechaNacimiento
                                        fechaProgramada
                                        horaProgramada
                                        tipoAtencion
                                        ciudadAtencion
                                        genero
                                        estadoCivil
                                        tipoDocumento
                                        telefonosPlanes
                                        expedicion
                                        plan
                                        fotoCi
                                        fotoCi2
                                        fotoFactura
                                        fotoReferenciaFinanciera
                                        numeroPospago
                                        creado
                                        calleAvenida
                                        nroDocumento
                                        multicentro
                                        multicentroDireccion
                                        ciudadAtencion
                                        horaPropuesta
                                        departamentoPersomal
                                        referencias
                                        zona
                                        nroVivienda
                                    }}}`};
            const lista = await this.$axios.$post(`/graphql`, q)
            this.revision= lista.data.allVwSimpleIlimitados.nodes[0];
        }
    },
    computed: {
        dateRangeText () {
            return this.dates.join(' ~ ')
        },
        listaReformada() {
            return this.$store.state.reformarLista.lista
        },
        permiso () {
            return this.$store.state.menu.filtro
        }
    }
}
</script>