#1

CREATE TABLE `employees` (
  `employeeNumber` int(11) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `extension` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `officeCode` varchar(10) NOT NULL,
  `reportsTo` int(11) DEFAULT NULL,
  `jobTitle` varchar(50) NOT NULL,
  PRIMARY KEY (`employeeNumber`)
);

insert into employees (
   employeeNumber,
   lastName,
   firstName,
   extension, 
   email,
   officeCode,
   reportsTo,
   jobTitle
) VALUES (
        50,
        'Maximo',
        'Blazquez',
        '???',
        NULL,
        '1234',
        123,
        'JEFE'
);

  
#2

UPDATE employees SET employeeNumber = employeeNumber - 20

/* Le resta 20 a todos los IDs */

UPDATE employees SET employeeNumber = employeeNumber + 20;
/* Le sumara 20 a todos los empleyee de la tabla,
    si se obtiene un resultado que ya existe en la misma columna. 
    tendrías una violación de la restricción de unicidad, 
    ya que las columnas con valores duplicados no cumplen con la propiedad de clave única. */



#3 

ALTER TABLE employees
    ADD age INT CHECK ( age BETWEEN 16 AND 70);




#4

/* La tabla films tiene peliculas, y la tabla film_actor es una tabla intermedia que
   contiene la relacion entre la pelicula y los actores que actuaron en esa determinada pelicula.
   Esta relacion es asi ya que es una relacion de muchos a muchos (una pelicula puede tener
   muchos actores, y un actor puede tener muchas peliculas). El caracter de esta realcion
   no permite que sea solamente una clave foranea en otra tabla, ya que habria que concatenar o
   poner muchos valores en un campo o poner un valor nulo (malas practicas) */



#5 
  
alter table employees add column lastUpdate datetime;

alter table employees add lastUpdateUser varchar(50);

DELIMITER $$
create trigger before_employees_update before update on employees for each row 
begin
  set NEW.lastUpdate = now();
  SET NEW.lastUpdateUser = CURRENT_USER;
end$$
create trigger before_employees_insert before insert on employeesfor each row 
begin
  set NEW.lastUpdate = now();
  SET NEW.lastUpdateUser = CURRENT_USER;
end$$
delimeter ;

/*Ej6
#Find all the triggers in sakila db related to loading film_text table. 
#What do they do? Explain each of them using its source code for the explanation*/

----------------- INS_FILM ------------------
-- Inserta una nueva pelicula en film_text --
/*
BEGIN
    INSERT INTO film_text (film_id, title, description)
        VALUES (new.film_id, new.title, new.description);
END
*/
------------------------ UPD_FILM ------------------------
-- Actualiza el film_text existente por uno actualizado --
/*
BEGIN
	IF (old.title != new.title) OR (old.description != new.description) OR (old.film_id != new.film_id)
	THEN
	    UPDATE film_text
	        SET title=new.title,
	            description=new.description,
	            film_id=new.film_id
	    WHERE film_id=old.film_id;
	END IF;
END
*/
---------------------------------- DEL_FILM --------------------------------
-- Elimina el film_text existente que corresponde a la pelicula eliminada --
/*
BEGIN
    DELETE FROM film_text WHERE film_id = old.film_id;
END
*/
