\c nc_flix

-- Query the database to find the number of films in stock for each genre.

SELECT
    g.genre_name,
    COUNT(s.stock_id) AS total_movies    
FROM genres g 
JOIN movies_genres mg ON g.genre_id = mg.genre_id
JOIN movies m ON mg.movie_id = m.movie_id
JOIN stock s ON m.movie_id = s.movie_id 
GROUP BY g.genre_name
ORDER BY COUNT(s.stock_id);

-- Query the database to find the average rating for films in stock in Newcastle.

SELECT
    ROUND(AVG(movies.rating), 2) AS average_rating,
    COUNT(stock.stock_id) AS qty_in_stock,
    stores.city
FROM movies
JOIN stock on movies.movie_id = stock.movie_id
JOIN stores ON stock.stock_id = stores.store_id
WHERE stores.city = 'Newcastle' 
GROUP BY stores.city
HAVING COUNT(stock.stock_id) >= 1;

-- Query the database to retrieve all the films released in the 90s that have a rating greater 
-- than the total average.

SELECT AVG(rating) FROM movies;

SELECT
    m.title,
    m.release_date,
    m.rating
FROM movies m
WHERE m.release_date >= '1990-01-01' AND m.release_date < '2000-01-01'
    AND m.rating > (SELECT ROUND(AVG(rating)) FROM movies);



-- Query the database to find the total number of copies that are in stock for the top-rated film 
-- from a pool of the five most recently released films.

-- want one result only : top-rated film from 5 most recenlty released films

SELECT * FROM movies;

SELECT
    movies.title,
    COUNT(stock.stock_id) AS total_copies
FROM movies
JOIN stock ON movies.movie_id = stock.movie_id
WHERE movies.movie_id = (SELECT movies.movie_id
        FROM movies
        ORDER BY movies.release_date DESC, rating DESC
        LIMIT 1)
GROUP BY movies.title
;

-- ensuring the pool to pick from is 5 most recent releases 
SELECT
    movies.title,
    movies.release_date,
    COUNT(stock.stock_id) AS total_copies
FROM movies
JOIN stock ON movies.movie_id = stock.movie_id
WHERE movies.movie_id = (
    SELECT movie_id 
    FROM (
        SELECT movie_id
        FROM movies 
        ORDER BY release_date DESC 
        LIMIT 5
    ) recent_movies
    ORDER BY rating DESC
    LIMIT 1
)
GROUP BY movies.title, movies.release_date;
                    



 