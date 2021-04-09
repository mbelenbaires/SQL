create database tp1B
go
use tp1B
go
create table carreras(
id int not null identity(1,1) primary key,
nombre varchar(50) not null
)
go
create table materias(
idmateria int not null identity(1,1) primary key,
idcarrera int not null foreign key references carreras(id)
)
go
create table alumnos(
legajo bigint not null identity(1,1) primary key,
apellido varchar(25) not null,
nombres varchar(30) not null
)
go
create table carrerasxalu(
legajo bigint not null foreign key references alumnos(legajo),
idcarrera int not null foreign key references carreras(id),
primary key (legajo,idcarrera)
)
go
create table materiasxalu(
legajo bigint not null foreign key references alumnos(legajo),
idmateria int not null foreign key references materias(idmateria),
primary key(legajo,idmateria)
)
go
create table examenes(
idmateria int not null foreign key references materias(idmateria),
fecha date not null,
idexamen bigint identity(1,1) primary key
)
go
create table inscripciones(
idmateria int not null foreign key references materias(idmateria),
fecha date not null,
legajo bigint not null foreign key references alumnos(legajo),
nota int check (nota>-1 and nota<10),
primary key (legajo,idmateria,fecha)
)
