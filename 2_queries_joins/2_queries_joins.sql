-- Get the total amount of time that all students from a specific cohort have spent on all assignments.
select  sum(duration) from assignment_submissions
join students on student_id = students.id
 join cohorts on students.cohort_id = cohorts.id
where cohorts.name = 'FEB12';