<template>
    <div class="pa-2 full">
        <v-card>
            <div class="pa-2 headline grey lighten-2  text-center">
                LO QUE NECESITA ESTÁ AQUI
            </div>
            <v-card-text>
                <v-container>
                    <div class="text-center">
                        <img src="~/assets/logo.png" alt="DATACOM" width="250" class="right VuetifyLogo">
                    </div>
                    <v-row class="pt-4">
                        <v-col v-for="row in listCategoria"
                                :key="row.id"
                                cols="12" sm="12" md="4">
                            
                                <v-btn text @click="idCategoria=row.id; fnEviarParam()">
                                    <v-icon left x-large>{{ row.logo }}</v-icon> &nbsp; &nbsp; {{ row.nombre }}
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
export default {
    head() {
      return {
        title: this.title,
      }
    },
    components:{
    },
    auth: false,
    prefetchLinks: false,
    data () {
        return {
            title:'Servicios',
            idCategoria:0,
            listCategoria:[],
            desserts: [],
            modulo:{
                nombre:this.param
            },
            param:0
        }
    },
    async created(){
        this.fnCategorias()
    },
    methods:{
        fnEviarParam(){
            console.log("########-->", this.idCategoria)
            this.$store.commit('param/fnParam', {idCategoria:this.idCategoria})
            this.$router.push(`/publico/servicio?${this.idCategoria}`)
        },
        async fnCategorias(){
            const q = {query:`query{allVwCategoriaServicios {
                                nodes {
                                    fechaInicio
                                    fechaVigencia
                                    id
                                    logo
                                    nombre
                                }
                            }}`};
            const datos = await this.$axios.$post(`/graphql`, q)
            try {
                this.listCategoria = datos.data.allVwCategoriaServicios.nodes;
            } catch (error) {
                console.log('Error', error)
            }
        }
    }
}
</script>