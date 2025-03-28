/* 
 * You also like the acting in the movies ACADEMY DINOSAUR and AGENT TRUMAN,
 * and so you'd like to see movies with actors that were in either of these movies or AMERICAN CIRCUS.
 *
 * Write a SQL query that lists all movies where at least 3 actors were in one of the above three movies.
 * (The actors do not necessarily have to all be in the same movie, and you do not necessarily need one actor from each movie.)
 */

SELECT film2.title
FROM film_actor f1
JOIN film ON f1.film_id = film.film_id
JOIN film_actor f2 ON f1.actor_id = f2.actor_id
JOIN film film2 ON f2.film_id = film2.film_id
WHERE film.title IN ('AMERICAN CIRCUS', 'ACADEMY DINOSAUR', 'AGENT TRUMAN')
GROUP BY film2.film_id, film2.title
HAVING COUNT(f1.actor_id) >= 3
ORDER BY film2.title;

