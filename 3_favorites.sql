SELECT u.id, u.username, ARRAY_AGG(f.movie_id) AS favorite_movies
FROM users u
LEFT JOIN favorites f ON u.id = f.user_id
GROUP BY u.id, u.username;