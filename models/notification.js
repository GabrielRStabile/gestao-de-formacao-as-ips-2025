const db = require('../config/dbNotifications');

module.exports = {
  async create(notification) {
    const res = await db.query(
      `INSERT INTO notifications(user_id, type, content, status)
      VALUES($1, $2, $3, $4) RETURNING *`,
      [notification.user_id, notification.type, notification.content, notification.status || 'PENDING']
    );
    return res.rows[0];
  },
  async listByUser(user_id) {
    const res = await db.query('SELECT * FROM notifications WHERE user_id=$1', [user_id]);
    return res.rows;
  }
};
