Complete the frist 5 lessons of https://sqlbolt.com/

## Lesson 1 
SELECT Title 
FROM movies;

SELECT Director 
FROM movies;

SELECT Director, title 
FROM movies;

SELECT title, year
FROM movies;

SELECT Director, year 
FROM movies;

SELECT * 
FROM movies;

## Lesson 2

SELECT title
FROM movies
WHERE id=6

SELECT *
FROM movies
WHERE year
BETWEEN 2000 AND 2010

SELECT *
FROM movies
WHERE year
NOT BETWEEN 2000 AND 2010

SELECT *
FROM movies
WHERE id < 6

## Lesson 3

SELECT *
FROM movies
WHERE title LIKE "%Toy Story%"

SELECT *
FROM movies
WHERE director LIKE "John Lasseter"

SELECT *
FROM movies
WHERE director NOT LIKE "John Lasseter"

SELECT *
FROM movies
WHERE title LIKE "Wall-%"

## Lesson 4
SELECT DISTINCT Director
FROM movies
ORDER BY Director ASC;

SELECT title, year
FROM Movies
ORDER BY year DESC
LIMIT 4;

SELECT title
FROM Movies
ORDER BY title ASC
LIMIT 5;

SELECT title
FROM Movies
ORDER BY title ASC
LIMIT 5 OFFSET 5;

## Lesson 5
SELECT City, Population
FROM north_american_cities
WHERE Country = 'Canada';

SELECT City, latitude
FROM north_american_cities
WHERE Country = 'United States'
ORDER BY latitude DESC; 

SELECT *
FROM north_american_cities
WHERE Longitude < -87.629798
ORDER BY Longitude asc

SELECT City, Population
FROM north_american_cities
WHERE Country = 'Mexico'
ORDER BY Population desc 
LIMIT 2; 

SELECT City, Population
FROM north_american_cities
WHERE Country = 'United States'
ORDER BY Population desc 
LIMIT 2 OFFSET 2; 