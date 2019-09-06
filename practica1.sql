--practica 1
create database colegio;
use colegio;

create table profesor(
	idP char(3) not null,
	nombre_profesor varchar(20) not null,
	oficina varchar(20) not null
);

create table asignatura(
	 idA char(3) not null,
	 nombre_asignatura varchar(20) not null
);

create table clase(
	idC char(3) not null,
	piso int(2) not null,
	bloque int(2) not null
);

create table asistencia(
	idP char(3) not null,
	idA char(3) not null,
	idC char(3) not null
);

alter table profesor
add constraint PK1 primary key(idP);

alter table asignatura
add constraint PK2 primary key(idA);

alter table clase
add constraint PK3 primary key(idC);

alter table asistencia
add constraint PK4 primary key(idP, idA, idC);

insert into profesor values('P1', 'Pedro', 105);
insert into profesor values('P2', 'Victor', 103);
insert into profesor values('P3', 'Sandy', 103);
insert into profesor values('P4', 'Josimar', 207);
insert into profesor values('P5', 'Eduardo', 207);

insert into asignatura values 
	('A1', 'Redes'),
	('A2', 'Bases de Datos'),
	('A3', 'Mercadotecnia'),
	('A4', 'Ciencias Sociales'),
	('A5', 'Ing. SW');

insert into clase values
	('C1', 1, 1),
	('C2', 1, 2),
	('C3', 2, 2),
	('C4', 3, 1);

insert into asistencia values
	('P1', 'A1','C1'),	
	('P1', 'A2','C3'),
	('P2', 'A4','C1'),
	('P3', 'A3','C3'),
	('P3', 'A3','C2'),	
	('P4', 'A2','C1'),
	('P4', 'A2','C2'),
	('P3', 'A3','C1'),
	('P5', 'A5','C2'),	
	('P5', 'A5','C1');	


alter table profesor
add column fecha_nacimiento date not null default '1999-01-01';

update profesor
	set fecha_nacimiento = '1991/06/14'
	where idP = 'P1';

update profesor
	set fecha_nacimiento = '1987/08/28'
	where idP = 'P2';

update profesor
	set fecha_nacimiento = '1984/11/11'
	where idP = 'P3';

update profesor
	set fecha_nacimiento = '1990/02/09'
	where idP = 'P4';

update profesor
	set fecha_nacimiento = '1987/04/16'
	where idP = 'P5';

-- hacer foreign key a los id's de asistencia, actualmente estan como primary keys
