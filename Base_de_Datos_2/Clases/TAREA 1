CREATE DATABASE TAREA1;

USE TAREA1;

CREATE TABLE Film (id int auto_increment primary key, title varchar(30), descripcion varchar(100), release_year datetime);


CREATE TABLE Actor (id int auto_increment primary key, first_name varchar (15), last_name varchar (15));


CREATE TABLE Film_Actor (id int auto_increment primary key);



ALTER TABLE Film add last_update datetime;



ALTER TABLE Actor add last_update datetime;



ALTER TABLE Film_Actor add id_film int;



ALTER TABLE Film_Actor add id_actor int;



ALTER TABLE Film_Actor add constraint foreign key (id_film) references Film(id);

ALTER TABLE Film_Actor add constraint foreign key (id_actor) references Actor(id);


insert into Film (title,descripcion,release_year) values ("La Roma","Pelicula de la vieja Roma", '2002-10-22 01:15:00');

insert into Film (title,descripcion,release_year) values ("Tokio","Pelicula de yakuzhas", '2022-10-22');

insert into Film (title,descripcion,release_year) values ("DEVIL MAY CRY","I AM THE STORM THAT IS APROCHING", '2022-10-22');


insert into Actor (first_name,last_name,last_update) values ("Virgil"," SSS ", '2222-12-22');


insert into Actor (first_name,last_name,last_update) values ("Luis","Fonsi", '2021-11-25');


insert into Actor (first_name,last_name,last_update) values ("Kurasaki"," Yomuya", '2017-01-14');



insert into Film_Actor (id_film,id_actor) values (3,1);

insert into Film_Actor (id_film,id_actor) values (2,2);

insert into Film_Actor (id_film,id_actor) values (1,3);


