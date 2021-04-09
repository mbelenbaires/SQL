create database tp1c
go
use tp1c
go
create table carreras(
codigo bigint identity(1,1) primary key,
nombre varchar(50) not null,
resolucion varchar(15) not null
)
go
create table materias(
idmateria bigint identity(1,1) primary key,
nombre varchar(40) not null,
codigocarrera bigint not null foreign key references carreras(codigo),
)
go
create table docentes(
legajo bigint identity(1,1) primary key,
dni bigint not null unique,
nombre varchar(30) not null,
apellido varchar(30) not null,
fechanac date not null
)
go
create table cargos(
idcargo int identity(1,1) primary key,
nombre varchar(20) not null
)
go
create table cargoxdocente(
idmateria bigint not null foreign key references materias(idmateria),
anio int not null,
legajo bigint not null foreign key references docentes(legajo),
idcargo int not null foreign key references cargos(idcargo)
)