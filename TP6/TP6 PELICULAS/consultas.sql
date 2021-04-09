--A) Listar los actores que no hayan participado en ninguna pel�cula.

select a.nombre, a.apellido from actores a full join actoresxpelicula axc on a.codigo = axc.actor
where axc.actor = null

--B) Listar todas las pel�culas que tengan una duraci�n mayor a la duraci�n promedio.

select * from peliculas p where duracion > (select avg(duracion) from peliculas)

--C) Listar todas las pel�culas que hayan vendido mayor cantidad de tickets que alguna pel�cula
--perteneciente al g�nero DRAMA.

select * from peliculas p where tickets >  any (select tickets from peliculas p inner join generos
on p.idgenero = generos.id)

--D) Listar todas las pel�culas que hayan recaudado m�s que cualquier pel�cula 'Apta para todo
--p�blico'.

select * from peliculas p where p.recaudacion > all (select recaudacion from peliculas
inner join calificaciones on p.idcalificacion = calificaciones.id
where calificacion like '%publico')

--E) Por cada pa�s, la cantidad de pel�culas que hayan tenido un puntaje mayor o igual a 7 y la
--cantidad de pel�culas que hayan tenido un puntaje menor a 7.

select paises.nombre as Pais, (select count(p.id) from peliculas p
where p.idpais = paises.id and puntaje >=7) as Cantmayor7,
(select count(p.id) from peliculas p
where p.idpais = paises.id and puntaje >7) as Cantmenor7
from paises

--F) Los pa�ses que hayan tenido al menos una pel�cula con puntaje mayor o igual a 7 y al menos
--una pel�cula con puntaje menor a 7.

SELECT AUX.* FROM  --selecciono todo lo de esa tabla aux
(
	SELECT P.NOMBRE as Pais,
	(SELECT COUNT(*) FROM PELICULAS WHERE P.ID = IDPAIS AND PUNTAJE >= 7) AS CANTmayor7,
	(SELECT COUNT(*) FROM PELICULAS WHERE P.ID = IDPAIS AND PUNTAJE < 7) AS CANTmenor7
	 FROM PAISES P
) AS AUX --me armo una tabla aux que tenga el pais, pelis c puntaje>7 y <7
WHERE AUX.CANTmayor7 >= 1 AND AUX.CANTmenor7 >= 1
--restrinjo a los casos donde tengan al menos uno
