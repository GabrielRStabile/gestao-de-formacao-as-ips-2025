const pool = require('../config/dbCourses');

module.exports = {
  listarCursos: async () => {
    const res = await pool.query('SELECT * FROM cursos');
    return res.rows;
  },
  criarCurso: async (nome, descricao, capacidade_maxima) => {
    const res = await pool.query(
      'INSERT INTO cursos (nome, descricao, capacidade_maxima) VALUES ($1, $2, $3) RETURNING *',
      [nome, descricao, capacidade_maxima]
    );
    return res.rows[0];
  },
  editarCurso: async (id, nome, descricao, capacidade_maxima) => {
    const res = await pool.query(
      'UPDATE cursos SET nome = $1, descricao = $2, capacidade_maxima = $3 WHERE id = $4 RETURNING *',
      [nome, descricao, capacidade_maxima, id]
    );
    return res.rows[0];
  },
  excluirCurso: async (id) => {
    await pool.query('DELETE FROM cursos WHERE id = $1', [id]);
  },
  vincularFormador: async (cursoId, formadorId) => {
    await pool.query(
      'INSERT INTO cursos_formadores (curso_id, formador_id) VALUES ($1, $2) ON CONFLICT DO NOTHING',
      [cursoId, formadorId]
    );
  },
  editarMateriais: async (cursoId, materiais) => {
    const res = await pool.query(
      'UPDATE cursos SET materiais = $1 WHERE id = $2 RETURNING *',
      [materiais, cursoId]
    );
    return res.rows[0];
  },
  editarPlaneamento: async (cursoId, planeamento) => {
    const res = await pool.query(
      'UPDATE cursos SET planeamento = $1 WHERE id = $2 RETURNING *',
      [planeamento, cursoId]
    );
    return res.rows[0];
  }
};
