const db = require('../config/dbEvaluations');

module.exports = {
  async create(evaluation) {
    const res = await db.query(
      `INSERT INTO evaluations(course_id, user_id, answers)
      VALUES($1,$2,$3) RETURNING *`,
      [evaluation.course_id, evaluation.user_id, JSON.stringify(evaluation.answers)]
    );
    return res.rows[0];
  },
  async listByCourse(course_id) {
    const res = await db.query('SELECT * FROM evaluations WHERE course_id=$1', [course_id]);
    return res.rows;
  }
};
