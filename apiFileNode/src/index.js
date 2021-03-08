var express                = require('express');
var router                 = express.Router();

const scraping             = require('./scraping');
const services             = require('./services');
const serSemillero         = require('./services/semillero');


router.post('/login', function(req, res, next) {
  // ******** login de YPFB   *******
  var log = new services(req, res, next);
  log.loginLDAP();
});

router.post('/token', function(req, res, next) {
  // ******** login de YPFB   *******
  var log = new services(req, res, next);
  log.loginLDAPToken();
});


router.get('/buscar', function(req, res, next) {
  // ******** login de YPFB   *******
  var log = new services(req, res, next);
  log.buscarLDAP();
});




module.exports = router;