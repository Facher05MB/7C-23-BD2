
#Write a function that returns the amount of copies of a film in a store in sakila-db.
#Pass either the film id or the film name and the store id.
#Write a stored procedure with an output parameter that contains a list of customer 
#first and last names separated by ";", that live in a certain country. You pass 
#the country it gives you the list of people living there. USE A CURSOR, 
#do not use any aggregation function (like CONTCAT_WS).
#Review the function inventory_in_stock and the procedure film_in_stock explain the code, write usage examples.



#1 


DROP FUNCTION IF EXISTS FilmStoreCopies;
DELIMITER //
CREATE FUNCTION FilmStoreCopies(DATA VARCHAR(200), STORE_ID INT) RETURNS INT READS SQL DATA

BEGIN 
    DECLARE copies INT;

    SELECT
        COUNT(*) INTO copies
    FROM inventory i
        JOIN film f ON i.film_id = f.film_id
    WHERE (
            f.film_id = Data
            OR f.title = Data
            OR f.description = Data
        )
        AND i.store_id = store_id;
    RETURN copies;
    END
//
DELIMITER ;

SELECT FilmStoreCopies('WORST BANGER', 2) as copies;
SELECT FilmStoreCopies(991, 2) as copies;
SELECT FilmStoreCopies('A Emotional Saga of a Crocodile And a Sumo Wrestler who must Discover a Mad Cow in New Orleans', 2) as copies;


#2







DROP PROCEDURE IF EXISTS getCustomersCountry;
DELIMITER //
CREATE PROCEDURE getCustomersCountry(
    IN country_name VARCHAR(50), 
    OUT customers_list TEXT
    )
BEGIN
    DECLARE response TEXT DEFAULT '';
    DECLARE separation BOOL DEFAULT FALSE;
    DECLARE customer_first_name VARCHAR(100) DEFAULT '';
    DECLARE customer_last_name VARCHAR(100) DEFAULT '';
    DECLARE done INT DEFAULT 0;

    DECLARE customer_cursor CURSOR FOR
        SELECT first_name, last_name
        FROM customer
            INNER JOIN address a on customer.address_id = a.address_id
            INNER JOIN city ci on a.city_id = ci.city_id
            INNER JOIN country co on ci.country_id = co.country_id
        WHERE co.country = country_name;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN customer_cursor;
    customers_loop:
    LOOP
        FETCH customer_cursor INTO customer_first_name, customer_last_name;
        IF done = 1 THEN
            LEAVE customers_loop;
        end if;

        IF separation = TRUE THEN
            SET response = CONCAT(response, ';');
        end if;

        SET separation = TRUE;

        SET response = CONCAT(response, customer_first_name, ' ', customer_last_name);

    end loop;
    CLOSE customer_cursor;

    SET customers_list = response;

END;
//
DELIMITER ;
CALL getCustomersCountry('Vietnam', @result);
SELECT @result;


#3
#Review the function inventory_in_stock and the procedure film_in_stock explain the code, 
#write usage examples.



/* 

La función inventory_in_stock devuelve un valor tinyint que representa Verdadero o Falso. 
En su implementación, se utilizan dos variables. Una de ellas guarda la cantidad de alquileres para una 
película específica,mientras que la otra guarda la cantidad de alquileres que aún no han sido devueltos 
(es decir, tienen una fecha de retorno pendiente) para los elementos con el ID proporcionado como parámetro.

Si al menos un artículo en el inventario tiene una fecha de retorno (return_date) pendiente,
 la función devuelve 1 (Verdadero). En cambio, si ninguno de 
los artículos en el inventario tiene una fecha de retorno pendiente, la función devuelve 0 (Falso).
*/

SET @result = inventory_in_stock(5);
SELECT @result;

SET @result = inventory_in_stock(7);
SELECT @result;

SET @result = inventory_in_stock(9);
SELECT @result;




/* 
El procedimiento almacenado film_in_stock devuelve la cantidad de películas que tienen el mismo identificador (ID) 
proporcionado como parámetro, en la tienda que también se especifica como parámetro.
En resumen, este procedimiento cuenta cuántas copias de una película en particular están 
disponibles en una tienda específica,  utilizando el ID de la película y la tienda como argumentos de entrada.
*/

CALL film_in_stock(1, 1, @result);
SELECT @result;

CALL film_in_stock(2, 2, @result);
SELECT @result;

CALL film_in_stock(2, 3, @result);
SELECT @result;