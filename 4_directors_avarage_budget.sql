SELECT p.id, p.first_name, p.last_name, ROUND(AVG(m.budget::numeric), 2) AS average_budget
FROM people p
  LEFT JOIN movies m ON p.id = m.director_id
GROUP BY p.id;
