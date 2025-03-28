/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */

SELECT first_name, last_name
FROM actor
WHERE (first_name, last_name) IN
(
    SELECT DISTINCT first_name, last_name
    FROM film_actor
    JOIN actor ON film_actor.actor_id = actor.actor_id
    JOIN film_category ON film_category.film_id = film_actor.film_id
    WHERE film_category.category_id = 3
) AND (first_name, last_name) NOT IN
(
    SELECT DISTINCT first_name, last_name
    FROM film_actor
    JOIN actor ON film_actor.actor_id = actor.actor_id
    JOIN film_category ON film_category.film_id = film_actor.film_id
    WHERE film_category.category_id = 11
)
;
