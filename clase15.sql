USE sakila;
1-
CREATE OR REPLACE VIEW list_of_customers AS SELECT customer_id, CONCAT_WS(" " ,first_name, last_name) AS full_name, address, postal_code, phone, city, country, CASE WHEN active = 1 THEN 'active' ELSE 'inactive' END AS status, store_id 
    FROM customer 
    INNER JOIN address USING(address_id) 
    INNER JOIN city USING(city_id) 
    INNER JOIN country USING(country_id);
SELECT * FROM list_of_customers;
2-
CREATE OR REPLACE VIEW film_details AS
    SELECT
        f.film_id,
        f.title,
        f.description,
        c.name,
        f.`length`,
        f.rating,
        GROUP_CONCAT(DISTINCT CONCAT_WS(" " ,first_name, last_name) SEPARATOR ',') AS 'actors'
    FROM film f
        INNER JOIN film_category fc USING (film_id)
        INNER JOIN category c USING (category_id)
		INNER JOIN film_actor fa USING (film_id)
		INNER JOIN actor a USING (actor_id)
	GROUP BY 1, 4;
SELECT * FROM film_details;
3-
CREATE OR REPLACE VIEW sales_by_film_category AS SELECT DISTINCT category.name, SUM(amount) AS total_rental 
    FROM category 
    INNER JOIN film_category USING(category_id) 
    INNER JOIN film USING(film_id) 
    INNER JOIN inventory USING(film_id) 
    INNER JOIN rental USING(inventory_id) 
    INNER JOIN payment USING(rental_id) 
    GROUP BY 1;
SELECT * FROM sales_by_film_category;
4-
CREATE OR REPLACE VIEW actor_information AS
    SELECT
        a.actor_id AS 'id',
        a.first_name,
        a.last_name,
        (SELECT COUNT(f.film_id)
            FROM film f 
            INNER JOIN film_actor fa USING (film_id)
            INNER JOIN actor a2 USING (actor_id)
            WHERE a.actor_id = a2.actor_id) AS "ammount_of_films"
    FROM actor a;

SELECT * FROM actor_information;

5-
SELECT * FROM actor_info;
SHOW CREATE VIEW actor_info;
