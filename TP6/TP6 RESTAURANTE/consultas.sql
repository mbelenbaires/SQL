--A - Obtener el listado de ingredientes y las cantidades necesarias, que componen la receta con ID
--nro 1.

select ingredientes.ingrediente, ingr_x_receta.cantidad, unidades.unidad  from ingr_x_receta inner join ingredientes on ingr_x_receta.idingrediente = ingredientes.id
inner join unidades on ingr_x_receta.idunidad = unidades.id
where ingr_x_receta.idreceta=1

--B - Obtener el total facturado del día de ayer.

select sum(platosxpedido.importe) where datediff(day,platosxpedido.fyhentrega,getdate())<1

-- C - Obtener un ranking con las diez recetas más solicitadas por los clientes.

select top(10) recetas.receta, count(platosxpedido.idreceta) as cantidad_pedida from recetas 
inner join platosxpedido on recetas.id = platosxpedido.idreceta group by(receta) order by (count(receta)) desc 

-- D - Realizar una vista que permita visualizar para cada receta el nombre y el tiempo estimado de
--elaboración, además incorporarle el tiempo promedio de elaboración real (surge de la espera de
--cada pedido).

create view puntoD as
select recetas.receta, recetas.tiempo, 
(select avg(datediff(MINUTE,platosxpedido.fyhpedido,platosxpedido.fyhentrega)*1.0) from platosxpedido where recetas.id = platosxpedido.id)  as promedio_real 
from recetas

--E - Obtener el valor que debe cobrar el mozo con ID nro 1 durante el mes de mayo de 2012 en
--concepto de comisiones.

select sum((platosxpedido.importe)*(mozxs.comision)) from platosxpedido inner join pedidos on platosxpedido.idpedido = pedidos.id
inner join mozxs on mozxs.id=pedidos.idmozo
where pedidos.idmozo = 1 and year(platosxpedido.fyhentrega)=2012 and month(platosxpedido.fyhentrega)=05

--F - La cantidad de platos por categoría de plato.

select count(recetas.id) as cantidad, categorias.categoria from recetas inner join categorias on recetas.idcategoria = categorias.id group by categoria

--G - Obtener un listado de los cinco platos más sencillos de hacer. (tener en cuenta la dificultad de
--la preparación)

select top(5) with ties recetas.receta, dificultad from recetas order by dificultad asc




