const express = require('express');
const router = express.Router();
const userController = require('../controllers/usersController');
const roles = require('../middlewares/roles');

// Rotas de autenticação
router.get('/register', userController.showRegister);
router.post('/register', userController.register);
router.get('/login', userController.showLogin);
router.post('/login', userController.login);
router.get('/logout', userController.logout);

// Perfil e edição (acesso apenas autenticado)
router.get('/profile', roles.isAuthenticated, userController.profile);
router.get('/edit', roles.isAuthenticated, userController.showEditProfile);
router.post('/edit', roles.isAuthenticated, userController.editProfile);

// Alteração de senha (acesso apenas autenticado)
router.get('/change-password', roles.isAuthenticated, userController.showChangePassword);
router.post('/change-password', roles.isAuthenticated, userController.changePassword);

// CRUD de usuários (apenas gestor)
router.get('/', roles.isGestor, userController.list);
router.get('/:id/edit', roles.isGestor, userController.showEditUser);
router.post('/:id/edit', roles.isGestor, userController.editUser);
router.post('/:id/delete', roles.isGestor, userController.deleteUser);

module.exports = router;
