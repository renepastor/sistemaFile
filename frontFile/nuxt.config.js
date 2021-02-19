import colors from 'vuetify/es5/util/colors'
const query = {"query": `query{miUsuario{mail:cuenta persId fullName:alias}
                                roleById(id: "1011100000000011") {
                                  menuesByRolId {nodes {
                                    enlaceByEnlaId {nombre nivel ruta imagen
                                      enlacesByPadreId(condition: {nivel: 2} orderBy: ORDEN_ASC) {nodes {
                                        menuesByEnlaId(condition: {rolId: "1011100000000011"}) {
                                          nodes {enlaceByEnlaId {nombre nivel ruta imagen
                                  }}}}}}}}}
                                }`};

export default {
  /*
  ** Headers of the page
  */
  head: {
    titleTemplate: '%s - ' + process.env.npm_package_name,
    title: process.env.npm_package_name || '',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: process.env.npm_package_description || '' }
    ],
    link: [
      {
        rel: 'stylesheet',
        href: 'https://fonts.googleapis.com/css?family=Muli:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i'
      },
      {
        rel: 'stylesheet',
        href: 'https://api.mapbox.com/mapbox-gl-js/v2.0.0/mapbox-gl.css'
      },
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
    ]
  },
  router: {
    middleware: ['auth']
  },
  /*
  ** Customize the progress-bar color
  */
  loading: { color: '#FF6F00', height: '3px', failedColor: 'red' },
  /*
  ** Global CSS
  */
  css: [
  ],
  publicRuntimeConfig: {
    baseURL: process.env.BASE_URL,
    apiKEY: process.env.API_KEY
  },
  privateRuntimeConfig: {
    apiSecret: process.env.API_SECRET
  },
  /*
  ** Plugins to load before mounting the App
  */
  plugins: [
    '@/plugins/axios',
    { src: '~/plugins/mapboxgl', mode: 'client' },
    { src: '~/plugins/vuefullscreen', mode: 'client' },
    
  ],
  server: {
    port: 8080, // default: 3000
    //host: '45.79.7.33' // default: localhost
  },
  /*
  ** Nuxt.js dev-modules
  */
  buildModules: [
    '@nuxtjs/vuetify',
  ],
  /*
  ** Nuxt.js modules
  */
  modules: [
    // Doc: https://axios.nuxtjs.org/usage
    '@nuxtjs/axios',
    '@nuxtjs/pwa',
    '@nuxtjs/auth-next',
    '@nuxtjs/dotenv',
  ],
  /*
  ** Axios module configuration
  ** See https://axios.nuxtjs.org/options
  */
  axios: {
    baseURL :process.env.COVID_URL
  },
  auth: {
     strategies: {
      local: {
        token: {
            property: 'data.jwt',
        },
        user: {
          property: 'data',
          autoFetch: true
        },
        endpoints: {
            login:{url: '/src/login',method: 'post',propertyName: 'data.jwt'},
            logout: false,
            user:{ url: '/graphql', method: 'post', data:query, propertyName: 'data' }
        },
        tokenType: 'Bearer',
        maxAge:100,
        //, autoFetchUser:false // para no llamas a "user"
      }
    }
  },
  /*
  ** vuetify module configuration
  ** https://github.com/nuxt-community/vuetify-module
  */
  vuetify: {
    customVariables: ['~/assets/variables.scss', '@/assets/style.css'],
    theme: {
      dark: false,
      themes: {
        dark: {
          primary: colors.blue.darken2,
          accent: colors.grey.darken3,
          secondary: colors.amber.darken3,
          info: colors.teal.lighten1,
          warning: colors.amber.base,
          error: colors.deepOrange.accent4,
          success: colors.green.accent3
        },
        ypfb: {
        }
      }
    }
  },
  pwa: {
    meta: {
      lang:'es'
    },
    manifest: {
      lang: 'es',
      name: process.env.npm_package_name || '',
      short_name: process.env.npm_package_name || '',
      description:process.env.npm_package_description || '',
      background_color:'red',
      theme_color:'red',
      useWebmanifestExtension: false,
      start_url:'../home'
    },
    icon: {
      source: '~/assets/ypfbApp.png',
      fileName: 'ypfbApp.png',
    }, // disables the icon module
    workbox: {
      workboxVersion: process.env.VERSION,
      offline:true,
      runtimeCaching: [
        {
          urlPattern: 'https://testmovil.ypfb.gob.bo/.*',
        }
      ]
    }
  },
  /*
  ** Build configuration
  */
  build: {
    /*
    ** You can extend webpack config here
    */
    extend (config, ctx) {
    }
  }
}
