SELECT title as Title, special_features as Special_Feature FROM film WHERE rating = 'PG-13';

SELECT DISTINCT length as Length FROM film Order by length ASC;

SELECT title as Title, rental_rate as Rental_Rate, replacement_cost as Replacement_cost FROM film WHERE replacement_cost BETWEEN 20.00 AND 24.00;

SELECT title, category.name as Name_Category, rating FROM film JOIN film_category ON film.film_id = film_category.film_id JOIN category ON film_category.category_id = category.category_id WHERE special_features like "%Behind the Scenes%";

SELECT actor.first_name As Actor_Name, actor.last_name As Actor_LastName FROM actor JOIN film_actor ON actor.actor_id = film_actor.actor_id JOIN film ON film.film_id = film_actor.film_id WHERE film.title = 'ZOOLANDER FICTION';


SELECT address, city, country FROM store JOIN address ON store.address_id = address.address_id  JOIN city ON address.city_id = city.city_id  JOIN country ON city.country_id = country.country_id WHERE store.store_id = 1;


SELECT f1.title As Film_1_NAME, f1.rating AS Film_1_RATING, f2.title AS Film_2_NAME, f2.rating AS Film_2_RATING FROM film f1, film f2 WHERE f1.film_id < f2.film_id AND f1.rating = f2.rating;



select distinct film.film_id as Id_Film, film.title as Film_Name, store.store_id as Store_Id, staff.first_name as Name_staff , staff.last_name  AS LastName_Staff from inventory   join film on inventory.film_id = film.film_id join store on inventory.store_id = store.store_id join staff on store.manager_staff_id = staff.staff_id where store.store_id = 2;
