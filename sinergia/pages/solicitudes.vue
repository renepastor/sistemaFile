<template>
    <div>
        <h3 class="title">Mis Solicitudes</h3>
        <v-row><v-col cols="12" lg="6">
        
        </v-col></v-row>

        <v-row>
            <v-col v-for="(item, i) in listaReformada.allVwSimpleIlimitados?listaReformada.allVwSimpleIlimitados.nodes:[]" :key="i" cols="12" sm="12" md="4" lg="2">
                <v-hover>
                    <template v-slot:default="{ hover }">
                        <v-card v-if="item.estadoSolicitado == 'S'" align="justify" color="purple accent-2" dark :elevation="hover ? 24 : 6" class="mx-auto pa-3">
                            <v-card-title class="text-h5">
                                <b><v-icon>mdi-notebook-edit-outline</v-icon><small>Tramite:</small> {{item.id}}</b><br/>
                            </v-card-title>
                            <v-card-subtitle class="text-h6">
                                <b>Fecha: </b>{{$moment(item.creado).format('DD/MM/YYYY HH:mm')}}
                            </v-card-subtitle>
                            <v-card-text>
                                Su solicitud esta en proceso, nos contactaremos con usted una ves que analicemos sus documentos.
                            </v-card-text>
                            <v-card-actions>
                                <v-btn  class="text-h5" text color="orange lighten-2">
                                    SOLICITADO PENDIENTE
                                </v-btn>
                            </v-card-actions>
                        </v-card>
                    </template>
                </v-hover>
                <v-hover>
                    <template v-slot:default="{ hover }">
                        <v-card v-if="item.estadoSolicitado == 'P'" align="justify" color="lime accent-2" :elevation="hover ? 24 : 6" class="mx-auto pa-3">
                            <v-card-title class="text-h5">
                                <b><v-icon>mdi-notebook-edit-outline</v-icon><small>Tramite:</small> {{item.id}}</b><br/>
                            </v-card-title>
                            <v-card-subtitle class="text-h6">
                                <b>Fecha: </b>{{$moment(item.creado).format('DD/MM/YYYY HH:mm')}}
                            </v-card-subtitle>
                            <v-card-text>
                                {{item.mensaje}}
                            </v-card-text>
                            <v-card-actions>
                                <v-btn  class="text-h5" text color="orange lighten-2">
                                    PROGRAMADO
                                </v-btn>
                            </v-card-actions>
                        </v-card>
                    </template>
                </v-hover>
                <v-hover>
                    <template v-slot:default="{ hover }">
                        <v-card v-if="item.estadoSolicitado == 'R'"  align="justify" color="red darken-1" :elevation="hover ? 24 : 6" class="mx-auto pa-3">
                            <v-card-title class="text-h5">
                                <b><v-icon>mdi-notebook-edit-outline</v-icon><small>Tramite:</small> {{item.id}}</b><br/>
                            </v-card-title>
                            <v-card-subtitle class="text-h6">
                                <b>Fecha: </b>{{$moment(item.creado).format('DD/MM/YYYY HH:mm')}}
                            </v-card-subtitle>
                            <v-card-text>
                                {{item.mensaje}}
                            </v-card-text>
                            <v-card-actions>
                                <v-btn  class="text-h5" text color="orange lighten-2">
                                    <b>RECHAZADO</b>
                                </v-btn>
                            </v-card-actions>
                        </v-card>
                    </template>
                </v-hover>
                <v-hover>
                    <template v-slot:default="{ hover }">
                        <v-card v-if="item.estadoSolicitado == 'A'" align="justify" color="green darken-3" dark :elevation="hover ? 24 : 6" class="mx-auto pa-3">
                            <v-card-title class="text-h5">
                                <b><v-icon>mdi-notebook-edit-outline</v-icon><small>Tramite:</small> {{item.id}}</b><br/>
                            </v-card-title>
                            <v-card-subtitle class="text-h6">
                                <b>Fecha: </b>{{$moment(item.creado).format('DD/MM/YYYY HH:mm')}}
                            </v-card-subtitle>
                            <v-card-text>
                                Solicitud fue aprobada para el plan <b>{{item.plan}}</b>
                            </v-card-text>
                            <v-card-actions>
                                <v-btn  class="text-h5" text color="orange lighten-2">
                                    APROBADO
                                </v-btn>
                            </v-card-actions>
                        </v-card>
                    </template>
                </v-hover>
            </v-col>
        </v-row>
        <br/>
    </div>
</template>
<script>
import compEdit from '@/components/programar/CompEdit'
export default {
    head() {
      return {
        title: this.title,
      }
    },
    components:{
        'comp-edit':compEdit
    },
    middleware: 'auth',
    data () {
        return {
            title:'Revisar Documento',
            lista: [],
            pagina:1,
            sig:this.pagina,
            dates: ['2019-09-10', '2019-09-20'],
            menu1: false,
        }
    },
    async created(){
        this.reformarLista(1)
    },
    methods:{
        async reformarLista(pg) {
            const query = {"query": `query{miUsuario{mail:username id alias}}`};
            const user = await this.$axios.$post(`/graphql`, query);
            console.log("lllll",  process.env.API_KEY)
            const q = {query: `{allVwSimpleIlimitados(condition:{ correo:"${user.data.miUsuario.mail}"}) {
                                    nodes {
                                        id
                                        plan
                                        correo
                                        nombres
                                        mensaje
                                        fechaProgramada
                                        horaProgramada
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
                                        estadoSolicitado
                                        creado
                                    }}}`};
            this.$store.commit('reformarLista/lista', q)
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