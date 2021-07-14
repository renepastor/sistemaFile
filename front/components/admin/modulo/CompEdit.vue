<template>
    <v-dialog
      v-model="dialog"
      width="500">
      <template v-slot:activator="{ on, attrs }">
        <v-hover>
            <template v-slot:default="{ hover }">
                <v-btn @click="getIdModulo()" icon color="grey darken-2" :elevation="hover ? 10 : 0" fab dark small v-bind="attrs" v-on="on">
                    <v-icon>mdi-book-edit</v-icon>
                </v-btn>
            </template>
        </v-hover>
      </template>

      <v-card>
        <v-card-title class="headline grey lighten-2">
          Crear datos
        </v-card-title>
        <v-card-text>
            <v-container>
            <v-row>
              <v-col cols="12" sm="12" md="12">
                <input type="hidden" v-model="modulo.id" required/>
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
    </v-dialog>
</template>

<script>
  export default {
    data () {
      
      return {
          dialog: false,
          modulo:{
              id:this.param,
              nombre:this.param
          }
      }
    },
    props:{
        param:{
            type:Number,
            default:0
        }
    },
    methods:{
        async getIdModulo(){
            const modulo = await this.$axios.$get(`${process.env.BASE_URL}/modulos/${this.param}`,{headers: {'Ypfb-App-Access-Token' : process.env.API_KEY}})
            try {
                this.modulo = modulo.data;
            } catch (error) {
                console.log('setWi------shlist', error)
            }
        },
        async editModulo(){
            const modulo = await this.$axios.$put(`${process.env.BASE_URL}/modulos/${this.param}`,this.modulo, {headers: {'Ypfb-App-Access-Token' : process.env.API_KEY} })
            try {
                this.modulo = modulo.data;
            } catch (error) {
                console.log('setWi------shlist', error)
            }
        }
    }
  }
</script>