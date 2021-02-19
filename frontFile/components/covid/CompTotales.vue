<template>
  <v-row no-gutters>
    <v-col>{{ prueba }}
      <v-card class="pa-1 text-center" color="deep-purple white--text">
        Reincidentes
          <v-list dense class="pa-0 ma-0 caption" style="overflow-y: auto; max-height:105px!important">
            <v-list-item v-for="(folder, index) in listReincidentes" :key="folder.sigla" :class="index % 2 === 0 ? 'grey lighten-1 pa-0 ma-0' : 'pa-0 ma-0'" style="min-height:22px!important;" >
                {{folder.casos}}
                <v-icon small>mdi-account-check</v-icon>
                {{folder.siglaEmpresa}}
                <v-avatar color="warning lighten-2" size="20">
                  {{folder.nroReindidencia}}
                </v-avatar>
            </v-list-item>
          </v-list>
      </v-card>
    </v-col>
    <v-col>
      <v-card
        class="pa-1 text-center" color="deep-orange accent-3" width="100%">
        <h2><v-icon left>mdi-hospital-building</v-icon>{{ nroConfirmados }}</h2>
        Confirmados
      </v-card>
    </v-col>
    <v-col>
      <v-card class="pa-1 text-center" color="lime accent-2" width="100%">
        <h2><v-icon left>mdi-account-check</v-icon>{{ nroActivos }}</h2>
        Activos
      </v-card>
    </v-col>
    <v-col>
      <v-card class="pa-1 text-center" color="green darken-1" dark width="100%">
        <h2><v-icon left>mdi-human-wheelchair</v-icon>{{ nroRecuperados }}</h2>
        Recuperados
      </v-card>
    </v-col>
    <v-col>
      <v-card class="pa-1 text-center" color="lime lighten-3">
        <h2>
          <v-icon left>mdi-help-circle-outline</v-icon>{{ nroSospechosos }}
        </h2>
        Sospechosos
      </v-card>
    </v-col>
    <v-col>
      <v-card class="pa-1 text-center" color="cyan darken-2">
        <h2><v-icon left>mdi-binoculars</v-icon>{{ nroProbables }}</h2>
        Probables
      </v-card>
    </v-col>
    <v-col>
      <v-card class="pa-1 text-center" color="black" dark>
        <h2>
          &nbsp;&nbsp;<v-icon left dark>mdi-christianity-outline</v-icon>{{ nroDecesos }}&nbsp;&nbsp;
        </h2>
        &nbsp;&nbsp;Decesos&nbsp;&nbsp;
      </v-card>
    </v-col>
  </v-row>
</template>
<script>
export default {
  props: {
    header: {
      type: String,
      default: "Tit.....",
    },
    datos: {
      type: Array,
      default: [],
    },
    listReincidentes:{
      type: Array,
      default: [],
    }
  },
  computed: {
    prueba() {
      this.datosComp(this.datos);
    },
  },
  created() {
    this.datosComp(this.datos);
  },
  data() {
    return {
      nroConfirmados: 0,
      nroActivos: 0,
      nroRecuperados: 0,
      nroSospechosos: 0,
      nroProbables: 0,
      nroDecesos: 0
    };
  },
  methods: {
    datosComp(param) {
      this.nroConfirmados = 0;
      this.nroActivos = 0;
      this.nroRecuperados = 0;
      this.nroSospechosos = 0;
      this.nroProbables = 0;
      this.nroDecesos = 0;
      param.map((row) => {
        this.nroConfirmados += parseInt(row.positivo);
        this.nroActivos +=
          parseInt(row.positivo) -
          parseInt(row.deceso) -
          parseInt(row.recuperado);
        this.nroRecuperados += parseInt(row.recuperado);
        this.nroSospechosos += parseInt(row.sospechoso);
        this.nroProbables += parseInt(row.probable);
        this.nroDecesos += parseInt(row.deceso);
      });
    },
  },
};
</script>