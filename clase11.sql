USE sakila;
1-
SELECT * FROM film f 
LEFT JOIN inventory i 
ON f.film_id = i.film_id 
WHERE i.film_id IS NULL
2-
SELECT f.title, i.inventory_id, r.rental_id
    FROM film f 
    INNER JOIN inventory i ON f.film_id = i.film_id
    LEFT JOIN rental r ON i.inventory_id = r.inventory_id
    WHERE r.rental_id IS NULL;
3-
SELECT customer.first_name,customer.last_name,inventory.store_id,film.title, rental.rental_date,rental.return_date 
    FROM film 
    INNER JOIN inventory USING (film_id) 
    INNER JOIN rental USING (inventory_id) 
    INNER JOIN customer USING (customer_id) 
    WHERE rental.return_date IS NOT NULL 
    ORDER BY inventory.store_id,customer.last_name;
4-
SELECT
    CONCAT_WS(" ", ci.city, co.country) AS 'address',
    CONCAT_WS(" ", st.first_name, st.last_name) AS 'name',
    s.store_id,
    SUM(p.amount) AS 'total_sales'
    FROM store s
    INNER JOIN customer c ON s.store_id = c.store_id
    INNER JOIN rental r ON c.customer_id = r.customer_id
    INNER JOIN payment p ON r.rental_id = p.rental_id
    INNER JOIN address a ON s.address_id = a.address_id
    INNER JOIN city ci ON a.city_id = ci.city_id
    INNER JOIN country co ON ci.country_id = co.country_id
    INNER JOIN staff st ON s.manager_staff_id = st.staff_id
    GROUP BY s.store_id;
5-
SELECT actor.actor_id, actor.first_name, actor.last_name, COUNT(actor_id) AS film_count 
    FROM actor 
    INNER JOIN film_actor USING (actor_id) 
    GROUP BY actor_id, actor.first_name, actor.last_name 
    HAVING COUNT(actor_id) >= (SELECT COUNT(film_id) 
    FROM film_actor 
    GROUP BY actor_id 
    ORDER BY 1 DESC LIMIT 1) 
    ORDER BY film_count desc;