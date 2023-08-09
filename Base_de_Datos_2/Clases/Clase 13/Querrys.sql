/*

Add a new customer
To store 1
For address use an existing address. The one that has the biggest address_id in 'United States'
Add a rental*/

#1

INSERT INTO customer (store_id, first_name, last_name, email, address_id, active)
SELECT 1, 'TEODORO', 'REYNA', 'RUBIUS_NO_SEAS_MALO@gmail.com', MAX(a.address_id), 1
FROM address a
WHERE  city_id IN (SELECT city_id FROM city WHERE country_id IN (SELECT country_id FROM country WHERE country = 'United States'));




/*
Make easy to select any film title. I.e. I should be able to put 'film tile' in the where, and not the id.
Do not check if the film is already rented, just use any from the inventory, e.g. the one with highest id.
Select any staff_id from Store 2.
Update film year based on the rating
*/

	
#2

INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)
SELECT
    NOW(),i.inventory_id,c.customer_id, NULL,s.staff_id 
FROM inventory AS i
INNER JOIN film AS f USING (film_id)
INNER JOIN customer AS c ON c.customer_id=1
INNER JOIN staff AS s ON s.store_id = 2  
WHERE f.title = 'SKY MIRACLE';      





/*	 
For example if rating is 'G' release date will be '2001'
You can choose the mapping between rating and year.
Write as many statements are needed.
Return a film
*/

#3

UPDATE film
SET release_year = 
    CASE rating
        WHEN 'G' THEN '2001'
        WHEN 'NC-17' THEN '2003'
        WHEN 'PG' THEN '2005'
        WHEN 'R' THEN '2007'
        ELSE '2000' 
END;



/*
Write the necessary statements and queries for the following steps.
Find a film that was not yet returned. And use that rental id. Pick the latest that was rented for example.
Use the id to return the film.
Try to delete a film
*/

#4

SELECT F.film_id
FROM film as F
         INNER JOIN inventory AS I on I.film_id = F.film_id
         INNER JOIN rental AS R on I.inventory_id = R.inventory_id
WHERE R.return_date > CURRENT_DATE()
ORDER BY rental_date DESC
LIMIT 1;	



/*	
#Check what happens, describe what to do.
#Write all the necessary delete statements to entirely remove the film from the DB.
#Rent a film
*/


#5

DELETE FROM rental
WHERE inventory_id IN (SELECT inventory_id FROM inventory WHERE film_id = 1);

DELETE FROM payment
WHERE rental_id IN (SELECT rental_id FROM rental WHERE inventory_id IN (SELECT inventory_id FROM inventory WHERE film_id = 1));

DELETE FROM film_actor
WHERE film_id = 1;

DELETE FROM film_category
WHERE film_id = 1;

DELETE FROM inventory
WHERE film_id = 1;

DELETE FROM film
WHERE film_id = 1;

select * from film;

/*
Esto se tiene en cuenta que podemos borrar datos de otra tabla.
Si no es posible borrar esos datos no sera posible eliminar una pelicula.
*/

/*
Find an inventory id that is available for rent (available in store) pick any movie. Save this id somewhere.
Add a rental entry
Add a payment entry
Use sub-queries for everything, except for the inventory id that can be used directly in the queries.
*/



#6

INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)
VALUES (CURRENT_DATE(), (SELECT I.inventory_id
                         FROM inventory AS I
                         WHERE NOT EXISTS(SELECT *
                                          FROM rental AS R
                                          WHERE R.inventory_id = I.inventory_id
                                            AND R.return_date < CURRENT_DATE())
                         LIMIT 1), 1, CURRENT_DATE(), 1);
INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date)
VALUES (1, 1, (SELECT LAST_INSERT_ID()), 10.2, CURRENT_DATE);
