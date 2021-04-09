use tp2
go
insert into paises(nombre) values ('argentina'),('estados unidos'), ('reino unido'), ('india'), ('francia'), ('españa')
go
insert into generos(genero) values ('terror'),('comedia'),('ciencia ficcion'), ('drama')
go
insert into calificaciones(calificacion) values ('apto para todo publico'), ('apto para mayores de 13'), ('apto para mayores de 16')
go
insert into actores (apellido,nombre,fechanac,idpais) values ('darin','ricardo','16/01/1957','1'),('bale','christian','30/01/1974','3'),('paltrow','gwyneth','27/11/1972','2'),('freeman','morgan','01/06/1937','2')
go
insert into peliculas (idpais,nombre,inversion,recaudacion,tickets,idgenero,estreno,duracion,idcalificacion,puntaje)
values ('2','seven','10000000','30000000','5000000','4','15/01/1996','127','2','8.70'),
('1','un cuento chino', '5000000','4000000','1000000','2','24/03/2011','93','1','6.70'),
('2','terminator','20000000','90000000','6000000','3','3/06/2009','115','2','6.70')
go
insert into actoresxpelicula(idpeli,actor) values ('1','3'),('1','4'),('2','1'),('3','2')
