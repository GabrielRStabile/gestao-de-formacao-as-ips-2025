const express = require('express');
const router = express.Router();
const formadorController = require('../controllers/formadorController');

router.get('/relatorio/:formadorId', formadorController.visualizarRelatorioCurso);

module.exports = router;
