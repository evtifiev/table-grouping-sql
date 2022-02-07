CREATE TABLE IF NOT EXISTS Students (
  id SERIAL PRIMARY KEY,
  name CHARACTER VARYING(45),
  age INTEGER,
  registration_date TIMESTAMP
);
CREATE TABLE IF NOT EXISTS Teachers (
  id SERIAL PRIMARY KEY,
  name CHARACTER VARYING(45),
  salary INTEGER,
  age INTEGER
);
CREATE TYPE CourseType AS ENUM ('design', 'programming', 'marketing', 'management', 'business');

CREATE TABLE IF NOT EXISTS Courses (
  id SERIAL PRIMARY KEY,
  name CHARACTER VARYING(500),
  duration INTEGER,
  type CourseType,
  description CHARACTER VARYING(500),
  teacher_id INTEGER REFERENCES Teachers(id),
  students_count INTEGER,
  price INTEGER,
  price_per_hour INTEGER
);
CREATE TABLE IF NOT EXISTS Subscriptions (
  student_id INTEGER REFERENCES Students(id) ON UPDATE CASCADE ON DELETE CASCADE,
  course_id  INTEGER REFERENCES Courses(id) ON UPDATE CASCADE,
  subscription_date TIMESTAMP NOT NULL DEFAULT CURRENT_DATE,
  CONSTRAINT subscription_pkey PRIMARY KEY (student_id, course_id)
);