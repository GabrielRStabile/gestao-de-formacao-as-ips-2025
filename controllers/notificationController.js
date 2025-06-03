const Notification = require('../models/notification');

exports.list = async (req, res) => {
  if (!req.session.user) return res.redirect('/users/login');
  const notifications = await Notification.listByUser(req.session.user.id);
  res.render('notifications/list', { notifications });
};
