-- Actividad 1:
-- Agregar la tabla rental audit, script arriba. Luego escribir 2 triggers: Uno cuando se inserta una fila a la tabla rental, poner la acción 'rented' en la tabla rental_audit. Otro trigger cuando se hace un update de la tabla rental y debe especificar la accion 'returned'. Asumir que los updates solo cambian la columna return_date. Puntos extras si ponen una logica para insertar solo en la tabla rental_audit cuando solamente se actualiza return_date de null a otro valor.

USE sakila;
DROP TABLE IF EXISTS rental_audit;
CREATE TABLE rental_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id SMALLINT UNSIGNED NOT NULL,
    inventory_id MEDIUMINT UNSIGNED NOT NULL,
    changedat DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);

DROP TRIGGER IF EXISTS rented;
DELIMITER //
CREATE trigger rented AFTER INSERT ON rental
FOR EACH ROW
  BEGIN
    INSERT INTO rental_audit(action, customer_id, inventory_id) VALUES ('rented', NEW.customer_id, NEW.inventory_id);
  END//
DELIMITER ;

-- Actividad 2:
-- Muestre un reporte de la cantidad de películas rentadas y no devueltas por país y por categoría de películas. Columnas a mostrar nombre del país, nombre la categoría y cantidad de películas alquiladas

SELECT concat_ws (" ", cat.name) AS 'Categoria', concat_ws (" ", c.country) AS 'Pais', concat_ws (" ",  count(rental_id)) AS 'Cantidad De Rentas'
    FROM country c
    INNER JOIN city ci USING(country_id)
    INNER JOIN address a USING(city_id)
    INNER JOIN customer cu USING(address_id)
    INNER JOIN rental r USING(customer_id)
    INNER JOIN inventory i USING(inventory_id)
    INNER JOIN film f USING(film_id)
    INNER JOIN film_category ca USING(film_id)
    INNER JOIN category cat USING(category_id)
    WHERE r.return_date IS NULL
    GROUP BY cat.name, c.country ORDER BY c.country, cat.name;

