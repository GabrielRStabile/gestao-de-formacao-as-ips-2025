const express = require('express');
const router = express.Router();
const formadorController = require('../controllers/formadorController');

router.put('/cursos/:cursoId/materiais', formadorController.editarMateriais);
router.put('/cursos/:cursoId/planeamento', formadorController.editarPlaneamento);

module.exports = router;
