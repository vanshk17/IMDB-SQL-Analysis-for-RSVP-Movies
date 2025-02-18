SELECT * FROM imdb.director_mapping;
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
