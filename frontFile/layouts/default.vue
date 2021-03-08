<template lang="es">
    <v-app id="inspire">
        <v-app-bar v-if="$auth.loggedIn"
            :clipped-left="clipped"
            fixed
            app
            color="red darken-4 "
            class="white--text"
            dense
            lighten>
            <v-app-bar-nav-icon @click.stop="drawer = !drawer" />
            <v-toolbar-title v-text="title" />
            <v-spacer class="text-right">
                <em v-if="$auth.loggedIn">
                    <b>{{$auth.user.miUsuario.alias}}</b>
                </em>
                <em v-else>
                    Usuario
                </em>
            </v-spacer>
            <v-btn icon>
                <v-icon>mdi-account-circle</v-icon>
            </v-btn>
            <nuxt-link to="./login/salir" class="btn" title="Salir">
                <v-icon>mdi-logout</v-icon>
            </nuxt-link>
            <v-btn
                icon
                @click.stop="rightDrawer = !rightDrawer">
                <v-icon>mdi-menu</v-icon>
            </v-btn>
            
        </v-app-bar>
        
        <v-navigation-drawer
            v-if="$auth.loggedIn"
            v-model="drawer"
            :permanent="permanent"
            app dark
            mini-variant
            mini-variant-width="48"
            expand-on-hover>
            <comp-menu-left />
        </v-navigation-drawer>

        <v-navigation-drawer
            v-model="rightDrawer"
            :right="right"
            temporary
            fixed>
        </v-navigation-drawer>

        <v-main>
            <comp-loading :loading="loading">
                <nuxt />
            </comp-loading>
        </v-main>
    </v-app>
</template>

<script>

import compMenuLeft from '@/components/layout/CompMenuLeft'
import compSnackbar from '@/components/layout/CompSnackbar'
import compLoading from '@/components/Loading'

export default {
    head() {
        return {
            title: this.title,
        }
    },
    components:{
        'comp-menu-left': compMenuLeft,
        'comp-snackbar':compSnackbar,
        'comp-loading':compLoading
    },
    data () {
        return {
            title:'*~.',
            loading:true,
            clipped: false, // icono menu Left
            drawer: null,
            fixed: false,
            miniVariant: false,
            left: true,
            right: true,
            rightDrawer: false, // menu right activado
            permanent:false
        }
    },
    created(){
        this.loading = false
    },
    methods:{
    
    }
}
</script>
<style>
body {
    font-family: "Muli", sans-serif !important;
    color: #6f6f74 !important; 
}
a, .v-list-item__title{
    text-decoration:none;
    font-weight: bold;
}
.css-list > tr > th{
    background-color: #BF360C !important;
    color: #fff !important;
    height: 32px !important;
    text-transform: uppercase;
}
body{
    background-color: #e6e6e6 !important;
}
</style>
