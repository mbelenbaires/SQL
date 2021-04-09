--A) Obtener un listado de actores que muestre el Apellido y nombre separados 
-- por una coma en la misma columna, edad y nombre del país donde nació.

select actores.nombre+', '+actores.apellido as Actxr, datediff(year,fechanac,getdate()) as Edad, paises.nombre from actores inner join paises on idpais = id

--B) Obtener para cada actor su nombre y apellido y los nombres de las películas en las que actuó.
select actores.nombre, actores. apellido, peliculas.nombre from actores inner join actoresxpelicula on actores.codigo = actoresxpelicula.actor inner join peliculas on peliculas.id = actoresxpelicula.idpeli

--C) Obtener para cada película su título y el nombre y apellido de los actores que participaron en ella.

select peliculas.nombre, actores.apellido, actores.nombre from peliculas inner join actoresxpelicula on peliculas.id = actoresxpelicula.idpeli inner join actores on actores.codigo = actoresxpelicula.actor

-- D) Obtener para cada película su código, título, nombre de país de realización, saldo (ganancia o pérdida), nombre de género, nombre de calificación y puntaje.

select p.id, p.nombre, paises.nombre as pais, recaudacion-inversion as saldo, genero, puntaje, calificacion from peliculas p inner join paises on paises.id = p.idpais inner join generos on p.idgenero = generos.id inner join calificaciones on p.idcalificacion = calificaciones.id

--E) Obtener los países en los que se haya realizado alguna película (no tener en cuenta aquellos países en los que no se realizó alguna película).

select distinct p.nombre from paises p inner join peliculas on p.id = peliculas.idpais 

-- F) Obtener el título de las películas y el país de realización. Incluir los países que no tienen alguna
-- película asociada completando con NULL el campo reservado para el título de película.

select p.nombre as pelicula, paises.nombre as pais from peliculas p full join paises on p.idpais = paises.id 

--G) Obtener para cada actor su nombre y apellido y además el/los géneros de película en que haya
-- participado. Si ocurriese que un mismo actor haya participado en más de una película del mismo
-- género, esta combinación debe aparecer sólo una vez.

select distinct a.nombre, a.apellido, genero from actores a inner join actoresxpelicula axc on a.codigo = axc.actor inner join peliculas 
on peliculas.id = axc.idpeli inner join generos on peliculas.idgenero = generos.id

--H) Obtener un listado que contenga Apellido y nombre, fecha de nacimiento, título de película,
--fecha de estreno y la edad que tenía el actor al momento del estreno de la película.

select a.apellido, a.nombre, a.fechanac, peliculas.nombre, peliculas.estreno, datediff(year,fechanac,peliculas.estreno) as edad from actores a inner join actoresxpelicula
on actoresxpelicula.actor = a.codigo inner join peliculas on actoresxpelicula.idpeli = peliculas.id