SELECT t.name as name, AVG(st.age) as age FROM students st
JOIN subscriptions sub ON st.id = sub.student_id
JOIN courses c ON sub.course_id = c.id
JOIN teachers t ON c.teacher_id = t.id
GROUP BY t.name;