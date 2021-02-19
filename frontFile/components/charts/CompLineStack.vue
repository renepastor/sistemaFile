<template>
    <v-chart :options="lineStack" @click="selectArea"  hideLoading autoresize>{{actualiza}}</v-chart>
</template>
<style scoped>
.echarts, .img-chart {
  width: 100%;
  min-height: 530px !important;
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
import 'echarts/lib/component/dataZoom'

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
      }
  },
  computed:{
      actualiza(){
          this.lineStack = this.datosChart(this.datos);
      }
  },
  async created(){
        this.lineStack = await this.datosChart(this.datos);
  },
  data () {
      return {
        lineStack:{}
      }
  },
    methods:{
        selectArea(param){
            console.log("##---Stack---##", param.seriesName)
        },
        datosChart(covidXEmep){
            //var covidXEmep = this.datos;
    
    
            this.datos.sort(function(a, b){
                var nameA=a.value, nameB=b.value
                if (nameA < nameB) //sort string ascending
                  return -1 
                if (nameA > nameB)
                  return 1
                return 0 //default return value (no sorting)
            });
            function generarLetra(){
              var letras = ["a","b","c","d","e","f","0","1","2","3","4","5","6","7","8","9"];
              var numero = (Math.random()*15).toFixed(0);
              return letras[numero];
            }
              
            function colorHEX(){
              var coolor = "";
              for(var i=0;i<6;i++){
                coolor = coolor + generarLetra() ;
              }
              return "#" + coolor;
            }
            const trasformado =[], label = [];
            this.datos.map((row,r) =>{
                var reg = {data:[row.value], name:row.name, type:'bar',barGap: 0, barWidth: 20}
                //trasformado.push(row.value)
                trasformado.push({value: row.value,itemStyle: {color: colorHEX()}})
                label.push(row.name)
            });
            
            return {
                color: ['#00ffbb','#77bef7', '#000abb','#77bef7', '#000abb', '#000abb','#77bef7'],
                title: {
                    text: this.header,
                    left: "center",
                    textStyle: {
                        fontSize: 12
                    }
                },
                tooltip: {
                    formatter: '{b} : {c}'
                },
                dataZoom: [{
                    type: 'slider',
                    yAxisIndex: 0,
                    filterMode: 'empty',
                    start: 280,
                    end: 300
                }],
                grid: {
                    top: '35px',
                    left: '1%',
                    right: '10px',
                    bottom: '1%',
                    containLabel: true
                },
                xAxis: {
                    type: 'value',
                    min: 0,
                    interval: 100
                },
                yAxis: {
                    type: 'category',
                    data: label,
                    axisLabel: {
                        interval: 0,
                        rotate: 30,
                        textStyle:{
                            fontSize:10
                        },
                    },
                    splitLine: {
                        show: false
                    }
                },
                series: {
                    data:trasformado,
                    type:'bar',
                    z: 3,
                    label: {
                        normal: {
                            position: 'right',
                            show: true
                        }
                    },
                }
            }
    
    


        }
    }
}
</script>

