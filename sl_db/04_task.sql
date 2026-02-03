\c nc_flix

-- Query the database to find a list of all the locations in which customers live that don't contain 
-- a store.

SELECT location FROM customers
EXCEPT
SELECT city FROM stores;

-- (EXCEPT returns all rows that are in the result of query1 but not in the result of query2.)



-- Query the database to find a list of all the locations we have influence over (locations of stores 
-- and/or customers). There should be no repeated data.

SELECT location FROM customers
UNION
SELECT city FROM stores;

-- (UNION effectively joins the result of query2 to the result of query1 and deletes duplicates)



-- From a list of our stores which have customers living in the same location, calculate which store 
-- has the largest catalogue of stock. What is the most abundant genre in that store?

WITH valid_stores AS(
    SELECT location FROM customers
    INTERSECT
    SELECT city FROM stores  
),

largest_catalogue_stores AS(
        SELECT
            COUNT(stock.stock_id) AS total_catalogue,
            stores.city
        FROM
            stock
        JOIN stores on stores.store_id = stock.store_id
        WHERE stores.city IN (SELECT location FROM valid_stores)
        GROUP BY stores.city
        ORDER BY COUNT(stock.stock_id) DESC
        LIMIT 1
    )
SELECT
    genres.genre_name,
    COUNT(stock.stock_id) AS total,
    stores.city
FROM genres
JOIN movies_genres ON genres.genre_id = movies_genres.genre_id
JOIN movies ON movies_genres.movie_id = movies.movie_id
JOIN stock ON movies.movie_id = stock.movie_id
JOIN stores ON stock.store_id =  stores.store_id
WHERE stores.city IN (SELECT location FROM valid_stores)
GROUP BY genres.genre_name, stores.city
ORDER BY total DESC
LIMIT 1;



-- -- stores where we have customers living 
-- SELECT location FROM customers
-- INTERSECT
-- SELECT city FROM stores;
-- --(INTERSECT returns all rows that are both in the result of query1 and in the result of query2 without duplicates)

-- -- store with largest catalogue
-- SELECT
--     COUNT(stock.stock_id) AS total_catalogue,
--     stores.city,
--     stores.store_id
-- FROM
--     stock
-- JOIN stores on stores.store_id = stock.store_id
-- GROUP BY stores.store_id
-- ORDER BY COUNT(stock.stock_id) DESC
-- LIMIT 1;

-- -- most abundant genre in that store
-- SELECT
--     genres.genre_name,
--     COUNT(stock.stock_id),
--     stores.city
-- FROM
--     genres
-- JOIN movies_genres ON genres.genre_id = movies_genres.genre_id
-- JOIN movies ON movies_genres.movie_id = movies.movie_id
-- JOIN stock ON movies.movie_id = stock.movie_id
-- JOIN stores ON stock.store_id =  stores.store_id
-- GROUP BY stores.store_id, genres.genre_name
-- ORDER BY stores.city;

