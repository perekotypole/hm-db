SELECT d.id, d.first_name, d.last_name, ROUND(AVG(m.budget::numeric), 2) AS average_budget
FROM directors d
LEFT JOIN movies m ON d.id = m.director_id
GROUP BY d.id;
