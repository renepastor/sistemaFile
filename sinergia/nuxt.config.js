import path from 'path'
import fs from 'fs'
import colors from 'vuetify/es5/util/colors'
const query = {"query": `query{miUsuario{mail:username id alias}}`};

export default {
  // Target: https://go.nuxtjs.dev/config-target
  target: 'server',

  // Global page headers: https://go.nuxtjs.dev/config-head
  head: {
    titleTemplate: '%s - argos-front',
    title: 'argos-front',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: '' },
      { name: 'format-detection', content: 'telephone=no' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
    ]
  },

  router: {
    middleware: ['auth']
  },
  // Global CSS: https://go.nuxtjs.dev/config-css
  css: [
  ],

  publicRuntimeConfig: {
    baseURL: process.env.BASE_URL,
    apiKEY: process.env.API_KEY
  },
  privateRuntimeConfig: {
    apiSecret: process.env.API_SECRET
  },

  loading: {
    color: 'DodgerBlue',
    height: '10px',
    continuous: true,
    duration: 3000
  },

  // Plugins to run before rendering page: https://go.nuxtjs.dev/config-plugins
  plugins: [
  ],
  
  server: {
    port: 3000, // default: 3000
    host: 'localhost', //'proyectfin.xyz', //'45.79.7.33', // default: localhost
    /*https: {
      key: fs.readFileSync(path.resolve(__dirname, 'server.key')),
      cert: fs.readFileSync(path.resolve(__dirname, 'server.crt'))
    },*/
    //timing: false
  },

  serverMiddleware: [
    { path: "/api", handler: "~/server/admin.js" },
  ],

  // Auto import components: https://go.nuxtjs.dev/config-components
  components: true,

  // Modules for dev and build (recommended): https://go.nuxtjs.dev/config-modules
  buildModules: [
    // https://go.nuxtjs.dev/vuetify
    '@nuxtjs/vuetify',
  ],

  // Modules: https://go.nuxtjs.dev/config-modules
  modules: [
    // https://go.nuxtjs.dev/axios
    '@nuxtjs/axios',
    // https://go.nuxtjs.dev/pwa
    '@nuxtjs/pwa',
    '@nuxtjs/auth-next',
    '@nuxtjs/dotenv',
    '@nuxtjs/moment'
  ],

  // Axios module configuration: https://go.nuxtjs.dev/config-axios
  axios: {
    baseURL :process.env.URL_API
  },
  auth: {
     strategies: {
      local: {
        token: {
            property: 'data.auth.jwt',
        },
        user: {
          property: 'data.miUsuario',
          autoFetch: true
        },
        endpoints: {
            login:{url: '/graphql', method: 'post',propertyName: 'data.auth.jwt'},
            logout: false,
            user:{ url: '/graphql', method: 'post', data:query, propertyName: 'data.miUsuario' }
        },
        tokenType: 'Bearer',
        maxAge:100,
        //, autoFetchUser:false // para no llamas a "user"
      }
    }
  },

  // PWA module configuration: https://go.nuxtjs.dev/pwa

  pwa: {
    meta: {
      lang:'es'
    },
    manifest: {
      lang: 'es',
      name: process.env.npm_package_name || '',
      short_name: process.env.npm_package_name || '',
      description:process.env.npm_package_description || '',
      background_color:'blue',
      theme_color:'blue',
      useWebmanifestExtension: false,
      start_url:'../'
    },
    icon: {
      source: '~/assets/logo.png',
      fileName: 'logo.png',
    }, // disables the icon module
    /*workbox: {
      workboxVersion: process.env.VERSION,
      offline:true,
      runtimeCaching: [
        {
          urlPattern: 'https://proyectfin.xyz/.*',
        }
      ]
    }*/
  },

  // Vuetify module configuration: https://go.nuxtjs.dev/config-vuetify
  vuetify: {
    customVariables: ['~/assets/variables.scss'],
    theme: {
      dark: false,
      argos: true,
      themes: {
        dark: {
          primary: colors.blue.darken2,
          accent: colors.grey.darken3,
          secondary: colors.amber.darken3,
          info: colors.teal.lighten1,
          warning: colors.amber.base,
          error: colors.deepOrange.accent4,
          success: colors.green.accent3,
          over: colors.grey.darken3,
          btnew: colors.yellow.accent4,
          btedit: colors.green.accent1,
          btdelet: colors.red.accent4
        },
        argos: {
          primary: colors.blueGrey.lighten4,
          accent: colors.grey.darken3,
          secondary: colors.amber.darken3,
          info: colors.teal.lighten1,
          warning: colors.amber.base,
          error: colors.deepOrange.accent4,
          success: colors.green.accent3,
          over: colors.grey.darken3,
          btnew: colors.yellow.accent4,
          btedit: colors.grey.darken2,
          btdelet: colors.red.accent4
        }
      }
    }
  },

  // Build Configuration: https://go.nuxtjs.dev/config-build
  build: {
     transpile: [
      'vee-validate'
    ]
  }
}
