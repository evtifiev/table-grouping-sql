#!/bin/bash
set -e
export PGPASSWORD=$POSTGRES_PASSWORD;
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  CREATE USER $APP_DB_USER WITH PASSWORD '$APP_DB_PASS';
  CREATE DATABASE $APP_DB_NAME;
  GRANT ALL PRIVILEGES ON DATABASE $APP_DB_NAME TO $APP_DB_USER;
  \connect $APP_DB_NAME $APP_DB_USER
  BEGIN;
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
      student_id INTEGER REFERENCES Students(id),
      course_id  INTEGER REFERENCES Teachers(id),
      subscription_date TIMESTAMP
    );
  COMMIT;
EOSQL