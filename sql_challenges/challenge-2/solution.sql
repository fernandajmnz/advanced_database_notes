-- Lesson 6

SELECT Title, Domestic_sales, International_sales
FROM Movies
JOIN Boxoffice
ON movies.id = Boxoffice.movie_id

SELECT Title, Domestic_sales, International_sales
FROM Movies
JOIN Boxoffice
ON movies.id = Boxoffice.movie_id
WHERE International_sales > Domestic_sales;

SELECT Title, Rating
FROM Movies
JOIN Boxoffice
ON movies.id = Boxoffice.movie_id
ORDER BY Rating desc

--Lesson 7 

SELECT DISTINCT Building
FROM Employees;

SELECT Building_name, Capacity
FROM Buildings;

SELECT DISTINCT Building_name, Role
FROM Buildings
LEFT JOIN Employees
ON buildings.building_name = employees.building;

--Interview Question
SELECT pages.page_id
FROM pages
LEFT JOIN page_likes
  ON pages.page_id = page_likes.page_id
WHERE page_likes.page_id ISNULL
ORDER BY pages.page_id ASC;