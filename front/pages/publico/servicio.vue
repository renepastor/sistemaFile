<template>
  <div class="pa-2">
        <v-card>
            <div class="pa-2 headline grey lighten-2  text-center">
                LO QUE NECESITA ESTÁ AQUI
            </div>
            <v-card-text>
                <v-container>
                    <div class="text-center">
                        <img src="~/assets/logo.png" alt="DATACOM" width="250" class="right VuetifyLogo">
                    </div>
                    <v-row>
                        <v-col v-for="row in listServicio"
                                :key="row.id"
                                cols="12" sm="12" md="5" class="pa-0">
                            <v-btn text :to="'/publico/servicioDetalle?'+row.id">
                                <v-icon left>mdi-chevron-right</v-icon>{{ row.servicio }}
                            </v-btn>
                        </v-col>
                    </v-row>
                </v-container>
            </v-card-text>

            <v-divider></v-divider>

        </v-card>
    </div>
</template>
<script>
import compCreate from '@/components/admin/modulo/CompCreate'
import compEdit from '@/components/admin/modulo/CompEdit.vue'
export default {
    head() {
      return {
        title: this.title,
      }
    },
    components:{
        'comp-create':compCreate,
        'comp-edit':compEdit
    },
    auth: false,
    prefetchLinks: false,
    data () {
        return {
            title:'Datos Personales',
            listServicio:[],
            desserts: [],
            modulo:{
                nombre:this.param
            },
            param:0
        }
    },
    async asyncData({$axios}) {
        var URLactual = window.location;
        var arrayUri = (URLactual.href).split("?");
        const q = {query: `{allServicios(condition:{categoriaId:"${arrayUri[1]}", estado:"C"}){
                                nodes{id servicio}
                            }}`};
        
        const datos = await $axios.$post(`${process.env.BASE_URL}/graphql`, q)
        try {
            return {listServicio: datos.data.allServicios.nodes};
        } catch (error) {
            console.log('Error', error)
        }
    },
    async created(){
        var URLactual = window.location;
        var arrayUri = (URLactual.href).split("?");
        const q = {query: `{allServicios(condition:{categoriaId:"${arrayUri[1]}", estado:"C"}){
                                nodes{id servicio}
                            }}`};
        const datos = await this.$axios.$post(`${process.env.BASE_URL}/graphql`, q)
        try {
            this.listServicio = datos.data.allServicios.nodes;
        } catch (error) {
            console.log('Error', error)
        }
    }
}
</script>
<style>
.v-card__subtitle {
    padding: 0px !important;
}
</style>