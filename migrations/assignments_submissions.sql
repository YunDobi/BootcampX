CREATE table assignments (
  id serial primary key NOT NULL,
  name varchar(250),
  content TEXT,
  day integer,
  chapter integer,
  duration integer
);

CREATE table assignment_submissions (
  id serial primary key NOT NULL,
  assignment_id integer references assignments(id) ON DELETE CASCADE,
  student_id integer REFERENCES students(id) ON DELETE CASCADE,
  duration integer,
  submission_date date
);