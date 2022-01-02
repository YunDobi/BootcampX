create table cohorts (
  id serial primary key,
  name varchar(255),
  start_date date,
  end_date date
);

create table students (
  id serial primary key,
  name varchar(255),
  email varchar(255),
  phone varchar(255),
  github varchar(255),
  start_date date,
  end_date date,
  cohort_id integer references cohorts(id) on delete cascade
);