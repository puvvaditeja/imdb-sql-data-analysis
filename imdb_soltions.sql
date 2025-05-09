-- Segment 1:
-- 1. Find the total number of movies released in each year. How does the trend look month-wise? 
-- Part one
SELECT 
    year, COUNT(*) AS number_of_movies
FROM
    movie
GROUP BY year;

-- Part two
SELECT 
    MONTH(date_published) AS month_num, COUNT(*) AS number_of_movies
FROM
    movie
GROUP BY month_num
ORDER BY month_num;

-- 2. Find the unique list of the genres present in the data set?
SELECT DISTINCT
    genre
FROM
    genre;
    
-- 3.Write a SQL query to find those movies, which were released before 2019. Return movie title.
SELECT 
	title,year
FROM 
	movie
WHERE 
	year < 2019
ORDER BY year;

-- 4.Write a SQL query to find those actors with the first name 'A' and the last name 'A' and the Movies_id they are known for. Return actor ID.
SELECT 
	id,name,Known_For_Movies
FROM 
	names
WHERE 
	name LIKE "A%A";

-- 5.Count how many movies each production company has produced
SELECT 
	Production_Company, COUNT(*) AS Number_Of_Movies
FROM 
	movie
GROUP BY Production_Company
ORDER BY Number_Of_Movies DESC;

-- 6.Find the yongest actor (by Date_Of_Birth)
SELECT 
	Name, Date_Of_Birth
FROM 
	names
ORDER BY Date_Of_Birth DESC
LIMIT 1;

-- 7.Write a SQL query to find when the movie 'Secret Superstar' was released. Return movie release year.
select* from movie;
select title,year
from movie
where title = "Secret Superstar";

-- 8.Which genre had the highest number of movies produced overall?
SELECT 
    genre,
    COUNT(movie_id) AS movie_count
FROM
    genre
GROUP BY genre
ORDER BY movie_count DESC
LIMIT 1;
    
-- 9.What is the average duration of movies in each genre? 
SELECT 
    genre,
    AVG(duration) AS avg_duration
FROM
    genre AS g
        LEFT JOIN
    movie AS m 
		ON g.movie_id = m.id
GROUP BY genre;
    
-- 10.Which are the top 10 movies based on average rating?
SELECT 
	title,Avg_Rating,DENSE_RANK() OVER(ORDER BY Avg_Rating DESC) AS Movie_Rank
FROM ratings AS R
JOIN Movie AS M
ON M.id = R.movie_id
LIMIT 10;

-- 11.Summarise the ratings table based on the movie counts by median ratings.
SELECT 
    median_rating, COUNT(movie_id) AS movie_count
FROM
    ratings
GROUP BY median_rating
ORDER BY median_rating;

-- 12.How many movies released in each genre in March 2017 in the USA had more than 1,000 votes?
SELECT 
    genre, 
    COUNT(g.movie_id) AS movie_count
FROM
    genre AS g
        INNER JOIN
    movie AS m 
		ON g.movie_id = m.id
			INNER JOIN
		ratings AS r 
			ON m.id = r.movie_id
WHERE
    year = 2017
        AND MONTH(date_published) = 3
        AND LOWER(country) LIKE '%usa%'
        AND total_votes > 1000
GROUP BY genre
ORDER BY movie_count DESC;

-- 13.Find the movies in each genre that start with the characters ‘The’ and have an average rating > 8.
SELECT 
    title, 
    avg_rating,
    genre
FROM
    movie AS m 
	    INNER JOIN
    genre AS g
    	ON m.id =g.movie_id 
			INNER JOIN
		ratings AS r 
			ON m.id = r.movie_id
WHERE
    title like 'The%' AND avg_rating>8
ORDER BY genre, avg_rating DESC;

-- 14.count the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?
SELECT 
    COUNT(m.id) AS movie_count
FROM
    movie AS m 
	    INNER JOIN
	ratings AS r 
		ON m.id = r.movie_id
WHERE
    median_rating=8 AND 
    date_published BETWEEN '2018-04-01' AND '2019-04-01';

-- 15.Who are the top two actors whose movies have a median rating >= 8?
SELECT 
	n.name as actor_name,
	COUNT(m.id) AS movie_count
FROM
	names AS n
		INNER JOIN
	role_mapping AS a
		ON n.id=a.name_id
			INNER JOIN
        movie AS m
			ON a.movie_id = m.id
				INNER JOIN
            ratings AS r
				ON m.id=r.movie_id
WHERE median_rating>=8 AND category = 'actor'
GROUP BY actor_name
ORDER BY movie_count DESC
LIMIT 2;

/* 16. Consider thriller movies having at least 25,000 votes. Classify them according to their average ratings in
   the following categories: 

			Rating > 8: Superhit
			Rating between 7 and 8: Hit
			Rating between 5 and 7: One-time-watch
			Rating < 5: Flop

*/

SELECT 
    m.title AS movie_name,
    CASE
        WHEN r.avg_rating > 8 THEN 'Superhit'
        WHEN r.avg_rating BETWEEN 7 AND 8 THEN 'Hit'
        WHEN r.avg_rating BETWEEN 5 AND 7 THEN 'One time watch'
        ELSE 'Flop'
    END AS movie_category
FROM
    movie AS m
        LEFT JOIN
    ratings AS r ON m.id = r.movie_id
        LEFT JOIN
    genre AS g ON m.id = g.movie_id
WHERE
    LOWER(genre) = 'thriller'
        AND total_votes > 25000;
 
-- 17.Who are the top actresses based on a number of Super Hit movies (average rating >8) in the drama genre? - Advanced
SELECT 
	name AS actress_name, SUM(total_votes) AS total_votes, COUNT(rm.movie_id) AS movie_id,ROUND(SUM(avg_rating * total_votes)/SUM(total_votes),2) AS actress_avg_rating,DENSE_RANK() OVER(ORDER BY COUNT(rm.movie_id) DESC) AS actress_rank 
FROM 
	names AS n 
		JOIN role_mapping rm 
	ON n.id = rm.name_id 
		JOIN ratings r 
	ON r.movie_id = rm.movie_id 
		JOIN genre g 
	ON g.movie_id = r.movie_id 
WHERE category="actress" AND avg_rating>=8 AND g.genre="Drama" 
GROUP BY name;

 -- 18.Find movies with an average rating higher than the overall average rating of all movies
 SELECT 
	title, Avg_Rating
FROM 
	movie m
		JOIN ratings r 
	ON m.id = r.Movie_Id
WHERE Avg_Rating > (
    SELECT 
		AVG(Avg_Rating) 
	FROM 
		ratings
);

-- 19.Find directors who have directed more than 3 movies
SELECT 
	n.Name, COUNT(dm.Movie_Id) AS Movies_Directed
FROM 
	names n
		JOIN director_mapping dm 
	ON n.id = dm.Name_Id
GROUP BY n.Name
HAVING COUNT(dm.Movie_Id) > 3;

-- 20.Identify all the movies of particular genre
DELIMITER //
CREATE PROCEDURE GetMoviesByGenre(IN genreName VARCHAR(20))
BEGIN
    SELECT m.title, g.Genre
    FROM movie m
    JOIN genre g ON m.id = g.Movie_Id
    WHERE g.Genre = genreName;
END //
DELIMITER ;

CALL GetMoviesByGenre('Action');
