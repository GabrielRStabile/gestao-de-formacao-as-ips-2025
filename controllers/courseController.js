const Course = require('../models/course');

exports.list = async (req, res) => {
  const courses = await Course.listAll();
  res.render('courses/list', { courses, user: req.session.user });
};

exports.showCreate = (req, res) => {
  res.render('courses/create', { error: null, user: req.session.user });
};

exports.create = async (req, res) => {
  try {
    const course = await Course.create(req.body);
    res.redirect('/courses');
  } catch (err) {
    res.render('courses/create', { error: err.message, user: req.session.user });
  }
};

exports.showEdit = async (req, res) => {
  const course = await Course.findById(req.params.id);
  if (!course) return res.status(404).send('Curso não encontrado');
  res.render('courses/edit', { course, error: null, user: req.session.user });
};

exports.edit = async (req, res) => {
  try {
    await Course.update(req.params.id, req.body);
    res.redirect('/courses');
  } catch (err) {
    const course = await Course.findById(req.params.id);
    res.render('courses/edit', { course, error: err.message, user: req.session.user });
  }
};

exports.delete = async (req, res) => {
  try {
    await Course.delete(req.params.id);
    res.redirect('/courses');
  } catch (err) {
    res.status(500).send('Erro ao deletar curso');
  }
};
