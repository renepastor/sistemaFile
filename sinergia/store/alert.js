export const strict = false

export const state = () => ({
    alert:[]
})

export const mutations = {
    /**
     * Listando Tipo Cambio
     */
    ok(state, msj) {
        state.alert.push({
            mensaje:msj,
            done: false,
            id: Date.now(),
            type: "success"
        })
    },
    info(state, msj) {
        state.alert.push({
            mensaje:msj,
            done: false,
            id: Date.now(),
            type: "info"
        })
    },
    error(state, msj) {
        state.alert.push({
            mensaje:msj,
            done: false,
            id: Date.now(),
            type: "warning"
        })
    },
    remove (state, todo) {
        state.alert = state.alert.filter(item => item.id !== todo.id)
    }
}
