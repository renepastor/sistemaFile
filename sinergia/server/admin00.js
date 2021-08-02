'use strict';
require('dotenv').config();

const bodyParser = require('body-parser')
const app = require('express')()
module.exports = { path: '/getJSON', handler: app }
app.use(bodyParser.json());
app.all('/getJSON', (req, res, next) => {
  console.log(req.body)
  res.json(req.body)
})

module.exports = app