const { Pool, Client } = require('pg');

const pool = new Pool({
  user: 'yun',
  password: '123',
  host: 'localhost',
  database: 'bootcampx'
});

const cohortsName = process.argv[2] || 'JUL02';

pool.query(`
SELECT distinct teachers.name as teacher, cohorts.name as cohort
FROM teachers
JOIN assistance_requests ON teacher_id = teachers.id
JOIN students ON student_id = students.id
JOIN cohorts ON cohort_id = cohorts.id
WHERE cohorts.name = $1
ORDER BY teacher;
`, [cohortsName])
  .then(res => {
    res.rows.forEach(user => {
      console.log(`${user.cohort}: ${user.teacher} `);
      pool.end()
    });
  })
  .catch(err => console.error('query error', err.stack));
console.log('connected');