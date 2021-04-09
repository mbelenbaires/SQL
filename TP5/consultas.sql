--A) Hacer un listado que permita conocer el total recaudado agrupado por año. Se deberá mostrar
--año y total recaudado.

select year(p.estreno) as anio, sum(recaudacion) from peliculas p group by year(p.estreno)

--B) Obtener el promedio de duración en minutos entre todas las películas.

select avg(duracion) as Promedio_duracion from peliculas

--C) Obtener el promedio de duración en minutos entre todas las películas que se hayan estrenado
--desde el año 2000 en adelante.

select avg(duracion) as Promedio from peliculas where year(estreno)>1999

--D) Obtener el total recaudado agrupado por país. Se deberá mostrar el nombre del país y el total
--recaudado.

select sum(recaudacion) as Recaudado, paises.nombre as Pais from peliculas p inner join paises on p.idpais=paises.id group by paises.nombre

--E) Obtener la puntuación mínima entre todas las películas.

select min(puntaje) as Puntaje_minimo from peliculas 

--F) Obtener la cantidad de actores y actrices agrupados por nacionalidad. Se deberá mostrar el
--nombre del país y la cantidad de actores.

select count(a.codigo) as cantidad_Actores, paises.nombre from actores a inner join paises on a.idpais = paises.id group by paises.nombre

--G) Obtener el promedio de tickets vendidos de las películas estrenadas en el primer semestre y
--en el segundo semestre. Se deberá obtener dos filas, la primera obteniendo el promedio de
--tickets vendidos para el primer semestre y la segunda fila para el segundo. Sólo debe de tenerse
--en cuenta los meses. Los días y años serán indiferentes.

select 'Primer_sem', avg(tickets) from peliculas p where month(estreno) between 01 and 06
union
select 'Segundo_sem', avg(tickets) from peliculas p where month(estreno) between 07 and 12

--H) Obtener la cantidad de películas realizadas por país. Si algún país no tiene relacionada ninguna
--película, este deberá contabilizar cero. Se deberá mostrar nombre del país y cantidad de
--películas.

select count(p.id) as Cant_Pelis, paises.nombre from peliculas p full join paises on p.idpais=paises.id group by paises.nombre

--I) Obtener el promedio de puntajes de películas agrupado por país. Incorporar al listado sólo
--aquellos países que superen el valor promedio de 7,5. Se deberá mostrar nombre del país y
--promedio de puntaje.

select paises.nombre as Pais, avg(p.puntaje) as Puntaje_prom from peliculas p inner join paises on p.idpais=paises.id 
group by paises.nombre
having avg(p.puntaje)>7.5 

--J) Obtener la fecha de nacimiento más cercana a la actual.

select max(fechanac) as Mas_Cercana from actores

--K) Obtener la cantidad de países en los que se haya realizado alguna película.

select count(distinct p.idpais) as Cant_paises from peliculas p

