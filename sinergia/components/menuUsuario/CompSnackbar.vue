<template>
  <div>
    
    <v-snackbar
      v-for="(snackbar, index) in snackbars.filter(s => s.showing)"
      :key="snackbar.text + Math.random()"
      v-model="snackbar.showing"
      content-class="pb-0 pt-0 mb-0 mt-0"
      elevation=24
      
      icon="$mdiAccount"
      dismissible
      top
      right
      border="right"
      colored-border
      type="warning"
      max-width='6px'
      :timeout="snackbar.timeout||6000"
      :color="snackbar.color"
      :style="`top: ${(index * 50) + 8}px !important`"
    >
        <v-icon >mdi-account-circle</v-icon>
        {{ snackbar.text }}
        <v-icon @click="snackbar.showing = false">mdi-close-circle</v-icon>
    </v-snackbar>
  </div>
</template>

<script>
import { mapState } from 'vuex'

export default {
  computed: {
    ...mapState({
      snackbars: state => state.snackbar.snackbars
    })
  }
}
</script>
