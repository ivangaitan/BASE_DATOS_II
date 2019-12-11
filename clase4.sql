1-
SELECT title, special_features FROM film WHERE rating = 'PG-13';
2-
SELECT DISTINCT length FROM film ORDER BY length;
3- 
SELECT title, rental_rate, replacement_cost FROM filM WHERE replacement_cost BETWEEN 20.00 AND 24.00;
4- 
SELECT title, rating, special_features FROM film WHERE special_features LIKE '%Behind the Scenes%';
5-
SELECT first_name, last_name from film, film_actor, actor WHERE film.film_id = film_actor.film_id and film_actor.actor_id = actor.actor_id and film.title like 'ZOOLANDER FICTION';
6-
SELECT address, city, country FROM store , address, city, country WHERE store.address_id = address.address_id AND address.city_id =city.city_id AND city.country_id = country.country_id AND store_id = 1;
7-
SELECT DISTINCT f1.title, f2.title, f1.rating FROM film f1 INNER JOIN film f2 ON f1.film_id <> f2.film_id WHERE f1.rating = f2.rating ORDER BY 3, 1, 2;
8- 
SELECT f.title, c.first_name, c.last_name FROM film f, inventory i, store s, customer c WHERE f.film_id = i.film_id AND i.store_id = s.store_id AND s.store_id = c.store_id AND s.store_id=2;
