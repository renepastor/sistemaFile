<template>
    <div>
        <h3 class="title">{{title}}</h3>
        <v-row><v-col cols="12" lg="6">
        <v-menu ref="menu1" v-model="menu1" :close-on-content-click="false"
          transition="scale-transition"
          offset-y
          max-width="290px"
          min-width="auto">
                <v-date-picker v-model="dates" range no-title @input="menu1 = false"></v-date-picker>
                <template v-slot:activator="{ on, attrs }">
                    <v-text-field
                        v-model="dateRangeText"
                        label="Rango de fecha"
                        prepend-icon="mdi-calendar"
                        v-bind="attrs"
                        v-on="on"
                        readonly
                    ></v-text-field>
                </template>
        </v-menu>
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
                    <th><comp-create :title="title" v-if="permiso.creacion"></comp-create></th>
                </tr>
            </thead>
            <tbody class="px-0">
                <tr v-for="(item, i) in listaReformada.allVwSimpleIlimitados?listaReformada.allVwSimpleIlimitados.nodes:[]" :key="i" :class="(i%2 != 0)? 'over' :''">
                    <td>{{ i+1  }}</td>
                    <td>{{ item.correo }} <b>{{ item.nroDocumento}}</b></td>
                    <td>{{ item.nombres }} {{item.apellidoPaterno}} {{item.apellidoMaterno }}</td>
                    <td>{{item.primerNumero}} ~ {{item.segundoNumero }}</td>
                    <td>{{item.ciudadAtencion }}</td>
                    <td>{{item.multicentro}} </td>
                    <td>{{item.horaPropuesta}}</td>
                    <td>
                        <v-slide-group multiple show-arrows >
                            <comp-edit :paramId="item.id" :title="title" ></comp-edit>
                        </v-slide-group>
                    </td>
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
            title:'Asignar Hora',
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
            const q = {query: `{allVwSimpleIlimitados(condition:{estadoSolicitado:"S"}) {
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