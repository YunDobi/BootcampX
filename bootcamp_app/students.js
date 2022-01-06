const { Pool } = require('pg');

const pool = new Pool({
  user: 'yun',
  password: '123',
  host: 'localhost',
  database: 'bootcampx'
});


pool.query(`
SELECT students.id, students.name, cohort_id
FROM students
JOIN cohorts on cohorts.id = cohort_id
WHERE cohorts.name LIKE '%${process.argv[2]}%'
LIMIT ${process.argv[3]};
`)
  .then(res => {
    res.rows.forEach(user => {
      console.log(`${user.name} has an id of ${user.id} and was in the ${user.cohort_id} cohort`);
    });
  })
  .catch(err => console.error('query error', err.stack));