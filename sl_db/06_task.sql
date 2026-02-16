\c nc_flix

-- Create an output to display the information on our customers. It should include:
-- name
-- location
-- loyalty membership status (see below)

-- Loyalty membership tiers:
-- - 'doesn't even go here' - 0 points
-- - 'bronze status' - < 10 points
-- - 'silver status' - 10 - 100 points
-- - 'gold status' - > 100 points
--------------------------------------------------------------------------------------------

-- conditional expressions in a SELECT clause 

SELECT
    customer_name,
    location,
    --loyalty_points,
    CASE
        WHEN loyalty_points IS NULL THEN 'doesn''t even go here'
        WHEN loyalty_points = 0 THEN 'doesn''t even go here'
        WHEN loyalty_points < 10 THEN 'bronze status'
        WHEN loyalty_points >= 10 and loyalty_points <= 100 THEN 'silver status'
        WHEN loyalty_points > 100 THEN 'gold status'
    END AS loyalty_membership_status
FROM
    customers;

-- NULL is not a value so cannot be handled with =,>,< --> IS NULL 


-- We want more information on our customers:
-- name
-- age
-- location
-- loyalty points
-- We would also like to order them by location, and then within their location groups, 
-- order by number of loyalty points, high to low.
-----------------------------------------------------------------------------------------

SELECT
    customer_name,
    --EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM date_of_birth) AS age,
    EXTRACT(YEAR FROM AGE(date_of_birth)) AS age, 
    location,
    loyalty_points
FROM
    customers
ORDER BY 
    location,
    loyalty_points DESC NULLS LAST;



