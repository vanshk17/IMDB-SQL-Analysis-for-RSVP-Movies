SELECT * FROM imdb.genre;

SELECT * FROM imdb.genre;
SELECT DISTINCT genre
FROM genre; 

SELECT g.genre, COUNT(m.id) AS number_of_movies
FROM genre g
JOIN movie m ON g.movie_id = m.id 
GROUP BY g.genre
ORDER BY number_of_movies DESC;  

SELECT COUNT(*) AS total_movies_with_one_genre
FROM (
    SELECT m.id
    FROM movies m
    INNER JOIN genre g ON m.id = g.movie_id  -- Join the movies table with the genre table
    GROUP BY m.id
    HAVING COUNT(g.genre) = 1  -- Only movies with one genre
) AS single_genre_movies;

SELECT g.genre, AVG(m.duration) AS average_duration
FROM movie m
JOIN genre g ON m.id = g.movie_id 
GROUP BY g.genre;

WITH GenreRank AS (
    SELECT genre, 
           COUNT(*) AS number_of_movies,
           RANK() OVER (ORDER BY COUNT(*) DESC) AS genre_rank
    FROM genre g
    JOIN movie m ON g.movie_id = m.id  -- Adjust this join condition based on your schema
    GROUP BY genre
)
SELECT genre_rank
FROM GenreRank
WHERE genre = 'thriller';


SELECT m.title, r.avg_rating, g.genre
FROM movie m
JOIN ratings r ON m.id = r.movie_id
JOIN genre g ON m.id = g.movie_id
WHERE m.title LIKE 'The%' AND r.avg_rating > 8
ORDER BY g.genre, r.avg_rating DESC;

SELECT * FROM imdb.genre;
WITH top_genres AS (
    SELECT g.genre, COUNT(*) AS movie_count
    FROM genre g
    JOIN ratings r ON g.movie_id = r.movie_id
    WHERE r.avg_rating > 8
    GROUP BY g.genre
    ORDER BY movie_count DESC
    LIMIT 3
),
top_directors AS (
    SELECT n.name AS director_name, COUNT(*) AS movie_count,
           ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS director_rank
    FROM names n
    JOIN director_mapping dm ON n.id = dm.name_id
    JOIN genre g ON dm.movie_id = g.movie_id
    JOIN ratings r ON g.movie_id = r.movie_id
    WHERE r.avg_rating > 8 AND g.genre IN (SELECT genre FROM top_genres)
    GROUP BY n.name
)
SELECT director_name, movie_count
FROM top_directors
WHERE director_rank <= 3
ORDER BY movie_count DESC;

SELECT 
    g.genre,
    AVG(r.avg_rating) AS average_rating
FROM 
    genre g
JOIN 
    movie m ON g.movie_id = m.id
JOIN 
    ratings r ON m.id = r.movie_id
WHERE 
    YEAR(m.date_published) = 2020
GROUP BY 
    g.genre
ORDER BY 
    average_rating DESC
LIMIT 5;



