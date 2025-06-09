const pool = require('./config');

module.exports = {
  getCursoById: async (id) => {
    const res = await pool.query('SELECT * FROM cursos WHERE id = $1', [id]);
    return res.rows[0];
  }
};
