const Evaluation = require('../models/evaluation');
const EventBus = require('../shared/eventBus');

exports.showSurvey = (req, res) => {
  if (!req.session.user) return res.redirect('/users/login');
  res.render('evaluations/survey', { course_id: req.params.id, user: req.session.user, error: null });
};

exports.submitSurvey = async (req, res) => {
  if (!req.session.user) return res.redirect('/users/login');
  try {
    await Evaluation.create({
      course_id: req.params.id,
      user_id: req.session.user.id,
      answers: req.body
    });
    // Notificação para gestor (simples)
    await EventBus.publish('notifications', {
      type: 'SURVEY',
      user_id: req.session.user.id,
      content: `Sua avaliação do curso foi registrada.`,
      recipient: req.session.user.email
    });
    res.redirect('/courses');
  } catch (err) {
    res.render('evaluations/survey', { course_id: req.params.id, user: req.session.user, error: err.message });
  }
};
