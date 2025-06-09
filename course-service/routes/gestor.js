const express = require('express');
const router = express.Router();
const gestorController = require('../controllers/gestorController');

router.post('/cursos', gestorController.criarCurso);
router.put('/cursos/:id', gestorController.editarCurso);
router.delete('/cursos/:id', gestorController.excluirCurso);
router.post('/cursos/vincular-formador', gestorController.vincularFormador);

module.exports = router;
