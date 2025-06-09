const express = require('express');
const router = express.Router();
const formandoController = require('../controllers/formandoController');

router.get('/inquerito/:formandoId', formandoController.visualizarInquerito);
router.post('/resposta', formandoController.responderInquerito);

module.exports = router;
