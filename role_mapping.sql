SELECT * FROM imdb.role_mapping;
SELECT table_name, table_rows
FROM information_schema.tables
WHERE table_schema = 'imdb'
ORDER BY table_rows DESC;
SELECT
    SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS country_nulls,
    SUM(CASE WHEN worldwide_gross_income IS NULL THEN 1 ELSE 0 END) AS gross_income_nulls,
    SUM(CASE WHEN languages IS NULL THEN 1 ELSE 0 END) AS languages_nulls,
    SUM(CASE WHEN production_company IS NULL THEN 1 ELSE 0 END) AS production_company_nulls,
    SUM(CASE WHEN title IS NULL THEN 1 ELSE 0 END) AS title_nulls,
    SUM(CASE WHEN year IS NULL THEN 1 ELSE 0 END) AS year_nulls,
    SUM(CASE WHEN duration IS NULL THEN 1 ELSE 0 END) AS duration_nulls,
    SUM(CASE WHEN date_published IS NULL THEN 1 ELSE 0 END) AS date_published_nulls
FROM movie;

