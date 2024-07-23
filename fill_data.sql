INSERT INTO files (filename, mime_type, key, url)
VALUES
  ('poster1.jpg', 'image/jpeg', 'key1', 'http://example.com/poster1.jpg'),
  ('poster2.jpg', 'image/jpeg', 'key2', 'http://example.com/poster2.jpg');

INSERT INTO users (username, first_name, last_name, email, password, avatar_id)
VALUES
  ('johndoe1', 'John', 'Doe', 'john.doe1@example.com', 'password123', 1),
  ('janedoe2', 'Jane', 'Doe', 'jane.doe2@example.com', 'password456', 2);

INSERT INTO countries (name)
VALUES ('Ukraine'), ('USA'), ('UK');

INSERT INTO genres (name)
VALUES ('Action'), ('Comedy'), ('Fantasy');

INSERT INTO movies (title, description, budget, release_date, duration, poster_id, country_id, director_id)
VALUES
  ('Movie A', 'An action-packed adventure.', '100000', '2024-07-01', '3 hours', 1, 1, 1),
  ('Movie B', 'A comedy about friends.', '50000', '2024-08-01', '1.5 hours', 2, 2, 2),
  ('Movie D', null, '150000', '2015-07-01', '2.3 hours', 1, 3, 2);

INSERT INTO movies_genres (movie_id, genre_id)
VALUES (1, 1), (2, 2), (2, 3);

INSERT INTO characters (name, description, role_type)
VALUES
  ('Hero', 'The main hero of the story.', 'leading'),
  ('Sidekick', 'The sidekick who helps the hero.', 'supporting');

INSERT INTO people (first_name, last_name, biography, birth_date, gender)
VALUES
  ('Tom', 'Hanks', 'Famous actor known for his roles in various movies.', '1956-07-09', 'Male'),
  ('Emma', 'Watson', 'Actress known for her role in Harry Potter series.', '1990-04-15', 'Female');

INSERT INTO people_photos (photo_id, person_id, is_primary)
VALUES (1, 1, TRUE), (1, 2, FALSE), (2, 2, FALSE);

INSERT INTO movies_roles (movie_id, character_id, person_id)
VALUES (1, 1, 1), (1, 2, 2), (2, 2, 1);

INSERT INTO favorites (movie_id, user_id)
VALUES (1, 1), (1, 2), (2, 2);
