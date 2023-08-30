
    select a.postal_code, ci.city, co.country
    from address a
    inner join city ci on ci.city_id = a.city_id
    inner join country co on co.country_id = ci.country_id
    where postal_code in(
        '18743', '77948', '30695'
    );

    select a.postal_code, ci.city, co.country
    from address a
    inner join city ci on ci.city_id = a.city_id
    inner join country co on co.country_id = ci.country_id
    where postal_code not in(
        '18743', '77948', '30695'
    );

    create index idx_postal_code on address (postal_code);

    ###
    Un índice en la columna postal_code ayudará a mejorar la velocidad de las consultas que utilizan postal_code como filtro de búsqueda.
    ###


select *
from actor
where first_name = "GENE";

select *
from actor
where last_name = "MCKELLEN";

###
La diferencia es imperceptible, si es que la hay.
###

alter table film add FULLTEXT(description);

select *
from film
where description like '%action%';


select *
from film
where match(description) against('action');

###
El indice FULLTEXT está diseñado para manejar consultas que buscan palabras o frases en las columnas varchar de una tabla. En esta base de datos es imperceptible el tiempo que se ahorra
###