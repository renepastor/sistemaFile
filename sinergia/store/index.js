export const strict = false

export const state = () => ({
  isLoaded: false,
  loading: false,
  lista:[{nombre:"nom1", edad:233}]
})

export const mutations = {
  FINISH_LOADING (state) {
    state.isLoaded = true
    state.loading = true
  }
}
