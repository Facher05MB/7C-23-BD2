#Find all the film titles that are not in the inventory


#ej1
Select title
FROM film as f
where film_id not in (select film_id
                      from inventory);


#Find all the films that are in the inventory but were never rented.

#Show title and inventory_id.
#This exercise is complicated.
#hint: use sub-queries in FROM and in WHERE or use left join and ask if one of the fields is null


#ej2
Select f.title, i.inventory_id
FROM inventory as i
INNER join film f on i.film_id = f.film_id
where inventory_id not in (select inventory_id
                           from rental);


#Generate a report with:

#customer (first, last) name, store id, film title,
#when the film was rented and returned for each of these customers
#order by store_id, customer last_name

#ej3
Select concat(c.first_name,' ', c.last_name), s.store_id, f.title
From customer as c
INNER JOIN store s on c.store_id = s.store_id
INNER JOIN rental r on r.customer_id = c.customer_id
INNER JOIN inventory i on i.store_id = s.store_id
INNER JOIN film f on f.film_id = i.film_id
where r.rental_date is not null and r.return_date is not null
order by  store_id, last_name;



#Show sales per store (money of rented films)

#show store's city, country, manager info and total sales (money)'
#(optional) Use concat to show city and country and manager first and last name




Select concat(co.country, " " , ci.city) as locationn, concat(sta.first_name, " ", sta.last_name) as staff, sum(p.amount)
from store sto
INNER JOIN address a on a.address_id = sto.address_id
INNER JOIN city ci on ci.city_id = a.city_id
INNER JOIN country co on co.country_id = ci.country_id
INNER JOIN staff sta on sta.store_id = sto.store_id
INNER JOIN payment p on p.staff_id = sta.staff_id
group by locationn, sta.first_name, sta.last_name;



