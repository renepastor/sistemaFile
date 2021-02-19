<template>
  <div>
    <div v-if="loading">
      <v-progress-circular
        size="large"
        color="indigo"
        class="mt-4"
        indeterminate
      />
    </div>
    <div v-else>
      <slot />
    </div>
  </div>
</template>

<script>
export default {
  props: {
    loading: {
      type: Boolean,
      default: false
    }
  }
}
</script>
