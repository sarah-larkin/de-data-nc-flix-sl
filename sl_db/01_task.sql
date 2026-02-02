\c nc_flix

-- Query the database to retrieve all of the movie titles that were released 
-- in the 21st century.

SELECT
    title,
    release_date
FROM 
    movies
WHERE release_date >= '01-01-2000';


-- Query the database to find the oldest customer.

SELECT
    customer_name,
    date_of_birth
FROM 
    customers
ORDER BY 
    date_of_birth
LIMIT 1;

-- SELECT
--     customer_name,
--     date_of_birth
-- FROM 
--     customers
-- WHERE date_of_birth = (SELECT MIN(date_of_birth) FROM customers);



-- Query the database to find the customers whose name begins with the letter D.
-- Organise the results by age, youngest to oldest.

SELECT
    customer_name,
    date_of_birth
FROM
    customers
WHERE customer_name LIKE 'D%'
ORDER BY date_of_birth DESC;

-- The rise in living costs is affecting rentals. Drop the cost of all rentals by
-- 5% and display the updated table. As this is a monetary value, make sure it is
-- rounded to 2 decimal places.

-- SELECT * FROM movies;

-- UPDATE movies
-- SET cost = ROUND(cost * 0.95, 2);

SELECT * FROM movies;