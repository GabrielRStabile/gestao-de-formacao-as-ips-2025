const cursoModel = require('../models/cursoModel');

exports.editarMateriais = async (req, res) => {
  const { cursoId } = req.params;
  const { materiais } = req.body;
  try {
    const curso = await cursoModel.editarMateriais(cursoId, materiais);
    res.json(curso);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.editarPlaneamento = async (req, res) => {
  const { cursoId } = req.params;
  const { planeamento } = req.body;
  try {
    const curso = await cursoModel.editarPlaneamento(cursoId, planeamento);
    res.json(curso);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
