const Joi = require('joi');

const userSchema = Joi.object({
  name: Joi.string().required(),
  date_of_birth: Joi.date().required(),
  nif: Joi.string().required(),
  email: Joi.string().email().required(),
  phone: Joi.string().optional(),
  address: Joi.string().optional(),
  password: Joi.string().min(8).required(),
  role: Joi.string().valid('admin', 'usuario').required(),
});

module.exports = { userSchema };
