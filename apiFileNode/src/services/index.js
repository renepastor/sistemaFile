'use strict';
require('dotenv').config();
const ActiveDirectory = require('activedirectory');
const btoa = require('btoa');
const axios = require('axios');
var jwtToken = require('jsonwebtoken');
const urlRRHH = process.env.HOST_RRHH;
const apiSERV = process.env.HOST_API_SERV;

module.exports = function(req, res, next){
  

  this.loginLDAP = function(){
      var user = {};
      const dataLogin = {
        "username" : req.body.pUsuario,
        "password" : req.body.pClave
      };
      //******autenticacion interna
      if(req.body.pUsuario.indexOf("@")>-1){
        var qin =`mutation{
                auth(input:{pClave:"${dataLogin.password}",pUsuario:"${dataLogin.username}"}) {
                clientMutationId jwt
              }}`;
          console.log("######",qin);
          axios({
            url: process.env.HOST_SERV + '/graphql',
            method:"post",
            data:{query:qin}
          }).then(reg => {
            console.log("$$$",reg.data.data);
            if(reg.data.data.auth.jwt != null){
              user.data = {"jwt": reg.data.data.auth.jwt, "username": req.body.pUsuario, "fullName": req.body.pUsuario.toUpperCase()};
              user.status = 200;
              user.success = true;
              res.send(user);
            }else{
              next();
            }
          }).catch(err=>{next();});
      }else{
      //******Autenticacion AD
      user ={};
      var credentials = btoa(req.body.pUsuario + ':' + req.body.pClave);
      const options = {
          headers: {
              "clientcode"  : "SAC",
              "clientsecret": "apptest",
              "authorization": "Basic " + credentials,
              "cache-control": "no-cache"
          },
          auth: {
            "username": req.body.pUsuario,
            "password": req.body.pClave
          }
      };
      
      // ****** conexion con AD Activ Directori ******
      let configLDAP = { url: process.env.HOST_LDAP,
          baseDN: process.env.HOST_LDAP_DN,
          username: req.body.pUsuario + process.env.HOST_LDAP_DOMAIN_LOCAL,
          password: req.body.pClave
      }
      
      var ad = new ActiveDirectory(configLDAP);
      ad.findUser(configLDAP.username, function(err, user) {
          var resData = {};
          if (!user) {
              next([err]);   
          }else {
              var p =`mutation{
                    auth(input:{pClave:"#$%&${dataLogin.username}#$%&",pUsuario:"${dataLogin.username}"}) {
                    jwt
                  }}`;
              axios({
                  url: process.env.HOST_SERV + '/graphql',
                  method:"post",
                  data:{query:p}
              }).then(reg => {
                  resData.data = {
                      "fullName":user.displayName,
                      "username":user.cn,
                      "mail":user.mail,
                      "jwt":reg.data.data.auth.jwt,
                      "unidad":user.description,
                      "ci":user.employeeID
                  };
                  resData.success = true;
                  res.send(resData);
              }).catch(err=>{res.send({success:false, errors:[{err:"No existe usuario"}], msj:"Usuario no esta registrado"});});
          }
      }, function(err, user){
        console.log("###", err, user);
      })
  }
    
    


    /*
    // ****** conexion con AD Activ Directori ******
    let configLDAP = { url: process.env.HOST_LDAP,
      baseDN: process.env.HOST_LDAP_DN,
      username: req.body.pUsuario + process.env.HOST_LDAP_DOMAIN_LOCAL,
      password: req.body.pClave
    }
    var ad = new ActiveDirectory(configLDAP);
    ad.findUser(configLDAP.username, function(err, user) {
      if (!user) {
        next();
      }else {
        var p =`mutation{
               auth(input:{pClave:"#$%&${req.body.pUsuario}#$%&",pUsuario:"${req.body.pUsuario}"}) {
               clientMutationId jwt
             }}`;
        axios({
          url: process.env.HOST_SERV + '/graphql',
          method:"post",
          data:{query:p}
        }).then(reg => {
          console.log("Token..#####..", reg.data.data.auth.jwt);
          if(reg.data.data.auth.jwt == null){
            p =`mutation{
               auth(input:{pClave:"${process.env.PWD_INVITADO}",pUsuario:"invitado"}) {
               clientMutationId jwt
             }}`;
             axios({
                url: process.env.HOST_SERV + '/graphql',
                method:"post",
                data:{query:p}
             }).then(regInv => {
                console.log("Usuario que no tiene cuenta en la BD",regInv);
                user.jwt = regInv.data.data.auth.jwt;
                res.send(user);
             });
          }else{
            user.jwt = reg.data.data.auth.jwt;
            res.send(user);
          }
        }).catch(err=>{console.log("Error3.....:",err);});
      }
    });
    */
  };
  
  /*
  this.loginLDAP = function(){
    // ****** conexion con AD Activ Directori ******
    var user = {sAMAccountName:"rpmamani",
                displayName: req.body.pUsuario, //:"Rene Pastor Mamani Flores"
                description:"GTIC"};

        var p =`mutation{
               auth(input:{pClave:"#$%&${req.body.pUsuario}#$%&",pUsuario:"${req.body.pUsuario}"}) {
               clientMutationId jwt
             }}`;
        axios({
          url: process.env.HOST_SERV + '/graphql',
          method:"post",
          data:{query:p}
        }).then(reg => {
          console.log("Token....", reg.data.data.auth.jwt);
          user.jwt = reg.data.data.auth.jwt;
          res.send(user);
        }).catch(err=>{console.log("Error3.....:",err);});
  };
  */

  this.loginLDAPToken = function(){
    // ****** conexion con AD Activ Directori ******
    let configLDAP = { url: process.env.HOST_LDAP,
      baseDN: process.env.HOST_LDAP_DN,
      username: req.body.pUsuario + process.env.HOST_LDAP_DOMAIN_LOCAL,
      password: req.body.pClave
    }
    var ad = new ActiveDirectory(configLDAP);
    ad.findUser(configLDAP.username, function(err, user) {
      if (!user) {
        next();
      }else {
        var paramToken = {
          username:   user.cn,
          ci:         user.employeeID
        };
        //process.env.JWT_SECRET
        var token = jwtToken.sign(paramToken, 'Secret Password', {
           expiresIn: 60 * 60 * 24 // expires in 24 hours
        })
        var rowUser       = {};
        rowUser.mail      = user.mail;
        rowUser.ci        = user.employeeID;
        rowUser.userName  = user.cn;
        rowUser.nombre    = user.displayName;
        rowUser.unidad    = user.description;
        rowUser.fecha     = user.whenCreated;
        rowUser.jwt       = token;
        res.send(rowUser);
      }
    });
  };
  
  this.buscarLDAP = function(){
    
    var query = 'displayName=*'+req.query.user+'*';
    console.log(query);
    var ad = new ActiveDirectory(configLDAP);
    ad.findUsers(query, function(err, users) {
       if (err) {
         console.log('ERROR: ' +JSON.stringify(err));
         return;
       }
 
      if ((! users) || (users.length == 0)) next();
      else {
        //console.log('findUsers: '+JSON.stringify(users));
        res.send(users);
      }
    });
  }
  
}


/*
var q =`
  mutation{
    auth(input:{pClave:"${pClave}",pUsuario:"${pUsuario}"}) {
    clientMutationId jwt
  }}`;
  fnGql({query:q, action:function(res){
    if(res.data.auth.jwt != null){
      toastr.success("Bienvenido.. ","..");
      sessionStorage.token = res.data.auth.jwt;
      var q2 =`query{miUsuario{cuenta persId
        personaByPersId{primerNombre primerApellido}
        usrRolesByUserId{nodes{rolId permiso}}
      }}`;
      fnGql({query:q2, action:function(res){
        console.log(res);
        sessionStorage.sRolId = res.data.miUsuario.usrRolesByUserId.nodes[0].rolId;
        sessionStorage.userName = res.data.miUsuario.cuenta
        window.location = window.location.origin;
      }});
    }else{
      toastr.info("Ups! el usuario o contraseña es incorrecto","Aviso");
      $("#formLogin")[0].reset();
    }
  }});
*/
