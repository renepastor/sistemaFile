require('dotenv').config();
//var https = require('https');
//const rp = require('request-promise');
//const bodyParser = require('body-parser');
//const express = require('express');
//const postgraphql = require('postgraphile').postgraphql;
//const postgraphql = require('postgraphql').postgraphql;
///const whisper = require('./src/whisper');
//const dataPl = require('./src/dataPl');
//const clientFact = require('./src/clientesFactura');
//const cheerio = require('cheerio');
const axios = require('axios');


var depa = [{id:1,dep:"Santa Cruz"},{id:2,dep:"Beni"},{id:3,dep:"Pando"},{id:4,dep:"Tarija"},{id:5,dep:"Chuquisaca"},{id:6,dep:"Cochabamba"},{id:7,dep:"Oruro"},{id:8,dep:"La Paz"},{id:9,dep:"Potosi"}];

  const dataDep = [];
  var row = {};


  depa.map((res, r) => {
    axios.post("http://www.bancounion.com.bo/pub/pub/AgenciasCajeros.aspx/BuscarAgenciasCajeros",
      {"idDepartamento":res.id,"idLocalidad":"-1","idProvincia":"-1","idSector":"-1","tipo":"1"}).then(function (response) {
        dataDep.push(response.data.d[0]);
        //console.log(JSON.stringify(response.data.d[0]));
        //res.send(response.data.d);
    }).catch(function (error) {
       console.log("error", res.id, error);
    });
    //console.log(res, r);
    if(r ==8){
      setTimeout(fun => console.log(JSON.stringify(dataDep)), 2500);
    }
  });

