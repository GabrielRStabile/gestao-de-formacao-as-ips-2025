const Course = require('../models/course');
const Enrollment = require('../models/enrollment');

// Listar cursos
exports.list = async (req, res) => {
  const courses = await Course.listAll();
  let userEnrollments = [];
  if (req.session.user && req.session.user.role === 'formando') {
    userEnrollments = await Enrollment.getUserEnrollments(req.session.user.id);
  }
  res.render('courses/list', {
    courses,
    user: req.session.user,
    userEnrollments
  });
};

// CRUD do gestor
exports.showCreate = (req, res) => {
  res.render('courses/create', { error: null, user: req.session.user });
};
exports.create = async (req, res) => {
  try {
    await Course.create(req.body);
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

// Inscrição do formando
exports.enroll = async (req, res) => {
  if (!req.session.user || req.session.user.role !== 'formando') {
    return res.status(403).send('Acesso restrito aos formandos!');
  }
  const courseId = req.params.id;
  await Enrollment.enroll(req.session.user.id, courseId);
  res.redirect('/courses');
};

// Visualizar inscrições do formando
exports.myEnrollments = async (req, res) => {
  if (!req.session.user || req.session.user.role !== 'formando') {
    return res.status(403).send('Acesso restrito aos formandos!');
  }
  const enrolledCourses = await Enrollment.getUserEnrollments(req.session.user.id);
  res.render('courses/my-enrollments', {
    courses: enrolledCourses,
    user: req.session.user
  });
};
