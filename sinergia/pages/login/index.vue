<template>
    <v-app fluid dark class="mi-login">
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
                              <v-col cols sm="12" md="6" class="text-center">
                                  <vuetify-logo /><br/><br/>
                                  <h4 class="oblique">Bienvenido</h4>
                                  <h5>v1.0</h5>
                              </v-col>
                              <v-divider vertical></v-divider>
                              <v-col cols sm="12" md="6" class="text-center">
                                  <v-text-field
                                      v-model="usuario.pUsuario"
                                      :rules="userRules"
                                      label="* Usuario"
                                      required></v-text-field>
                                  <v-text-field
                                      v-model="usuario.pClave"
                                      :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
                                      :type="passwordTp"
                                      :rules="passRules"
                                      label="* Contraseña"
                                      required
                                      @click:append="toggleMarker"></v-text-field>
                                  <v-btn
                                      class="mr-4 primary"
                                      type="submit"
                                      :disabled="invalid">
                                      Ingresar
                                  </v-btn>
                              </v-col>
                          </v-row>
                        </v-container>
                    </v-form>
                </v-card>
                <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
            </v-col>
        </v-row>
        </comp-loading>
        
    </v-app>
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
        userRules: [
            v => !!v || 'El dato es requerido'
        ],
        passRules: [
            v => !!v || 'El dato es requerido'
        ],
    }),
    methods:{
        listarMenu() {
            this.$store.commit('menu/listaMenu')
        },
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
                var q = {query:`mutation{auth(input:{pClave:"${this.usuario.pClave}",pUsuario:"${this.usuario.pUsuario}"}) {jwt}}`};
                const response = await this.$auth.loginWith('local', {data: q});
                const REDIRECT_URI =  this.$route.query.redirect || process.env.URL_DEFAULT;
                this.$router.push(REDIRECT_URI)
                this.$store.dispatch('snackbar/setSnackbar', { color: 'teal', text: `Gracias por iniciar sesión, ${response.data.data.fullName} ` })
                this.listarMenu();
            } catch (err) {
                this.$store.commit('alert/error', `Error con el inicio de sesión.  Por favor intente de nuevo.`)
                this.$store.dispatch('snackbar/setSnackbar', { color: 'red', text: 'Hubo un error con el inicio de sesión.  Por favor intente de nuevo.' })
            }
            this.loading = false
        }
    },
    computed:{
        menu () {
            return this.$store.state.menu.listaMenu
        }
    }
}
</script>
<style>
.mi-login{
    position: fixed;
    left: 0;
    right: 0;
    width: 100vw;
    height: 100vh;
    top: 0;
    z-index: 10;
}
.oblique {
    font-style:italic;
    font-weight:bold;
    font-size:2em;
    font-family: Arial, Helvetica, sans-serif;
}
</style>