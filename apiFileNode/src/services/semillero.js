'use strict';
require('dotenv').config();
const axios = require('axios');
var header = {"YPFB-KEY": "AUbxCCFf69djqtbDZn5WJy6NnfTg2gTN",'Access-Control-Allow-Origin': '*', 'Accept': 'application/json', 'Content-Type': 'application/json'};
var config = {headers: header};

module.exports = function(req, res, next){

  this.semReferencia = function(){
    // ****** conexion con AD Activ Directori ******
    var datos = {"gestion": "2019", "convocatoria": "6"};
    
    const options = {
      method: 'POST',
      headers: header,
      data: datos,
      url:process.env.HOST_SEMILLERO+'/consultaReferencias',
    };
    axios(options)
    .then(respons =>respons)
    .catch(err => {console.log("Error....", err);res.next();})
    .then(respons =>{
          res.send(respons.data);
    });
  };
  
  this.loginSemillero = function(){
    var datos = {"username": "", "password": "6", "gestion":"", "convocatoria":"", "referencia":"", "fnData":"{}"};
    const options = {
      method: 'POST',
      headers: header,
      data: datos,
      url:process.env.HOST_SEMILLERO+'/prospectoConsultaRRSS',
    };
    axios(options)
    .then(respons =>respons)
    .catch(err => {console.log("Error....", err);res.next();})
    .then(respons =>{
          res.send(respons.data);
    });
  }
  
}

