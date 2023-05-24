#ej1


SELECT c.country_id as id , c.country as pais
    FROM country c
    JOIN city ci ON c.country_id = ci.country_id
    GROUP BY c.country_id, c.country
    having  COUNT(ci.city_id)
    ORDER BY c.country, c.country_id;


#ej2



SELECT c.country_id as id , c.country as pais, COUNT(ci.city_id) as ciudades
    FROM country c
    JOIN city ci ON c.country_id = ci.country_id
    GROUP BY c.country_id, c.country
    having  COUNT(ci.city_id)  > 10
    ORDER BY COUNT(ci.city_id);

#ej3

SELECT concat(c.last_name, ' ', c.first_name) as nombre, SUM(p.amount) AS Plata_Gastada, a.address as direccion, COUNT(r.rental_id) as Cantidad_de_peliculas
    FROM customer c
    JOIN address a on c.address_id = a.address_id  
    JOIN rental r on c.customer_id = r.customer_id
    JOIN payment p on c.customer_id = p.customer_id
    GROUP BY c.customer_id
    ORDER BY Plata_Gastada DESC;


#ej4
SELECT c.name as Nombre_Categoria, AVG(f.length) as Duracion_Promedio
    FROM film f
    JOIN film_category fm on f.film_id = fm.film_id
    JOIN category c on fm.category_id = c.category_id  
    GROUP BY c.name
    ORDER BY Duracion_Promedio DESC;


#ej5
SELECT f.rating as Rating, count(r.rental_id) as Ventas
    FROM film f
    JOIN inventory i on f.film_id = i.film_id
    JOIN rental r on i.inventory_id = r.inventory_id
    GROUP BY Rating;