const db = require('../config/dbCourses');

module.exports = {
  async create(course) {
    const res = await db.query(
      `INSERT INTO courses(title, description, max_capacity, start_date, end_date, instructor_id)
      VALUES($1,$2,$3,$4,$5,$6) RETURNING *`,
      [course.title, course.description, course.max_capacity, course.start_date, course.end_date, course.instructor_id]
    );
    return res.rows[0];
  },
  async listAll() {
    const res = await db.query('SELECT * FROM courses');
    return res.rows;
  },
  async findById(id) {
    const res = await db.query('SELECT * FROM courses WHERE id=$1', [id]);
    return res.rows[0];
  },
  async update(id, course) {
    const res = await db.query(
      `UPDATE courses SET title=$1, description=$2, max_capacity=$3, start_date=$4, end_date=$5, instructor_id=$6 WHERE id=$7 RETURNING *`,
      [course.title, course.description, course.max_capacity, course.start_date, course.end_date, course.instructor_id, id]
    );
    return res.rows[0];
  },
  async delete(id) {
    await db.query('DELETE FROM courses WHERE id=$1', [id]);
  }
};
