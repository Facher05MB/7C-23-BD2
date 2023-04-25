#ej1
select last_name,first_name,actor_id 
    from actor
    where last_name in (
                        select last_name
                        from actor
                        group by last_name
    )
    order by last_name,first_name;


#ej2
select first_name, last_name 
    from actor
    where not Exists (select actor_id
                      from film_actor
                      ); 

#ej3
select customer_id,first_name,last_name
    from customer
    where customer_id in (
                          select customer_id from (
                          select count(customer_id) as cant,customer_id
                          from rental
                          group by customer_id 
                          order by count(customer_id))
                          as countCustomers
                          where cant = 1
                          );





#ej5
SELECT a1.first_name, a1.actor_id
    FROM actor a1
    JOIN film_actor fa ON a1.actor_id = fa.actor_id
    JOIN film f ON f.film_id = fa.film_id
    WHERE f.title = 'BETRAYED REAR'
    OR a1.actor_id IN (
                       SELECT a2.actor_id
                       FROM actor a2
                       JOIN film_actor fa2 ON a2.actor_id = fa2.actor_id
                       JOIN film f2 ON f2.film_id = fa2.film_id
                       WHERE f2.title = 'CATCH AMISTAD'
                       )
    group by actor_id; 



#ej6
SELECT a1.first_name, a1.actor_id
    FROM actor a1
    JOIN film_actor fa ON a1.actor_id = fa.actor_id
    JOIN film f ON f.film_id = fa.film_id
    WHERE f.title = 'BETRAYED REAR'
    OR a1.actor_id  NOT IN (
                            SELECT a2.actor_id
                            FROM actor a2
                            JOIN film_actor fa2 ON a2.actor_id = fa2.actor_id
                            JOIN film f2 ON f2.film_id = fa2.film_id
                            WHERE f2.title = 'CATCH AMISTAD'
);


#ej7
SELECT a1.first_name, a1.actor_id
    FROM actor a1
    JOIN film_actor fa ON a1.actor_id = fa.actor_id
    JOIN film f ON f.film_id = fa.film_id
    WHERE  f.title = 'BETRAYED REAR'and
    a1.actor_id  IN (
                    SELECT a2.actor_id
                    FROM actor a2
                    JOIN film_actor fa2 ON a2.actor_id = fa2.actor_id
                    JOIN film f2 ON f2.film_id = fa2.film_id
                    WHERE f2.title = 'CATCH AMISTAD'
                    );

#ej8
SELECT a1.first_name, a1.actor_id
    FROM actor a1
    JOIN film_actor fa ON a1.actor_id = fa.actor_id
    JOIN film f ON f.film_id = fa.film_id
    WHERE a1.actor_id NOT IN (
                              SELECT a2.actor_id
                              FROM actor a2
                              JOIN film_actor fa2 ON a2.actor_id = fa2.actor_id
                              JOIN film f2 ON f2.film_id = fa2.film_id
                              WHERE f2.title = 'BETRAYED REAR' or f2.title = 'CATCH AMISTAD'
                              )
    group by actor_id;




