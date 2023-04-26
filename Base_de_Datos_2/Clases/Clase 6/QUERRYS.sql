#ej1
select last_name,first_name,actor_id 
    from actor
    where last_name in (select last_name
                        from actor
                        group by last_name
                        having count(*) > 1)
    order by last_name,first_name;


#ej2
select first_name, last_name 
    from actor
    where not Exists (select actor_id
                      from film_actor); 

#ej3
select customer_id,first_name,last_name
    from customer
    where customer_id in (
                          select customer_id
                          from(
                          select count(customer_id) as cant,customer_id
                          from rental
                          group by customer_id 
                          order by count(customer_id))
                          as countCustomers
                          where cant = 1);


#ej4
select customer_id,first_name,last_name
    from customer
    where customer_id in (
                          select customer_id
                          from(
                          select count(customer_id) as cant,customer_id
                          from rental
                          group by customer_id 
                          order by count(customer_id))
                          as countCustomers
                          where cant > 1);




#ej5
select actor_id,first_name,last_name
    from actor
    where actor_id in ( select actor_id
                        from film_actor
                        where film_id in ( select film_id 
                                           from film
                                           where title = 'BETRAYED REAR' or title = 'CATCH AMISTAD')  
                        group by actor_id);



#ej6
select actor_id,first_name,last_name
    from actor
    where actor_id in ( select actor_id
                        from film_actor
                        where film_id in ( select film_id 
                                           from film
                                           where title = 'BETRAYED REAR' or title = 'CATCH AMISTAD')  
                        group by actor_id)
    and actor_id not in ( select actor_id
                        from film_actor
                        where film_id in ( select film_id 
                                           from film
                                           where title = 'BETRAYED REAR' or title = 'CATCH AMISTAD')  
                        group by actor_id);



#ej7
select actor_id,first_name,last_name
    from actor
    where actor_id in ( select actor_id
                        from film_actor
                        where film_id in ( select film_id 
                                           from film
                                           where title = 'BETRAYED REAR' or title = 'CATCH AMISTAD')  
                        group by actor_id)
    and actor_id in ( select actor_id
                        from film_actor
                        where film_id in ( select film_id 
                                           from film
                                           where title = 'BETRAYED REAR' or title = 'CATCH AMISTAD')  
                        group by actor_id);

#ej8
select actor_id,first_name,last_name
    from actor
    where actor_id not in ( select actor_id
                        from film_actor
                        where film_id in ( select film_id 
                                           from film
                                           where title = 'BETRAYED REAR' or title = 'CATCH AMISTAD')  
                        group by actor_id);



