const pool = require('../config/dbEvaluations');

module.exports = {
  getInqueritosPorFormando: async (formandoId) => {
    const res = await pool.query(
      'SELECT i.* FROM inquéritos i JOIN formandos f ON f.curso_id = i.curso_id WHERE f.id = $1',
      [formandoId]
    );
    return res.rows;
  }
};
