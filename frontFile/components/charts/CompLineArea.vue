<template>
    <v-chart :options="lineArea" class="img-chart" hideLoading autoresize>{{load}}</v-chart>
</template>
<style scoped>
.echarts, .img-chart {
  width: 100%;
  min-height: 260px !important;
  height: 100%;
}
</style>
<script>
import ECharts from 'vue-echarts'
import 'echarts/lib/chart/line'
import 'echarts/lib/component/polar'
import 'echarts/lib/component/axis'

export default {
    components: {
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
        parametros:{
            type:Array,
            default:[]
        }
    },
    data () {
        return {
            lineArea: {}
        }
    },
    async created(){
        this.lineArea = await this.loadData()
    },
    computed:{
        load(){
            this.lineArea = [];
            this.lineArea = this.loadData()
        }
    },
    methods:{
        loadData(){
            const label = []
            var misParametros = [];
            this.parametros.map(v => v.data=[]);
            this.datos.map((row,r) =>{
                this.parametros.map(varRow =>{
                    //if(parseInt(row[varRow.id])>=0){
                        varRow.data.push(parseInt(row[varRow.id]));
                    //}
                })
                label.push(row.fechaRegistro)
            });
            const parametrosGF= this.parametros;
            return {
                    title:{
                        text: this.header,
                        left: "center",
                        textStyle: {
                            fontSize: 12
                        }
                    },
                    color: ['#00ffbb','#77bef7', '#000abb','#77bef7', '#000abb', '#000abb','#77bef7'],
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'cross',
                            crossStyle: {
                                color: '#999'
                            }
                        }
                    },
                    toolbox: {
                        feature: {
                            dataView: {show: true, readOnly: false},
                            magicType: {show: true, type: ['line', 'bar']},
                            restore: {show: true},
                            saveAsImage: {show: true}
                        }
                    },
                    dataZoom: [{
                        start: 80,
                        type: "inside"
                    }, {
                        start: 80
                    }],
                    grid: {
                        top: '40px',
                        left: '1%',
                        right: '140px',
                        bottom: '40px',
                        containLabel: true
                    },
                    legend: {
                        orient: 'vertical',
                        right: 10,
                        top: 20,
                        bottom: 20,
                        data: parametrosGF
                    },
                    xAxis: [
                        {
                            type: 'category',
                            data: label,
                            axisPointer: {
                                type: 'shadow'
                            }
                        }
                    ],
                    yAxis: [
                        {
                            type: 'value',
                            min: 0,
                            axisLabel: {
                                formatter: '{value}'
                            }
                        },
                        {
                            type: 'value'
                        }
                    ],
                    series: parametrosGF
                }

        }
    }
}
</script>

