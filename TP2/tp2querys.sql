---QUERYS TP2---

--A) Obtener un listado de actores ordenado por apellido en forma descendente.

select * from actores order by apellido desc;

--B) Obtener un listado de actores que tengan edad entre 18 y 28 años.

select * from actores where datediff(year,fechanac,getdate()) between 18 and 28;

--C) Obtener un listado de actores que cumplan años en los meses de Enero, Febrero, Marzo,
--Octubre, Noviembre y Diciembre.

select * from actores where month(fechanac) in (01,02,03,10,11,12);

--D) Obtener un listado de actores que no sean de nacionalidad con código 1, 2, 3, 6, 7 ni 8.

select * from actores where idpais not in(1,2,3,6,7,8);

--E) Obtener la última película estrenada del género ciencia ficción.

select top (1) with ties * from peliculas where idgenero = (select id from generos where genero like 'CIENCIA FICCION') order by estreno desc

--F) Obtener la película que mayor recaudación haya obtenido en el año 2011.

select top(1) with ties * from peliculas where year(estreno) = 2011 order by recaudacion desc

--G) Obtener las 10 mejores películas calificadas por los críticos. Mostrar todas las películas que se
-- encuentren en el 10° puesto si hay más de una película con igual puntaje en dicha posición.

select top (10) with ties * from peliculas order by puntaje desc

--H) Obtener un listado de todas las películas en las que haya actuado el actor con código número 1.

select * from peliculas where id = (select idpeli from actoresxpelicula where actor = 1)

--I) Obtener un listado que indique código de película, título y ganancia sólo de las películas que no
-- hayan generado pérdida.

select id,nombre, (recaudacion-inversion) as ganancia from peliculas where (recaudacion-inversion)>0

--J) Obtener los datos de la película que menos duración tenga.

select top(1) with ties * from peliculas order by duracion asc

--K) Obtener los datos de las películas que su título comience con la cadena 'Star'.

select * from peliculas where nombre like 'Star%'

--L) Obtener los datos de las películas que su título comience con la letra 'T' pero su última letra no
--sea 'A', 'E', 'I', 'O' ni 'U'.

select * from peliculas where nombre like 't%[^A,E,I,O,U]'

--M) Obtener los datos de las películas que su título contenga al menos un número del 0 al 9.

select * from peliculas where nombre like '%[0-9]%'

--N) Obtener los datos de las películas que su título contenga exactamente cinco caracteres.
--Resolverlo de dos maneras: 1) Utilizando el operador LIKE y comodines - 2) Utilizando la función
--LEN.

select * from peliculas where nombre like '_____'
select * from peliculas where len(nombre)=5

--O) Obtener los datos de las películas cuya recaudación supere el 25% de la inversión.

select * from peliculas where recaudacion > inversion*0.25

--P ) Obtener el título y el valor promedio de cada ticket. Teniendo en cuenta que la recaudación
--es netamente sobre venta de tickets.

select nombre, (recaudacion/tickets) as valor_promedio from peliculas

--Q) Obtener el título de la película, la recaudación en dólares y la recaudación pesos. Teniendo en
--cuenta que u$s 1 -> $ 4,39

select nombre, recaudacion, (recaudacion*4.39) as recaudacion_pesos from peliculas

--R) Obtener los datos de las películas cuyo puntaje se encuentre en el intervalo (1, 7).

select * from peliculas where puntaje between 1 and 7