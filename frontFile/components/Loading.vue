<template lang="html">
    <div>
        <v-dialog v-model:loading="loading" max-width="290" v-if="loading">
            <v-card color="grey" dark>
                <v-card-text>
                    Cargando...
                    <v-progress-linear indeterminate color="white" class="mb-0">
                    </v-progress-linear>
                </v-card-text>
            </v-card>
        </v-dialog>
        <div v-else>
          <slot/>
        </div>
    </div>
</template>

<script>
  export default {
    props:{
        loading:{
          type:Boolean,
          default:true
        }
    }
  }
</script>