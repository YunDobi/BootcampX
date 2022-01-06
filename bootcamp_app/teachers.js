const { Pool, Client } = require('pg');

const pool = new Pool({
  user: 'yun',
  password: '123',
  host: 'localhost',
  database: 'bootcampx'
});

pool.query(`
SELECT distinct teachers.name as teacher, cohorts.name as cohort
FROM teachers
JOIN assistance_requests ON teacher_id = teachers.id
JOIN students ON student_id = students.id
JOIN cohorts ON cohort_id = cohorts.id
WHERE cohorts.name = '${process.argv[2] || 'JUL02'}'
ORDER BY teacher;
`)
  .then(res => {
    res.rows.forEach(user => {
      console.log(`${user.cohort}: ${user.teacher} `);
    });
  })
  .catch(err => console.error('query error', err.stack));
console.log('connected');