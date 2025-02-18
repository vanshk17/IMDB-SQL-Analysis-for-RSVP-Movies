SELECT * FROM imdb.movie;
SELECT
    COUNT(*) - COUNT(country) AS country_nulls,
    COUNT(*) - COUNT(worlwide_gross_income) AS gross_income_nulls,
    COUNT(*) - COUNT(languages) AS languages_nulls,
    COUNT(*) - COUNT(production_company) AS production_company_nulls,
    COUNT(*) - COUNT(title) AS title_nulls,
    COUNT(*) - COUNT(year) AS year_nulls,
    COUNT(*) - COUNT(duration) AS duration_nulls,
    COUNT(*) - COUNT(date_published) AS date_published_nulls
FROM movie;
SELECT 
    YEAR(date_published) AS Year,
    COUNT(*) AS number_of_movies
FROM 
    movie
GROUP BY 
    YEAR(date_published)
ORDER BY 
    Year;
SELECT 
    MONTH(date_published) AS month_num,
    COUNT(*) AS number_of_movies
FROM 
    movie
WHERE 
    date_published IS NOT NULL  
GROUP BY 
    MONTH(date_published)
ORDER BY 
    month_num;

SELECT 
    COUNT(*) AS number_of_movies
FROM 
    movie
WHERE 
    (country = 'USA' OR country = 'India') 
    AND YEAR(date_published) = 2019;  
WITH RankedMovies AS (
    SELECT 
        m.title, 
        r.avg_rating,
        RANK() OVER (ORDER BY r.avg_rating DESC) AS movie_rank
    FROM 
        movie m
    JOIN 
        ratings r ON m.id = r.movie_id  -- Adjust if necessary based on your schema
)

SELECT 
    title, 
    avg_rating, 
    movie_rank
FROM 
    RankedMovies
WHERE 
    movie_rank <= 10
ORDER BY 
    Movie_rank;


SELECT * FROM movie;
SELECT *
FROM movie
WHERE date_published BETWEEN '2017-03-01' AND '2017-03-31';
SELECT m.*, r.total_votes
FROM movie m
JOIN ratings r ON m.id = r.movie_id
WHERE m.date_published BETWEEN '2017-03-01' AND '2017-03-31';
SELECT m.*, r.total_votes
FROM movie m
JOIN ratings r ON m.id = r.movie_id
WHERE m.country = 'USA'
  AND m.date_published BETWEEN '2017-03-01' AND '2017-03-31';
SELECT m.*, r.total_votes
FROM movie m
JOIN ratings r ON m.id = r.movie_id
WHERE m.country = 'USA'
  AND m.date_published BETWEEN '2017-03-01' AND '2017-03-31';
SELECT g.genre, COUNT(m.id) AS movie_count
FROM movie m
JOIN ratings r ON m.id = r.movie_id
JOIN genre g ON m.id = g.movie_id
WHERE m.country = 'USA'
  AND m.date_published BETWEEN '2017-03-01' AND '2017-03-31'
  AND r.total_votes > 1000
GROUP BY g.genre;


SELECT * FROM imdb.movie;
SELECT COUNT(*) AS movie_count
FROM movie m
JOIN ratings r ON m.id = r.movie_id
WHERE m.date_published BETWEEN '2018-04-01' AND '2019-04-01'
  AND r.median_rating = 8;
  
  
SELECT 
    CASE 
        WHEN SUM(CASE WHEN m.country = 'Germany' THEN r.total_votes ELSE 0 END) >
             SUM(CASE WHEN m.country = 'Italy' THEN r.total_votes ELSE 0 END)
        THEN 'Yes'
        ELSE 'No'
    END AS german_more_votes
FROM movie m
JOIN ratings r ON m.id = r.movie_id
WHERE m.country IN ('Germany', 'Italy');



SELECT 
    m.production_company,
    AVG(r.avg_rating) AS average_rating
FROM 
    movie m
    
    SELECT 
    m.country,
    COUNT(*) AS total_movies
FROM 
    movie m
WHERE 
    YEAR(m.date_published) = 2021
GROUP BY 
    m.country
ORDER BY 
    total_movies DESC;

JOIN 
    ratings r ON m.id = r.movie_id
WHERE 
    YEAR(m.date_published) = 2020
GROUP BY 
    m.production_company
ORDER BY 
    average_rating DESC;
    
    SELECT 
    m.country,
    COUNT(*) AS total_movies
FROM 
    movie m
WHERE 
    YEAR(m.date_published) = 2021
GROUP BY 
    m.country
ORDER BY 
    total_movies DESC;
    
    SELECT 
    m.country,
    COUNT(*) AS total_movies
FROM 
    movie m
WHERE 
    YEAR(m.date_published) = 2021
GROUP BY 
    m.country
ORDER BY 
    total_movies DESC;




