import colors from 'vuetify/es5/util/colors'
const query = {"query": `query{
  miUsuario{persId usuario cuenta alias}
  miMenu{nodes{id nombre ruta imagen nivel orden padreId}}}`};

export default {
  /*
  ** Headers of the page
  */
  mode: 'universal',
  ssr: false,
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
    middleware: ['auth'],
    prefetchLinks: false
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
    //host: '172.16.0.148' // default: localhost
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
    baseURL :process.env.URL_GRAPH
  },
  auth: {
     strategies: {
      local: {
        token: {
            property: 'data.auth.jwt',
        },
        user: {
          property: 'data',
          autoFetch: true
        },
        endpoints: {
            login:{url: '/graphql', method: 'post',propertyName: 'data.auth.jwt'},
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
        }
      }
    }
  },
  pwa: {
    meta: {
      lang:'es'
    }
  },
  manifest: {
      lang: 'es-BO',
      name: process.env.npm_package_name || '',
      short_name: process.env.npm_package_name || '',
      description:process.env.npm_package_description || '',
      background_color:'#b71c1c',
      theme_color:'#b71c1c',
      useWebmanifestExtension: false,
      start_url:'../home',
      display: 'standalone',
      orientation: 'portrait',
      scope: '/',
      gcm_sender_id: "274065036763698",
      gcm_user_visible_only: true
   },
   icon: {
      source: '~/assets/LOGO DATACOM.png',
      fileName: 'LOGO DATACOM.png',
   }, // disables the icon module
   workbox: {
       runtimeCaching: [
          {
              urlPattern: 'https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js',
              handler: 'cacheFirst',
              method: 'GET',
              strategyOptions: { cacheableResponse: { statuses: [0, 200] } }
          }
       ]
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
