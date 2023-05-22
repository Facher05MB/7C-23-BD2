#ej1


SELECT c.country_id as id , c.country as pais
    FROM country c
    JOIN city ci ON c.country_id = ci.country_id
    GROUP BY c.country_id, c.country
    having  COUNT(ci.city_id)
    ORDER BY c.country, c.country_id;


#ej2


