
/*1:Write a query that gets all the customers that live in Argentina. 
Show the first and last name in one column, the address and the city.*/



SELECT CONCAT(c.first_name, ' ', c.last_name) AS NombreCompleto, a.address, ci.city
    FROM customer c
    INNER JOIN address a on c.address_id = a.address_id
    INNER JOIN city ci on ci.city_id = a.city_id
    INNER JOIN country co on co.country_id = ci.country_id
    WHERE co.country = 'Argentina';



/*2:Write a query that shows the film title, language and rating. Rating shall be shown as the full text described here: 
https://en.wikipedia.org/wiki/Motion_picture_content_rating_system#United_States. Hint: use case*/



SELECT f.title, l.name AS lenguaje,
       CASE f.rating
           WHEN 'G' THEN 'General Audiences'
           WHEN 'PG' THEN 'Parental Guidance Suggested'
           WHEN 'PG-13' THEN 'Parents Strongly Cautioned'
           WHEN 'R' THEN 'Restricted'
           WHEN 'NC-17' THEN 'Adults Only'
           ELSE 'Not Rated'
       END rating
FROM film f
INNER JOIN language l on l.language_id = f.language_id;



/*3:Write a search query that shows all the films (title and release year) an actor was part of. 
Assume the actor comes from a text box introduced by hand from a web page. Make sure to 
"adjust" the input text to try to find the films as effectively as you think is possible*/



SELECT CONCAT(ac.first_name,' ',ac.last_name)as Nombre, f.title, f.release_year
FROM film f
    INNER JOIN film_actor fa on f.film_id = fa.film_id
    INNER JOIN actor ac on fa.actor_id = ac.actor_id
WHERE
    CONCAT(first_name, ' ', last_name) LIKE TRIM(UPPER('ED CHASE'));

select * from actor;



/*4:Find all the rentals done in the months of May and June. Show the film title, customer name 
and if it was returned or not. There should be returned column with two possible values 'Yes' and 'No'*/



SELECT f.title, CONCAT(c.first_name, ' ', c.last_name) AS Nombre,
       CASE
           WHEN r.return_date IS NULL THEN 'No'
           ELSE 'Sí'
       END Devuelto
FROM rental r
INNER JOIN inventory i on r.inventory_id = i.inventory_id
INNER JOIN film f on f.film_id = i.film_id
INNER JOIN customer c on r.customer_id = c.customer_id
WHERE MONTH(r.rental_date) IN (5, 6);

select MONTH(rental_date) from rental;










/*6:Investigate NVL, ISNULL, IFNULL, COALESCE, etc type of function. Explain what they do.
 Which ones are not in MySql and write usage examples.*/



/*
 NLV():
   Se utiliza para remplazar un valor nulo por otro valor especificado. 
   Ejemplo: -SELECT NVL(columna, 'DESCONOCIDO') FROM tabla;


ISNULL():
   Devuelve un valor especificado si la expresión es nula; de lo contrario, devuelve la expresión. 
   EJEMPLO: -SELECT ISNULL(columna, 'DESCONOCIDO') FROM tabla;



IFNULL():
    Devuelve un valor especificado si la expresión es nula; de lo contrario, devuelve la expresión. 
    Ejemplo: -SELECT IFNULL(nombre, 'Desconocido') FROM empleados.


COALESCE(): 
    Devuelve el primer valor no nulo en una lista de expresiones.
    Ejemplo: -SELECT COALESCE(nombre, apellido, 'Desconocido') FROM empleados;

Las funciones NLV() Y ISNULL() No son admitidas en myaql. Pero IFNULL() si es especifica de mysql
COALESCE() es mas generica y compatible con mas motores de bases de datos.*/
