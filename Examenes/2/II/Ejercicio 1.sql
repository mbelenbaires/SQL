create database SP_PI
go
use SP_PI
go
create table Paises(
id int identity(1,1) primary key,
pais varchar(50) not null
)
go
create table Equipos(
id bigint identity(1,1) primary key,
idpais int not null foreign key references Paises(id),
equipo varchar(50) not null
)
go
create table Personas(
dni int not null primary key,
idpais int not null foreign key references Paises(id),
nombre varchar(30) not null,
apellido varchar(30) not null,
idequipo_fav bigint foreign key references Equipos(id)
)
 