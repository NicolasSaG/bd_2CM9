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

-- practica 2
insert into asistencia values
	('P8', 'A8','C8');
-- no se ha ingresado un profesor, clase ni asignatura 8
-- La tabla de asistencia tiene inconsistencia de datos

delete from asistencia where idP='P8';

alter table asistencia
add constraint FK1 foreign key (idP) references profesor(idP);

alter table asistencia
add constraint FK2 foreign key (idA) references asignatura(idA);

alter table asistencia
add constraint FK3 foreign key (idC) references clase(idC);


-- comprobar que las llaves foraneas funcionen
--select * from asistencia natural join profesor, asignatura, clase;


delete from profesor
where idP='P1';
--error ya que la esta usando asistencia
--primero, borrar de asistencia P1

delete from asistencia
	where idP='P1';

--volver a ingressar
insert into asistencia values
	('P1', 'A1','C1'),	
	('P1', 'A2','C3');

-- borrar foraneas
alter table asistencia
drop foreign key FK1;

alter table asistencia
drop foreign key FK2;


alter table asistencia
drop foreign key FK3;


-- modificar llaves foraneas
alter table asistencia
add constraint FK1 foreign key (idP) references profesor(idP) on delete cascade on update cascade;

alter table asistencia
add constraint FK2 foreign key (idA) references asignatura(idA) on delete cascade on update cascade;

alter table asistencia
add constraint FK3 foreign key (idC) references clase(idC) on delete cascade on update cascade;

-- borrar de profesor idP = P2
delete from profesor
	where idP='P2';

update profesor
	set idP='P7'
	where idP='P1';

-- que pasa si se pone on delete set null on update set null
--									 restrict 		restrict
--					  				no action		no action





-- agregar idPAux char(3) null en asistencia, es foranea y hace referencia a profesor.idP
-- a la foranea ponerle set null
-- a la mitad P7
-- a los otros P5
-- borrar foraneas antes o despues de agregar la columna?


alter table asistencia 
add column idPAux char(3) null;

alter table asistencia
add constraint FK4 foreign key (idPAux) references profesor(idP) on delete set null on update set null;

update asistencia
	set idPAux = 'P7'
	where idP = 'P7' AND 
	idA = 'A1' AND 
	idC = 'C1';

update asistencia
	set idPAux = 'P7'
	where idP = 'P3';


update asistencia
	set idPAux = 'P7'
	where idP = 'P4';


update asistencia
	set idPAux = 'P5'
	where idP = 'P5';


update asistencia
	set idPAux = 'P5'
	where idP = 'P7';



--delete from profesor
--	where idP='P2';

-- que pasa si se pone on delete set null on update set null
--									 restrict 		restrict
--					  				no action		no action


delete from profesor 
	where idP='P7';