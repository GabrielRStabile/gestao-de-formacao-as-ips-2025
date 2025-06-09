const express = require('express');
const router = express.Router();
const gestorController = require('../controllers/gestorController');

router.post('/inquerito', gestorController.criarInquerito);
router.get('/relatorio/curso/:cursoId', gestorController.emitirRelatorioCurso);
router.get('/relatorio/formador/:formadorId', gestorController.emitirRelatorioFormador);

module.exports = router;
