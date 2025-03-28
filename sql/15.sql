/*
 * Find every documentary film that is rated G.
 * Report the title and the actors.
 *
 * HINT:
 * Getting the formatting right on this query can be tricky.
 * You are welcome to try to manually get the correct formatting.
 * But there is also a view in the database that contains the correct formatting,
 * and you can SELECT from that VIEW instead of constructing the entire query manually.
 */

SELECT title,
       STRING_AGG(CONCAT(INITCAP(first_name), INITCAP(last_name)), ', ') AS actors
FROM film
JOIN film_category USING (film_id)
JOIN category USING (category_id)
JOIN film_actor USING (film_id)
JOIN actor USING (actor_id)
WHERE category.name ILIKE 'Documentary' AND film.rating = 'G'
GROUP BY film.title
ORDER BY film.title;

