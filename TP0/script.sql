create database parte1
go
USE PARTE1
alter table socios
(legajo int identity (1000,1000),
dni int not null unique,
nombre varchar(20) not null,
nacimiento date not null check (year(nacimiento)<2010),
genero varchar,
primary key(legajo,dni))
go
create table provincias
(idprov int identity(1,1) primary key,
nombre varchar(40) not null
)
go
create table localidades
(idloc bigint identity(1,1) primary key,
nombre varchar(40) not null,
idprov int not null foreign key references provincias(idprov))
go
create table sedes
(idsede int identity(1,1) primary key,
nombre varchar not null,
telefono bigint,
mail varchar(50),
localidad bigint not null foreign key references localidades(idloc)
)
go
create table actividades
(id int primary key identity(1,1),
nombre varchar(25) not null,
costo money not null check (costo>0),
apto varchar(2) not null check (apto='si' or apto='no'),
idsede int not null foreign key references sedes(idsede))


insert into socios (dni,nombre,nacimiento,genero) values ('2','a','2000/01/01','')

select * from socios