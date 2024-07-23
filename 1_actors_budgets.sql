SELECT p.id, p.first_name, p.last_name, SUM(m.budget) as total_budget
FROM people p
  JOIN movies_roles mr ON p.id = mr.person_id
  JOIN movies m ON mr.movie_id = m.id
GROUP BY p.id, p.first_name, p.last_name;
