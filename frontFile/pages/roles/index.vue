<template>
  <div class="pa-2">
      <div>
            <h3 class="title">{{title}}</h3>
            <comp-create></comp-create>
      </div>
      <v-card elevation="4">
          <v-simple-table
            fixed-header
            height="500px">
            <thead class="css-list">
                <tr>
                    <th class="text-left">
                        Nombre
                    </th>
                    <th class="text-left">
                        Icono
                    </th>
                    <th class="text-left">
                        Orden
                    </th>
                    <th class="text-left">
                        Descripcion
                    </th>
                    <th class="text-center"></th>
                </tr>
            </thead>
            <tbody>
                <tr
                    v-for="item in desserts"
                    :key="item.id">
                    <td>{{ item.nombre }}</td>
                    <td>{{ item.icono }}</td>
                    <td>{{ item.orden }}</td>
                    <td>{{ item.descripcion }}</td>
                    <td>
                        <nuxt-link to="roles">
                            <v-tooltip top>
                                <template v-slot:activator="{ on, attrs }">
                                    <v-btn icon  color="yellow accent-4" dark v-bind="attrs" v-on="on">
                                        <v-icon color="brown darken-4">mdi-view-list-outline</v-icon>
                                    </v-btn>
                                </template>
                                <span>Ver detalle</span>
                            </v-tooltip>
                        </nuxt-link>
                        <comp-edit :param="item.id"></comp-edit>
                        <nuxt-link to="roles">
                            <v-btn icon  color="red">
                                <v-icon>mdi-delete-forever</v-icon>
                            </v-btn>
                        </nuxt-link>
                    </td>
                </tr>
            </tbody>
            
            </v-simple-table>
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
    middleware: 'auth',
    data () {
        return {
            title:'Modulo',
            desserts: [],
            param:0
        }
    }/*,
    async asyncData({$axios}) {
        const datos = await $axios.$get(`${process.env.BASE_URL}/modulos`,{headers: {'Ypfb-App-Access-Token' : process.env.API_KEY}})
        console.log(datos)
        try {
            return {desserts:datos.data};
        } catch (error) {
            console.log('Error', error)
        }
    }*/
}
</script>