exports.isAuthenticated = (req, res, next) => {
  if (req.session.user) return next();
  res.redirect('/users/login');
};

exports.isGestor = (req, res, next) => {
  if (req.session.user && req.session.user.role === 'gestor') return next();
  res.status(403).send('Acesso restrito ao gestor');
};

exports.isCourseInstructorOrGestor = async (req, res, next) => {
  const Course = require('../models/course');
  const course = await Course.findById(req.params.id);
  if (!course) return res.status(404).send('Curso não encontrado');
  if (
    req.session.user.role === 'gestor' ||
    (req.session.user.role === 'formador' && course.instructor_id === req.session.user.id)
  ) {
    return next();
  }
  res.status(403).send('Acesso negado');
};
