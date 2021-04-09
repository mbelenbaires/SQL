--A) Modificar la duración de la película de nombre 'SEVEN' a 130 minutos.

update peliculas set duracion = 130 where nombre like 'seven'

--B) Modificar la duración de todas las películas agregándole 10 minutos extra.

update peliculas set duracion = duracion + 10

--C) Modificar la recaudación a $ 0 a todas las películas que se hayan estrenado entre el 1/1/1990 y
-- el 1/1/2000.

update peliculas set recaudacion = 0 where year(estreno)=2000 and month(estreno)=01 and day(estreno)=01

--D) Modificar el apellido a 'Kloster' de todos los actores cuyos nombres terminen en 'AN'.

update actores set apellido = 'Kloster' where nombre like '%AN'

--E) Modificar las calificaciones de:
--'APTO PARA TODO PUBLICO' -> 'ATP'
--'APTO PARA MAYORES DE 13' -> 'PG-13'
--'APTO PARA MAYORES DE 16' -> 'PG-16'

update calificaciones set calificacion = 'ATP' where calificacion like '%publico%'
update calificaciones set calificacion = 'PG-13' where calificacion like '%13%'
update calificaciones set calificacion = 'PG-16' where calificacion like '%16%'

--A) Eliminar los países cuyo nombres sean 'India', 'Francia' o 'España'

delete from paises where nombre like 'india' or nombre like 'francia' or nombre like 'españa' 

--B) Eliminar el género con código 1

delete from generos where id=1

--C) Eliminar el país 'Reino Unido'. ¿Por qué no se pudo eliminar el registro?

delete generos
delete paises
delete actores
delete actoresxpelicula
delete peliculas