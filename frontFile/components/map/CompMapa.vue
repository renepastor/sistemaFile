<template>
  <div id="map" class="basemap ma-0">{{actualiza}}</div>
</template>
<style scoped>
.basemap {
  width: 100%; 
  min-height: 550px !important;
}
</style>

<script>

export default {
    props:{
        header:{
            type:String,
            default:"Tit....."
        },
        datos:{
            type:Array,
            default:[]
        },
        xyCenter:{
            type:Array,
            default:()=>[-63.554,-16.5497]
        },
        mapZoom:{
            type:Number,
            default:4.5
        }
    },
    data() {
        return {
            accessToken: process.env.KEY_MAPBOX,
            mapStyle: 'mapbox://styles/mapbox/streets-v11',
        };
    },
    /*async created(){
        await this.createMap(this.datos)
    },
    mounted(){
        this.createMap(this.datos)
    },*/
    computed:{
        actualiza(){
            const accessToken = 'mapbox://styles/mapbox/streets-v11';
            this.createMap(this.datos);
        }
    },
    methods:{
      async createMap(datoMap = this.datos){
          //const datoMap = this.datos;
          this.$mapboxgl.accessToken = await this.accessToken
          
          const paramMap = {
              container:'map',
              style: this.mapStyle,
              zoom: this.mapZoom,
              center: this.xyCenter
          }
          this.map = new this.$mapboxgl.Map(paramMap);
          var m = this.map;
          //Controles: OpenFull, Navegacion, Geolocalizacion
          m.addControl(new this.$mapboxgl.FullscreenControl());
          m.addControl(new this.$mapboxgl.NavigationControl());
          m.addControl(
              new this.$mapboxgl.GeolocateControl({
                  positionOptions: {
                      enableHighAccuracy: true
                  },
                  trackUserLocation: true
              })
          );
        
          this.map.on('load', function () {
              var geoJson = {
                  "type": "FeatureCollection",
                  "crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:OGC:1.3:CRS84" } },
                  "features": datoMap
              };
              m.addSource('earthquakes', {
                  'type': 'geojson',
                  'data':geoJson
              });
              m.addLayer({
                  'id': 'earthquakes-heat',
                  'type': 'heatmap',
                  'source': 'earthquakes',
                  'maxzoom': 9,
                  'paint': {
                      // Aumente el peso del mapa de calor según la frecuencia y la magnitud de la propiedad
                      'heatmap-weight': [
                          'interpolate',
                          ['linear'],
                          ['get', 'mag'],
                          0,0,6,1
                      ],
                      // Aumente el peso del color del mapa de calor por nivel de zoom
                      // La intensidad del mapa de calor es un multiplicador además del peso del mapa de calor.
                      'heatmap-intensity': [
                          'interpolate',
                          ['linear'],
                          ['zoom'],
                          0,1,9,3
                      ],
                      // Rampa de color para mapa de calor. El dominio es de 0 (bajo) a 1 (alto).
                      // Comience la rampa de color en 0-stop con un color de transparencia 0
                      // para crear un efecto de desenfoque
                      'heatmap-color': [
                          'interpolate',
                          ['linear'],
                          ['heatmap-density'],
                          0, 'rgba(33,102,172,0)',
                          0.2, 'rgb(103,169,207)',
                          0.4, 'rgb(209,229,240)',
                          0.6, 'rgb(253,219,199)',
                          0.8, 'rgb(255, 82, 0)',
                          1, 'rgb(178,24,43)'
                      ],
                      // Ajustar el radio del mapa de calor por nivel de zoom
                      'heatmap-radius': [
                          'interpolate',
                          ['linear'],
                          ['zoom'],
                          0,2,9,20
                      ],
                      // Transición de mapa de calor a capa circular por nivel de zoom
                      'heatmap-opacity': [
                          'interpolate',
                          ['linear'],
                          ['zoom'],
                          7,1,9,0
                      ]
                  }
              },
              'waterway-label'
              );
            
              m.addLayer({
                  'id': 'earthquakes-point',
                  'type': 'circle',
                  'source': 'earthquakes',
                  'minzoom': 7,
                  'paint': {
                      // Tamaño del radio del círculo por magnitud del terremoto y nivel de zoom
                      'circle-radius': [
                          'interpolate',
                          ['linear'],
                          ['zoom'],
                          7,
                          ['interpolate', ['linear'], ['get', 'mag'], 1, 1, 6, 4],
                          16,
                          ['interpolate', ['linear'], ['get', 'mag'], 1, 5, 6, 50]
                      ],
                      // Círculo de color por magnitud de terremoto
                      'circle-color': [
                          'interpolate',
                          ['linear'],
                          ['get', 'mag'],
                          1,
                          'rgba(33,102,172,1)',
                          2,'rgb(103,169,207)',
                          3,'rgb(209,229,240)',
                          4,'rgb(253,219,199)',
                          5,'rgb(239,138,98)',
                          6,'rgb(178,24,43)'
                      ],
                      'circle-stroke-color': 'blue',
                      'circle-stroke-width': 1,
                      // Transición de mapa de calor a capa circular por nivel de zoom
                      'circle-opacity': [
                          'interpolate',
                          ['linear'],
                          ['zoom'],
                          7,0,8,1
                      ]
                  }
              },
              'waterway-label'
              );
          });   
      }
    }
  };
</script>
