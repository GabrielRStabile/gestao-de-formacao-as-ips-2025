const express = require('express');
const router = express.Router();
const courseController = require('../controllers/courseController');
const roles = require('../middlewares/roles');

// Listar cursos (todos podem ver)
router.get('/', courseController.list);

// Criar curso (apenas gestor)
router.get('/create', roles.isAuthenticated, roles.isGestor, courseController.showCreate);
router.post('/create', roles.isAuthenticated, roles.isGestor, courseController.create);

// Editar curso (apenas gestor)
router.get('/:id/edit', roles.isAuthenticated, roles.isGestor, courseController.showEdit);
router.post('/:id/edit', roles.isAuthenticated, roles.isGestor, courseController.edit);

// Excluir curso (apenas gestor)
router.post('/:id/delete', roles.isAuthenticated, roles.isGestor, courseController.delete);

// Inscrever-se (formando)
router.post('/:id/enroll', roles.isAuthenticated, courseController.enroll);

// Visualizar inscrições do formando
router.get('/my-enrollments', roles.isAuthenticated, courseController.myEnrollments);

module.exports = router;
