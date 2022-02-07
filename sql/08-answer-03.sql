SELECT type, AVG(c.price) as price FROM courses c
JOIN teachers t ON c.teacher_id = t.id
GROUP BY type;