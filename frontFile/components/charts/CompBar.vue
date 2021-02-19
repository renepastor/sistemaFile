<template>
    <comp-loading :loading="loading">
        <v-chart :options="bar" @click="selectArea"  hideLoading autoresize>{{nextEmpresa}}</v-chart>
    </comp-loading>
</template>
<style scoped>
.echarts, .img-chart {
    width: 100%;
    min-height: 505px !important;
    height: 100%;
}
</style>

<script>
import ECharts from 'vue-echarts'
import 'echarts/lib/chart/line'
import 'echarts/lib/chart/pie'
import 'echarts/lib/chart/bar'
import 'echarts/lib/component/polar'
import 'echarts/lib/component/axis'
import compLoading from '@/components/Loading'

export default {
    components: {
        'comp-loading':compLoading,
        'v-chart': ECharts
    },
    props:{
        header:{
            type:String,
            default:"Tit....."
        },
        datos:{
            type:Array,
            default:[]
        },
        colorBar:String
    },
    async created(){
        this.bar = await this.fnDatosChar(this.datos)
    },
    computed:{
        nextEmpresa(){
            this.hideLoading=true
            this.bar = this.fnDatosChar(this.datos)
        }
    },
    data () {
        return {
            expandir:'',
            loading: false,
            bar:{}
        }
    },
    methods:{
        fnDatosChar(covidXEmep){
            const color = eval(this.colorBar)[0];
            const tipo = eval(this.colorBar)[1];
            this.datos.sort(function(a, b){
                var nameA=a.value, nameB=b.value
                if (nameA < nameB)
                    return -1 
                if (nameA > nameB)
                    return 1
                return 0
            });
            const trasformado =[];
            this.datos.map(row =>{
                trasformado.push([row.value, row.name])
            });
            return {
                color:[color],
                title: {
                    text: tipo+this.header,
                    left: "center",
                    textStyle: {
                        fontSize: 12
                    }
                },
                tooltip: {
                    trigger: 'item',
                    formatter: '{b} : {c}'
                },
                dataset: {
                    source: trasformado,
                },
                grid: {
                    top:'30px',
                    left: '3%',
                    right: '4%',
                    bottom: '5px',
                    containLabel: true
                },
                xAxis: {
                    name: 'amount'
                },
                yAxis: {
                    type: 'category',
                    axisLabel:{
                            textStyle:{
                                fontSize:10
                            },
                    }
                },
                series: [{
                    type: 'bar',
                    encode: {
                        x: 'Confirmados',
                        y: 'name'
                    }
                }]
            }
        },
        selectArea(param){
            var dt = this.$emit('select-area-bar', param);
        }
    }
}
</script>

