<template>
  <div class="pa-2">
            <v-card>
                <v-card-title class="headline grey lighten-2">
                Crear datos
                </v-card-title>
                <v-card-text>
                    <v-container>
                    <v-row>
                    <v-col cols="12" sm="12" md="12">
                        <v-text-field label="*Nombre" v-model="modulo.nombre" required></v-text-field>
                    </v-col>
                    <v-col cols="12" sm="8" md="8">
                        <v-text-field label="Icono" hint="Icono de .." v-model="modulo.icono">
                        </v-text-field>
                    </v-col>
                    <v-col cols="12" sm="4" md="4">
                        <v-text-field
                        label="*Orden"
                        hint="Orden para el menu"
                        v-model="modulo.orden"
                        persistent-hint
                        required
                        ></v-text-field>
                    </v-col>
                    <v-col cols="12">
                        <v-text-field
                        label="*Descripción"
                        v-model="modulo.descripcion"
                        required
                        ></v-text-field>
                    </v-col>
                    
                    </v-row>
                </v-container>
                <small>*Datos requeridos</small>


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
            desserts: [],
            modulo:{
                nombre:this.param
            },
            param:0
        }
    },
    async asyncData({$axios}) {
        /*const datos = await $axios.$get(`${process.env.BASE_URL}/modulos`,{headers: {'Ypfb-App-Access-Token' : process.env.API_KEY}})
        console.log(datos)
        try {
            return {desserts:datos.data};
        } catch (error) {
            console.log('Error', error)
        }*/
    }
}
</script>