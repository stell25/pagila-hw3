/*
 * List the total amount of money that customers from each country have payed.
 * Order the results from most to least money.
*/

SELECT country, sum(payment) as total_payments
FROM customer
JOIN address USING (address_id)
JOIN city USING (city_id)
JOIN country USING (country_id)
LEFT JOIN (
    SELECT customer_id, sum(amount) as payment
    FROM customer
    JOIN payment USING (customer_id)
    GROUP BY customer_id
) cust_pay USING (customer_id)
GROUP BY country
ORDER BY sum(payment) DESC;

