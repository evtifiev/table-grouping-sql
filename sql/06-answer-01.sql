SELECT st.name as name, SUM(duration) FROM students st
JOIN subscriptions sub ON st.id = sub.student_id
JOIN courses c ON sub.course_id = c.id
GROUP BY st.name;