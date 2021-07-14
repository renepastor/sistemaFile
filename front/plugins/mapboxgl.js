/* eslint-disable import/no-extraneous-dependencies */
import Vue from 'vue';
//import { MglMap, MglGeolocateControl } from 'vue-mapbox';
import mapboxgl from 'mapbox-gl';
Vue.use(mapboxgl)
//Vue.component('MglMap', MglMap);
//Vue.component('MglGeolocateControl', MglGeolocateControl);
//Vue.prototype.$mapbox = mapboxgl;
Vue.prototype.$mapboxgl = mapboxgl;