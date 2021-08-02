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
                        <v-col v-for="row in listServicio"
                                :key="row.id"
                                cols="12" sm="12" md="5" class="pa-0">
                            <v-btn text @click="idServicio=row.id; fnEnviarParam()" >
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
            title:'Datos Personales',
            listServicio:[],
            desserts: [],
            idServicio:0,
            modulo:{
                nombre:this.param
            },
            param:0
        }
    },
    async asyncData({$axios}) {
        /*var URLactual = window.location;
        var arrayUri = (URLactual.href).split("?");
        const q = {query: `{allVwServicios(condition:{categoriaId:"${arrayUri[1]}", activo:true}){
                                nodes{id servicio}
                            }}`};
        
        const datos = await $axios.$post(`/graphql`, q)
        try {
            return {listServicio: datos.data.allVwServicios.nodes};
        } catch (error) {
            console.log('Error', error)
        }*/
    },
    async created(){
        var URLactual = this.$route.fullPath;
        var arrayUri = URLactual.split("?");
        const q = {query: `{allVwServicios(condition:{categoriaId:"${arrayUri[1]}", activo:true}){
                                nodes{id servicio}
                            }}`};
        const datos = await this.$axios.$post(`/graphql`, q)
        try {
            this.listServicio = datos.data.allVwServicios.nodes;
        } catch (error) {
            console.log('Error', error)
        }
    },
    methods:{
        fnEnviarParam(){
            console.log("----", this.idServicio)
            this.$router.push(`/publico/servicioDetalle?${this.idServicio}`)
        }
    },
    computed: {
        categoria () {
            return this.$store.state.param.param
        }
    }
}
</script>
<style>
.v-card__subtitle {
    padding: 0px !important;
}
</style>