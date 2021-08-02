<template>
    <v-app fluid dark class="full">
        <v-card>
            <div class="pa-2 headline grey lighten-2  text-center">
                <img src="~/assets/logo1.png" alt="DATACOM" class="">
                <h5>SOLICITA TU SERVICIOS</h5>
            </div>
            <v-card-text>
                <v-container>
                    <div class="text-center">
                        <img src="~/assets/logo.png" alt="DATACOM" width="250" class="right VuetifyLogo">
                    </div>
                    <v-row>
                    </v-row>
                </v-container>
            </v-card-text>

            <v-divider></v-divider>
            
            <div class="text-center pa-2">
                <v-btn to="/publico/categoriaServ" outlined color="indigo">SERVICIOS</v-btn>
                <v-btn to="/publico/categoria" outlined color="indigo">CONSULTAS</v-btn>
            </div>
        </v-card>
    </v-app>
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
            listCategoria:[],
            desserts: [],
            modulo:{
                nombre:this.param
            },
            param:0
        }
    },
    methods:{
        addTodo (e) {
            this.$store.commit('menu/add', e.target.value)
            e.target.value = ''
        }
    },
    computed: {
        //
    },
    async asyncData({$axios}) {
        //
    }
}
</script>