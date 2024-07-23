DROP TABLE IF EXISTS
  favorites,
  movies_roles,
  movies_genres,
  people_photos,
  people,
  characters,
  movies,
  genres,
  countries,
  directors,
  users,
  files;

DROP TYPE IF EXISTS role_type;

CREATE TABLE files (
  id SERIAL PRIMARY KEY,

  filename VARCHAR(100) NOT NULL,
  mime_type VARCHAR(50) NOT NULL,
  key TEXT,
  url VARCHAR(150),

  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE users (
  id SERIAL PRIMARY KEY,

  username VARCHAR(30) UNIQUE NOT NULL,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30),
  email VARCHAR(50) UNIQUE NOT NULL,
  password VARCHAR(30) NOT NULL,
  avatar_id INT,

  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (avatar_id) REFERENCES files(id)
);

CREATE TABLE countries (
  id SERIAL PRIMARY KEY,

  name VARCHAR(50) UNIQUE NOT NULL,

  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE directors (
  id SERIAL PRIMARY KEY,

  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30),

  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE genres (
  id SERIAL PRIMARY KEY,

  name VARCHAR(50) UNIQUE NOT NULL,

  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE movies (
  id SERIAL PRIMARY KEY,

  title VARCHAR(50) NOT NULL,
  description TEXT,
  budget MONEY,
  release_date DATE,
  duration INTERVAL,
  poster_id INT,
  country_id INT,
  director_id INT,

  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  UNIQUE (title, release_date),

  FOREIGN KEY (poster_id) REFERENCES files(id),
  FOREIGN KEY (country_id) REFERENCES countries(id),
  FOREIGN KEY (director_id) REFERENCES directors(id)
);

CREATE TABLE movies_genres (
  movie_id INT NOT NULL,
  genre_id INT NOT NULL,

  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY (movie_id, genre_id),
  FOREIGN KEY (movie_id) REFERENCES movies(id),
  FOREIGN KEY (genre_id) REFERENCES genres(id)
);


CREATE TYPE role_type AS ENUM ('leading', 'supporting', 'background');

CREATE TABLE characters (
  id SERIAL PRIMARY KEY,

  name VARCHAR(100) NOT NULL,
  description TEXT,
  role_type role_type,

  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE people (
  id SERIAL PRIMARY KEY,

  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30),
  biography TEXT,
  birth_date DATE,
  gender VARCHAR(30),

  UNIQUE (first_name, last_name, birth_date),

  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE people_photos (
  id SERIAL PRIMARY KEY,

  photo_id INT NOT NULL,
  person_id INT NOT NULL,
  is_primary BOOLEAN DEFAULT FALSE,

  UNIQUE (photo_id, person_id),

  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (photo_id) REFERENCES files(id),
  FOREIGN KEY (person_id) REFERENCES people(id)
);

CREATE TABLE movies_roles (
  movie_id INT NOT NULL,
  character_id INT,
  person_id INT,

  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY (movie_id, character_id, person_id),
  FOREIGN KEY (movie_id) REFERENCES movies(id),
  FOREIGN KEY (character_id) REFERENCES characters(id),
  FOREIGN KEY (person_id) REFERENCES people(id)
);

ALTER TABLE movies_roles
  ADD CONSTRAINT check_role 
  CHECK (character_id IS NOT NULL OR person_id IS NOT NULL);

CREATE TABLE favorites (
  movie_id INT NOT NULL,
  user_id INT NOT NULL,

  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY (movie_id, user_id),
  FOREIGN KEY (movie_id) REFERENCES movies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);
