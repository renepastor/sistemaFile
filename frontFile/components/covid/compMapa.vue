<template>
  <div class="p-o m-0 h-100">
    <!-- Mapbox GL CSS -->
    <link
      href="https://api.tiles.mapbox.com/mapbox-gl-js/v0.53.0/mapbox-gl.css"
      rel="stylesheet"
    />
    <!-- Vue-mapbox CSS -->
    <link
      href="https://cdn.jsdelivr.net/npm/vue-mapbox@latest/dist/vue-mapbox.css"
      rel="stylesheet"
    />
    <!-- Mapbox GL JS -->
    <script src="https://api.tiles.mapbox.com/mapbox-gl-js/v0.53.0/mapbox-gl.js"></script>
    <!-- VueJS -->
    <script src="https://cdn.jsdelivr.net/npm/vue@latest/dist/vue.min.js"></script>
    <!-- Vue-mapbox -->
    <script
      type="text/javascript"
      src="https://cdn.jsdelivr.net/npm/vue-mapbox@latest/dist/vue-mapbox.min.js"
    ></script>
    <div id="map" class="w-100 h-100"></div>
  </div>
</template>
<script>
import Mapbox from "mapbox-gl";
//import {MglMap} from "vue-mapbox";

  export default {
    data() {
      return {
        accessToken: "pk.eyJ1IjoicmVuZXBhc3RvciIsImEiOiJjam5lcjRmaXgwMGwwM3JyMW9teHpnaGtuIn0.1PBzVNQLaIubrI77ZmediA", // your access token. Needed if you using Mapbox maps
        mapStyle: 'mapbox://styles/mapbox/streets-v11', // your map style,
        location: null
      };
    },
    mounted(){
      this.createMap()
    },
    methods:{
      createMap(){
        Mapbox.accessToken=this.accessToken
        this.map = new Mapbox.Map({
          container:'map',
          style:this.mapStyle,
          zoom:5,
          center:[-63.554, -16.5497]
        });




        var m = this.map;
        this.map.on('load', function () {
            // Add a geojson point source.
            // Heatmap layers also work with a vector tile source.
            m.addSource('earthquakes', {
              'type': 'geojson',
              'data':'https://docs.mapbox.com/mapbox-gl-js/assets/earthquakes.geojson'
            });
            m.addLayer({
              'id': 'earthquakes-heat',
              'type': 'heatmap',
              'source': 'earthquakes',
              'maxzoom': 9,
              'paint': {
              // Increase the heatmap weight based on frequency and property magnitude
              'heatmap-weight': [
                  'interpolate',
                  ['linear'],
                  ['get', 'mag'],
                  0,
                  0,
                  6,
                  1
              ],
              // Increase the heatmap color weight weight by zoom level
              // heatmap-intensity is a multiplier on top of heatmap-weight
              'heatmap-intensity': [
              'interpolate',
              ['linear'],
              ['zoom'],
              0,
              1,
              9,
              3
              ],
              // Color ramp for heatmap.  Domain is 0 (low) to 1 (high).
              // Begin color ramp at 0-stop with a 0-transparancy color
              // to create a blur-like effect.
              'heatmap-color': [
              'interpolate',
              ['linear'],
              ['heatmap-density'],
              0,
              'rgba(33,102,172,0)',
              0.2,
              'rgb(103,169,207)',
              0.4,
              'rgb(209,229,240)',
              0.6,
              'rgb(253,219,199)',
              0.8,
              'rgb(239,138,98)',
              1,
              'rgb(178,24,43)'
              ],
              // Adjust the heatmap radius by zoom level
              'heatmap-radius': [
              'interpolate',
              ['linear'],
              ['zoom'],
              0,
              2,
              9,
              20
              ],
              // Transition from heatmap to circle layer by zoom level
              'heatmap-opacity': [
              'interpolate',
              ['linear'],
              ['zoom'],
              7,
              1,
              9,
              0
              ]
              }
              },
              'waterway-label'
              );
            
            m.addLayer(
            {
            'id': 'earthquakes-point',
            'type': 'circle',
            'source': 'earthquakes',
            'minzoom': 7,
            'paint': {
            // Size circle radius by earthquake magnitude and zoom level
            'circle-radius': [
            'interpolate',
            ['linear'],
            ['zoom'],
            7,
            ['interpolate', ['linear'], ['get', 'mag'], 1, 1, 6, 4],
            16,
            ['interpolate', ['linear'], ['get', 'mag'], 1, 5, 6, 50]
            ],
            // Color circle by earthquake magnitude
            'circle-color': [
            'interpolate',
            ['linear'],
            ['get', 'mag'],
            1,
            'rgba(33,102,172,0)',
            2,
            'rgb(103,169,207)',
            3,
            'rgb(209,229,240)',
            4,
            'rgb(253,219,199)',
            5,
            'rgb(239,138,98)',
            6,
            'rgb(178,24,43)'
            ],
            'circle-stroke-color': 'white',
            'circle-stroke-width': 1,
            // Transition from heatmap to circle layer by zoom level
            'circle-opacity': [
            'interpolate',
            ['linear'],
            ['zoom'],
            7,
            0,
            8,
            1
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

<style lang="scss" scoped>

</style>
