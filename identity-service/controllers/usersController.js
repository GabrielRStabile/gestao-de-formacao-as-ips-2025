const User = require('../models/user');
const bcrypt = require('bcrypt');
const isValidNIF = require('../utils/nifValidator');

exports.showRegister = (req, res) => res.render('users/register', { error: null });
exports.showLogin = (req, res) => res.render('users/login', { error: null });

exports.register = async (req, res) => {
  try {
    if (!isValidNIF(req.body.nif)) {
      return res.render('users/register', { error: 'NIF inválido' });
    }
    await User.create(req.body);
    res.redirect('/users/login');
  } catch (err) {
    res.render('users/register', { error: err.message });
  }
};

exports.login = async (req, res) => {
  const user = await User.findByEmail(req.body.email);
  if (user && await bcrypt.compare(req.body.password, user.password)) {
    req.session.user = { id: user.id, name: user.name, role: user.role, email: user.email };
    res.redirect('/');
  } else {
    res.render('users/login', { error: 'Credenciais inválidas' });
  }
};

exports.logout = (req, res) => {
  req.session.destroy();
  res.redirect('/');
};

exports.profile = async (req, res) => {
  const user = await User.findById(req.session.user.id);
  res.render('users/profile', { user });
};

exports.showEditProfile = async (req, res) => {
  const user = await User.findById(req.session.user.id);
  res.render('users/edit', { user, error: null });
};

exports.editProfile = async (req, res) => {
  if (!isValidNIF(req.body.nif)) {
    return res.render('users/edit', { user: req.body, error: 'NIF inválido' });
  }
  try {
    await User.update(req.session.user.id, req.body);
    req.session.user.name = req.body.name;
    res.redirect('/users/profile');
  } catch (err) {
    res.render('users/edit', { user: req.body, error: err.message });
  }
};

//Alterar password
exports.showResetPassword = (req, res) => {
  res.render('users/change-password', { error: null });
};

exports.resetPassword = async (req, res) => {
  const { email, newPassword, confirmPassword } = req.body;
  if (!email || !newPassword || !confirmPassword) {
    return res.render('users/change-password', { error: 'Todos os campos são obrigatórios.' });
  }
  if (newPassword !== confirmPassword) {
    return res.render('users/change-password', { error: 'As palavras-passe não coincidem.' });
  }
  const user = await User.findByEmail(email);
  if (!user) {
    return res.render('users/change-password', { error: 'Email não encontrado.' });
  }
  await User.updatePassword(user.id, newPassword);
  res.redirect('/users/login');
};


// CRUD para gestor
exports.list = async (req, res) => {
  const users = await User.listAll();
  res.render('users/list', { users });
};

exports.showEditUser = async (req, res) => {
  const user = await User.findById(req.params.id);
  res.render('users/edit', { user, error: null });
};

exports.editUser = async (req, res) => {
  if (!isValidNIF(req.body.nif)) {
    return res.render('users/edit', { user: req.body, error: 'NIF inválido' });
  }
  try {
    await User.update(req.params.id, req.body);
    res.redirect('/users');
  } catch (err) {
    res.render('users/edit', { user: req.body, error: err.message });
  }
};

exports.deleteUser = async (req, res) => {
  try {
    await User.delete(req.params.id);
    res.redirect('/users');
  } catch (err) {
    res.status(500).send('Erro ao deletar usuário');
  }
};