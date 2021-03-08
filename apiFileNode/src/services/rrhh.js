'use strict';
require('dotenv').config();
const axios = require('axios');
const moment =require('moment');
var express = require('express');
var router = express.Router();

const urlRRHH = process.env.HOST_RRHH;
const urlSERV = process.env.HOST_SERV;
router.use(function timeLog(req, res, next) {
  console.log('Time: ', Date.now());
  next();
});
router.get('/', function(req, res) {
  res.send('rrhh');
});


var dataTrab = [], dataPuesto = [];

function httpPost(url, data){
  return new Promise((resolve, reject) => {
    axios.post(url, data)
    .then((response) => resolve(response.data.data))
    .catch((error) => reject(error) );
  });
}


router.post('/unidades', function(req, res, next) {
  axios.post(urlRRHH+'/rrhhApi/unidades',req.body) //{fecha: '10/10/2014'}
  .then(function (response) {
    res.send(response.data.data);
  }).catch(function (error) {
    next();
  });
});
router.post('/rowUnidad', function(req, res, next) {
  axios.post(urlRRHH+'/rrhhApi/unidades',{fecha: req.body.fecha}) //{fecha: '10/10/2014'}
  .then(function (response) {
    var findUnOrg = response.data.data.find(element => {
       return element.id == req.body.id;
    });
    res.send(findUnOrg);
  }).catch(function (error) {
    console.log(error);
    next();
  });
});

router.post('/puestos', function(req, res, next) {
  axios.post(urlRRHH+'/rrhhApi/puestos',req.body //{ "fecha": "10/10/2014", "idUnidadOrganizacional": "1001000000000030"}
  ).then(function (response) {
    res.send(response.data.data);
  }).catch(function (error) {
    next();
  });
});
  
router.post('/trabajadores', function(req, res, next) {
  if(!req.body.fecha) req.body.fecha = moment().format("DD/MM/YYYY");
  axios.post(urlRRHH+'/rrhhApi/trabajadores',req.body) //, {"fecha": "10/10/2014","idUnidadOrganizacional": "1001000000000030"})
  //axios.post(urlRRHH+'/rrhhApi/trabajadores',{"fecha": "10/10/2014","idUnidadOrganizacional": "1001000000000030"}) //, {"fecha": "10/10/2014","idUnidadOrganizacional": "1001000000000030"})
  .then(function (response) {
    console.log("si", response.data.data);
    res.send(response.data.data);
  }).catch(function (error) {
    console.log("no ", error);
    next();
  });
});

router.post('/aprobadorDesignado', function(req, res, next) {
  axios.post(urlRRHH+'/rrhhApi/aprobadorDesignado',req.body) //, {"idUnidad": "1001000000000001"})
  .then(function (response) {
    res.send(response.data.data);
  }).catch(function (error) {
    next();
  });
});

/*
router.post('/searchTrabajadores', function(req, res, next) {
  axios.post(urlRRHH+'/rrhhApi/trabajadores',{fecha:moment().format("DD/MM/YYYY")})
  .then(function (response) {
    var lista = (response.data.data).filter(element => {
      return (element.nombreTrabajador.search(req.body.query.toUpperCase()) >= 0);
    });
    var listaTrabajadorUsuario = [], TrabajadorUsuario = {}, p=0;
    lista.map(rowTrab => {
      axios.post(urlRRHH+'/rrhhApi/personas',{"id":rowTrab.idPersona})
      .then(resTrab => {
        console.log(resTrab.data.data.username);
        TrabajadorUsuario = rowTrab;
        TrabajadorUsuario.usuario = resTrab.data.data.username;
        TrabajadorUsuario.ci = resTrab.data.data.ci;
        listaTrabajadorUsuario.push(TrabajadorUsuario);
        p++;
        if(p===lista.length){
          res.send(listaTrabajadorUsuario);
        }
      }).catch(err=>{console.log("Error lista buscando usuario de trabajador",err);});
      
    });
    
  }).catch(function (error) {
    console.log("Error ", error);
    //next();
  });
});
*/
router.post('/searchTrabajadores', function(req, res, next) {
  var filtro = {fecha:moment().format("DD/MM/YYYY")};
  if(!isNaN(req.body.query)){
   filtro.ci = req.body.query;
  }
  axios.post(urlRRHH+'/rrhhApi/trabajadores',filtro)
  .then(function (response) {
    //return (element.nombreTrabajador.search(req.body.query.toUpperCase()) >= 0);
    var lista = (response.data.data).filter(element => {
      if(!isNaN(req.body.query)){ //Si ingres ci
        return element;
      }else{ //Si ingres "texto nombre"
        return (element.nombreTrabajador.search(req.body.query.toUpperCase()) >= 0);
      }
    });
    var listaTrabajadorUsuario = [], TrabajadorUsuario = {}, p=0;
    lista.map(rowTrab => {
      axios.post(urlRRHH+'/rrhhApi/personas',{"id":rowTrab.idPersona})
      .then(resTrab => {
        TrabajadorUsuario = rowTrab;
        TrabajadorUsuario.usuario = resTrab.data.data.username;
        TrabajadorUsuario.ci = resTrab.data.data.ci;
        listaTrabajadorUsuario.push(TrabajadorUsuario);
        p++;
        if(p===lista.length){
          res.send(listaTrabajadorUsuario);
        }
      }).catch(err=>{res.send({"succes":false, "message":"No Existe resultado"});console.log("Error lista buscando usuario de trabajador",err);});
      //res.send({"succes":false, "message":"No Existe resultado"});
    });
  }).catch((error) => {res.send({"succes":false, "message":"No Existe resultado"});console.log("Error ", error)});
});



/*
router.get('/personas', function(req, res, next) {
  console.log("get",req.query);
  axios.post(urlRRHH+'/rrhhApi/personas',req.query) //, {"id":"1001000000005411"})
  .then(function (response) {
    //console.log(JSON.stringify(response.data.data));
    res.send(response.data.data);
  }).catch(function (error) {
    console.log(error);
    //next();
  });
});
*/
router.post('/personas', function(req, res, next) {
  axios.post(urlRRHH+'/rrhhApi/personas',req.body) //, {"id":"1001000000005411"})
  .then(function (response) {
    //console.log(JSON.stringify(response.data.data));
    res.send(response.data.data);
  }).catch(function (error) {
    console.log(JSON.stringify(error));
    //next();
  });
});

router.post('/personaTrabajador', function(req, res, next) {
  console.log("wwwww00..:",req.body);
  //https://testasir.ypfb.gob.bo/
  axios.post(urlRRHH+'/rrhhApi/personas',req.body) //, {"id":"1001000000005411"})
  .then(function (response) {
      console.log("wwwww..:",response);
      var persona = response.data.data;
      req.body.fecha = moment().format("DD/MM/YYYY");
      axios.post(urlRRHH+'/rrhhApi/trabajadores',req.body) 
      .then(function (respTrab) {
         var trabajo = respTrab.data.data
         //console.log(response, "sss", respTrab);
         persona.trabajador = trabajo[0];
         //var resTrab = Object.assign(persona, trabajo);
         res.send(persona);
      }).catch(function (error) {
         console.log("ERROR.. :",JSON.stringify(error));
         //next();
      });
      //res.send(persona);
  }).catch(function (error) {
    console.log("Error...:",error);
    //next();
  });
 
});

router.post('/responsablesdeUnidad2', function(req, res, next) {
  req.body.fecha = moment().format("DD/MM/YYYY");
  // ***** Buscamos al trabajador
  axios.post(urlRRHH+'/rrhhApi/trabajadores', req.body)
  .then(response => {
    var trabajador = response.data.data;
      // ***** buscamos el jefe de la unidad
      var parUnOrg = {};
      parUnOrg.fecha = moment().format("DD/MM/YYYY");
      axios.post(urlRRHH+'/rrhhApi/unidades',parUnOrg)
      .then(respUnOrg => {
         var unOrg = respUnOrg.data.data;
         var findUnOrg = unOrg.find(element => {
           return element.id == trabajador[0].idUnidadOrganizacional;
         });
         var parTrabAut = {idUnidadOrganizacional:trabajador[0].idUnidadOrganizacional, fecha: moment().format("DD/MM/YYYY")};
         axios.post(urlRRHH+'/rrhhApi/trabajadores',parTrabAut)
         .then(respTrabAut => {
             var respoUnidad = [];
             var jefe = respTrabAut.data.data.find(element => {
               return element.idPuesto == findUnOrg.idPuestoAutoridad;
             });
             axios.post(urlRRHH+'/rrhhApi/aprobadorDesignado',{"idUnidad":trabajador[0].idUnidadOrganizacional})
             .then(respAiAsignado => {
                if(respAiAsignado.data)
                  respoUnidad = respAiAsignado.data;
                respoUnidad.push({
                  idEmpleado: jefe.idEmpleado,
                  idPersona: jefe.idPersona,
                  idUnidad: jefe.idUnidadOrganizacional,
                  nombreCompleto: jefe.nombreTrabajador,
                  nombreFormal: jefe.nombreTrabajador,
                  unidad: "",
                  siglaUnidad: "",
                  puesto: jefe.nombrePuesto
                });
                res.send(respoUnidad);
             }).catch(err => {console.log("ERROR.4. :",err);});
             
         }).catch(err => {console.log("ERROR.3. :",JSON.stringify(err));});
      }).catch(err => {
         console.log("ERROR.2. :",JSON.stringify(err));
      });
      res.send(jefes);
  }).catch(function (error) {
    console.log("Error..1.:",JSON.stringify(error));
  });
});
router.post('/responsablesdeUnidad', function(req, res, next) {
  req.body.fecha = moment().format("DD/MM/YYYY");
  axios.post(urlRRHH+'/rrhhApi/trabajadores', req.body)
  .then(response => {
      var trabajador = response.data.data;
      //console.log("trabajador es..:",trabajador);
      var parUnOrg = {};
      var listJefes = [];
      parUnOrg.fecha = moment().format("DD/MM/YYYY");
      axios.post(urlRRHH+'/rrhhApi/unidades',parUnOrg)
      .then(respUnOrg => {
         var unOrg = respUnOrg.data.data
         var findUnOrg = unOrg.find(element => {
           return element.id == trabajador[0].idUnidadOrganizacional;
         });
         var findUnOrgSup = unOrg.find(function(element) {
           return element.id == findUnOrg.idPredecesor;
         });
         console.log(findUnOrgSup.id);
         if(trabajador[0].nombrePuesto.toUpperCase().indexOf("GERENTE") >= 0 || trabajador[0].nombrePuesto.toUpperCase().indexOf("VICE") >= 0){
            axios.post(urlRRHH+'/rrhhApi/aprobadorDesignado',{"idUnidad":findUnOrgSup.id})  //trabajador[0].idUnidadOrganizacional})
            .then(respAiAsignado => {
               respAiAsignado.data.map(rowDesignado => {
                 axios.post(urlRRHH+'/rrhhApi/personas',{"id":rowDesignado.idPersona})
                 .then(resPersonaDesignada => {
                    axios.post(urlRRHH+'/rrhhApi/trabajadores',{username:resPersonaDesignada.data.data.username})
                    .then(respTrabAutSup => {
                       respTrabAutSup.data.data[0].ci = resPersonaDesignada.data.data.ci;
                       respTrabAutSup.data.data[0].username = resPersonaDesignada.data.data.username;
                       listJefes.push(respTrabAutSup.data.data[0]);
                    });
                 });
              });
            });
         }
         //console.log("unOrg es..:",findUnOrg, findUnOrgSup);
         var parTrabAut = {idUnidadOrganizacional:trabajador[0].idUnidadOrganizacional, fecha: moment().format("DD/MM/YYYY")};
         axios.post(urlRRHH+'/rrhhApi/trabajadores',parTrabAut)
         .then(respTrabAut => {
             var jefe = respTrabAut.data.data.find(element => {
               return element.idPuesto == findUnOrg.idPuestoAutoridad;
             });
             axios.post(urlRRHH+'/rrhhApi/personas',{"id":jefe.idPersona}) 
             .then(resPersonaJefe => {
                 jefe.ci = resPersonaJefe.data.data.ci;
                 jefe.username = resPersonaJefe.data.data.username;
                 var parTrabAutSup = {idUnidadOrganizacional:findUnOrgSup.id, fecha: moment().format("DD/MM/YYYY")};
                 axios.post(urlRRHH+'/rrhhApi/trabajadores',parTrabAutSup)
                 .then(respTrabAutSup => {
                     var jefeSup = {};
                     jefeSup = respTrabAutSup.data.data.find(element => {
                         return element.idPuesto == findUnOrgSup.idPuestoAutoridad;
                     });
                     if(jefeSup === undefined) {
                             axios.post(urlRRHH+'/rrhhApi/aprobadorDesignado',{"idUnidad":findUnOrgSup.id})  //trabajador[0].idUnidadOrganizacional})
                             .then(respAiAsignado => {
                                listJefes.push(jefe);
                                listJefes = listJefes.filter(element => {
                                    return (element.username !== req.body.username && element.username !== "obarriga") ;
                                });
                                res.send(listJefes);
                              }).catch(err => {console.log("ERROR.7. :",JSON.stringify(err));});
                     }else{
                         axios.post(urlRRHH+'/rrhhApi/personas',{"id":jefeSup.idPersona})
                         .then(resPersonaJefeSup => {
                             //console.log("Unidade...:",trabajador[0].idUnidadOrganizacional, findUnOrgSup);
                             axios.post(urlRRHH+'/rrhhApi/aprobadorDesignado',{"idUnidad":findUnOrgSup.id})  //trabajador[0].idUnidadOrganizacional})
                             .then(respAiAsignado => {
                                jefeSup.ci = resPersonaJefeSup.data.data.ci;
                                jefeSup.username = resPersonaJefeSup.data.data.username;
                                if(jefeSup !== {}) listJefes.push(jefeSup);
                                listJefes.push(jefe);
                                listJefes = listJefes.filter(element => {
                                    return (element.username !== req.body.username && element.username !== "obarriga");
                                });
                                listJefes = listJefes.filter(element => {
                                    return (element.nombrePuesto.toUpperCase().indexOf("GERENTE") >= 0 || 
                                            element.nombrePuesto.toUpperCase().indexOf("JEFE") >= 0 || 
                                            element.nombrePuesto.toUpperCase().indexOf("DIRECTOR") >= 0 || 
                                            element.nombrePuesto.toUpperCase().indexOf("VICE") >= 0
                                            );
                                });
                                res.send(listJefes);
                              }).catch(err => {console.log("ERROR.7. :",JSON.stringify(err));});
                         }).catch(err => {console.log("ERROR.6. :",JSON.stringify(err));});
                     }
                }).catch(err => {console.log("ERROR.5 jeje. :",JSON.stringify(err));});
           }).catch(err => {console.log("ERROR.4. :",JSON.stringify(err));});
         }).catch(err => {console.log("ERROR.3. :",JSON.stringify(err));});
      }).catch(err => {
         console.log("ERROR.2. :",JSON.stringify(err));
      });
      res.send(jefes);
  }).catch(function (error) {
    console.log("Error..1.:",JSON.stringify(error));
    //next();
  });
});

router.post('/trabajadoresContrato', function(req, res, next) {
  var param = {fecha : moment().format("DD/MM/YYYY"), username : req.body.username};
  req.body.fecha = moment().format("DD/MM/YYYY");
  req.body.idUnidadOrganizacional = req.body.idUnidadOrganizacional;
  axios.post(urlRRHH+'/rrhhApi/trabajadores',param)
  .then(response => {
    var paramLista = {fecha : moment().format("DD/MM/YYYY"), idUnidadOrganizacional : response.data.data[0].idUnidadOrganizacional};
    axios.post(urlRRHH+'/rrhhApi/trabajadores',paramLista)
    .then(resLista => {
      var listaPersonal = resLista.data.data.filter(element => {
        return element.tipoContrato == req.body.tipo;
      });
      var nuevaListaPersona = [], k=0;
      listaPersonal.map(resPer => {
        axios.post(urlRRHH+'/rrhhApi/personas',{id:resPer.idPersona})
        .then(resPersona => {
            console.log(listaPersonal.length,k);
            resPer.ci = resPersona.data.data.ci;
            nuevaListaPersona.push(resPer);
            k++;
            if(listaPersonal.length == k){
              res.send(nuevaListaPersona);
            }
        });
      }).catch(err => console.log("Error map ", err));
    }).catch(err => console.log("no ", err));
  }).catch(err => console.log("no ", err));
});

router.post('/unidadesHijas', function(req, res, next) {
  axios.post(urlRRHH+'/rrhhApi/unidades',{fecha: moment().format("DD/MM/YYYY")})
  .then(function (response) {
    var idUnidad = req.body.idUnidad;
    var idPuesto = req.body.idPuesto; // puesto de la autoridad
    var lista = response.data.data;
    var lista2 = response.data.data;
    var nueva = lista.filter(element => {
      return ((element.id == idUnidad) && (element.idPuestoAutoridad = idPuesto));
    });
    lista.map((row, r) => {
      if(row.idPredecesor == idUnidad){
        var l = lista2.filter(element => {
          return element.idPredecesor == idUnidad;
        });
        l.map(d => {
          nueva.push(d);
        });
        idUnidad = row.id;
      }
    });
    res.send(nueva);
  }).catch(err => console.log("no ", err));
});

router.post('/trabajadorSegunContrato', function(req, res, next) {
  console.log(req.body);
  axios.post(urlRRHH+'/rrhhApi/trabajadores',{fecha: moment().format("DD/MM/YYYY"),idUnidadOrganizacional: req.body.id})
  .then(resTrabajador => {
    console.log("Este es el valor de ",resTrabajador);
    var l = resTrabajador.data.data.filter(element => {
      return element.tipoContrato == req.body.tipo;
    });
    res.send(l);
  });
})

router.post('/dependientes', function(req, res, next) {
  axios.post(urlSERV+'/rrhh/unidadesHijas',req.body)
  .then(function (response) {
    var unidades = response.data,
    listaPersonal = [];
    unidades.map((rowUnidad, g) => {
      axios.post(urlRRHH+'/rrhhApi/trabajadores',{fecha: moment().format("DD/MM/YYYY"),idUnidadOrganizacional: rowUnidad.id})
      .then(resTrabajador => {
        var l = resTrabajador.data.data.filter(element => {
          return element.tipoContrato == req.body.tipo;
        });
        l.map(r => {
        
          axios.post(urlRRHH+'/rrhhApi/personas',{id:r.idPersona})
          .then(resPersona => {
            resPer.ci = resPersona.data.data.ci;
            nuevaListaPersona.push(resPer);
            k++;
            if(listaPersonal.length == k){
              res.send(nuevaListaPersona);
            }
          });
         
        
          listaPersonal.push(r);
        });
        if(unidades.length == g+1)
          res.send(listaPersonal);
      });
    })
  }).catch(err => console.log("no ", err));
});

router.post('/sedes', function(req, res, next) {
  axios.post(urlRRHH+'/rrhhApi/puestos',{fecha: moment().format("DD/MM/YYYY")}) //, {"id":"1001000000005411"})
  .then(function (response) {
    var listaSedes = [], rowSedes = {}, c=0;
    response.data.data.map(row => {
      c++;
      rowSedes[row.sede] = row.sede;
      //listaSedes.push(row.sede);
    });
    console.log(c, response.data.data.length);
    //if(c==response.data.data.length)
      res.send(Object.values(rowSedes));
  }).catch(error => console.log(error));
});


router.post('/trabajadorSede', function(req, res, next) {
  var rows = JSON.parse(req.body.rows);
  var filtro = {fecha:moment().format("DD/MM/YYYY")};
  if(!isNaN(req.body.query)){
   filtro.ci = req.body.query;
  }
  httpPost(urlRRHH+'/rrhhApi/trabajadores',filtro)
  .then(value => {
    dataTrab = value;
    return httpPost(urlRRHH+'/rrhhApi/puestos',filtro);
  })
  .then(value => {
    dataPuesto = value;
    return value;
  })
  .then(result => {
    var newTrabajador = [], sinPuestos =[], newRow ={};
    dataTrab.map((row, r) => {
      var puesto = dataPuesto.find(arg => (arg.id === row.idPuesto));
      if(puesto != undefined){
        row.sede = puesto.sede;
      }
      newRow ={};
      rows.map(reg => {
        newRow[reg] = row[reg];
      });
      newTrabajador.push(newRow);
    });
    res.send(newTrabajador);
  }).catch(err => console.log("Error..:", err));
});

router.post('/trabajadorActivo', function(req, res, next) {
  axios.post(urlRRHH+'/rrhhApi/personas',{id:req.body.id})
  .then(resPersona => {
    console.log("pers..",resPersona.data);
    var paramTrab = {fecha: moment().format("DD/MM/YYYY"), ci: resPersona.data.data.ci};
    axios.post(urlRRHH+'/rrhhApi/trabajadores', paramTrab)
    .then(resTraba => {
      console.log("trab..",resTraba.data);
      res.send(resTraba.data.data[0]);
    }).catch(err => console.log("Error de Trababajor ", err))
  }).catch(err => console.log("Error no existe persona ", err));
});


router.get('/empresas', function(req, res, next) {
  axios.get('http://172.16.0.48/apiCore/v1/aplicaciones/83/empresas') //{fecha: '10/10/2014'}
  .then(function (response) {
    res.send(response.data.data);
  }).catch(function (error) {
    next();
  });
});









/***BORRAR**/

router.get('/unidades', function(req, res, next) {
  axios.post(urlRRHH+'/rrhhApi/unidades',{fecha: moment().format("DD/MM/YYYY")}) //{fecha: '10/10/2014'}
  .then(function (response) {
    res.send(response.data.data);
  }).catch(function (error) {
    next();
  });
});

router.get('/puestos', function(req, res, next) {
  //axios.post(urlRRHH+'/rrhhApi/puestos',{"fecha": "10/10/2014", "idUnidadOrganizacional": "1001000000000030"} //{"fecha": "10/10/2014", "idUnidadOrganizacional": "1001000000000030"}
  //axios.post(urlRRHH+'/rrhhApi/puestos',{"fecha": "31/12/2018","idUnidadOrganizacional":"1001000000000608"} //{"fecha": "10/10/2014", "idUnidadOrganizacional": "1001000000000030"}
  //"fecha": moment().format("DD/MM/YYYY")
  axios.post(urlRRHH+'/rrhhApi/puestos',{"fecha":moment().format("DD/MM/YYYY")} //{"fecha": "10/10/2014", "idUnidadOrganizacional": "1001000000000030"}
  ).then(function (response) {
    res.send(response.data.data);
  }).catch(function (error) {
    next();
  });
});
  
router.get('/trabajadores', function(req, res, next) {
  console.log("log....", req.query);
  //axios.post(urlRRHH+'/rrhhApi/trabajadores',{"username":"rcoronel"}) //, {"fecha": "10/10/2014","idUnidadOrganizacional": "1001000000000030"})
  axios.post(urlRRHH+'/rrhhApi/trabajadores',{ 
  //ci: '2017664', fecha : moment().format("DD/MM/YYYY")
  //username:"msequeiros", fecha : moment().format("DD/MM/YYYY")
   ci: req.query.ci,
   fecha : moment().format("DD/MM/YYYY")
  })
//  idUnidadOrganizacional: '1001000000000606',  fecha: '02/01/2019' })
  //{"fecha": "10/12/2018","idUnidadOrganizacional": "1001000000000606"}) //, {"fecha": "10/10/2014","idUnidadOrganizacional": "1001000000000030"})
  .then(function (response) {
    console.log("si", response.data.data);
    res.send(response.data.data);
  }).catch(function (error) {
    console.log("no ", error);
    next();
  });
});
/*
router.get('/personas', function(req, res, next) {
  console.log("get",req.query);
  axios.post(urlRRHH+'/rrhhApi/personas',req.query) //, {"id":"1001000000005411"})
  .then(function (response) {
    //console.log(JSON.stringify(response.data.data));
    res.send(response.data.data);
  }).catch(function (error) {
    console.log(error);
    //next();
  });
});
*/
router.get('/personas', function(req, res, next) {
  axios.post(urlRRHH+'/rrhhApi/personas',{"ci": '2017664'}) //, {"id":"1001000000005411"})
  .then(function (response) {
    console.log(JSON.stringify(response.data.data));
    res.send(response.data.data);
  }).catch(function (error) {
    console.log(JSON.stringify(error));
    //next();
  });
});

router.get('/personaTrabajador', function(req, res, next) {
  console.log("wwwww00..:");
  axios.post(urlRRHH+'/rrhhApi/personas',{"id":"1001000000016109"}) //, {"id":"1001000000005411"})
  .then(function (response) {
      console.log("persona..:",response);
      var persona = response.data.data;
      var paramTrab = {};
      paramTrab.fecha = moment().format("DD/MM/YYYY");
      paramTrab.idUnidadOrganizacional = persona.id;
      axios.post(urlRRHH+'/rrhhApi/trabajadores',paramTrab) 
      .then(function (respTrab) {
         var trabajo = respTrab.data.data
         console.log("trabajadores", trabajo);
         persona.trabajador = trabajo[0];
         //var resTrab = Object.assign(persona, trabajo);
         res.send(persona);
      }).catch(function (error) {
         console.log("ERROR.. :",JSON.stringify(error));
         //next();
      });
      //res.send(persona);
  }).catch(function (error) {
    console.log("Error...:",JSON.stringify(error));
    //next();
  });
});
router.get('/aprobadores', function(req, res, next) {
   axios.post(urlRRHH+'/rrhhApi/aprobadorDesignado',{"idUnidad":"1001000000000001"})  //trabajador[0].idUnidadOrganizacional})
   .then(respAiAsignado => {
     console.log("Reddd",respAiAsignado.data);
   }).catch(function (error) {
    console.log("Error...:",JSON.stringify(error));
    //next();
  });
});

router.get('/searchTrabajadores', function(req, res, next) {
  var filtro = {fecha:moment().format("DD/MM/YYYY")};
  console.log("ddddd....", req.query.ci);
  if(!isNaN(req.queryci)){
   filtro.ci = req.query.ci;
  }
  axios.post(urlRRHH+'/rrhhApi/trabajadores',filtro)
  .then(function (response) {
    //return (element.nombreTrabajador.search(req.body.query.toUpperCase()) >= 0);
    var lista = (response.data.data).filter(element => {
      if(!isNaN(req.query.ci)){ //Si ingres ci
        return element;
      }else{ //Si ingres "texto nombre"
        return (element.nombreTrabajador.search(req.query.ci.toUpperCase()) >= 0);
      }
    });
    var listaTrabajadorUsuario = [], TrabajadorUsuario = {}, p=0;
    lista.map(rowTrab => {
      axios.post(urlRRHH+'/rrhhApi/personas',{"id":rowTrab.idPersona})
      .then(resTrab => {
        TrabajadorUsuario = rowTrab;
        TrabajadorUsuario.usuario = resTrab.data.data.username;
        TrabajadorUsuario.ci = resTrab.data.data.ci;
        listaTrabajadorUsuario.push(TrabajadorUsuario);
        p++;
        if(p===lista.length){
          res.send(listaTrabajadorUsuario);
        }
      }).catch(err=>{console.log("ErrorPERSONA lista buscando usuario de trabajador",err);});
    });
  }).catch((error) => console.log("ErrorTRABAJADOR ", error));
});

router.get('/trabajadorActivo', function(req, res, next) {
  axios.post(urlRRHH+'/rrhhApi/personas',{id:req.query.id})
  .then(resPersona => {
    console.log("pers..",resPersona.data);
    var paramTrab = {fecha: moment().format("DD/MM/YYYY"), ci: resPersona.data.data.ci};
    axios.post(urlRRHH+'/rrhhApi/trabajadores', paramTrab)
    .then(resTraba => {
      console.log("trab..",resTraba.data);
      res.send(resTraba.data.data[0]);
    }).catch(err => console.log("Error de Trababajor ", err))
  }).catch(err => console.log("Error no existe persona ", err));
});


router.get('/miLogin', function(req, res, next) {
    const data = {
      "username" : "rpmamani", "password" : "123456"
    };
    const options = {
        headers: {
            "clientcode"  : "SAC",
            "clientsecret": "apptest",
            "authorization": "Basic cnBtYW1hbmk6MTIzNDU2",
            "cache-control": "no-cache"
        }
    };

    axios.post('http://testapiservicios.ypfb.gob.bo/apiCore/v1/login', data, options)
     .then((res) => {
       console.log("RESPONSE ==== : ", res.data);
     })
     .catch((err) => {
       console.log("ERROR: ====", err.Error);
     })

/*
    var filtro = {"clientCode" : "rpmamani", "clientSecret" : "123456"};
    axios.post('http://testapiservicios.ypfb.gob.bo/apiCore/v1/login',filtro)
    .then(function (response) {
        console.log("#$%#$%#$%#$%",response)
    }).catch(err => console.log("Error no existe persona ", err));
    */
});



module.exports = router;