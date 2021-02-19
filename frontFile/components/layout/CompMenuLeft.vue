<template>
    <div>
        <v-list>
            <v-list-item class="px-2 justify-center">
                <v-list-item-avatar class="justify-center">
                    <v-icon x-large dark>mdi-shield-account</v-icon>
                </v-list-item-avatar>
            </v-list-item>

            <v-list-item link>
                <v-list-item-content>
                    <v-list-item-title class="title">
                        <em>{{$auth.user.miUsuario.fullName}}</em>
                    </v-list-item-title>
                    <v-list-item-subtitle>{{$auth.user.miUsuario.mail}}</v-list-item-subtitle>
                </v-list-item-content>
            </v-list-item>
        </v-list>

        <v-divider></v-divider>
        
        <v-list>
            <v-list-group
                v-for="item in items"
                active-class="white--text"
                :key="item.enlaceByEnlaId.enlacesByPadreId.nodes[1]"
                v-model="item.active"
                multiple
                no-action>
                
                    <template v-if="item.enlaceByEnlaId.enlacesByPadreId.nodes.length > 0" v-slot:activator>
                        <v-avatar color="red" size="32">
                            <v-icon dark>{{item.enlaceByEnlaId.imagen}}</v-icon>
                        </v-avatar>
                        <v-list-item-content class="ml-2">
                            <v-list-item-title v-text="item.enlaceByEnlaId.nombre"></v-list-item-title>
                        </v-list-item-content> 
                    </template>
                    <div  v-if="item.enlaceByEnlaId.enlacesByPadreId.nodes.length > 0">
                        <v-list-item
                            v-for="child in item.enlaceByEnlaId.enlacesByPadreId.nodes[0].menuesByEnlaId.nodes"
                            :key="child.enlaceByEnlaId.nivel" link outlined
                            class="grey darken-3 pl-6 pr-2">
                            <nuxt-link :to="child.enlaceByEnlaId.ruta" link class="white--text mx-0 px-0 m-0 p-0" color="red"
                            active-class="red--text">
                                <v-list-item-content  @click="loader()" class="white--text mx-0 px-0 m-0 p-0">
                                    <v-list-item-title v-text="child.enlaceByEnlaId.nombre" class="white--text"></v-list-item-title>
                                </v-list-item-content>
                            </nuxt-link>
                        </v-list-item>
                    </div>
            </v-list-group>
        </v-list>

        <v-footer fixed class="px-0">
            <v-list-item link>
                <v-list-item-content>
                    <v-list-item-subtitle>
                        &copy; {{ new Date().getFullYear() }}
                    </v-list-item-subtitle>
                </v-list-item-content>
            </v-list-item>
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
        setTimeout(()=>{
            //this.items = this.$auth.$storage.getLocalStorage("perm");
            this.items = [this.$auth.user.roleById.menuesByRolId.nodes[0]];
        },200)
    },
    data(){
        return{
            items:[]
        }
    },
    methods:{
        async loader(){
            console.log("ssssss....")
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
