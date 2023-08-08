Se desea generar un informe que muestre el mes del año con mayor tendencia a
adopciones exitosas, junto con el tipo de mascota más adoptada por mes del año y
ratio de voluntarios por atención médica.






SELECT (
    SELECT concat(first_name, ' ', last_name) 
    from customer
    where customer_id = p1.customer_id
) as name,
p1.amount as amount_1, p2.amount as amount_2
FROM payment p1, payment p2
where p1.customer_id = p2.customer_id
and p1.amount <> p2.amount
and customer.first_name REGEXP '^ [aeiou]';