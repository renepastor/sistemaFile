export const strict = false

export const state = () => ({
    listaMenu:[
        {
            listaModulos:[],
            listaRecursos:[],
            usuario:{}
        }
    ],
    filtro:{}
})

export const mutations = {
    /**
     * Listando menu de accesos del usuario logueado
     */
    async listaMenu(state, text) {
        const idAplicacion = 3;
        const q = {query: `{miUsuario{username alias}
                            miMenu(arg0: "${idAplicacion}") {
                                nodes {
                                    recurso
                                    uri
                                    posicionRecurso
                                    posicionModulo
                                    modulo
                                    modificacion
                                    lectura
                                    idAplicacion
                                    iconoRecurso
                                    eliminacion
                                    iconoModulo
                                    esMenu
                                    creacion
                                }}}`};
        const resMenu = await this.$axios.$post(`/graphql`, q)
        
        if(resMenu.errors){
            state.listaMenu = {
                listaModulos:[],
                listaRecursos:[],
                usuario:{},
            }
            return false;
        }
        const listaMenu = resMenu.data.miMenu.nodes;
        const listaModulos = [];
        listaMenu.forEach(categoria => {
            if (!listaModulos.find(cat => cat.modulo == categoria.modulo && cat.iconoModulo == categoria.iconoModulo)) {
                const {modulo, iconoModulo} = categoria;
                listaModulos.push({ modulo, iconoModulo });
            }
        });
        console.log(listaModulos)
        state.listaMenu = {
            listaModulos:listaModulos,
            listaRecursos:listaMenu,
            usuario:resMenu.data.miUsuario,
        }


/*        if (listaMenu.code<400){
            state.listaMenu = {}
                listaModulos:listaMenu.data.listaModulos,
                listaRecursos:listaMenu.data.listaRecursos,
                usuario:listaMenu.data.usuario[0],
                code:listaMenu.code,
                message:listaMenu.message
            };*/
/*        }else{
            state.listaMenu = {
                listaModulos:[],
                listaRecursos:[],
                usuario:{},
                code:listaMenu.code,
                message:listaMenu.message
            };
        }*/
    },
    async permisos(state, obj) {
        const newUri = ((obj.uri).indexOf("/")==0)? (obj.uri).substring(1, (obj.uri).length): obj.uri;
        const uriRecurso = newUri.split("?")[0]
        const listaMenu = await this.$axios.$get('/listaMenu')
        try{
            const permiso = listaMenu.data.listaRecursos.find(row=>(row.uri==uriRecurso))
            state.filtro = permiso||{};
        }catch (error){
            console.log("Error encontrar acceso al menu", uriRecurso)
        }
    }
}
