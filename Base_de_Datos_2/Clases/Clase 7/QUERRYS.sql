

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
                        AND NOT EXISTS(SELECT * FROM film AS f2 WHERE f2.film_id <> f1.film_id AND f2.length <= f1.length)

;



Generate a report with list of customers showing the lowest payments done by each of them. 
Show customer information, the address and the lowest amount, provide both solution using ALL and/or ANY and MIN.
#ej3

SELECT customer_id, 
       first_name, 
       last_name, 
       (SELECT DISTINCT amount 
          FROM payment 
         WHERE customer.customer_id = payment.customer_id 
           AND amount >= ALL (SELECT amount 
                                FROM payment 
                               WHERE customer.customer_id = payment.customer_id))
	   AS max_amount 
  FROM customer 
 ORDER BY max_amount DESC, 
        customer_id DESC;

address address

SELECT DISTINCT amount 
          FROM payment,customer
         WHERE customer.customer_id = payment.customer_id 
           AND amount >= ALL (SELECT amount 
                                FROM payment 
                               WHERE customer.customer_id = payment.customer_id)

Generate a report that shows the customer's information with the highest payment and the lowest payment in the same row'.
#ej4 






