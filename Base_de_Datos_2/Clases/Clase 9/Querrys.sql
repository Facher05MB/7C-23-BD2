#ej1



SELECT country_id, country
    FROM country 
    where country_id in ( select country_id
                            from city 
                            having COUNT(city_id)) 
    GROUP BY country_id, country;
 
