<template>
    <div dark>
        <v-list>
            <v-list-item class="px-2 justify-center">
                <vuetify-logo />
            </v-list-item>
            <v-list-item link>
                <v-list-item-content v-if="menu.usuario">
                    <v-list-item-title class="title">
                        <em>{{menu.usuario.alias}}</em>
                    </v-list-item-title>
                    <v-list-item-subtitle>{{menu.usuario.username}}</v-list-item-subtitle>
                </v-list-item-content>
            </v-list-item>
        </v-list>
        <v-divider :menu="menu"></v-divider>
        <v-list>
            <v-list-group dense v-for="(modulo, j) in menu.listaModulos" :key="j" :title="modulo.modulo" link :value="false" :prepend-icon="modulo.icono" class="mx-0 px-0 m-0 p-0">
                <template v-slot:activator dense class="mx-0 px-0 m-0 p-0">
                    <v-list-item-content class="">
                        <v-list-item-title class="" v-text="modulo.modulo"></v-list-item-title>
                    </v-list-item-content>
                </template>
                <v-list-item dense v-for="(recurso, i) in menu.listaRecursos" :key="i" v-if="modulo.modulo == recurso.modulo" :to="'/'+recurso.uri" @click="permisos(recurso)" link>
                    <v-list-item-icon class="mx-2 px-0 m-0 p-0" :title="recurso.recurso">
                        <v-icon v-text="recurso.icono_recurso"></v-icon>
                    </v-list-item-icon>
                    <v-list-item-content class="mx-0 px-0 m-0 p-0">
                        <v-list-item-title v-text="recurso.recurso" class=""></v-list-item-title>
                    </v-list-item-content>
                </v-list-item>
            </v-list-group>
        </v-list>
        <v-footer fixed class="px-0">
            <nuxt-link to="/login/salir" link class="mx-0 px-0 m-0 p-0" color="red" active-class="red--text">
                <v-btn class="ma-1" plain>
                    <v-icon left>mdi-location-exit</v-icon>
                    Cerrar sesión
                </v-btn>
            </nuxt-link>
        </v-footer>
    </div>    
</template>
<script>
import compLoading from '@/components/Loading'
export default {
    components:{
        'comp-loading':compLoading
    },
    props:{
        left:{
            type:Boolean,
            default:true
        },
        drawer:{
            type:Boolean,
            default:false
        }
    },
    created(){
        this.listarMenu()
    },
    data(){
        return{
            modulos:[],
            recursos:[],
            usuario:{},
            exit:"mdi-location-exit"
        }
    },
    methods:{
        permisos(obj){
            this.$store.commit('menu/permisos', obj)
        },
        listarMenu() {
            this.$store.commit('menu/listaMenu')
        }
    },
    computed:{
        menu () {
            return this.$store.state.menu.listaMenu
        }
    }
}
</script>
<style scoped>
a, .v-list-item__title{
    text-decoration:none;
    font-weight: bold;
}
</style>
