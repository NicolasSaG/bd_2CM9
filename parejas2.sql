--hsim hombre le es simpatico a la mujer
--ejemplo: a nancy le gusta angel
--		   a nancy le gusta luis
-- nomH		nomM
--angel		nancy
--luis		nancy
--alex		nancy
--angel		miriam


--msim ejemplos mujer le es simpatica a hombre
--nomH 		nomM
--angel		maria
--luis		alex

--matrimonio
--nomH 		nomm
--angel		nancy
--angel		maria

--HACER CONSULTAS
--encontrar los hombres que están solteros
--encontrar parejas que se caen mutuamente simpaticos
--encontrar parejas parejas casadas que se caen mutuamente simpaticos
--Encontrar parejas que se caen mutuamente simpaticos en que sus edades seanmayores a 30 anios
--hallar los hombres casados a los que no les cae simpatico su esposa
--hallar mujeres casadas que caen simpaticas a algun hombre
--encontrar los hombres a quienes solo caen simpaticas mujeres casadas


--las relaionas solo una llave primaria
--crear llaves foraneas hsim y msim y matrimonio 2 llaves foraneas

create database parejas2;
use parejas2;

create table hombre(
	nomh varchar(20) not null,
	edad int(3) not null 
);

create table mujer(
	nomm varchar(20) not null,
	edad int(3) not null
);

create table hsim(
	nomh varchar(20) not null, 
	nomm varchar(20) not null
);

create table msim(
	nomh varchar(20) not null,
	nomm varchar(20) not null
);

create table matrimonio(
	nomh varchar(20) not null,
	nomm varchar(20) not null
);


alter table hombre
add constraint PK1 primary key(nomh);


alter table mujer
add constraint PK2 primary key(nomm);


alter table hsim
add constraint FK1 foreign key (nomh) references hombre(nomh) on delete cascade on update cascade;

alter table hsim
add constraint FK2 foreign key (nomm) references mujer(nomm) on delete cascade on update cascade;

alter table hsim
add constraint PK3 primary key(nomh, nomm);


alter table msim
add constraint FK3 foreign key (nomh) references hombre(nomh) on delete cascade on update cascade;

alter table msim
add constraint FK4 foreign key (nomm) references mujer(nomm) on delete cascade on update cascade;

alter table msim
add constraint PK4 primary key(nomh, nomm

--HACER CONSULTAS
--encontrar los hombres que están solteros
--encontrar parejas que se caen mutuamente simpaticos
--encontrar parejas parejas casadas que se caen mutuamente simpaticos
--Encontrar parejas que se caen mutuamente simpaticos en que sus edades seanmayores a 30 anios
--hallar los hombres casados a los que no les cae simpatico su esposa
--hallar mujeres casadas que caen simpaticas a algun hombre
--encontrar los hombres a quienes solo caen simpaticas mujeres casadas);


alter table matrimonio
add constraint FK5 foreign key (nomh) references hombre(nomh) on delete no action on update no action;

alter table matrimonio
add constraint FK6 foreign key (nomm) references mujer(nomm) on delete no action on update no action;

alter table matrimonio
add constraint PK5 primary key(nomh, nomm);



--insercins ejemplo
insert into hombre values
	('francisco', 45),
	('marco', 22),
	('nicolas', 20),
	('uriel', 17),
	('tristan',21),
	('alberto', 33),
	('juan',35),
	('roberto',31);


insert into mujer values
	('mariana', 20),
	('diana', 22),
	('valeria', 22),
	('sandra', 31),
	('jacqueline',31),
	('aida', 43),
	('melissa',25),
	('jessica',37);

insert into matrimonio values
	('francisco', 'marlene'),
	('uriel', 'jacqueline'),
	('alberto', 'jessica'),
	('tristan', 'diana'),
	('roberto','valeria'),
	('juan', 'melissa');

insert into hsim values
	('francisco','marlene'),
	('roberto','valeria'),
	('tristan', 'valeria'),
	('nicolas', 'jessica'),
	('roberto', 'sandra'),
	('juan', 'aida');

insert into msim values
	('francisco','marlene'),
	('roberto','mariana'),
	('tristan', 'aida'),
	('nicolas', 'valeria'),
	('roberto', 'diana'),
	('juan', 'melissa');


--HACER CONSULTAS
--encontrar los hombres que están solteros
select * from hombre where nomh not in (select nomh from matrimonio);

--encontrar parejas que se caen mutuamente simpaticos
select hsim.nomh, hsim.nomm from hsim, msim where hsim.nomh = msim.nomh and hsim.nomm = msim.nomm;

--encontrar parejas parejas casadas que se caen mutuamente simpaticos
select parejas.nomh, parejas.nomm from matrimonio, (select hsim.nomh,hsim.nomm from hsim, msim where hsim.nomh = msim.nomh and hsim.nomm = msim.nomm) as parejas where parejas.nomh = matrimonio.nomh and parejas.nomm = matrimonio.nomm;

--Encontrar parejas que se caen mutuamente simpaticos en que sus edades seanmayores a 30 anios
select parejas.nomh, parejas.nomm from (select hsim.nomh,hsim.nomm from hsim, msim where hsim.nomh = msim.nomh and hsim.nomm = msim.nomm) as parejas, hombre, mujer  where  hombre.nomh = parejas.nomh and mujer.nomm = parejas.nomm and hombre.edad > 30 and mujer.edad > 30;

--hallar los hombres casados a los que no les cae simpatico su esposa
select nomh from matrimonio where nomh not in (select matrimonio.nomh from hsim, matrimonio where hsim.nomh = matrimonio.nomh and hsim.nomm = matrimonio.nomm);

--hallar mujeres casadas que caen simpaticas a algun hombre
select matrimonio.nomm from matrimonio, msim where matrimonio.nomm = msim.nomm;

--encontrar los hombres a quienes solo caen simpaticas mujeres casadas
select casadas_y_solteras.nomh from (select msim.nomh, msim.nomm from msim, matrimonio where matrimonio.nomm = msim.nomm) as casadas_y_solteras where casadas_y_solteras.nomh not in ( select solteras.nomh from hsim, (select nomm from mujer where nomm not in (select nomm from matrimonio)) where mujer.nomm = hsim.nomm); 


select nomh from (select hsim.nomm, nomh from (select nomm from matrimonio) as casadas, hsim where casadas.nomm = hsim.nomm) as sol_y_cas where sol_y_cas.nomh not in (select nomh from ((select algo.nomm,nomh from hsim, (select nomm from mujer where nomm not in (select nomm from matrimonio)) as algo where algo.nomm = hsim.nomm)) as sol); 


