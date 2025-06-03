const express = require('express');
const router = express.Router();
const evaluationController = require('../controllers/evaluationController');

router.get('/course/:id', evaluationController.showSurvey);
router.post('/course/:id', evaluationController.submitSurvey);

module.exports = router;
