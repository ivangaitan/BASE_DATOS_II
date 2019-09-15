USE sakila;
SELECT concat_ws(" ", first_name, last_name) AS nombrecompleto, concat_ws(" ", address, city)AS calle, country 
from customer 
INNER JOIN address a USING (address_id)
INNER JOIN city c USING (city_id) 
INNER JOIN country USING (country_id) WHERE country = 'Argentina'
ORDER BY country ASC;
2-
SELECT title, language.name, CASE WHEN rating = 'G' THEN 'All Ages Are Admitted.' WHEN rating = 'PG' THEN 'Some Material May Not Be Suitable For Children.' WHEN rating = 'PG-13' THEN 'Some Material May Be Inappropriate For Children Under 13.' WHEN rating = 'R' THEN 'Under 17 Requires Accompanying Parent Or Adult Guardian.' WHEN rating = 'NC-17' THEN 'No One 17 and Under Admitted.' END AS rating_description 
    FROM film 
    INNER JOIN language USING (language_id);
3-
SELECT f.title, f.release_year, CONCAT_WS(" ", a.first_name, a.last_name) as 'name'
    FROM film f
    INNER JOIN film_actor fa ON f.film_id = fa.film_id
    INNER JOIN actor a ON fa.actor_id = a.actor_id
    WHERE CONCAT_WS(" ", a.first_name, a.last_name) LIKE TRIM(UPPER(' PeNELope guiNESs'));
4-
SELECT film.title, CONCAT_WS(" ", customer.first_name, customer.last_name) as full_name, CASE WHEN rental.return_date IS NOT NULL THEN 'Yes' ELSE 'No' END AS was_returned, MONTHNAME(rental.rental_date) as month 
    FROM film 
    INNER JOIN inventory USING(film_id) 
    INNER JOIN rental USING(inventory_id) 
    INNER JOIN customer USING(customer_id) WHERE MONTHNAME(rental.rental_date) 
    LIKE 'May' OR MONTHNAME(rental.rental_date) 
    LIKE 'June';
5-
SELECT CAST(last_update AS DATE) as only_date 
    FROM rental;
SELECT CONVERT("2006-02-15", DATETIME);
6-
SELECT rental_id, IFNULL(return_date, 'La pelicula no fue devuelta aun') as fecha_de_devolucion 
    FROM rental 
    WHERE rental_id = 12610 OR rental_id = 12611;
SELECT rental_id, ISNULL(return_date) as pelicula_faltante 
    FROM rental 
    WHERE rental_id = 12610 OR rental_id = 12611;
SELECT COALESCE(NULL, NULL, 
    (SELECT return_date 
        FROM rental 
        WHERE rental_id = 12610),
            (SELECT return_date FROM rental WHERE rental_id = 12611)) AS primer_valor_no_nulo;


