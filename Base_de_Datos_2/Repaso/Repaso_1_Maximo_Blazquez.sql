CREATE DATABASE TP_1_BASE_DE_DATOS_2_MAXIMO_BLAZQUEZ;

USE TP_1_BASE_DE_DATOS_2_MAXIMO_BLAZQUEZ;


Drop Table if exist Sede;
Drop Table if exist Clase;
Drop Table if exist Socio;
Drop Table if exist Reserva;
Drop Table if exist Assistencia;
Drop Table if exist Tipo_Plan;
Drop Table if exist Plan;
Drop Table if exist Session;
Drop Table if exist Ejercicio;
Drop Table if exist Registro;


Create Table Sede(id int primary key, nombre varchar(30));

Create Table Clase(id int primary key, nombre varchar(30), hora_inicio_clase datetime, hora_final_clase datetime, id_sede int, foreign key (id_sede) references Sede(id));


Create Table Socio(documento int primary key, nombre varchar(30), apellido varchar(30), fecha_nacimiento datetime, etc varchar(70));

Create Table Reserva(id int primary key, id_clase int, foreign key (id_clase) references Clase(id), documento_socio int, foreign key (documento_socio) references Socio(documento));


Create Table Assistencia(id int primary key, hora_llegada datetime, id_reserva int, foreign key (id_reserva) references Reserva(id));


Create Table Tipo_Plan(id int primary key, nombre varchar(30));


Create Table Plan(id int primary key, nombre varchar(30), fecha_limite datetime, id_tipo_plan int, foreign key (id_tipo_plan) references Tipo_Plan(id));


Create Table Sessiones(id int primary key, nombre varchar(30), orden int, id_plan int, foreign key (id_plan) references Plan(id));

Create Table Ejercicio(id int primary key, nombre varchar(30), series int, repeticiones int, nota varchar(70) ,  id_sessiones int , foreign key (id_sessiones) references Sessiones(id));

Create Table Registro(id int primary key, nombre varchar(30), series int, repeticiones int, observacion varchar(70), peso float ,  id_ejercicio int , foreign key (id_ejercicio) references Ejercicio(id));











