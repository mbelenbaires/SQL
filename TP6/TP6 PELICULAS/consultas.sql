--A) Listar los actores que no hayan participado en ninguna película.

select a.nombre, a.apellido from actores a full join actoresxpelicula axc on a.codigo = axc.actor
where axc.actor = null

--B) Listar todas las películas que tengan una duración mayor a la duración promedio.

select * from peliculas p where duracion > (select avg(duracion) from peliculas)

--C) Listar todas las películas que hayan vendido mayor cantidad de tickets que alguna película
--perteneciente al género DRAMA.

select * from peliculas p where tickets >  any (select tickets from peliculas p inner join generos
on p.idgenero = generos.id)

--D) Listar todas las películas que hayan recaudado más que cualquier película 'Apta para todo
--público'.

select * from peliculas p where p.recaudacion > all (select recaudacion from peliculas
inner join calificaciones on p.idcalificacion = calificaciones.id
where calificacion like '%publico')

--E) Por cada país, la cantidad de películas que hayan tenido un puntaje mayor o igual a 7 y la
--cantidad de películas que hayan tenido un puntaje menor a 7.

select paises.nombre as Pais, (select count(p.id) from peliculas p
where p.idpais = paises.id and puntaje >=7) as Cantmayor7,
(select count(p.id) from peliculas p
where p.idpais = paises.id and puntaje >7) as Cantmenor7
from paises

--F) Los países que hayan tenido al menos una película con puntaje mayor o igual a 7 y al menos
--una película con puntaje menor a 7.

SELECT AUX.* FROM  --selecciono todo lo de esa tabla aux
(
	SELECT P.NOMBRE as Pais,
	(SELECT COUNT(*) FROM PELICULAS WHERE P.ID = IDPAIS AND PUNTAJE >= 7) AS CANTmayor7,
	(SELECT COUNT(*) FROM PELICULAS WHERE P.ID = IDPAIS AND PUNTAJE < 7) AS CANTmenor7
	 FROM PAISES P
) AS AUX --me armo una tabla aux que tenga el pais, pelis c puntaje>7 y <7
WHERE AUX.CANTmayor7 >= 1 AND AUX.CANTmenor7 >= 1
--restrinjo a los casos donde tengan al menos uno
