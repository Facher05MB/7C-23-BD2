

#ej1


SELECT title,rating,length 
  FROM film as f1
  WHERE length <= ALL (SELECT length 
                        FROM film)
;


#ej2
SELECT title,rating,length 
  FROM film as f1
  WHERE length <= ALL (SELECT length 
                        FROM film)
                        AND  NOT EXISTS(SELECT * FROM film AS f2 WHERE f2.film_id <> f1.film_id AND f2.length <= f1.length)

;





#ej3 


SELECT * from (
  SELECT c.customer_id as id,c.first_name as nombre, c.last_name as apellido , a.address as dirrecion, p.amount AS menor_pago
  FROM customer c
  INNER JOIN payment p on c.customer_id = p.customer_id
  INNER JOIN address a on c.address_id = a.address_id
  WHERE p.amount <= ALL(
    SELECT amount from payment WHERE customer_id=c.customer_id
  )
) as query_principal
GROUP BY id,menor_pago;




#ej4 

SELECT id, nombre, apellido, direccion, min(precio) AS menor_pago, max(precio) AS mayor_pago from (
  SELECT c.customer_id as id,c.first_name as nombre, c.last_name as apellido,a.address as direccion,p.amount as precio
  FROM customer c
  INNER JOIN payment p on c.customer_id = p.customer_id
  INNER JOIN address a on c.address_id = a.address_id
  WHERE p.amount <= ALL(
    SELECT amount from payment WHERE customer_id=c.customer_id
  )
  OR p.amount >= ALL(
    SELECT amount from payment WHERE customer_id=c.customer_id
  )
) as query_principal
GROUP BY id;








