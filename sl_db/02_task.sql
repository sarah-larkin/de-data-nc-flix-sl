\c nc_flix

-- Query the database to find the average rating of the movies released in the 1980s.

SELECT
    title,
    release_date,
    ROUND(AVG(rating), 0) AS average_rating    
FROM movies
WHERE release_date >= '1980-01-01' and release_date < '1990-01-01'
GROUP BY title, release_date
ORDER BY average_rating;



-- Query the database to list the locations of our customers, as well as the total and 
-- average number of loyalty points for all customers. You can assume that if the loyalty 
-- points row is empty, they are a new customer so they should have the value set to zero.

SELECT
    location,
    SUM(CASE WHEN loyalty_points IS NULL THEN 0 ELSE loyalty_points END) AS total_points,
    ROUND(AVG(CASE WHEN loyalty_points IS NULL THEN 0 ELSE loyalty_points END), 2) AS average_points
FROM
    customers
GROUP BY customers.location;

    