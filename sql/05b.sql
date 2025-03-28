/*
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 */

SELECT film.title                                            FROM film
JOIN film_actor USING (film_id)
WHERE actor_id IN
(
    SELECT actor_id
    FROM film_actor
    JOIN film ON film_actor.film_id = film.film_id
    WHERE film.title ILIKE 'AMERICAN CIRCUS'
)
GROUP BY title
HAVING COUNT(DISTINCT actor_id) >= 2
ORDER BY title
;
