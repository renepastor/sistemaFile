<template>
    <v-chart :options="pie" @click="selectPie" hideLoading autoresize>{{load}}</v-chart>
</template>
<style scoped>
.echarts, .img-chart {
  width: 100%;
  min-height: 265px !important;
  height: 100%;
}
</style>
<script>
import ECharts from 'vue-echarts'
import 'echarts/lib/chart/pie'
import 'echarts/lib/component/axis'
import 'echarts/lib/component/tooltip'
import 'echarts/lib/component/title'
import 'echarts/lib/component/legend'
import 'echarts/lib/component/legend/ScrollableLegendModel'
import 'echarts/lib/component/legend/ScrollableLegendView'
import 'echarts/lib/component/legend/scrollableLegendAction'

export default {
    components: {
        'v-chart': ECharts
    },
    props:{
        header:{
            type:String,
            default:"Tit....."
        },
        title:{
            type:String,
            default:""
        },
        subtitle:{
            type:String,
            default:""
        },
        datos:{
            type:Array,
            default:[]
        }
    },
    async created(){
        await this.fnLoadDatos()
    },
    computed:{
        load(){
            this.pie = this.fnLoadDatos()
        }
    },
    data () {
        return {
            pie: {},
            campo: 'departamento'
        }
    },
    methods:{
        async selectPie(param){
            if(this.header.indexOf('Municipio')>0) this.campo = 'municipio';
            var dt = this.$emit('select-area-pie', param, this.campo);
        },
        fnLoadDatos(){
            const label = []
            this.datos.map(row=>{
                label.push(row.name)
            })
            this.datos = this.datos;
            return {
                title: {
                    text: this.header,
                    left: "center",
                    subtext: "",
                    textStyle: {
                        fontSize: 12
                    }
                },
                tooltip: {
                    trigger: 'item',
                    formatter: '{a} <br/>{b} : {c} ({d}%)'
                },
                legend: {
                    type:'scroll',
                    orient: 'vertical',
                    textStyle:{
                        fontSize:10,
                        width:'2'
                    },
                    width:'20',
                    right: 10,
                    top: 20,
                    bottom: 20,
                    data: label
                },
                series: [{
                    name: '',
                    type: 'pie',
                    radius: ['0%', '50%'],
                    center: ['25%', '50%'],
                    avoidLabelOverlap: false,
                    label: {
                        show: false,
                        position: 'center'
                    },
                    labelLine: {
                        show: false
                    },
                    data: this.datos,
                    emphasis: {
                        itemStyle: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }]
            }
        }
    }
}
</script>

