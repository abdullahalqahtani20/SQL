/* query 4 */
SELECT word, COUNT(*) AS word_count
FROM (
  SELECT unnest(string_to_array(lower(title), ' ')) AS word
  FROM film
) AS word_table
WHERE word NOT IN ('the', 'a', 'an', 'and', 'of', 'in', 'to', 'is', 'for', 'as')
  AND word <> ''
GROUP BY word
HAVING COUNT(*) >= 5  
ORDER BY word_count DESC
LIMIT 5;

/* query 3 */
SELECT actor.first_name || ' ' || actor.last_name AS actor_name,
       AVG(DATE_PART('day', rental.return_date - rental.rental_date)) AS average_rental_duration
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE film.length > 120
GROUP BY actor_name
ORDER BY average_rental_duration DESC;

/* query 2 */
SELECT city,
       title AS top_film,
       MAX(total_revenue) AS max_revenue,
       CASE 
           WHEN city IN ('London', 'Paris', 'Madrid') THEN 'Europe'
           WHEN city IN ('New York', 'Los Angeles', 'Chicago') THEN 'North America'
           ELSE 'Other'
       END AS region
FROM (
    SELECT city,
           f.title,
           SUM(p.amount) AS total_revenue,
           DENSE_RANK() OVER (PARTITION BY city ORDER BY SUM(p.amount) DESC) AS film_rank
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN payment p ON r.rental_id = p.rental_id
    JOIN customer c ON r.customer_id = c.customer_id
    JOIN address a ON c.address_id = a.address_id
    JOIN city ct ON a.city_id = ct.city_id
    GROUP BY city, f.title
) AS film_revenue_ranked
WHERE film_rank = 1
GROUP BY city, top_film
ORDER BY region, max_revenue DESC; 

/* query 1 */
SELECT EXTRACT(YEAR FROM rental_date) AS rental_year,
       name AS category_name,
       COUNT(*) AS rental_count,
       RANK() OVER (PARTITION BY EXTRACT(YEAR FROM rental_date) ORDER BY COUNT(*) DESC) AS category_rank
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film_category ON inventory.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY rental_year, category_name
ORDER BY rental_year, category_rank;