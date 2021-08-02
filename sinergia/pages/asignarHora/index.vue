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
                    <th class="text-center">Codigo</th>
                    <th class="text-center">Des. Abreviada</th>
                    <th class="text-center">Des. General</th>
                    <th class="text-center">Estado</th>
                    <th><comp-create :title="title" v-if="permiso.creacion"></comp-create></th>
                </tr>
            </thead>
            <tbody class="px-0">
                <tr v-for="(item, i) in listaReformada.content" :key="i" :class="(i%2 != 0)? 'over' :''">
                    <td>{{  (listaReformada.number*listaReformada.size) + i+1  }}</td>
                    <td>{{ item.codigo }}</td>
                    <td>{{ item.descripcionAbreviada }}</td>
                    <td>{{ item.descripcionGeneral }}</td>
                    <td class="text-center">
                        <v-icon :color="item.activo?'orange':'red'">{{ item.activo?'mdi-flag ':'mdi-flag-remove ' }}</v-icon>
                    </td>
                    <td>
                        <v-slide-group multiple show-arrows >
                            <comp-edit :paramId="item.id" :title="title" :anular="permiso.eliminacion" v-if="permiso.modificacion"></comp-edit>
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
import compCreate from '@/components/materialGrupo/CompCreate'
import compEdit from '@/components/materialGrupo/CompEdit'
import compDelete from '@/components/materialGrupo/CompDelete'
import compAlert from '@/components/Alert'
export default {
    head() {
      return {
        title: this.title,
      }
    },
    components:{
        'comp-create':compCreate,
        'comp-edit':compEdit,
        'comp-delete':compDelete,
        'comp-alert': compAlert
    },
    middleware: 'auth',
    data () {
        return {
            title:'Grupos de Material',
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
        reformarLista(pg) {
            this.$store.commit('reformarLista/lista', `/materialGrupo?page=${pg-1}`)
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