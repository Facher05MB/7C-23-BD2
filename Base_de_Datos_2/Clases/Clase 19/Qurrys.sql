#1
#Create a user data_analyst

CREATE USER 'data_analyst'@'localhost' IDENTIFIED BY 'pepe1234';

#2
#Grant permissions only to SELECT, UPDATE and DELETE to all sakila tables to it.

GRANT SELECT, UPDATE, DELETE ON sakila.* TO 'data_analyst'@'localhost';

