--A) Obtener un listado de actores que muestre el Apellido y nombre separados 
-- por una coma en la misma columna, edad y nombre del pa�s donde naci�.

select actores.nombre+', '+actores.apellido as Actxr, datediff(year,fechanac,getdate()) as Edad, paises.nombre from actores inner join paises on idpais = id

--B) Obtener para cada actor su nombre y apellido y los nombres de las pel�culas en las que actu�.
select actores.nombre, actores. apellido, peliculas.nombre from actores inner join actoresxpelicula on actores.codigo = actoresxpelicula.actor inner join peliculas on peliculas.id = actoresxpelicula.idpeli

--C) Obtener para cada pel�cula su t�tulo y el nombre y apellido de los actores que participaron en ella.

select peliculas.nombre, actores.apellido, actores.nombre from peliculas inner join actoresxpelicula on peliculas.id = actoresxpelicula.idpeli inner join actores on actores.codigo = actoresxpelicula.actor

-- D) Obtener para cada pel�cula su c�digo, t�tulo, nombre de pa�s de realizaci�n, saldo (ganancia o p�rdida), nombre de g�nero, nombre de calificaci�n y puntaje.

select p.id, p.nombre, paises.nombre as pais, recaudacion-inversion as saldo, genero, puntaje, calificacion from peliculas p inner join paises on paises.id = p.idpais inner join generos on p.idgenero = generos.id inner join calificaciones on p.idcalificacion = calificaciones.id

--E) Obtener los pa�ses en los que se haya realizado alguna pel�cula (no tener en cuenta aquellos pa�ses en los que no se realiz� alguna pel�cula).

select distinct p.nombre from paises p inner join peliculas on p.id = peliculas.idpais 

-- F) Obtener el t�tulo de las pel�culas y el pa�s de realizaci�n. Incluir los pa�ses que no tienen alguna
-- pel�cula asociada completando con NULL el campo reservado para el t�tulo de pel�cula.

select p.nombre as pelicula, paises.nombre as pais from peliculas p full join paises on p.idpais = paises.id 

--G) Obtener para cada actor su nombre y apellido y adem�s el/los g�neros de pel�cula en que haya
-- participado. Si ocurriese que un mismo actor haya participado en m�s de una pel�cula del mismo
-- g�nero, esta combinaci�n debe aparecer s�lo una vez.

select distinct a.nombre, a.apellido, genero from actores a inner join actoresxpelicula axc on a.codigo = axc.actor inner join peliculas 
on peliculas.id = axc.idpeli inner join generos on peliculas.idgenero = generos.id

--H) Obtener un listado que contenga Apellido y nombre, fecha de nacimiento, t�tulo de pel�cula,
--fecha de estreno y la edad que ten�a el actor al momento del estreno de la pel�cula.

select a.apellido, a.nombre, a.fechanac, peliculas.nombre, peliculas.estreno, datediff(year,fechanac,peliculas.estreno) as edad from actores a inner join actoresxpelicula
on actoresxpelicula.actor = a.codigo inner join peliculas on actoresxpelicula.idpeli = peliculas.id