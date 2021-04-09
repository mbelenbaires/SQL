--A) - Realizar un procedimiento almacenado que permita conocer el listado de ingredientes y sus
--respectivas cantidades y unidades de medida. Se deberá enviar el código de receta.

create procedure listado_ingr_x_receta
(@idreceta int) 
AS
BEGIN
select ingredientes.ingrediente, ingr_x_receta.cantidad, unidades.unidad from ingredientes inner join ingr_x_receta on ingredientes.id = ingr_x_receta.idingrediente
inner join unidades on unidades.id = ingr_x_receta.idunidad
where ingr_x_receta.idreceta = @idreceta
END

Exec listado_ingr_x_receta 1;

--B) - Realizar un procedimiento almacenado que permita conocer a partir de un código de
--producto los datos de los proveedores que lo venden. Ordenado de menor a mayor por tiempo
--de envío.

use tp_resto

create procedure prov_x_ingr 
(@idingrediente bigint)
AS
BEGIN

select * from proveedores inner join ingr_x_prov on ingr_x_prov.idprov = proveedores.id
inner join ingredientes on ingredientes.id = ingr_x_prov.idingrediente
where ingredientes.id = @idingrediente
order by (ingr_x_prov.espera) asc

END;

Exec prov_x_ingr 1


--C) - Realizar un procedimiento almacenado que permita ingresar un plato.

create procedure insert_plato
(
@receta varchar(50),
@idcategoria int,
@precio money,
@dificultad int,
@tiempo int
)
 AS
BEGIN
insert into recetas(receta,idcategoria,precio,dificultad,tiempo) values (@receta,@idcategoria,@precio,@dificultad,@tiempo)
END

Exec insert_plato huevo_frito, 1, 30, 1, 5



--E) - Realizar un procedimiento almacenado que permita conocer el total de horas trabajadas por
--un Chef en un mes. Se deberá ingresar el código de chef, el mes y año.

create procedure horas_x_chef
(@chef int, @mes varchar(10), @ano int)
AS
BEGIN

select sum(datediff(hour,horarioentrada,horariosalida)) as total_horas from diasxchef
where month(horarioentrada)=@mes and year(horarioentrada)=@ano and diasxchef.idchef=@chef

END


--F) - Realizar un procedimiento almacenado que actualice el tiempo promedio de elaboración de
--todos los platos, al valor calculado por el promedio de demora de los pedidos de cada plato en la
--realidad.

create procedure actualizar_tiempos
AS
BEGIN
update recetas set recetas.tiempo = (select avg (datediff(minute,fyhpedido,fyhentrega)) from platosxpedido where recetas.id = platosxpedido.idreceta)
END;




