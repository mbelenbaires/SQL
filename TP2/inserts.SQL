INSERT INTO CALIFICACIONES (NOMBRE) VALUES
('APTO PARA TODO PUBLICO'),
('APTO PARA MAYORES DE 13'),
('APTO PARA MAYORES DE 16')

GO

INSERT INTO GENEROS 
(NOMBRE) 
VALUES
('TERROR'),
('COMEDIA'),
('CIENCIA FICCION'),
('DRAMA')

GO

INSERT INTO PAISES (NOMBRE) VALUES
('ARGENTINA'),
('ESTADOS UNIDOS'),
('REINO UNIDO'),
('INDIA'),
('FRANCIA'),
('ESPAÑA')

GO

INSERT INTO ACTORES (APELLIDO, NOMBRE, FECHA_NACIMIENTO, IDPAIS)
VALUES
('DARIN', 'RICARDO', '16/01/1957', 1),
('BALE', 'CHRISTIAN', '30/01/1974', 3),
('PALTROW','GWYNETH','27/11/1972',2),
('FREEMAN', 'MORGAN', '01/06/1937', 2)

GO

INSERT INTO PELICULAS (IDPAIS, TITULO, INVERSION, RECAUDACION, TICKETS_VENDIDOS, 
IDGENERO, FECHA_ESTRENO, DURACION, IDCALIFICACION, PUNTAJE)
VALUES
(2, 'SEVEN', 10000000, 30000000, 5000000, 4, '15/01/1996', 127, 2, 8.7),
(1, 'UN CUENTO CHINO', 5000000, 4000000, 1000000, 2, '24/03/2011', 93, 1, 7.3),
(2, 'TERMINATOR', 20000000, 90000000, 6000000, 3, '03/06/2009', 115, 2, 6.7)

GO

INSERT INTO ACTORES_X_PELICULA (IDACTOR, IDPELICULA)
VALUES
(1, 2),
(3, 1),
(4, 1),
(2, 3)

--A) Obtener un listado de actores ordenado por apellido en forma descendente.

USE LAB3_TP_N2
select APELLIDO from ACTORES
order by APELLIDO DESC

--B) Obtener un listado de actores que tengan edad entre 18 y 28 años.

select A.NOMBRE, A.APELLIDO from ACTORES AS A where DATEDIFF(YEAR,0,getdate()-A.FECHA_NACIMIENTO)>=18 and DATEDIFF(YEAR,0,getdate()-A.FECHA_NACIMIENTO)<=28

--C) Obtener un listado de actores que cumplan años en los meses de Enero, Febrero, Marzo, Octubre, Noviembre y Diciembre.
select A.NOMBRE, A.APELLIDO from ACTORES AS A where MONTH(A.FECHA_NACIMIENTO) in (01,02,03,10,11,12)

--D) Obtener un listado de actores que no sean de nacionalidad con código 1, 2, 3, 6, 7 ni 8.
select A.NOMBRE, A.APELLIDO from ACTORES AS A where A.IDPAIS not in (1,2,3,6,7,8)

--E) Obtener la última película estrenada del género ciencia ficción.
  
select TOP(1) P.TITULO from PELICULAS AS P inner join GENEROS AS G
ON P.IDGENERO = G.IDGENERO where G.NOMBRE like 'Ciencia ficcion'
order by P.FECHA_ESTRENO DESC

-- F) Obtener la película que mayor recaudación haya obtenido en el año 2011.
select TOP(1) P.TITULO FROM PELICULAS AS P where YEAR(FECHA_ESTRENO)=2011
order by P.RECAUDACION DESC

--G) Obtener las 10 mejores películas calificadas por los críticos. Mostrar todas las películas que se
--encuentren en el 10° puesto si hay más de una película con igual puntaje en dicha posición.

select TOP (10) WITH TIES P.TITULO from PELICULAS AS P 
order by P.PUNTAJE DESC

--H) Obtener un listado de todas las películas en las que haya actuado el actor con código número 1.

select P.TITULO from PELICULAS AS P inner join ACTORES_X_PELICULA AS AXP
ON P.IDPELICULA = AXP.IDPELICULA where AXP.IDACTOR=1

 
--I) Obtener un listado que indique código de película, título y ganancia sólo de las películas que no hayan generado pérdida.

select P.IDPELICULA, P.TITULO, (-P.INVERSION + P.RECAUDACION) AS GANANACIA FROM PELICULAS AS P where P.RECAUDACION >= P.INVERSION 

-- J) Obtener los datos de la película que menos duración tenga.

select top(1) * from PELICULAS AS P 
order by P.DURACION ASC

--K) Obtener los datos de las películas que su título comience con la cadena 'Star'.

SELECT * FROM PELICULAS AS P WHERE P.TITULO like 'Star%'

-- L) Obtener los datos de las películas que su título comience con la letra 'T' pero su última letra no sea 'A', 'E', 'I', 'O' ni 'U'.

SELECT * FROM PELICULAS AS P WHERE P.TITULO like 'T%' AND P.TITULO not like '%[AEIOU]'

--M) Obtener los datos de las películas que su título contenga al menos un número del 0 al 9.

SELECT * FROM PELICULAS AS P WHERE P.TITULO like '[0-9]'

--N) Obtener los datos de las películas que su título contenga exactamente cinco caracteres.
--Resolverlo de dos maneras: 1) Utilizando el operador LIKE y comodines - 2) Utilizando la función LEN.

select * from PELICULAS AS P where P.TITULO like '_____'

select * from PELICULAS AS P where len(P.TITULO) = 5

--O) Obtener los datos de las películas cuya recaudación supere el 25% de la inversión.

select * from PELICULAS AS P where P.RECAUDACION > P.INVERSION*0.25

--P ) Obtener el título y el valor promedio de cada ticket. Teniendo en cuenta que la recaudación es netamente sobre venta de tickets.

select P.TITULO, AVG(P.RECAUDACION / P.TICKETS_VENDIDOS) from PELICULAS AS P
group by P.TITULO

--Q) Obtener el título de la película, la recaudación en dólares y la recaudación pesos. Teniendo en cuenta que u$s 1 -> $ 4,39

select P.TITULO, P.RECAUDACION, P.RECAUDACION/4.39 AS RECAUDACION_DOLARES from PELICULAS AS P

--R) Obtener los datos de las películas cuyo puntaje se encuentre en el intervalo (1, 7).

SELECT * FROM PELICULAS AS P where P.PUNTAJE between 1 and 7





