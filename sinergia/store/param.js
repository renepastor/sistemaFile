export const strict = false

export const state = () => ({
    param:{}
})

export const mutations = {
    /**
     * Listando menu de accesos del usuario logueado
     */
    async fnParam(state, data) {
        console.log("param-------",data)
        state.param = data;
    }
}