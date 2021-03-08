<template>
  <div class="pa-2">
            <v-card>
                <v-card-title class="headline grey lighten-2 d-flex text-center">
                LO QUE NECESITA ESTÁ AQUI
                </v-card-title>
                <v-card-text>
                    <v-container>
                    <v-row class=" d-flex text-right">
                        <img src="~/assets/LOGO ENTEL.png" alt="DATACOM" width="60%" class="VuetifyLogo">
                    </v-row>
                    <v-row>
                        
                        <v-col v-for="row in listCategoria"
                                :key="row.id"
                                cols="12" sm="12" md="4">
                            <nuxt-link :to="'/publico/servicio?'+row.id">
                                <v-btn text>
                                    <v-icon left x-large>{{ row.logo }}</v-icon> {{ row.nombre }}
                                </v-btn>
                            </nuxt-link>
                        </v-col>
                    </v-row>
                   
                </v-container>
                </v-card-text>

                <v-divider></v-divider>

                <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn
                    color="primary"
                    text
                    @click=" dialog = false; editModulo()">
                    Guardar
                </v-btn>
                </v-card-actions>
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
            listCategoria:[],
            desserts: [],
            modulo:{
                nombre:this.param
            },
            param:0
        }
    },
    async asyncData({$axios}) {
        const q = {query: `{allCategoriaServicios {
                                nodes {
                                    fechaInicio
                                    fechaVigencia
                                    id
                                    logo
                                    nombre
                                }
                            }}`};
        const datos = await $axios.$post(`${process.env.BASE_URL}/graphql`, q)
        try {
            //this.listCategoria = datos.data.allCategoriaServicios.nodes;
            return {listCategoria: datos.data.allCategoriaServicios.nodes};
        } catch (error) {
            console.log('Error', error)
        }
        /*const datos = await $axios.$post(`${process.env.BASE_URL}/modulos`,{headers: {'Ypfb-App-Access-Token' : process.env.API_KEY}})
        console.log(datos)
        try {
            return {desserts:datos.data};
        } catch (error) {
            console.log('Error', error)
        }*/
    }
}
</script>