export const state = () => ({
  users: []
})

export const mutations = {
  SET_USERS (state, users) {
    state.users = users
  }
}

export const actions = {
  async loadAll ({ commit }) {
    const users = await this.$axios.get('/api/admin/users')
    commit('SET_USERS', users.data)
    return users.data
  }
}
