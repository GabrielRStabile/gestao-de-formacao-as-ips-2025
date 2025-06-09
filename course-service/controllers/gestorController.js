const cursoModel = require('../models/cursoModel');

exports.criarCurso = async (req, res) => {
  const { nome, descricao, capacidade_maxima } = req.body;
  try {
    const curso = await cursoModel.criarCurso(nome, descricao, capacidade_maxima);
    res.status(201).json(curso);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.editarCurso = async (req, res) => {
  const { id } = req.params;
  const { nome, descricao, capacidade_maxima } = req.body;
  try {
    const curso = await cursoModel.editarCurso(id, nome, descricao, capacidade_maxima);
    res.json(curso);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.excluirCurso = async (req, res) => {
  const { id } = req.params;
  try {
    await cursoModel.excluirCurso(id);
    res.status(204).send();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.vincularFormador = async (req, res) => {
  const { cursoId, formadorId } = req.body;
  try {
    await cursoModel.vincularFormador(cursoId, formadorId);
    res.status(201).send();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};
