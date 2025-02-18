SELECT * FROM imdb.names;
SELECT * FROM imdb.names;
SELECT 
    SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS name_nulls,
    SUM(CASE WHEN height IS NULL THEN 1 ELSE 0 END) AS height_nulls,
    SUM(CASE WHEN date_of_birth IS NULL THEN 1 ELSE 0 END) AS date_of_birth_nulls,
    SUM(CASE WHEN known_for_movies IS NULL THEN 1 ELSE 0 END) AS known_for_movies_nulls
FROM names;
SELECT 
    n.name AS actor_name,
    COUNT(rm.movie_id) AS movie_count
FROM 
    names n
JOIN 
    role_mapping rm ON n.id = rm.name_id
JOIN 
    movie m ON rm.movie_id = m.id
WHERE 
    rm.category = 'actor'
    AND YEAR(m.date_published) BETWEEN 2015 AND 2020
GROUP BY 
    n.name
ORDER BY 
    movie_count DESC
LIMIT 5;


SELECT 
    n.name AS director_name,
    COUNT(m.id) AS movie_count
FROM 
    names n
JOIN 
    director_mapping dm ON n.id = dm.name_id
JOIN 
    movie m ON dm.movie_id = m.id
JOIN 
    ratings r ON m.id = r.movie_id
WHERE 
    r.median_rating >= 7
GROUP BY 
    n.name
HAVING 
    movie_count > 5;
    
    SELECT 
    n.name AS director_name
FROM 
    names n
JOIN 
    director_mapping dm ON n.id = dm.name_id
JOIN 
    genre g ON dm.movie_id = g.movie_id
JOIN 
    ratings r ON g.movie_id = r.movie_id
WHERE 
    g.genre = 'Action'
    AND r.avg_rating > 8
GROUP BY 
    n.name;

