/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */

SELECT name, film.title, film_rentals.rental_count AS "total rentals"
FROM category
JOIN film_category USING (category_id)
JOIN film USING (film_id)
JOIN (
    SELECT film_id, COUNT(rental_id) AS rental_count
    FROM film
    JOIN inventory USING (film_id)
    JOIN rental USING (inventory_id)
    GROUP BY film_id
) film_rentals USING (film_id)
JOIN (
    SELECT fc.category_id, f.film_id, f.title,
           RANK() OVER (PARTITION BY fc.category_id ORDER BY rental_count DESC, f.title DESC) AS rank
    FROM film_category fc
    JOIN film f USING (film_id)
    JOIN (
        SELECT film_id, COUNT(rental_id) AS rental_count
        FROM film
        JOIN inventory USING (film_id)
        JOIN rental USING (inventory_id)
        GROUP BY film_id
    ) film_rentals USING (film_id)
) ranked_films USING (category_id, film_id)
WHERE ranked_films.rank <= 5
ORDER BY name, film_rentals.rental_count DESC, film.title;

