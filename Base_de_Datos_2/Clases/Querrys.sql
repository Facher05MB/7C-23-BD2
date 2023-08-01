1#Create a view named list_of_customers, it should contain the following columns:

1.customer id
2.customer full name,
3.address
4.zip code
5.phone
6.city
7.country
8.status (when active column is 1 show it as 'active', otherwise is 'inactive')
9.store id


CREATE OR REPLACE VIEW list_of_customers AS
  SELECT c.customer_id, concat(c.first_name, ' ' ,c.last_name) as customer_full_name, c.store_id, concat(a.address, ' ', a.address2) as address, a.phone, co.country_id, c.active
  FROM customer c
  INNER JOIN address a on a.address_id = c.address_id 
  INNER JOIN city ci on ci.city_id = a.city_id 
  INNER JOIN country co on co.country_id = ci.country_id
  ;


2#Create a view named film_details,
 it should contain the following columns: 
 film id, /
 title, /
 description, / 
 category, /
 price, 
 length, /
 rating, /
 actors - as a string of all the actors separated by comma. Hint use GROUP_CONCAT /


CREATE OR REPLACE VIEW film_details AS
  SELECT f.film_id, f.title, f.description, c.name as category, f.length, f.rating , GROUP_CONCAT(concat(a.first_name, ' ' ,a.last_name) ORDER BY a.actor_id SEPARATOR ',') AS actor_list
  FROM film f
  INNER JOIN film_category fc on fc.film_id = f.film_id
  INNER JOIN category c on c.category_id = fc.category_id
  INNER JOIN film_actor fa on fa.film_id = f.film_id
  INNER JOIN actor a on a.actor_id = fa.actor_id
  group by f.film_id, c.name
  ;



3#Create view sales_by_film_category, it should return 'category' and 'total_rental' columns.


CREATE OR REPLACE VIEW  sales_by_film_category AS
  SELECT c.category_id, c.name, c.last_update as last_update_category, r.rental_id, r.rental_date , r.inventory_id, r.customer_id, r.return_date, r.staff_id, r.last_update  as last_update_rental
  FROM category c
  INNER JOIN film_category fc on c.category_id = fc.category_id
  INNER JOIN film f on fc.film_id = f.film_id
  INNER JOIN inventory i on i.film_id = f.film_id
  INNER JOIN rental r on i.inventory_id = r.inventory_id
  ;


4#Create a view called actor_information where it should return, actor id, first name, last name and the amount of films he/she acted on.


CREATE OR REPLACE VIEW actor_information AS
  SELECT a.actor_id, a.first_name, a.last_name, count(f.film_id)
  FROM actor a
  INNER JOIN film_actor fa on a.actor_id = fa.actor_id
  INNER JOIN film f on fa.film_id = f.film_id
  group by a.actor_id
  ;


5#Analyze view actor_info, explain the entire query and specially how the sub query works. Be very specific, take some time and decompose each part and give an explanation for each.



#5
/*
Explicación de la consulta:
CREATE VIEW actor_information AS: Esta línea indica que estamos creando una nueva vista llamada actor_information. 


En la siguiente parte, SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS film_count, especificamos las columnas que queremos seleccionar y mostrar en la vista resultante. 
En este caso que son :
#el ID del actor, 
#su primer nombre, 
#su apellido y el recuento de películas en las que ha actuado.

La tabla de la que obtenemos los datos principales es actor, y usamos el alias a para abreviar el nombre de la tabla.

Luego, usamos los 2 INNER JOINS para asi conectar las tabla film con actor por medio de film_actor. Esto significa que estamos combinando la tabla actor con la tabla film_actor según el ID del actor.
El problema de esto es que los INNER JOIN solo mostraran los actores que tengan alguna pelicula  LEFT JOIN asegura que incluso si un actor no ha actuado en ninguna película

Finalmente, utilizamos GROUP BY a.actor_id para agrupar los resultados. de mayor en la view controlando el que no se repita ningun valor

*/




6#Materialized views, write a description, why they are used, alternatives, DBMS were they exist, etc.
/*

**Descripción de las Vistas Materializadas:**
Una vista materializada es un objeto de base de datos que almacena los resultados de una consulta como una tabla física,
 representando los datos extraídos de una o más tablas fuente. A diferencia de las vistas regulares, que son virtuales y 
 no almacenan datos por sí mismas, las vistas materializadas están precalculadas y se actualizan periódicamente para garantizar 
 que sus datos estén sincronizados con las tablas fuente subyacentes.



**Sintaxis**
CREATE MATERIALIZED VIEW nombre_de_la_vista
AS
SELECT columnas
FROM tablas
WHERE condiciones
[REFRESH {FAST | COMPLETE | FORCE | ON DEMAND | NEVER}];




**Por qué se utilizan:**
Las vistas materializadas se utilizan por varias razones:
1. **Mejora del rendimiento:** Las vistas materializadas pueden mejorar significativamente el rendimiento de las consultas precalculando y almacenando los resultados de consultas complejas o frecuentemente utilizadas. Esto reduce la necesidad de ejecutar repetidamente consultas costosas en conjuntos de datos grandes.
2. **Agregación y resumen de datos:** A menudo se utilizan para agregar, resumir o transformar datos, lo que permite a los usuarios acceder eficientemente a información resumida sin consultar todo el conjunto de datos.
3. **Procesamiento sin conexión:** Las vistas materializadas se pueden utilizar para el procesamiento y reportes sin conexión, lo que permite una recuperación de datos más rápida con fines analíticos.
4. **Reducción de la carga en las tablas fuente:** Al proporcionar una fuente de datos alternativa, las vistas materializadas pueden reducir la carga en las tablas fuente subyacentes, lo que puede ser crucial en sistemas con alta concurrencia y operaciones de lectura frecuentes.
5. **Soporte para datos remotos:** Las vistas materializadas se pueden utilizar para almacenar datos de bases de datos remotas, lo que facilita el trabajo con sistemas distribuidos.

**Alternativas a las Vistas Materializadas:**
Aunque las vistas materializadas ofrecen beneficios significativos, existen enfoques alternativos para lograr resultados similares:
1. **Vistas Regulares:** Las vistas regulares (no materializadas) son tablas virtuales que representan los resultados de una consulta. A diferencia de las vistas materializadas, no almacenan datos, pero proporcionan una vista actualizada de las tablas subyacentes cada vez que se consultan. Las vistas son más adecuadas cuando se requiere acceso a datos en tiempo real y el costo de recomputar los resultados es aceptable.
2. **Caché:** Almacenar en caché los resultados de consultas en memoria puede mejorar el rendimiento de las consultas al reducir la necesidad de volver a calcular las mismas consultas con frecuencia. Sin embargo, este enfoque puede no ser tan eficiente como las vistas materializadas para conjuntos de datos complejos o grandes.
3. **Indexación:** Crear índices apropiados en columnas consultadas con frecuencia puede mejorar el rendimiento de las consultas sin la necesidad de vistas materializadas. Si bien los índices no almacenan resultados precalculados, proporcionan un acceso más rápido a los datos al optimizar la recuperación de datos.

**SGBD donde existen:** 
Las vistas materializadas son compatibles con varios sistemas de gestión de bases de datos relacionales (SGBD). Algunos SGBD populares donde se pueden encontrar vistas materializadas incluyen:
1. **Oracle Database:** Oracle brinda un sólido soporte para vistas materializadas, ofreciendo varias opciones para su actualización y mantenimiento.
2. **PostgreSQL:** A partir de la versión 9.3, PostgreSQL introdujo soporte para vistas materializadas, lo que permite a los usuarios crearlas y utilizarlas como en otros SGBD.
3. **Microsoft SQL Server:** SQL Server también admite vistas materializadas, llamadas "Vistas Indexadas", que se pueden indexar para mejorar aún más el rendimiento.
4. **IBM Db2:** Db2 admite vistas materializadas como "Tablas de Consulta Materializadas (MQTs)", que proporcionan una funcionalidad similar.
5. **MySQL:** Hasta mi última actualización de conocimientos en septiembre de 2021, MySQL no tenía soporte incorporado para vistas materializadas. Sin embargo, es posible que algunas soluciones y extensiones de terceros ofrezcan una funcionalidad similar.
/*  

inspirado en chatGPT