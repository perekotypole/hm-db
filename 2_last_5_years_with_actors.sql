SELECT m.id, m.title, m.release_date, COUNT(DISTINCT mr.person_id) AS actors
FROM movies m
LEFT JOIN movies_roles mr ON m.id = mr.movie_id
WHERE m.release_date >= CURRENT_DATE - INTERVAL '5 years'
GROUP BY m.id, m.title, m.release_date;
