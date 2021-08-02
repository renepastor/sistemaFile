export const strict = false

export const state = () => ({
    lista:[]
})

export const mutations = {
    /**
     * Listando Tipo Cambio
     */
    async lista(state, url) {
        try{
            const lista = await this.$axios.$get(`${url}`)
            state.lista = lista.data;
        }catch(error){
            /*state.lista = [{
                code:404,
                message:`Recurso no encontrato: api = ${url}`,
                success: true
            }]*/
            this.$router.push("/error")
        }
        
    }
}
