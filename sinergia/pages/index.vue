<template>
    <v-app fluid dark class="full" >
        <v-card outlined tile elevation="4" class="ma-4">
            <div class="pa-2 headline grey lighten-2 text-center">
                <v-col col="12" sm="12" md="4" class="d-flex flex-column justify-space-between align-center">
                    <img aspect-ratio="16" src="~/assets/logo1.png" alt="DATACOM" class="">
                </v-col>
                
                <h5>SOLICITA TU SERVICIOS</h5>
            </div>
            <v-card-text>
                <v-container>
                    <div class="text-center">
                        <img src="~/assets/logo.png" alt="DATACOM" width="250" class="right VuetifyLogo">
                    </div>
                </v-container>
            </v-card-text>

            <v-divider></v-divider>

            <div class="text-center pa-2">
                <v-btn to="/publico/categoriaServ" outlined color="indigo">SERVICIOS</v-btn>
                <v-btn to="/publico/categoria" outlined color="indigo">CONSULTAS</v-btn>
            </div>
        </v-card>
        <v-footer :absolute="!fixed" app  class="indigo lighten-1 white--text text-center">
            <span>
                <v-icon  class="ma-2 white--text">mdi-facebook</v-icon>
                <v-icon  class="ma-2 white--text">mdi-twitter</v-icon>
                <v-icon  class="ma-2 white--text">mdi-youtube</v-icon>
                <v-icon  class="ma-2 white--text">mdi-whatsapp</v-icon>
            </span>
            <span  style="right: 15px;position: absolute;">
                <v-btn to="./login" title="Iniciar Sesión" icon><v-icon class="ma-2 white--text">mdi-login</v-icon></v-btn>
            </span>
        </v-footer>
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
            fixed:false,
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