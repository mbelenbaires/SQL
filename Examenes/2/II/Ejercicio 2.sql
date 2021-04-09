use modelo_parcial2
go
create trigger verificar_importes on creditos
instead of insert
as
begin

	declare @idbanco int
	select @idbanco = idbanco from inserted
	declare @fecha date
	select @fecha = fecha from inserted
	declare @importe money
	select @importe = importe from inserted
	declare @plazo int
	select @plazo = plazo from inserted
	declare @cancelado money
	select @cancelado = cancelado from inserted
	declare @dni int
	select @dni = dni from inserted

		if @importe+(select sum(cr.IMPORTE) from creditos cr where cr.DNI=@dni and cr.CANCELADO=0) <= 3*(select p.DECLARACION_GANANCIAS from personas p where p.dni=@dni)
			begin
				insert into CREDITOS(IDBANCO,dni,fecha,importe,plazo,CANCELADO)
				values
				(@idbanco,@dni,@fecha,@importe,@plazo,@cancelado)
			end
		else
			begin
				raiserror('El importe del credito sumado a los demas no debe superar el triple de la declaracion de ganancias',16,1)
			end
end

drop trigger verificar_importes



--2 - Hacer un trigger que al eliminar un crédito realice la cancelación del mismo.

create trigger cancelar_credito on creditos
instead of delete
as
begin
	declare @idcredito bigint
	select @idcredito = idcredito from deleted

	update creditos set creditos.CANCELADO=1 where IDCREDITO=@idcredito

end




--3 - Hacer un trigger que no permita otorgar créditos con un plazo de 20 o más años a personas
--cuya declaración de ganancias sea menor al promedio de declaración de ganancias.

create trigger verificar_ganancias on creditos
instead of insert
as
begin
	declare @plazo int
	select @plazo = plazo from inserted
	declare @idbanco int
	select @idbanco = idbanco from inserted
	declare @fecha date
	select @fecha = fecha from inserted
	declare @importe money
	select @importe = importe from inserted
	declare @cancelado money
	select @cancelado = cancelado from inserted
	declare @dni int
	select @dni = dni from inserted

	if @plazo >=20
		begin
			if (select p.DECLARACION_GANANCIAS from personas p where p.DNI=@dni) < (select avg(p.DECLARACION_GANANCIAS) from personas p)
				begin
					raiserror('No es posible entregar el crédito.',16,1)
				end

			else
				begin
					insert into CREDITOS(IDBANCO,dni,fecha,importe,plazo,CANCELADO)
					values
					(@idbanco,@dni,@fecha,@importe,@plazo,@cancelado)
				end
		end
	else
		begin
			insert into CREDITOS(IDBANCO,dni,fecha,importe,plazo,CANCELADO)
			values
			(@idbanco,@dni,@fecha,@importe,@plazo,@cancelado)
		end

end


--4 - Hacer un procedimiento almacenado que reciba dos fechas y liste todos los créditos otorgados
--entre esas fechas. Debe listar el apellido y nombre del solicitante, el nombre del banco, el tipo de
--banco, la fecha del crédito y el importe solicitado.

create procedure listar_creditos_entre 
(
@fechainicio date,
@fechafin date
)
as
begin

	select cr.FECHA, cr.IMPORTE, p.NOMBRES, p.APELLIDO, b.NOMBRE, b.TIPO from creditos cr 
	inner join personas p
	on cr.dni = p.DNI
	inner join bancos b
	on b.IDBANCO = cr.IDBANCO	
	where cr.FECHA between @fechainicio and @fechafin

end
