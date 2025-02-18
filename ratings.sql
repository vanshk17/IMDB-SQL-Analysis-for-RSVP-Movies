SELECT * FROM imdb.ratings;
SELECT 
    MIN(avg_rating) AS min_avg_rating,
    MAX(avg_rating) AS max_avg_rating,
    MIN(total_votes) AS min_total_votes,
    MAX(total_votes) AS max_total_votes,
    MIN(median_rating) AS min_median_rating,
    MAX(median_rating) AS max_median_rating
FROM ratings;
SELECT 
    r.median_rating, 
    COUNT(*) AS movie_count
FROM 
    ratings r
GROUP BY 
    r.median_rating
ORDER BY 
    r.median_rating;  

SELECT 
    m.production_company,
    COUNT(*) AS movie_count,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS prod_company_rank
FROM 
    movie m
JOIN 
    ratings r ON m.id = r.movie_id  
WHERE 
    r.avg_rating > 8  
GROUP BY 
    m.production_company
ORDER BY 
    movie_count DESC;  



SELECT n.name AS actor_name, COUNT(*) AS movie_count
FROM names n
JOIN role_mapping rm ON n.id = rm.name_id
JOIN ratings r ON rm.movie_id = r.movie_id
WHERE r.median_rating >= 8 AND rm.category = 'actor'
GROUP BY n.name
ORDER BY movie_count DESC
LIMIT 2;

SELECT 
    m.production_company,
    AVG(r.avg_rating) AS average_rating
FROM 
    movie m
JOIN 
    ratings r ON m.id = r.movie_id
WHERE 
    YEAR(m.date_published) = 2020
GROUP BY 
    m.production_company
ORDER BY 
    average_rating DESC;
    
    WITH total_movies AS (
    SELECT COUNT(*) AS total
    FROM movie
    WHERE YEAR(date_published) = 2018
),
movies_above_7 AS (
    SELECT COUNT(*) AS above_7
    FROM movie m
    JOIN ratings r ON m.id = r.movie_id
    WHERE YEAR(m.date_published) = 2018
    AND r.avg_rating > 7
)
SELECT 
    (SELECT above_7 FROM movies_above_7) * 100.0 / (SELECT total FROM total_movies) AS percentage_above_7;

SELECT 
    r.total_votes,
    COUNT(*) AS movie_count
FROM 
    ratings r
JOIN 
    movie m ON r.movie_id = m.id
WHERE 
    YEAR(m.date_published) = 2019
GROUP BY 
    r.total_votes
ORDER BY 
    r.total_votes;
    
    WITH top_genres AS (
    SELECT g.genre, COUNT(*) AS movie_count
    FROM genre g
    JOIN movie m ON g.movie_id = m.id
    WHERE YEAR(m.date_published) = 2018
    GROUP BY g.genre
    ORDER BY movie_count DESC
    LIMIT 3
)
SELECT 
    AVG(r.total_votes) AS average_votes
FROM 
    ratings r
JOIN 
    movie m ON r.movie_id = m.id
JOIN 
    genre g ON m.id = g.movie_id
WHERE 
    g.genre IN (SELECT genre FROM top_genres)
    AND YEAR(m.date_published) = 2018;
    
   SELECT 
    r.total_votes,
    COUNT(*) AS movie_count
FROM 
    ratings r
JOIN 
    movie m ON r.movie_id = m.id
WHERE 
    YEAR(m.date_published) = 2019
GROUP BY 
    r.total_votes
ORDER BY 
    r.total_votes;

WITH top_genres AS (
    SELECT g.genre, COUNT(*) AS movie_count
    FROM genre g
    JOIN movie m ON g.movie_id = m.id
    WHERE YEAR(m.date_published) = 2018
    GROUP BY g.genre
    ORDER BY movie_count DESC
    LIMIT 3
)
SELECT 
    AVG(r.total_votes) AS average_votes
FROM 
    ratings r
JOIN 
    movie m ON r.movie_id = m.id
JOIN 
    genre g ON m.id = g.movie_id
WHERE 
    g.genre IN (SELECT genre FROM top_genres)
    AND YEAR(m.date_published) = 2018;



