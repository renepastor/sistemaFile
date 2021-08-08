<template>
    <v-app dark argos>
        <v-navigation-drawer
          v-model="drawer"
          :mini-variant="miniVariant"
          :clipped="clipped"
          fixed
          app
        >
            <v-list>
                <comp-menu-left />
            </v-list>
        </v-navigation-drawer>
        <v-app-bar
          :clipped-left="clipped"
          fixed
          app
        >
            <v-app-bar-nav-icon @click.stop="drawer = !drawer" />
            <v-btn
              icon
              @click.stop="miniVariant = !miniVariant"
            >
              <v-icon>mdi-{{ `chevron-${miniVariant ? 'right' : 'left'}` }}</v-icon>
            </v-btn>
            <v-btn
              icon
              @click.stop="clipped = !clipped"
            >
              <v-icon>mdi-application</v-icon>
            </v-btn>
            <v-btn
              icon
              @click.stop="fixed = !fixed"
            >
              <v-icon>mdi-minus</v-icon>
            </v-btn>
            <v-toolbar-title v-text="title" />
            <v-spacer />
            <v-btn
              icon
              @click.stop="rightDrawer = !rightDrawer"
            >
              <v-icon>mdi-menu</v-icon>
            </v-btn>
        </v-app-bar>
        <v-main>
            <div class="px-4 py-2">
                <v-sheet class="radius pa-2" elevation="2">
                    <comp-alert></comp-alert>
                    <Nuxt />
                </v-sheet>
            </div>
        </v-main>
        <v-navigation-drawer
          v-model="rightDrawer"
          :right="right"
          temporary
          fixed
        >
          <v-list>
            <v-list-item @click.native="right = !right">
              <v-list-item-action>
                <v-icon light>
                  mdi-repeat
                </v-icon>
              </v-list-item-action>
              <v-list-item-title>Switch drawer (click me)</v-list-item-title>
            </v-list-item>
          </v-list>
        </v-navigation-drawer>
        <v-footer
          :absolute="!fixed"
          app
        >
          <span>&copy; {{ new Date().getFullYear() }}</span>
        </v-footer>
    </v-app>
</template>

<script>
import compMenuLeft from '@/components/menuUsuario/CompMenuLeft'
import compSnackbar from '@/components/menuUsuario/CompSnackbar'
import compLoading from '@/components/Loading'
import compAlert from '@/components/Alert'


export default {
  components:{
    'comp-menu-left': compMenuLeft,
    'comp-snackbar':compSnackbar,
    'comp-loading':compLoading,
    'comp-alert':compAlert
  },
  data () {
    return {
      clipped: false,
      drawer: false,
      fixed: false,
      miniVariant: false,
      right: true,
      rightDrawer: false,
      title: 'DATACOM'
    }
  }
}
</script>
<style>
.lista thead tr th{
    background: #e7e7e7 !important;
    color: #000;
    font-weight: bold;
    text-transform: uppercase;
}
.over{
    background: #f2f2f2 !important;
    border: 3px solid #000 !important;
}
.full{
    position: absolute;
    background: #f2f2f2 !important;
    right: 0;
    width: 100vw;
    height: 100vh;
    z-index: 10;
    top: -60px;
}
</style>