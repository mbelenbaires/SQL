create database tp1Av2
go
use tp1Av2
go
create table marcas(
idmarca bigint identity(1,1) primary key,
nombre varchar(20) not null
)
go
create table tipoart(
idtipo bigint identity(1,1) primary key,
tipo varchar(25) not null
)
go
create table articulos(
codigo varchar(6) not null primary key,
descripcion varchar(30) not null,
marca bigint not null foreign key references marcas(idmarca),
precioc money not null check (precioc>0),
preciov money not null check (preciov>0),
tipoart bigint not null foreign key references tipoart(idtipo),
stockactual bigint not null check(stockactual > -1),
stockmin bigint not null check (stockmin > 0),
estado varchar(8) not null check (estado='activo' or estado='inactivo')
)
go
create table provincias(
id int primary key identity(1,1),
nombre varchar(30) not null
)
go
create table localidades(
id bigint identity(1,1),
idprov int not null foreign key references provincias(id),
cp varchar(10) not null primary key
)
go
create table clientes(
dni bigint not null primary key,
nombres varchar(30) not null,
apellidos varchar (30) not null,
genero varchar(5),
nacimiento date not null,
alta date not null,
direccion varchar(50) not null,
cp varchar(10) not null foreign key references localidades (cp),
telefono bigint,
mail varchar(50),
sueldo bigint not null,
)
go
create table vendedores(
dni bigint not null unique,
legajo bigint not null primary key,
nombres varchar(30) not null,
apellidos varchar (30) not null,
genero varchar(5),
nacimiento date not null,
alta date not null,
direccion varchar(50) not null,
cp varchar(10) not null foreign key references localidades (cp),
telefono bigint,
sueldo bigint not null,
)
go
create table ventas(
factura varchar(15) not null primary key,
fecha date not null,
cliente bigint not null foreign key references clientes(dni),
vendedor bigint not null foreign key references vendedores(legajo),
pago varchar(1) not null check (pago='e' or pago='t')
)
go
create table artxventa(
venta varchar(15) not null foreign key references ventas(factura),
codigo varchar(6) not null foreign key references articulos(codigo),
cant bigint not null check(cant>0)
)