-- Made By Zackary Paulson

-- Problem 1: A famous Terrier
SELECT Movie.name, Movie.year
FROM Movie, Person, MovieCast, Person AS Actor
WHERE Movie.director_id = Person.id
AND Movie.id = MovieCast.movie_id
AND MovieCast.actor_id = Actor.id
AND Actor.name = 'Geena Davis' AND Actor.year = 'SFA \'79';

-- Problem 2: Runtimes of R-rated movies
SELECT MIN(runtime) AS shortest, MAX(runtime) AS longest, AVG(runtime) AS average
FROM Movie
WHERE rating = 'R';

-- Problem 3: Spielberg Oscars
SELECT Oscar.type, Oscar.year, Movie.name
FROM Oscar, Movie
WHERE Oscar.movie_id = Movie.id
AND Movie.director_id = (SELECT id FROM Person WHERE name = 'Steven Spielberg');

-- Problem 4: Common POBs
SELECT birthplace AS pob, COUNT(birthplace) AS "number of people"
FROM Person
WHERE birthplace IS NOT NULL
GROUP BY birthplace
HAVING COUNT(birthplace) >= 50;

-- Problem 5: How many movies without Oscars?
SELECT COUNT(*) AS "number of movies without Oscars"
FROM Movie
WHERE id NOT IN (SELECT movie_id FROM Oscar);

-- Problem 6: Actors from Sweden
SELECT Person.name, COUNT(MovieCast.actor_id) AS "number of movies acted"
FROM Person, MovieCast
LEFT OUTER JOIN Movie ON MovieCast.actor_id = Person.id
WHERE Person.birthplace LIKE '%Sweden'
GROUP BY Person.name
ORDER BY COUNT(MovieCast.actor_id) DESC, Person.name;

-- Problem 7: Directors of R-rated movies
SELECT COUNT(DISTINCT director_id) AS "number of directors"
FROM Movie
WHERE rating = 'R';

-- Problem 8: Changing a movie's rating
UPDATE Movie
SET rating = 'PG-13'
WHERE name LIKE 'Indiana Jones%' AND year = '1984';
