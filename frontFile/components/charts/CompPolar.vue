<template>
    <v-chart :options="polar"/>
</template>

<script>
import ECharts from 'vue-echarts'
import 'echarts/lib/chart/line'
import 'echarts/lib/chart/pie'
import 'echarts/lib/chart/bar'
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
      }
  },
  async created(){
    //console.log("########",this.datos)
  },
  data () {
    const dato = []
    for (let i = 0; i <= 360; i++) {
      const t = i / 180 * Math.PI
      const r = Math.sin(2 * t) * Math.cos(2 * t)
      dato.push([r, i])
    }
    return {
      polar: {
        title: {
          text: 'Reporte',
          left: "center",
        },
        legend: {
          data: ['line']
        },
        polar: {
          center: ['50%', '54%']
        },
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            type: 'cross'
          }
        },
        angleAxis: {
          type: 'value',
          startAngle: 0
        },
        radiusAxis: {
          min: 0
        },
        series: [
          {
            coordinateSystem: 'polar',
            name: 'line',
            type: 'line',
            showSymbol: false,
            data: dato
          }
        ],
        animationDuration: 2000
      }
    }
  }
}
</script>

