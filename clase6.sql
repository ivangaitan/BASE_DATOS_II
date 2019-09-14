USE sakila;
1-
SELECT a.first_name, a.last_name
    FROM actor a 
    WHERE EXISTS (SELECT * 
                    FROM actor a2
                    WHERE a.last_name = a2.last_name
                    AND a.actor_id <> a2.actor_id)
    ORDER BY a.last_name;
2-
SELECT a.first_name, a.last_name
    FROM actor a 
    WHERE EXISTS (SELECT * FROM film_actor fa WHERE fa.film_id IS NULL);
3-
SELECT * FROM customer c1 
WHERE EXISTS 
(SELECT * FROM rental c2 WHERE c1.customer_id = c2.customer_id HAVING count(inventory_id) = 1);
4-
SELECT c.first_name, c.last_name
    FROM customer c
    WHERE c.customer_id IN (SELECT customer_id
                    FROM rental
                    GROUP BY customer_id
                    HAVING COUNT(inventory_id) > 1);
5-
SELECT * FROM actor a1 WHERE actor_id IN 
(SELECT actor_id FROM film_actor INNER JOIN film USING(film_id) WHERE film.title = 'BETRAYED REAR' OR film.title = 'CATCH AMISTAD');
6-
SELECT last_name, first_name
	FROM actor
WHERE actor_id IN (SELECT actor_id
				FROM film_actor INNER JOIN film USING(film_id)
				WHERE film.title = 'BETRAYED REAR')
AND actor_id NOT IN (SELECT actor_id
					FROM film_actor INNER JOIN film using(film_id)
					WHERE film.title = 'CATCH AMISTAD');
7-
SELECT *
    FROM actor a
    WHERE a.actor_id IN (SELECT fa.actor_id
                            FROM film_actor fa
                            WHERE fa.film_id IN (SELECT f.film_id FROM film f WHERE f.title LIKE 'BETRAYED REAR')) 
    AND a.actor_id IN (SELECT fa.actor_id
                            FROM film_actor fa
                            WHERE fa.film_id IN (SELECT f.film_id FROM film f WHERE f.title LIKE 'CATCH AMISTAD'));
8-
SELECT * FROM actor a1 WHERE actor_id NOT IN 
(SELECT actor_id FROM film_actor INNER JOIN film USING(film_id) WHERE film.title = 'BETRAYED REAR' OR film.title = 'CATCH AMISTAD');
