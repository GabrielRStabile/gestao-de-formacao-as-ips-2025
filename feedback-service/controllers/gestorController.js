const pool = require('../config/dbEvaluations');

exports.criarInquerito = async (req, res) => {
  const { titulo, descricao, gestor_id, curso_id } = req.body;
  try {
    const result = await pool.query(
      'INSERT INTO inquéritos (titulo, descricao, gestor_id, curso_id) VALUES ($1, $2, $3, $4) RETURNING *',
      [titulo, descricao, gestor_id, curso_id]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.emitirRelatorioCurso = async (req, res) => {
  const { cursoId } = req.params;
  try {
    const result = await pool.query(
      `SELECT i.titulo, r.resposta, p.texto as pergunta
       FROM respostas_formando r
       JOIN perguntas_inquerito p ON r.pergunta_id = p.id
       JOIN inquéritos i ON p.inquérito_id = i.id
       JOIN formandos f ON r.formando_id = f.id
       WHERE f.curso_id = $1`,
      [cursoId]
    );
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.emitirRelatorioFormador = async (req, res) => {
  const { formadorId } = req.params;
  try {
    const result = await pool.query(
      `SELECT i.titulo, r.resposta, p.texto as pergunta
       FROM respostas_formando r
       JOIN perguntas_inquerito p ON r.pergunta_id = p.id
       JOIN inquéritos i ON p.inquérito_id = i.id
       JOIN cursos_formadores cf ON i.curso_id = cf.curso_id
       WHERE cf.formador_id = $1`,
      [formadorId]
    );
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
