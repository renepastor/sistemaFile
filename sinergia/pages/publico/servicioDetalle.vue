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
                        <v-btn text>
                            <v-icon left x-large>{{ rowServicio.logo }}</v-icon> {{ rowServicio.nombre }}
                        </v-btn>
                        <v-col cols="12" sm="12" md="12">
                            <h3 class="text-center"><v-btn class="text" text>{{ rowServicio.servicio }}</v-btn></h3>
                        </v-col>
                    </v-row>
                    <v-row>
                        <h3>REQUISITOS:</h3>
                    </v-row>
                    <v-row>
                        <v-list>
                            <v-list-item-group>
                                <div href="javascript:void(0)" v-for="row in listRequisitos" :key="row.id">
                                    - {{ row.descripcion }}<br/>
                                </div>
                            </v-list-item-group>
                        </v-list>
                    </v-row>
                </v-container>
            </v-card-text>

            <v-divider></v-divider>

            <div class="text-center pa-2">
                <v-btn :to="rutaFormulario" outlined color="indigo">Realiza tu Contrato</v-btn>
            </div>
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
            rowServicio:{},
            rutaFormulario:'./',
            listRequisitos:[],
            desserts: [],
            html:'...',
            modulo:{
                nombre:this.param
            },
            param:0
        }
    },
    async asyncData({$axios}) {
        /*var URLactual = window.location;
        var arrayUri = (URLactual.href).split("?");
        const q = {query: `{
            allVwServicios(condition:{id:"${arrayUri[1]}"}){nodes{id servicio promocion nombre logo}}
            allVwRequisitosServicios(condition:{servicioId:"${arrayUri[1]}" activo:true}){nodes{id requerido descripcion}}
        }`};
        const datos = await $axios.$post(`/graphql`, q)
        var newRowServicio = datos.data.allVwServicios.nodes[0];
        //const newHtml = await fetch('..'+newRowServicio.descripcion).then(res => res.text());
        //console.log("-------", newHtml)
        try {
            return {
                rowServicio: newRowServicio,
                listRequisitos: datos.data.allVwRequisitosServicios.nodes
                //,html: newHtml
            };
        } catch (error) {
            console.log('Error', error)
        }*/
    },
    async created(){
        const URLactual = this.$route.fullPath;
        var arrayUri = URLactual.split("?");
        const q = {query: `{
            allVwServicios(condition:{id:"${arrayUri[1]}"}){nodes{id servicio formulario promocion nombre logo}}
            allVwRequisitosServicios(condition:{servicioId:"${arrayUri[1]}" activo:true}){nodes{id requerido descripcion}}
        }`};
        const datos = await this.$axios.$post(`/graphql`, q)
        try {
            this.rowServicio = datos.data.allVwServicios.nodes[0];
            this.rutaFormulario = datos.data.allVwServicios.nodes[0].formulario;
            this.listRequisitos = datos.data.allVwRequisitosServicios.nodes;
        } catch (error) {
            console.log('Error', error)
        }
        //this.fnDetalle(URLactual);
    }
}
</script>