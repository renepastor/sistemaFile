<template>
  <div class="pa-2">
        <v-card>
            <div class="pa-2 headline grey lighten-2  text-center">
                LO QUE NECESITA ESTÁ AQUI
            </div>
            <v-card-text>
                <v-container>
                    <div class="text-right">
                        <img src="~/assets/LOGO ENTEL.png" alt="DATACOM" width="250" class="right VuetifyLogo">
                    </div>
                    <v-row>
                        <v-col cols="12" sm="12" md="4" class="pa-0">
                            <h3 class="text-center"><v-btn class="text" text>{{rowServicio.servicio }}</v-btn></h3>
                            <div>{{rowServicio.descripcion}}</div>
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
            rowServicio:{},
            desserts: [],
            modulo:{
                nombre:this.param
            },
            param:0
        }
    },
    async asyncData({$axios}) {
        var URLactual = window.location;
        var arrayUri = (URLactual.href).split("?");
        const q = {query: `{servicioById(id:"${arrayUri[1]}"){id servicio descripcion}}`};
        const datos = await $axios.$post(`${process.env.BASE_URL}/graphql`, q)
        try {
            return {rowServicio: datos.data.servicioById};
        } catch (error) {
            console.log('Error', error)
        }
    },
    async created(){
        var URLactual = window.location;
        var arrayUri = (URLactual.href).split("?");
        const q = {query: `{servicioById(id:"${arrayUri[1]}"){id servicio descripcion}}`};
        const datos = await this.$axios.$post(`${process.env.BASE_URL}/graphql`, q)
        try {
            this.rowServicio = datos.data.servicioById;
        } catch (error) {
            console.log('Error', error)
        }
    }
}
</script>