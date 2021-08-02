'use strict';
require('dotenv').config();
const express         = require('express');
const app             = express();
const http            = require('http').Server(app);
const formidable      = require('formidable')
const bodyParser      = require('body-parser');
const postgraphql     = require('postgraphile').postgraphql;
const format          = require('date-format');
const axios           = require('axios');
var mv = require('mv');

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: false })); //false
//Acceso para descargar por
app.use('/files', express.static(__dirname + '/adj/'));
//Adjuntar por POST
app.post('/upload',function (req, res) {
    if (req.url == '/upload') {
        var form = new formidable.IncomingForm();
    }
    form.parse(req, function (err, fields, files) {
        var oldpath = files.miFile.path;
        var nombre = files.miFile.name;
        var dt = format.asString('yyyyMMddhhmmssSSS',new Date())+"_"+nombre.substring(-6);
        var newpath = './server/adj/' + dt;
        //fs.rename
        mv(oldpath, newpath, function (err) {
            if (err){throw err;}
            var json = JSON.stringify({"url":newpath.replace("/server/adj/","/api/files/"), "name":nombre});
            res.end(json);
        });
    });
});


// *******  ACCESOS A POSTGRAPHILE
const postgresConfig = {
    user: process.env.POSTGRES_USERNAME,
    password: process.env.POSTGRES_PASSWORD,
    host: process.env.POSTGRES_HOST,
    port: process.env.POSTGRES_PORT,
    database: process.env.POSTGRES_DATABASE
}

app.use(postgraphql(
    postgresConfig,
    process.env.POSTGRAPHQL_SCHEMA, {
        graphiql: true,
        watchPg: true,
        enableCors: true,
        jwtPgTypeIdentifier: `${process.env.POSTGRAPHQL_SCHEMA}.jwt`,
        jwtSecret: process.env.JWT_SECRET,
        pgDefaultRole: process.env.POSTGRAPHQL_DEFAULT_ROLE
        //,bodySizeLimit:'200kB'
        //,timeout: 5000
    }
))

// ***** MOSTRAR ERRO SI NO EXISTE URL
app.use(function (req, res, next) {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
});

// ***** VERIFICAR EMBIENTE *****
app.use(function (err, req, res, next) {
    res.send(' ', err.message, ' ', (req.app.get('env') === 'development' ? err : {}));
});
module.exports = app
