/*
	Continuacion de practica 1
	Se usa la bd de colegio (practica 1)

	Se hacen pruebas de lo que pasa al intentar actualizar tablas con referencias de foraneas
	usando cascade, set null, restrict y no action
*/

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

--PARTE 2

alter table asistencia
drop foreign key FK1;

alter table asistencia
drop foreign key FK2;

alter table asistencia
drop foreign key FK3;

alter table asistencia
drop foreign key FK4;

--probar borrado y actualizacion con restrict
alter table asistencia
add constraint FK1 foreign key (idP) references profesor(idP) on delete restrict on update restrict;

--agregar datos
insert into asistencia values
	('P4', 'A4', 'C4', NULL);	
insert into asistencia values
	('P4', 'A5', 'C4', NULL);

--borramos p4 de profesor
delete from profesor 
	where idP='P4';
 
--actualizacion 
update profesor
	set  nombre_profesor = 'Adrian'
	where idP = 'P4';

update profesor
	set  idP = 'P8'
	where idP = 'P4';

--probar borrado y actualizacion con no action
alter table asistencia
drop foreign key FK1;

alter table asistencia
add constraint FK1 foreign key (idP) references profesor(idP) on delete no action  on update no action;


--agregar datos en asistencia

insert into asistencia values
	('P3', 'A5', 'C1', NULL);	
insert into asistencia values
	('P3', 'A5', 'C2', NULL);


update profesor
	set  idP = 'P9'
	where idP = 'P3';

-- regresamos a parte 2
delete from asistencia 
	where idP='P3'
	and idA='A5'
	and idC= 'C2';

delete from asistencia 
	where idP='P3'
	and idA='A5'
	and idC= 'C1';

delete from asistencia 
	where idP='P4'
	and idA='A4'
	and idC= 'C4';

delete from asistencia 
	where idP='P4'
	and idA='A5'
	and idC= 'C4';

alter table asistencia
add constraint FK1 foreign key (idP) references profesor(idP) on delete cascade on update cascade;

alter table asistencia
add constraint FK2 foreign key (idA) references asignatura(idA) on delete cascade on update cascade;

alter table asistencia
add constraint FK3 foreign key (idC) references clase(idC) on delete cascade on update cascade;

alter table asistencia
add constraint FK4 foreign key (idPAux) references profesor(idP) on delete cascade on update cascade;

--punto 3 bd
alter table profesor 
add column edad int(2) null;

--fecha actual
select curdate();
select now();

--1er param dias, meses o anios
--2do param fecha_profesor, fechaactual
--3er fecha actual
select timestampdiff(year, fecha_nacimiento, curdate()) as edad from profesor;

update profesor
	set edad=timestampdiff(year, fecha_nacimiento, curdate()) where idP='P3';

update profesor
	set edad=timestampdiff(year, fecha_nacimiento, curdate()) where idP='P4';

update profesor
	set edad=timestampdiff(year, fecha_nacimiento, curdate()) where idP='P5';

-- borrar datos de edad
update profesor
	set edad=NULL;

--restriccion deedad a profesor
alter table profesor
add constraint PM1 check(edad>=31);

--intentar volver a meter los datos
update profesor
	set edad=timestampdiff(year, fecha_nacimiento, curdate()) where idP='P3';

update profesor
	set edad=timestampdiff(year, fecha_nacimiento, curdate()) where idP='P4';

update profesor
	set edad=timestampdiff(year, fecha_nacimiento, curdate()) where idP='P5';
