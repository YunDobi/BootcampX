--Get the total number of assistance_requests for a teacher.
select count(*) as total_assistance, teachers.name
from assistance_requests
join teachers on teacher_id = teachers.id
where name = 'Waylon Boehm'
group by teachers.name;

--Get the total number of assistance_requests for a student.
select count(*) as total_assistances, students.name from assistance_requests
join students on student_id = students.id
where name = 'Elliot Dickinson'
group by name;

--Get important data about each assistance request.
SELECT teachers.name as teacher, students.name as student, assignments.name as assignment,(completed_at - started_at) as duration
FROM assistance_requests
JOIN teachers on teachers.id = teacher_id
JOIN students on students.id = student_id
JOIN assignments on assignments.id = assignment_id
ORDER by duration;

--Get the average time of an assistance request.
select avg(completed_at - started_at) as average_assistance_request_duration
from assistance_requests;

--Get the average duration of assistance requests for each cohort.
select cohorts.name as name, avg(completed_at - started_at) as average_assistance_time
from assistance_requests
join students on students.id = student_id
join cohorts on cohorts.id = cohort_id
group by cohorts.name
order by average_assistance_time;

--Get the cohort with the longest average duration of assistance requests
select cohorts.name as name, avg(completed_at - started_at) as average_assistance_time
from assistance_requests
join students on students.id = student_id
join cohorts on cohorts.id = cohort_id
group by cohorts.name
order by average_assistance_time desc
limit 1;

--Calculate the average time it takes to start an assistance request.
SELECT avg(started_at-created_at) as average_wait_time
FROM assistance_requests;

--Get the total duration of all assistance requests for each cohort.
SELECT cohorts.name as cohort, sum(completed_at-started_at) as total_duration
FROM assistance_requests
JOIN students ON students.id = student_id
JOIN cohorts on cohorts.id = cohort_id
GROUP BY cohorts.name
ORDER BY total_duration;

--Calculate the average total duration of assistance requests for each cohort
select avg(total_duration) as average_total_duration
from (SELECT cohorts.name as cohort, sum(completed_at-started_at) as total_duration
FROM assistance_requests
JOIN students ON students.id = student_id
JOIN cohorts on cohorts.id = cohort_id
GROUP BY cohorts.name
ORDER BY total_duration) as total_duration;

--List each assignment with the total number of assistance requests with it.
SELECT assignments.id, name, day, chapter, count(assistance_requests) as total_requests
FROM assignments
JOIN assistance_requests ON assignments.id = assignment_id
GROUP BY assignments.id
ORDER BY total_requests DESC;

--Get each day with the total number of assignments and the total duration of the assignments.
SELECT assignments.day as day, count(*) as number_of_assignments, sum(duration) as duration
from assignments
group by assignments.day
ORDER by day;

--Get the name of all teachers that performed an assistance request during a cohort.
SELECT distinct teachers.name as teacher, cohorts.name as cohort
FROM teachers
JOIN assistance_requests ON teacher_id = teachers.id
JOIN students ON student_id = students.id
JOIN cohorts ON cohort_id = cohorts.id
WHERE cohorts.name = 'JUL02'
ORDER BY teacher;

--Perform the same query as before, but include the number of assistances as well.
SELECT distinct teachers.name as teacher, cohorts.name as cohort, count(assistance_requests) as total_assistances
FROM teachers
JOIN assistance_requests ON teacher_id = teachers.id
JOIN students ON student_id = students.id
JOIN cohorts ON cohort_id = cohorts.id
WHERE cohorts.name = 'JUL02'
GROUP BY teachers.name, cohorts.name
ORDER BY teacher;