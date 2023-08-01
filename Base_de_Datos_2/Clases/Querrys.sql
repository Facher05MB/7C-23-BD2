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
  SELECT a.actor_id, a.first_name, a.last_name
  FROM actor a
  INNER JOIN film_actor fa on a.actor_id = fa.actor_id
  INNER JOIN film f on fa.film_id = f.film_id
  
  group by a.actor_id
  ;


5#Analyze view actor_info, explain the entire query and specially how the sub query works. Be very specific, take some time and decompose each part and give an explanation for each.





6#Materialized views, write a description, why they are used, alternatives, DBMS were they exist, etc.