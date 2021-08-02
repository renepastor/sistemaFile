<template>
  <div>
    <v-dialog
      v-model="dialog"
      width="500">
      <template v-slot:activator="{ on, attrs }">
        <v-hover>
            <template v-slot:default="{ hover }">
                <v-btn icon color="btnew" @click="viewUnidadMedida()" :elevation="hover ? 10 : 0" fab small v-bind="attrs" v-on="on">
                    <v-icon >mdi-delete-forever</v-icon>
                </v-btn>
            </template>
        </v-hover>
      </template>

      <v-card>
        <v-card-title class="headline grey lighten-2">
          Unidades de Medida
        </v-card-title>
        <v-card-text>
            <v-container>
            <v-row>
              <v-col cols="12" sm="6" md="8">
                <v-text-field label="*Abreviatura" v-model="unidadMedida.abreviatura" required></v-text-field>
              </v-col>
              <v-col cols="12" sm="6" md="8">
                <v-text-field label="*Unidad de Medida" v-model="unidadMedida.unidadMedida" required></v-text-field>
              </v-col>
              <v-col>
                <v-switch v-model="unidadMedida.activo"
                color="primary" :value="unidadMedida.activo"
                :label="`Estado: `+(unidadMedida.activo?'Activo':'Inactivo')"
                ></v-switch>
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
  </div>
</template>


<script>
  export default {
    data () {
      return {
          dialog: false,
          unidadMedida:{
              abreviatura: this.abreviatura,
              unidadMedida: this.unidadMedida
          }
      }
    },
    props:{
        paramUM:{
            type:Number,
            default:"..."
        }
        /*,
        unidadMedida:{
            type:String,
            default:""
        }*/
    },
    created(){
        //
        
    },
    methods:{
        async viewUnidadMedida(){
            console.log("########### ", this.paramUM)
            const resultunidadMedida = await this.$axios.$get(`/unidadMedida/${this.paramUM}`)
            try {
                if(resultunidadMedida.success){
                    this.unidadMedida = resultunidadMedida.data;
                }else{
                    console.log("#######")
                }
                
            } catch (error) {
                console.log('setWi----sa--shlist', error)
            }
        },
        async editModulo(){
            const resultunidadMedida = await this.$axios.$put(`/unidadMedida/${this.paramUM}`,this.unidadMedida)
            try {
                if(resultunidadMedida.success){
                    this.unidadMedida = resultunidadMedida.data;
                }else{
                    console.log("#######")
                }
                
            } catch (error) {
                console.log('setWi------shlist', error)
            }
        }
    }
  }
</script>