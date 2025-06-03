const express = require('express');
const router = express.Router();
const courseController = require('../controllers/courseController');
const roles = require('../middlewares/roles');

// Listar cursos (todos podem ver)
router.get('/', courseController.list);

// Criar curso (apenas gestor)
router.get('/create', roles.isGestor, courseController.showCreate);
router.post('/create', roles.isGestor, courseController.create);

// Editar curso (gestor ou formador vinculado)
router.get('/:id/edit', roles.isAuthenticated, roles.isCourseInstructorOrGestor, courseController.showEdit);
router.post('/:id/edit', roles.isAuthenticated, roles.isCourseInstructorOrGestor, courseController.edit);

// Deletar curso (apenas gestor)
router.post('/:id/delete', roles.isGestor, courseController.delete);

module.exports = router;
