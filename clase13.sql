USE sakila;
1-
INSERT INTO sakila.customer (store_id, first_name, last_name, email, address_id, active) SELECT 1, 'Ivan', 'Gaitan', 'ivangaitan.kp@gmail.com', MAX(a.address_id), 1 FROM address a WHERE (SELECT c.country_id FROM country c, city c1 WHERE c.country = "United States" AND c.country_id = c1.country_id AND c1.city_id = a.city_id);
SELECT * FROM customer WHERE last_name = "Gaitan";
2-
SELECT * FROM rental r ORDER BY rental_id DESC;
INSERT INTO rental
	(rental_date, inventory_id, customer_id, return_date, staff_id)
SELECT CURRENT_TIMESTAMP,
	(SELECT MAX(i.inventory_id) FROM inventory i INNER JOIN film f USING (film_id) WHERE f.title = "ARABIA DOGMA" LIMIT 1),
	600,
	NULL,
	(SELECT staff_id FROM staff s INNER JOIN store st USING (store_id) WHERE st.store_id = 2 LIMIT 1);
3-
SELECT f.film_id, f.title, f.release_year, f.rating FROM film f ORDER BY rating;
UPDATE film f 
SET f.release_year = 2000 WHERE f.rating LIKE 'G';
UPDATE film f
SET f.release_year = 2002 WHERE f.rating LIKE 'PG';
UPDATE film f 
SET f.release_year = 2004 WHERE f.rating LIKE 'PG-13';
UPDATE film f 
SET f.release_year = 2006 WHERE f.rating LIKE 'R';
UPDATE film f 
SET f.release_year = 2010 WHERE f.rating LIKE 'NC-17';
4-
SELECT rental_id, rental_rate, customer_id, staff_id 
    FROM film 
    INNER JOIN inventory USING(film_id) 
    INNER JOIN rental USING(inventory_id) 
    WHERE rental.return_date IS NULL LIMIT 1;
UPDATE sakila.rental SET return_date=CURRENT_TIMESTAMP WHERE rental_id=11496;
5-
SELECT rental_id, rental_date, return_date 
FROM rental 
WHERE rental_id = 16050;
UPDATE rental SET return_date = NULL WHERE rental_id = 16050;
UPDATE rental SET return_date = NOW()
    WHERE rental_id = (SELECT rental_id
                            FROM (SELECT r2.rental_id
                                        FROM rental r2
                                        WHERE r2.return_date IS NULL
                                        ORDER BY r2.rental_date DESC
                                        LIMIT 1) r);
5-
SELECT * FROM film
INSERT INTO film
(film_id, title, DESCRIPTION, language_id)
VALUES
(1001, 'mi mundo', 'A intrepid era jodaa xddd ddd ddd lol', 1);
SELECT * FROM film f ORDER BY f.film_id DESC;
DELETE FROM film 
WHERE film_id = 1001  
6-
SELECT inventory_id, film_id
FROM inventory
WHERE inventory_id NOT IN (SELECT inventory_id
FROM inventory INNER JOIN rental USING (inventory_id) WHERE return_date IS NULL)
INSERT INTO sakila.rental
(rental_date, inventory_id, customer_id, staff_id)
VALUES(
CURRENT_DATE(),
10,
(SELECT customer_id FROM customer ORDER BY customer_id DESC LIMIT 1),
(SELECT staff_id FROM staff WHERE store_id = (SELECT store_id FROM inventory WHERE inventory_id = 10))
);
INSERT INTO sakila.payment
(customer_id, staff_id, rental_id, amount, payment_date)
VALUES(
(SELECT customer_id FROM customer ORDER BY customer_id DESC LIMIT 1),
(SELECT staff_id FROM staff LIMIT 1),
(SELECT rental_id FROM rental ORDER BY rental_id DESC LIMIT 1) ,
(SELECT rental_rate FROM film WHERE film_id = 2),
CURRENT_DATE());     
 