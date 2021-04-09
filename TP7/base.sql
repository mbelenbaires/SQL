create database tp_resto
go
use tp_resto
go
create table ingredientes(
id bigint identity(1,1) primary key,
ingrediente varchar(20) not null 
)
go
create table categorias(
id int identity(1,1) primary key,
categoria varchar(20) not null,
)
go
create table recetas(
id int identity(1,1) primary key,
receta varchar(50) not null,
idcategoria int not null foreign key references categorias(id),
precio money not null check (precio>0),
dificultad int not null check(dificultad between 1 and 5),
tiempo int not null
)
go
create table unidades(
id int identity(1,1) primary key,
unidad varchar(20) not null
)
go
create table ingr_x_receta(
idreceta int not null foreign key references recetas(id),
idingrediente bigint not null foreign key references ingredientes(id),
cantidad int not null check(cantidad>0),
idunidad int not null foreign key references unidades(id),
primary key(idreceta,idingrediente)
)
go
create table mozxs(
id int identity(1,1) primary key,
nombre varchar(40) not null,
comision decimal(10,2) not null
)
go
create table pedidos(
id bigint identity(1,1) primary key,
mesa int not null,
idmozo int not null foreign key references mozxs(id),
formapago varchar(2) not null CHECK(FORMAPAGO = 'T' OR FORMAPAGO = 'E')
)
go
create table platosxpedido(
id bigint identity(1,1) primary key,
idpedido bigint not null foreign key references pedidos(id),
idreceta int not null foreign key references recetas(id),
fyhpedido date not null,
fyhentrega date not null
)
go
use tp_Resto
create table chefs(
id int identity(1,1) primary key,
nombre varchar(40) not null,
)
go
create table diasxchef(
idchef int not null foreign key references chefs(id),
horarioentrada date not null,
horariosalida date not null,
primary key(horarioentrada, horariosalida,idchef)
)
go
create table rubros(
id int identity(1,1) primary key,
rubro varchar(20) not null
)
go
create table proveedores(
id int identity(1,1) primary key,
nombre varchar(30) not null,
email varchar(50) not null,
telefono int not null
)
go
create table rubrosxprov(
idprov int not null foreign key references proveedores(id),
idrubro int not null foreign key references rubros(id),
primary key(idprov,idrubro)
)
go
create table ingr_x_prov(
idingrediente bigint not null foreign key references ingredientes(id),
idprov int not null foreign key references proveedores,
espera int not null,
primary key(idingrediente, idprov)
)
go
create table pedidos_x_chef(
idpedido bigint not null foreign key references pedidos(id),
idchef int not null foreign key references chefs(id),
primary key(idpedido,idchef)
)

