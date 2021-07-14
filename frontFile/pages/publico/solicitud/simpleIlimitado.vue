<template>
    <div class="pa-2">
        <v-card>
            <div class="pa-2 headline grey lighten-2  text-center">
                <h5>Simple Ilimitado</h5>
            </div>
                <v-container>
                    
                    <form>
                        <v-row no-gutters>
                            <v-col>
                                <v-select :items="items" v-model="simpleIlimitado.plan_id" label="Plan"></v-select>
                            </v-col>
                            <v-col>
                                <v-btn outlined color="indigo">Nro. Favorito</v-btn>            
                            </v-col>
                        </v-row>
                        <v-row no-gutters>
                            <v-col>
                                <v-text-field label="ci" :rules="rules" v-model="simpleIlimitado.ci" hide-details="auto"></v-text-field>
                            </v-col>
                            <v-col>
                                <v-select :items="items" label="Pais"></v-select>
                            </v-col>
                        </v-row>
                        <v-col>
                            <v-text-field label="Nombres" :rules="nombres" hide-details="auto"></v-text-field>
                        </v-col>
                        <v-col>
                            <v-text-field label="Apellidos" :rules="apellidos" hide-details="auto"></v-text-field>
                        </v-col>
                        <v-col>
                            <v-select :items="items" label="Ciudad"></v-select>
                        </v-col>
                        <v-col>
                            <v-menu
                                v-model="menu2"
                                :close-on-content-click="false"
                                :nudge-right="40"
                                transition="scale-transition"
                                offset-y
                                min-width="auto"
                            >
                                <template v-slot:activator="{ on, attrs }">
                                <v-text-field
                                    v-model="date"
                                    label="Picker without buttons"
                                    prepend-icon="mdi-calendar"
                                    readonly
                                    v-bind="attrs"
                                    v-on="on"
                                ></v-text-field>
                                </template>
                                <v-date-picker
                                v-model="date"
                                @input="menu2 = false"
                                ></v-date-picker>
                            </v-menu>
                        </v-col>
                        <v-col>
                            <v-text-field label="Direccion" :rules="direccion" hide-details="auto"></v-text-field>
                        </v-col>
                        <v-col>
                            <v-row>
                                <v-checkbox v-model="checkbox"></v-checkbox>
                                <v-text-field label="Numero de Celular" :rules="rules" hide-details="auto"></v-text-field>
                            </v-row>
                            
                        </v-col>
                        <v-col>
                            <v-file-input
                                :rules="rules"
                                accept="image/png, image/jpeg, image/bmp"
                                placeholder="Pick an avatar"
                                prepend-icon="mdi-camera"
                                label="Avatar"
                            ></v-file-input>
                        </v-col>
                        <v-col>
                            <v-file-input
                                :rules="rules"
                                accept="image/png, image/jpeg, image/bmp"
                                placeholder="Pick an avatar"
                                prepend-icon="mdi-camera"
                                label="Avatar"
                            ></v-file-input>
                        </v-col>
                        <v-col>
                            <v-row>
                                <v-checkbox v-model="checkbox"></v-checkbox>
                                <v-file-input
                                    :rules="rules"
                                    accept="image/png, image/jpeg, image/bmp"
                                    placeholder="Pick an avatar"
                                    prepend-icon="mdi-camera"
                                    label="Avatar"
                                ></v-file-input>
                            </v-row>
                            
                        </v-col>
                    </form>

                </v-container>

            <v-divider></v-divider>
            <div class="text-center pa-2">
                <nuxt-link to="/publico/categoriaServ">
                    <v-btn outlined color="indigo">SERVICIOS</v-btn>
                </nuxt-link>
            </div>
        </v-card>
    </div>
</template>
<script>
    
    
export default {
    data: () => ({
        date: (new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString().substr(0, 10),
        menu2: false,
        simpleIlimitado:{},
        checkbox: true,
        rules: [
            value => !!value || 'Required.',
            value => (value && value.length >= 3) || 'Min 3 characters',
        ],
    }),
    auth: false,
    prefetchLinks: false,
    computed: {
    }
}
  
  
</script>