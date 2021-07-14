export const state = () => ({
  permisos: []
})
/*
export const mutations = {
  SET_PERMISOS (state, permisos) {
    console.log("state..##..", permisos)
    state.permisos = permisos
  }
}

export const actions = {
  setPermisos ({ commit }, permisos) {
    console.log("state..##..", permisos)
    commit('SET_PERMISOS', permisos)
    return permisos
  }
}
*/
export const mutations = {
  add(state, text) {
    state.permisos.push({
      text,
      done: false
    });
  },
  remove(state, { permiso }) {
    state.permisos.splice(state.list.indexOf(permiso), 1)
  },
  toggle(state, permiso) {
    permiso.done = !permiso.done
  }
}