const pool = require('../config/dbEvaluations');

exports.visualizarRelatorioCurso = async (req, res) => {
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
