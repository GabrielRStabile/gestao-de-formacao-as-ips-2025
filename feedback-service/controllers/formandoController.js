const pool = require('../config/dbEvaluations');
const avaliacaoModel = require('../models/avaliacaoModel');

exports.visualizarInquerito = async (req, res) => {
  const { formandoId } = req.params;
  try {
    const inqueritos = await avaliacaoModel.getInqueritosPorFormando(formandoId);
    res.json(inqueritos);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.responderInquerito = async (req, res) => {
  const { formandoId, perguntaId, resposta } = req.body;
  try {
    const result = await pool.query(
      'INSERT INTO respostas_formando (formando_id, pergunta_id, resposta) VALUES ($1, $2, $3) RETURNING *',
      [formandoId, perguntaId, resposta]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
