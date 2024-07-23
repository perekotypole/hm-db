WITH movie_data AS (
  SELECT m.id, m.title, m.release_date, m.duration, m.description,
    json_build_object(
      'id', f.id,
      'filename', f.filename,
      'mime_type', f.mime_type,
      'url', f.url
    ) AS poster,
    json_build_object(
      'id', p.id,
      'first_name', p.first_name,
      'last_name', p.last_name
    ) AS director
  FROM movies m
    LEFT JOIN files f ON f.id = m.poster_id
    LEFT JOIN people p ON p.id = m.director_id
  WHERE m.id = 1
),
actors_data AS (
  SELECT ma.movie_id,
    json_agg(
      json_build_object(
        'id', p.id,
        'first_name', p.first_name,
        'last_name', p.last_name,
        'photo', json_build_object(
          'id', pf.id,
          'filename', pf.filename,
          'mime_type', pf.mime_type,
          'url', pf.url
        )
      )
    ) AS actors
  FROM movies_roles ma
    LEFT JOIN people p ON ma.person_id = p.id
    LEFT JOIN people_photos pp ON ma.person_id = p.id AND pp.is_primary is TRUE
    LEFT JOIN files pf ON pp.photo_id = pf.id
  WHERE ma.movie_id = 1
  GROUP BY ma.movie_id
),
genres_data AS (
  SELECT mg.movie_id,
    json_agg(
      json_build_object(
        'id', g.id,
        'name', g.name
      )
    ) AS genres
  FROM movies_genres mg
    LEFT JOIN genres g ON mg.genre_id = g.id
  WHERE mg.movie_id = 1
  GROUP BY mg.movie_id
)
SELECT md.id, md.title, md.release_date, md.duration, md.description, md.poster, md.director,
  COALESCE(ad.actors, '[]'::json) AS actors,
  COALESCE(gd.genres, '[]'::json) AS genres
FROM movie_data md
  LEFT JOIN actors_data ad ON md.id = ad.movie_id
  LEFT JOIN genres_data gd ON md.id = gd.movie_id;
