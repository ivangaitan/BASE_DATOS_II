USE sakila;
1-
SELECT co.country, count(c.city_id) 
	FROM city c INNER JOIN country co 
	ON c.country_id = co.country_id 
		GROUP BY co.country_id 
		ORDER BY co.country_id;
2-
SELECT country, COUNT(c.city_id) AS cities
    FROM country co INNER JOIN city c
    ON co.country_id = c.country_id
    GROUP BY co.country_id
    HAVING cities > 10
    ORDER BY cities desc;
3-
SELECT
    CONCAT_WS(" ", last_name, first_name) AS name,
    (SELECT a.address FROM address a WHERE c.address_id = a.address_id) AS address,
    (SELECT COUNT(*) FROM rental r WHERE c.customer_id = r.customer_id GROUP BY c.customer_id) AS films_rented,
    (SELECT SUM(p.amount) FROM payment p WHERE c.customer_id = p.customer_id) AS money_spent
    FROM customer c
    ORDER BY money_spent desc;
4-
SELECT ct.name, 
	(SELECT AVG(film.`length`) FROM film 
		INNER JOIN film_category ON film.film_id = film_category.film_id 
		    WHERE film_category.category_id = ct.category_id) AS avg_len 
FROM category ct ORDER BY avg_len DESC;
5-
SELECT c.name, avg(`rental_duration`) 
 FROM film f INNER JOIN category c INNER JOIN film_category fc 
 ON fc.category_id = c.category_id AND f.film_id = fc.film_id 
 GROUP BY c.name;