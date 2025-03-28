/*
 * Management wants to create a "best sellers" list for each actor.
 *
 * Write a SQL query that:
 * For each actor, reports the three films that the actor starred in that have brought in the most revenue for the company.
 * (The revenue is the sum of all payments associated with that film.)
 *
 * HINT:
 * For correct output, you will have to rank the films for each actor.
 * My solution uses the `rank` window function.
 */
SELECT actor_id, first_name, last_name, film.film_id, title, actor_films.rank, revenue
FROM actor
JOIN film_actor USING (actor_id)
JOIN film USING (film_id)
JOIN (
    -- Calculate total revenue for each film
    SELECT film.film_id, SUM(payment.amount) AS revenue
    FROM film
    JOIN inventory USING (film_id)
    JOIN rental USING (inventory_id)
    JOIN payment USING (rental_id)
    GROUP BY film.film_id
) AS flim_revenue USING (film_id)
JOIN (
    -- Rank each film per actor based on revenue
    SELECT actor_id, film_id, 
           RANK() OVER (PARTITION BY actor_id ORDER BY revenue DESC, film_id ASC) AS rank
    FROM film_actor
    JOIN (
        SELECT film.film_id, SUM(payment.amount) AS revenue
        FROM film
        JOIN inventory USING (film_id)
        JOIN rental USING (inventory_id)
        JOIN payment USING (rental_id)
        GROUP BY film.film_id
    ) AS flim_revenue USING (film_id)
) AS actor_films USING (actor_id, film_id)
WHERE actor_films.rank <= 3
ORDER BY actor_id, actor_films.rank;

