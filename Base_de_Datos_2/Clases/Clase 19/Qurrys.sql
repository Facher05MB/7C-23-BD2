#1
#Create a user data_analyst

CREATE USER 'data_analyst'@'localhost' IDENTIFIED BY 'pepe1234';

#2
#Grant permissions only to SELECT, UPDATE and DELETE to all sakila tables to it.

GRANT SELECT, UPDATE, DELETE ON sakila.* TO 'data_analyst'@'localhost';


#3
#Login with this user and try to create a table. Show the result of that operation.

use sakila;
create table NewTable (
    id int primary key auto_increment,
    test varchear(20)
);

# ERROR 1142 (42000): CREATE command denied to user 'data_analyst'@'localhost' for table 'NewTable'
# thats happens because the user 'data_analyst' does not have the necessary privileges to create a table in sakila database.
# Becouse only have the privilegs of SELECT, UPDATE, DELETE garant the capacity of EDIT tablesx


#4
#Try to update a title of a film. Write the update script.


UPDATE film
    SET title = 'titanic boondock'
WHERE title = 'TITANIC BOONDOCK';

UPDATE film
    SET title = 'titanic boondock'
WHERE title = 'TITANIC BOONDOCK';

#this work whit the user becouse the user has the privileges of UPDATE

#5
#With root or any admin user revoke the UPDATE permission. Write the command

REVOKE UPDATE ON sakila.* FROM 'data_analyst'@'localhost';

#revoke the Update permition



#6
#Login again with data_analyst and try again the update done in step 4. Show the result.

UPDATE film
    SET title = 'TITANIC BOONDOCK'
WHERE title = 'TITANIC BOONDOCK ';

#ERROR 1142 (42000): UPDATE command denied to user 'data_analyst'@'localhost' for table 'film'


