\c nc_flix

-- Query the database to find the store with the highest total number of copies of sequels. Let's 
-- assume a film is a sequel if the title contains something like 'II' or 'VI'.
---------------------------------------------------------------------------------------------------

WITH sequel_totals AS (
    SELECT
        stores.city,
        COUNT(stock.stock_id) AS total_sequel_copies
    FROM movies
    JOIN stock ON stock.movie_id = movies.movie_id
    JOIN stores ON stores.store_id = stock.store_id
    WHERE movies.title LIKE ANY (ARRAY['%II%', '%III%', '%IV%', '%V%', '%VI%', '%IX%', '%X%'])
    GROUP BY stores.store_id)

SELECT
    city,
    total_sequel_copies,
    ranked
FROM (
    SELECT
        city,
        total_sequel_copies,
        RANK () OVER (
            ORDER BY total_sequel_copies DESC
        ) AS ranked
    FROM sequel_totals
) ranked_results
WHERE ranked = 1;



-- SELECT
--     city,
--     SUM(qty) AS total_sequel_copies
-- FROM (
--     SELECT
--         stores.city,
--         COUNT(stock.stock_id) AS qty
--     FROM movies
--     JOIN stock  ON stock.movie_id = movies.movie_id
--     JOIN stores ON stores.store_id = stock.store_id
--     WHERE movies.title LIKE ANY (
--         ARRAY['%II%', '%III%', '%IV%', '%V%', '%VI%', '%IX%', '%X%']
--     )
--     GROUP BY stores.city, movies.title
-- ) sequel_counts
-- GROUP BY city
-- ORDER BY total_sequel_copies DESC;



-- -- Does not answer the question correctly!! looking at movie level not store level
-- SELECT * FROM (
--     SELECT
--         movies.title,
--         stores.city,
--         COUNT(stock.stock_id) AS total_copies,
--         RANK () OVER (
--             ORDER BY COUNT(stock.stock_id) DESC
--         ) AS most_copies
--     FROM
--         movies
--     JOIN stock ON movies.movie_id = stock.movie_id
--     JOIN stores ON stock.store_id = stores.store_id
--     WHERE movies.title LIKE ANY (ARRAY['%I %','%II%', '%III%', '%IV%', '%V%', '%VI%', '%IX%', '%X%'])
--     GROUP BY movies.title, stores.city 
-- )
-- WHERE most_copies = 1;






-- This is likely not a good way to identify sequels going forward. Alter the movies table to track 
-- this information better and then update the previous query to make use of this new structure.
---------------------------------------------------------------------------------------------------

-- alter the table
-- add column 'no_in_series'
-- Where (roman numerals) change to equivalent
-- else set to 1 
-- select all films with 'no_in_series' > 1 

ALTER TABLE movies
    ADD COLUMN no_in_series INT;

UPDATE movies
SET no_in_series = (
    CASE 
        WHEN movies.title LIKE '%II%' THEN 2 
        WHEN movies.title LIKE '%III%' THEN 3
        WHEN movies.title LIKE '%IV%' THEN 4
        WHEN movies.title LIKE '%V%'THEN 5
        WHEN movies.title LIKE '%VI%' THEN 6
        WHEN movies.title LIKE '%VII%' THEN 7
        WHEN movies.title LIKE '%VIII%' THEN 8
        WHEN movies.title LIKE '%IX%' THEN 9
        WHEN movies.title LIKE '%X%' THEN 10 
        ELSE 1
    END
);

SELECT * FROM movies;


-- Query the database to find the store with the highest total number of copies of sequels. Let's 
-- assume a film is a sequel if the title contains something like 'II' or 'VI'.

WITH sequel_totals AS (
    SELECT
        stores.city,
        COUNT(stock.stock_id) AS total_sequel_copies
    FROM movies
    JOIN stock ON stock.movie_id = movies.movie_id
    JOIN stores ON stores.store_id = stock.store_id
    WHERE no_in_series > 1 -- updated here 
    GROUP BY stores.store_id)

SELECT
    city,
    total_sequel_copies,
    ranked
FROM (
    SELECT
        city,
        total_sequel_copies,
        RANK () OVER (
            ORDER BY total_sequel_copies DESC
        ) AS ranked
    FROM sequel_totals
) ranked_results
WHERE ranked = 1;