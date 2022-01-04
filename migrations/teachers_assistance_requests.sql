CREATE table teachers (
  id serial primary key NOT  NULL,
  name varchar(255) NOT NULL,
  start_date date,
  end_date date,
  is_active boolean default TRUE
);

CREATE table assistance_requests (
  id serial primary key NOT NULL,
  assignment_id integer REFERENCES assignments(id) on delete CASCADE,
  student_id integer REFERENCES students(id) on delete CASCADE,
  teacher_id integer REFERENCES teachers(id) on delete CASCADE,
  created_at timestamp,
  started_at timestamp,
  completed_at timestamp,
  student_feedback TEXT,
  techer_feedback TEXT
);