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

