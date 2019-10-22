#producto cruz
#multipliacion de 2 relaciones
#ejemplo usando bd de practica 1 llamda colegio2:
select * from profesor, asignatura;

#seleccion	
select * from asistencia where idC='C3';

#producto cruz
select * from (select * from asistencia where idC='C3') as asisC3, profesor;

#seleccion 
select * from (select * from asistencia where idC='C3') as asisC3, profesor where asisC3.idP = profesor.idP;


#proyeccion
select nombre_profesor from (select * from asistencia where idC='C3') as asisC3, profesor where asisC3.idP = profesor.idP;

#fomra de clase
select nombre_profesor from asistencia, profesor where asistencia.idP = profesor.idP and idC='C3';


#proyeccion en idP
#quitamos clumnas que no nos interesan de las 2 tablas
select nombre_profesor from (select idP, idC from asistencia) as t1, (select idP, nombre_profesor from profesor) as t2 where idC= 'C3' and t1.idP = t2.idP; 


update profesor
	set edad=timestampdiff(year, fecha_nacimiento, curdate()) where idP='P2';

	update profesor
	set edad=timestampdiff(year, fecha_nacimiento, curdate()) where idP='P1';



