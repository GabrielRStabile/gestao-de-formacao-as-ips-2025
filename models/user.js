const db = require('../config/dbUsers');
const bcrypt = require('bcrypt');
const isValidNIF = require('../utils/nifValidator');

module.exports = {
  async create(user) {
    if (!isValidNIF(user.nif)) {
      throw new Error('NIF inválido');
    }
    const hash = await bcrypt.hash(user.password, 10);
    const res = await db.query(
      `INSERT INTO users(name, date_of_birth, nif, email, phone, address, password, role)
      VALUES($1,$2,$3,$4,$5,$6,$7,$8) RETURNING *`,
      [
        user.name,
        user.date_of_birth,
        user.nif,
        user.email,
        user.phone,
        user.address,
        hash,
        user.role
      ]
    );
    return res.rows[0];
  },

  async findByEmail(email) {
    const res = await db.query('SELECT * FROM users WHERE email=$1', [email]);
    return res.rows[0];
  },

  async findById(id) {
    const res = await db.query('SELECT * FROM users WHERE id=$1', [id]);
    return res.rows[0];
  },

  async update(id, user) {
    const res = await db.query(
      `UPDATE users SET name=$1, date_of_birth=$2, nif=$3, email=$4, phone=$5, address=$6 WHERE id=$7 RETURNING *`,
      [user.name, user.date_of_birth, user.nif, user.email, user.phone, user.address, id]
    );
    return res.rows[0];
  },

  async updatePassword(id, newPassword) {
    const hash = await bcrypt.hash(newPassword, 10);
    await db.query(`UPDATE users SET password=$1 WHERE id=$2`, [hash, id]);
  },

   async listAll() {
    const res = await db.query('SELECT * FROM users');
    return res.rows;
  },

  async delete(id) {
    await db.query('DELETE FROM users WHERE id=$1', [id]);
  }
  
};
