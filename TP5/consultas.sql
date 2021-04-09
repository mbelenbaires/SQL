--A) Hacer un listado que permita conocer el total recaudado agrupado por a�o. Se deber� mostrar
--a�o y total recaudado.

select year(p.estreno) as anio, sum(recaudacion) from peliculas p group by year(p.estreno)

--B) Obtener el promedio de duraci�n en minutos entre todas las pel�culas.

select avg(duracion) as Promedio_duracion from peliculas

--C) Obtener el promedio de duraci�n en minutos entre todas las pel�culas que se hayan estrenado
--desde el a�o 2000 en adelante.

select avg(duracion) as Promedio from peliculas where year(estreno)>1999

--D) Obtener el total recaudado agrupado por pa�s. Se deber� mostrar el nombre del pa�s y el total
--recaudado.

select sum(recaudacion) as Recaudado, paises.nombre as Pais from peliculas p inner join paises on p.idpais=paises.id group by paises.nombre

--E) Obtener la puntuaci�n m�nima entre todas las pel�culas.

select min(puntaje) as Puntaje_minimo from peliculas 

--F) Obtener la cantidad de actores y actrices agrupados por nacionalidad. Se deber� mostrar el
--nombre del pa�s y la cantidad de actores.

select count(a.codigo) as cantidad_Actores, paises.nombre from actores a inner join paises on a.idpais = paises.id group by paises.nombre

--G) Obtener el promedio de tickets vendidos de las pel�culas estrenadas en el primer semestre y
--en el segundo semestre. Se deber� obtener dos filas, la primera obteniendo el promedio de
--tickets vendidos para el primer semestre y la segunda fila para el segundo. S�lo debe de tenerse
--en cuenta los meses. Los d�as y a�os ser�n indiferentes.

select 'Primer_sem', avg(tickets) from peliculas p where month(estreno) between 01 and 06
union
select 'Segundo_sem', avg(tickets) from peliculas p where month(estreno) between 07 and 12

--H) Obtener la cantidad de pel�culas realizadas por pa�s. Si alg�n pa�s no tiene relacionada ninguna
--pel�cula, este deber� contabilizar cero. Se deber� mostrar nombre del pa�s y cantidad de
--pel�culas.

select count(p.id) as Cant_Pelis, paises.nombre from peliculas p full join paises on p.idpais=paises.id group by paises.nombre

--I) Obtener el promedio de puntajes de pel�culas agrupado por pa�s. Incorporar al listado s�lo
--aquellos pa�ses que superen el valor promedio de 7,5. Se deber� mostrar nombre del pa�s y
--promedio de puntaje.

select paises.nombre as Pais, avg(p.puntaje) as Puntaje_prom from peliculas p inner join paises on p.idpais=paises.id 
group by paises.nombre
having avg(p.puntaje)>7.5 

--J) Obtener la fecha de nacimiento m�s cercana a la actual.

select max(fechanac) as Mas_Cercana from actores

--K) Obtener la cantidad de pa�ses en los que se haya realizado alguna pel�cula.

select count(distinct p.idpais) as Cant_paises from peliculas p

