<template>
    <div>
        <h3 class="title">Estado de Solicitudes</h3>
        <v-row><v-col cols="12" lg="6">
        
        </v-col></v-row>
        <v-simple-table dense fixed-header height="500px" class="lista">
            <thead>
                <tr>
                    <th>#</th>
                    <th class="text-center">Correo/Doc. Identidad</th>
                    <th class="text-center">Nombre</th>
                    <th class="text-center">Numero de Contacto</th>
                    <th class="text-center">Ciudad</th>
                    <th class="text-center">Multicentro</th>
                    <th class="text-center">Hora referencia</th>
                    <th class="text-center">Mensaje</th>
                    <th class="text-center">Fecha Hora Programada</th>
                    <th class="text-center">Multicentro</th>
                </tr>
            </thead>
            <tbody class="px-0">
                <tr v-for="(item, i) in listaReformada.allVwSimpleIlimitados?listaReformada.allVwSimpleIlimitados.nodes:[]" :key="i" :class="(i%2 != 0)? 'over' :''">
                    <td>{{ i+1  }}</td>
                    <td>{{ item.correo }} <b>{{ item.nroDocumento}}</b></td>
                    <td>{{ item.nombres }} {{item.apellidoPaterno}} {{item.apellidoMaterno }}</td>
                    <td>{{item.primerNumero}} ~ {{item.segundoNumero }}</td>
                    <td>{{item.multicentro}}</td>
                    <td>{{item.ciudadAtencion }}</td>
                    <td>{{item.horaPropuesta}}</td>
                    <td>{{item.mensaje}}</td>
                    <td>{{item.fechaProgramada}} {{item.horaProgramada}}</td>
                    <td>{{item.multicentro}}</td>

                </tr>
            </tbody>
        </v-simple-table>

        <div>
            <v-container class="max-width" dense>
                <v-pagination
                v-model="pagina"
                :pagina="listaReformada.number + 1"
                class="my-0"
                :length="listaReformada.totalPages"
                @input="reformarLista($event)"
                ></v-pagination>
            </v-container>
        </div>
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