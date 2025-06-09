const cursoModel = require('../models/cursoModel');

exports.listarCursos = async (req, res) => {
  try {
    const cursos = await cursoModel.listarCursos();
    res.json(cursos);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
