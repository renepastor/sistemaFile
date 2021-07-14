export const strict = false

export const state = () => ({
  isLoaded: false,
  loading: false
})

export const mutations = {
  FINISH_LOADING (state) {
    state.isLoaded = true
    state.loading = true
  }
}
