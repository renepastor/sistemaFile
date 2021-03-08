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
                        <em>{{$auth.user.miUsuario.alias}}</em>
                    </v-list-item-title>
                    <v-list-item-subtitle>{{$auth.user.miUsuario.cuenta}}</v-list-item-subtitle>
                </v-list-item-content>
            </v-list-item>
        </v-list>

        <v-divider></v-divider>
        
        <v-list>
            <v-list-group
                v-for="item in items"
                active-class="white--text"
                :key="item.id"
                v-model="item.nivel"
                multiple
                no-action>
                
                    <template v-if="item.dependiente.length > 0" v-slot:activator>
                        <v-avatar color="red" size="32">
                            <v-icon dark>{{item.imagen}}</v-icon>
                        </v-avatar>
                        <v-list-item-content class="ml-2">
                            <v-list-item-title v-text="item.nombre"></v-list-item-title>
                        </v-list-item-content> 
                    </template>
                    <div  v-if="item.dependiente.length > 0">
                        <v-list-item
                            v-for="child in item.dependiente"
                            :key="child.id" link outlined
                            class="grey darken-3 pl-6 pr-2"  :to="child.ruta">
                                <v-list-item-icon>
                                    <v-icon v-text="child.imagen"></v-icon>
                                </v-list-item-icon>
                                <v-list-item-content  @click="loader()" class="white--text mx-0 px-0 m-0 p-0">
                                    <v-list-item-title v-text="child.nombre" class="white--text"></v-list-item-title>
                                </v-list-item-content>
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
            
            var listMenu = (this.$auth.user.miMenu.nodes).filter((r)=> (r.nivel == 1));
            listMenu.map((row,i) =>{
                listMenu[i].dependiente = {};
                listMenu[i].dependiente = (this.$auth.user.miMenu.nodes).filter((r)=> (r.padreId == row.id));
            });
            console.log(this.$auth.user.miMenu.nodes, listMenu);
            this.items = listMenu;
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
