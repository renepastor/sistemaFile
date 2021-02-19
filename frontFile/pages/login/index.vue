<template>
    <v-container fluid>
      <comp-loading :loading="loading">
        <v-row no-gutters>
            <v-col cols sm="12" md="2" lg="4">
            </v-col>
            <v-col cols sm="12" md="8" lg="4">
                <br><br>
                <v-card class="pa-2" outlined tile elevation="12">
                    <v-form @submit.prevent="submit" ref="form" v-model="valid" lazy-validation>
                        <v-container>
                          <v-row>
                              <v-col cols sm="12" md="5" class="text-center">
                                  <vuetify-logo /><br/><br/>
                                  <h5>Bienvenido</h5>
                                  <h4>Contratos & Documentos Postpago</h4>
                              </v-col>
                              <v-divider vertical></v-divider>
                              <v-col cols sm="12" md="6" class="text-center">
                                  <v-text-field
                                      v-model="usuario.pUsuario"
                                      :rules="nameRules"
                                      :counter="4"
                                      label="Usuario"
                                      required></v-text-field>
                                  <v-text-field
                                      v-model="usuario.pClave"
                                      :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
                                      :type="passwordTp"
                                      label="*Contraseña"
                                      required
                                      @click:append="toggleMarker"></v-text-field>
                                  <v-btn
                                      class="mr-4"
                                      type="submit"
                                      :disabled="invalid">
                                      Ingresar
                                  </v-btn>
                              </v-col>
                          </v-row>
                        </v-container>
                    </v-form>
                </v-card>
            </v-col>
        </v-row>
        </comp-loading>
    </v-container>
</template>

<script>
import Logo from '~/components/Logo.vue'
import VuetifyLogo from '~/components/VuetifyLogo.vue'
import compLoading from '@/components/Loading'

export default {
    components: {
        Logo,
        VuetifyLogo,
        'comp-loading':compLoading
    },
    head() {
      return {
        title: this.title,
      }
    },
    middleware: false,
    data: () => ({
      title:"Iniciar session",
      usuario: {
          pUsuario: '',
          pClave: ''
      },
      show: true,
      loading: false,
      valid: true,
      invalid: false,
      passwordTp:"password",
      showPassword: false,
      nameRules: [
        v => !!v || 'El dato es requerido',
        v => v.length > 4 || 'Complete el numero de digitos requeridos',
      ],
    }),
    methods:{
      toggleMarker () {
        this.passwordTp = this.showPassword?'password':'text'
        this.showPassword = !this.showPassword
      },
      async submit (evt) {
        this.loading = true;
        this.$refs.form.validate()
        const loginInfo={};
        evt.preventDefault()
        try {
          var datoKey = new Buffer(this.usuario.pUsuario + ':' + this.usuario.pClave).toString('base64');
          const headers = {
                    'Accept': `application/json`,
                    'Content-Type' : `application/json`
                  };
          const response = await this.$auth.loginWith('local', {data: this.usuario,"headers":headers});
          const REDIRECT_URI = this.$route.query.redirect || process.env.URI_DEFAULT
          this.$router.push(REDIRECT_URI)
          this.$store.dispatch('snackbar/setSnackbar', { color: 'teal', text: `Gracias por iniciar sesión, ${response.data.data.fullName} ` })
        } catch (err) {
          console.log(err)
          this.$store.dispatch('snackbar/setSnackbar', { color: 'red', text: 'Hubo un error con el inicio de sesión.  Por favor intente de nuevo.' })
        }
        this.loading = false
      }
    }
}
</script>