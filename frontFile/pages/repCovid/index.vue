<template>
    <v-container fluid>
        <comp-loading :loading="loading">
            <h3>
                <v-btn class="mx-2" @click="funcion" fab dark x-small color="primary">
                    <v-icon>mdi-cached</v-icon>
                </v-btn>
                (YPFB) REPORTE COVID {{nombreReporte}}
            <v-divider></v-divider>
            </h3>
            <v-row no-gutters>
                <v-col cols sm="12" md="12" lg="1">
                    <comp-totales v-bind:datos.sync="listTotales" @select-area-total="funcion" :listReincidentes="reincidentes"/>
                </v-col>
                <v-col cols sm="12" md="12" lg="2">
                    <v-card class="pa-2 pnlEmp" outlined >
                        <v-btn class="ampliar" icon small @click="openFull('pnlEmp')" color="darck"><v-icon>mdi-arrow-expand-all</v-icon></v-btn>
                        <comp-bar header=" por Empresa" :colorBar="colorBar" :datos="covidXEmpresas" @select-area-bar="funcion"/>
                        <div width="100%" class="text-center">
                            <v-icon @click="cambiaEstadoEmpresa('ant')" class="back my-0 mr-4 py-0">mdi-arrow-left-thick</v-icon>
                            <b>{{estado}}</b>
                            <v-icon @click="cambiaEstadoEmpresa('sig')" class="next my-0 ml-4 py-0">mdi-arrow-right-thick</v-icon>
                        </div>
                    </v-card>
                </v-col>
                <v-col cols sm="12" md="12" lg="2">
                    <v-card class="pa-2 pnlOfi" outlined>
                        <v-btn class="ampliar" icon small @click="openFull('pnlOfi')" color="darck"><v-icon>mdi-arrow-expand-all</v-icon></v-btn>
                        <comp-line-stack header="Confirmados por Área de Operación" v-bind:datos="covidXArea"/>
                    </v-card>
                </v-col>
                <v-col cols sm="12" md="12" lg="4">
                    <v-card class="pa-0" outlined>
                        <comp-mapa v-bind:datos="puntos"/>
                    </v-card>
                </v-col>
                <v-col cols sm="12" md="12" lg="3">
                    <v-card class="pa-1 pnlDep" outlined>
                        <v-btn class="ampliar" icon small @click="openFull('pnlDep')" color="darck"><v-icon>mdi-arrow-expand-all</v-icon></v-btn>
                        <comp-pie header="Total Confirmados por Departamento" v-bind:datos="departamentos" @select-area-pie="funcion"/>
                    </v-card>
                    <v-card class="pa-1 pnlPro" outlined>
                        <v-btn class="ampliar" icon small @click="openFull('pnlPro')" color="darck"><v-icon>mdi-arrow-expand-all</v-icon></v-btn>
                        <comp-pie header="Total Confirmados por Municipio" v-bind:datos="municipios" @select-area-pie="funcion"/>
                    </v-card>
                </v-col>
            </v-row>
            <v-row no-gutters>
                <v-col cols sm="12" md="12" lg="6">
                    <v-card class="pa-2 pnlDia" outlined>
                        <v-btn class="ampliar" icon small @click="openFull('pnlDia')" color="darck"><v-icon>mdi-arrow-expand-all</v-icon></v-btn>
                        <comp-line-area header="Reporte Diario" v-bind:datos="datosFiltro" :parametros="variableDiario"  @select-area-bar="funcion"/>
                    </v-card>
                </v-col>
                <v-col cols sm="12" md="12" lg="6">
                    <v-card class="pa-2 pnlHis" outlined>
                        <v-btn class="ampliar" icon small @click="openFull('pnlHis')" color="darck"><v-icon>mdi-arrow-expand-all</v-icon></v-btn>
                        <comp-line-area header="Reporte Acumulado" v-bind:datos="datosHistoricos" :parametros="variableAcumilado"/>
                    </v-card>
                </v-col>
            </v-row>
        </comp-loading>
    </v-container>
</template>


<script>

import compPie from '@/components/charts/CompPie'
import compBar from '@/components/charts/CompBar'
import compPolar from '@/components/charts/CompPolar'
import compMapa from '@/components/map/CompMapa'
import compLineStack from '@/components/charts/CompLineStack'
import compLineArea from '@/components/charts/CompLineArea'
import compTotales from '@/components/covid/CompTotales'
import compLoading from '@/components/Loading'
import axios from 'axios'


export default {
    components: {
        'comp-loading':compLoading,
        'comp-pie': compPie,
        'comp-bar': compBar,
        'comp-polar':compPolar,
        'comp-mapa':compMapa,
        'comp-line-stack':compLineStack,
        'comp-line-area':compLineArea,
        'comp-totales': compTotales
    },
    middleware: ['auth'],
    data(){
        //this.$nuxt.$loading.start() 
        return{
            loading:true,
            pg:0,
            colorBar:"['#B71C1C', 'Confirmados']",
            estado:'',
            nombreReporte:'NACIONAL',
            dialog:false,
            datosDB:[],
            datosFiltro:[],
            datosHistoricos:[],
            prueba:"",
            municipios:[],
            departamentos:[],
            puntos:[],
            covidXEmpresas:[],
            datoCovid:[],
            listTotales:[],
            covidXArea:[],
            variableDiario:[
                {type:'bar',name:'Confirmados', id:'confirmados',data:[], color:'#B71C1C'},
                {type:'bar',name:'Activos', id:'activos',data:[], color:'#FFD600'},
                {type:'bar',name:'Recuperados', id:'recuperado',data:[], color:'#00E676'},
                {type:'bar',name:'Sospechosos', id:'sospechoso',data:[], color:'#FFA726'},
                {type:'bar',name:'Probables', id:'probable',data:[], color:'#795548'},
                {type:'bar',name:'Decesos', id:'deceso',data:[], color:'#000000'}
            ],
            variableAcumilado:[
                {type:'bar',name:'Activos', id:'activos',data:[], color:'#FFD600'},
                {type:'line',name:'Confirmados', id:'confirmados',data:[], color:'#B71C1C'},
                {type:'line',name:'Recuperados', id:'recuperados',data:[], color:'#00E676'},
                {type:'bar',name:'Sospechosos', id:'sospechosos',data:[], color:'#FFA726'},
                {type:'bar',name:'Probables', id:'probables',data:[], color:'#795548'},
                {type:'bar',name:'Decesos', id:'decesos',data:[], color:'#000000'}
            ],
            reincidentes:[],
            listaResumen:[]
        }
    },
    async asyncData() {
        const query = `{allVwHistoricoCovids{nodes{
                    idHistorico
                    confirmados
                    activos
                    probables
                    positivos
                    descartados
                    recuperados
                    sospechosos
                    fechaRegistro
                    decesos
                }}
                allVwResumenCovids:allVwResumenCovid2S{nodes{
                    siglaUnidad
                    positivo
                    probable
                    sospechoso
                    recuperado
                    deceso
                    confirmados
                    activos
                    descartado
                    departamento
                    municipio
                    latitud
                    longitud
                    siglaEmpresa
                    empresa
                    fechaRegistro
                    areaOperacion
                }}
                allVwReincidentes{nodes{
                  nroReindidencia, siglaEmpresa, casos
                }}
            }`;
        var paramQuery = {"query":query};


        try {
            const datosDB = await axios.post(`${process.env.COVID_URL}/graphql`, paramQuery);
            const datosFiltroDB = datosDB.data.data.allVwResumenCovids.nodes;
            const reincidentesDB = datosDB.data.data.allVwReincidentes.nodes;
            const datosHistoricosDB = datosDB.data.data.allVwHistoricoCovids.nodes;
            return{
                datosFiltro: datosFiltroDB,
                reincidentes: reincidentesDB
            }
        } catch (error) {
            console.log("error al cargar los datos de api covid")
            return{
                datosFiltro: [],
                reincidentes: []
            }
        }
    },
    async created(){
        this.funcion({});
        this.datosHistoricos = await this.historialFiltro('%');
    },
    methods:{
        async funcion(param, filtro = 'siglaEmpresa', estado='confirmados'){
            //this.loading = true;
            if(filtro == 'siglaEmpresa' && param.name != undefined){
                this.datosFiltro = this.datosFiltro.filter(r=>r[filtro] == param.name)
                this.datosHistoricos = [];
                this.datosHistoricos = await this.historialFiltro(param.name);
            }else{
                if(!this.listaResumen.length)
                    this.listaResumen = this.datosFiltro;
                this.datosFiltro = this.listaResumen;
                this.datosHistoricos = await this.historialFiltro('%');
            }
            
            var groupBy = function (miarray, prop) {
                return miarray.reduce(function(groups, item) {
                var val = item[prop];
                groups[val] = groups[val] || {name: item.name, value: 0};
                groups[val].value += item.value;
                return groups;
                }, {});
            }
            var datoCovid = [];
            if(param.name== undefined){
                datoCovid = this.datosFiltro;
                this.nombreReporte = "NACIONAL"
            }else{
                datoCovid = this.datosFiltro.filter(row=>row[filtro] == param.name);
                this.nombreReporte = datoCovid[0]?datoCovid[0][filtro]:"No existe";
            }
            //console.log("#####", JSON.stringify(this.datosFiltro.filter(row => row['siglaEmpresa'] == 'SHELL'), 0, 2))
            
            //const datoCovid = this.datosFiltro;
            const depart = [];
            const munici = [];
            const empresas = [];
            const listPoin = [];
            const listTotales = [];
            
            var area = [];
            const bar = this.variableDiario.find(r=>(r.id==estado));
            this.colorBar = `['${bar.color}', '${bar.name}']`
            this.estado = estado.toUpperCase();

            datoCovid.map(row => {
                var newRow = {name:row.departamento, value:(parseInt(row.confirmados))}
                depart.push(newRow)
                var newRow = {name:row.municipio, value:(parseInt(row.confirmados))}
                munici.push(newRow)
                var newRow = {name:row.siglaEmpresa, value:(parseInt(row[estado]))}
                empresas.push(newRow)
                var newRow = {name:row.siglaUnidad, value:(parseInt(row.confirmados))}
                area.push(newRow)
                

                listPoin.push({
                    "type": "Feature",
                    "properties": {
                        "id": row.fechaRegistro,
                        "mag": 2.3,
                        "time": 1507425650893,
                        "felt": null,
                        "tsunami": 0
                    },
                    "geometry": {
                        "type": "Point",
                        "coordinates": [row.longitud*1, row.latitud*1, 5.56 ]
                    }
                })
            });

            this.departamentos= Object.values(groupBy(depart,'name'));
            this.municipios= Object.values(groupBy(munici,'name'));
            this.puntos= listPoin;
            this.covidXArea = Object.values(groupBy(area,'name'));;
            this.covidXEmpresas=  Object.values(groupBy(empresas,'name'));
            this.listTotales= datoCovid;
            this.loading =  false
        },
        openFull (pnl) {
            this.$fullscreen.toggle(this.$el.querySelector(`.${pnl}`), {
                wrap: false,
                callback: this.fullscreenChange
            })
        },
        fullscreenChange (fullscreen) {
            this.fullscreen = fullscreen
        },
        cambiaEstadoEmpresa(tipo='sig'){
            this.pg = this.pg >= (this.variableDiario.length-1) ? -1 : this.pg;
            if(tipo=='ant'){
                this.pg = this.pg<=0 ? (this.variableDiario.length-1) : this.pg;
                this.pg = this.pg-1;
                this.pg = this.pg<=0 ? (this.variableDiario.length-1) : this.pg;
            }else
                this.pg = this.pg+1;
            const rowSelect = this.variableDiario[this.pg];
            this.funcion({}, 'siglaEmpresa', rowSelect.id)
        },
        async historialFiltro(siglaEmpresa='%'){
            this.loading = true;
            const query = `mutation{fnHistoricoCovid(input:{arg0:"${siglaEmpresa}"}){historialCovids{
                idHistorico
                confirmados
                activos
                probables
                positivos
                descartados
                recuperados
                sospechosos
                fechaRegistro
                decesos
            }}}`;
            var paramQuery = {"query":query};
            try {
                const datosDB = await axios.post(`${process.env.COVID_URL}/graphql`, paramQuery);
                const datosHistoricosDB = datosDB.data.data.fnHistoricoCovid.historialCovids;
                return datosHistoricosDB
            } catch (error) {
                console.log("error al cargar los datos de api covid")
                return []
            }
        } 
    }
}
</script>
<style scoped>
.ampliar{
    position:absolute;
    z-index: 2;
    top:-5px;
    right:-5px;
    opacity: 0.3;
}
.ampliar:hover, .back:hover, .next:hover{
    opacity: 1;
}
.back{
    left: 5px;
}
.back, .next{
    position: absolute !important;
    z-index: 2;
    opacity: 0.2;
}
.next{
    right: 5px
}
.container{
    background-color: #e6e6e6 !important;
}
</style>


