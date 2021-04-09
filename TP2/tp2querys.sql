---QUERYS TP2---

--A) Obtener un listado de actores ordenado por apellido en forma descendente.

select * from actores order by apellido desc;

--B) Obtener un listado de actores que tengan edad entre 18 y 28 a�os.

select * from actores where datediff(year,fechanac,getdate()) between 18 and 28;

--C) Obtener un listado de actores que cumplan a�os en los meses de Enero, Febrero, Marzo,
--Octubre, Noviembre y Diciembre.

select * from actores where month(fechanac) in (01,02,03,10,11,12);

--D) Obtener un listado de actores que no sean de nacionalidad con c�digo 1, 2, 3, 6, 7 ni 8.

select * from actores where idpais not in(1,2,3,6,7,8);

--E) Obtener la �ltima pel�cula estrenada del g�nero ciencia ficci�n.

select top (1) with ties * from peliculas where idgenero = (select id from generos where genero like 'CIENCIA FICCION') order by estreno desc

--F) Obtener la pel�cula que mayor recaudaci�n haya obtenido en el a�o 2011.

select top(1) with ties * from peliculas where year(estreno) = 2011 order by recaudacion desc

--G) Obtener las 10 mejores pel�culas calificadas por los cr�ticos. Mostrar todas las pel�culas que se
-- encuentren en el 10� puesto si hay m�s de una pel�cula con igual puntaje en dicha posici�n.

select top (10) with ties * from peliculas order by puntaje desc

--H) Obtener un listado de todas las pel�culas en las que haya actuado el actor con c�digo n�mero 1.

select * from peliculas where id = (select idpeli from actoresxpelicula where actor = 1)

--I) Obtener un listado que indique c�digo de pel�cula, t�tulo y ganancia s�lo de las pel�culas que no
-- hayan generado p�rdida.

select id,nombre, (recaudacion-inversion) as ganancia from peliculas where (recaudacion-inversion)>0

--J) Obtener los datos de la pel�cula que menos duraci�n tenga.

select top(1) with ties * from peliculas order by duracion asc

--K) Obtener los datos de las pel�culas que su t�tulo comience con la cadena 'Star'.

select * from peliculas where nombre like 'Star%'

--L) Obtener los datos de las pel�culas que su t�tulo comience con la letra 'T' pero su �ltima letra no
--sea 'A', 'E', 'I', 'O' ni 'U'.

select * from peliculas where nombre like 't%[^A,E,I,O,U]'

--M) Obtener los datos de las pel�culas que su t�tulo contenga al menos un n�mero del 0 al 9.

select * from peliculas where nombre like '%[0-9]%'

--N) Obtener los datos de las pel�culas que su t�tulo contenga exactamente cinco caracteres.
--Resolverlo de dos maneras: 1) Utilizando el operador LIKE y comodines - 2) Utilizando la funci�n
--LEN.

select * from peliculas where nombre like '_____'
select * from peliculas where len(nombre)=5

--O) Obtener los datos de las pel�culas cuya recaudaci�n supere el 25% de la inversi�n.

select * from peliculas where recaudacion > inversion*0.25

--P ) Obtener el t�tulo y el valor promedio de cada ticket. Teniendo en cuenta que la recaudaci�n
--es netamente sobre venta de tickets.

select nombre, (recaudacion/tickets) as valor_promedio from peliculas

--Q) Obtener el t�tulo de la pel�cula, la recaudaci�n en d�lares y la recaudaci�n pesos. Teniendo en
--cuenta que u$s 1 -> $ 4,39

select nombre, recaudacion, (recaudacion*4.39) as recaudacion_pesos from peliculas

--R) Obtener los datos de las pel�culas cuyo puntaje se encuentre en el intervalo (1, 7).

select * from peliculas where puntaje between 1 and 7