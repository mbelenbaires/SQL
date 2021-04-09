create database tp2
go
use tp2
go
create table paises(
id int identity (1,1) primary key,
nombre varchar(50) not null
)
go
create table actores(
codigo bigint identity(1,1) primary key,
nombre varchar(50) not null,
apellido varchar(50) not null,
fechanac date not null,
idpais int not null foreign key references paises(id)
)
go
create table generos(
id int identity(1,1) primary key,
genero varchar(30) not null
)
go
create table calificaciones(
id int identity(1,1) primary key,
calificacion varchar(30) not null
)
go
create table peliculas(
id bigint identity(1,1) primary key,
nombre varchar(150) not null,
idpais int not null foreign key references paises(id),
inversion money not null check (inversion>0),
tickets bigint not null check (tickets>-1),
recaudacion money not null,
idgenero int foreign key references generos(id),
estreno date not null,
duracion smallint not null check (duracion>0),
idcalificacion int not null foreign key references calificaciones(id),
puntaje decimal(10,2)
)
go
create table actoresxpelicula(
actor bigint not null foreign key references actores(codigo),
idpeli bigint not null foreign key references peliculas(id),
primary key (actor,idpeli)
)
