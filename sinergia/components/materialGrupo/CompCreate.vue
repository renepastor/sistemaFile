<template>
    <v-dialog v-model="dialog" width="500">
        <template v-slot:activator="{ on, attrs }">
            <v-hover>
                <template v-slot:default="{ hover }">
                    <v-btn icon color="btnew" :elevation="hover ? 10 : 0" fab small v-bind="attrs" v-on="on">
                        <v-icon >mdi-book-plus-multiple-outline</v-icon>
                    </v-btn>
                </template>
            </v-hover>
        </template>

        <v-card>
            <v-card-title class="headline grey lighten-2">Nuevo {{title}}</v-card-title>
            <val-obse ref="observer" v-slot="{ invalid }">
                <v-form @submit.prevent="guardarRegistro" ref="form" v-model="valid" lazy-validation>
                    <v-card-text>
                        <v-container>
                            <v-row>
                                <v-col cols="12" sm="6" md="6">
                                    <val-prov v-slot="{ errors }" name="Codigo" rules="required|max:100">
                                        <v-text-field label="* Codigo" :counter="4" v-model="materialGrupo.codigo"  maxlength="4" :error-messages="errors"></v-text-field>
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="6" md="12">
                                    <val-prov v-slot="{ errors }" name="Descripción Abreviada" rules="required|max:100">
                                        <v-text-field label="* Descripción Abreviada" :counter="100" v-model="materialGrupo.descripcionAbreviada" :error-messages="errors"></v-text-field>
                                    </val-prov>
                                </v-col>
                                <v-col cols="12" sm="6" md="12">
                                    <val-prov v-slot="{ errors }" name="Descripcion General" rules="required|max:150">
                                        <v-textarea autocomplete="email" label="* Descripcion General" :counter="150" v-model="materialGrupo.descripcionGeneral" :error-messages="errors" rows="2"></v-textarea>
                                    </val-prov>
                                </v-col>
                            </v-row>
                        </v-container>
                    </v-card-text>

                    <v-divider></v-divider>

                    <v-card-actions>
                        <small>*Datos requeridos</small>
                        <v-spacer></v-spacer>
                        <v-btn color="primary" :disabled="invalid" type="submit">
                            Guardar
                        </v-btn>
                    </v-card-actions>
                </v-form>
            </val-obse>
        </v-card>
    </v-dialog>
</template>


<script>
import { required, digits, email, max, regex } from 'vee-validate/dist/rules'
import { extend, ValidationObserver, ValidationProvider, setInteractionMode } from 'vee-validate'
setInteractionMode('eager')
extend('required', {
    ...required,
    message: '{_field_} no puede ser nulo',
})

extend('max', {
    ...max,
    message: '{_field_} no puede ser mayor a {length} caracteres',
})

export default {
    components: {
        'val-prov':ValidationProvider,
        'val-obse':ValidationObserver,
    },
    data () {
        return {
            valid: true,
            dialog: false,
            materialGrupo:{
                codigo:this.codigo,
                descripcionGeneral:this.descripcionGeneral,
                descripcionAbreviada:this.descripcionAbreviada
            }
        }
    },
    methods:{
        async guardarRegistro(evt){
            this.$refs.observer.validate()
            evt.preventDefault()
            const materialGrupoResult = await this.$axios.$post(`/materialGrupo`,this.materialGrupo)
            try {
                if(materialGrupoResult.success){
                    this.materialGrupo = {};
                    this.$store.commit('reformarLista/lista', `/materialGrupo`)
                    this.$store.commit('alert/ok', "EL Grupo de Material se registro correctamente")
                    this.dialog = false
                }else{
                    this.$store.commit('alert/error', materialGrupoResult.message)
                }
            } catch (error) {
                this.$store.commit('alert/error', error.message)
            }
        }
    },
    props:{
        title:{
            type:String,
            default:''
        }
    },
}
</script>