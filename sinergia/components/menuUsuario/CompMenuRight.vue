<template>
    <v-navigation-drawer
        v-model="rightDrawer"
        :right="right"
        rightDrawer
        temporary
        fixed>
        {{rightDrawer}}
        <!-- v-list>
            <v-list-item @click.native="right = !right">
                <v-list-item-action>
                  <v-icon light>
                    mdi-repeat
                  </v-icon>
                </v-list-item-action>
                <v-list-item-title>Switch drawer (click me)</v-list-item-title>
            </v-list-item>
        </v-list-->
    </v-navigation-drawer>
</template>
<script>
  export default {
      props:{
          rightDrawer:{
              type: Boolean,
              default:false
          }
      },
      data(){
        return {
          //fixed: false,
          //rightDrawer:false
          right:true
        }
      }
  }
</script>
