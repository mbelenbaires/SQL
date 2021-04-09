use BANCO
go
/*1 - Elaborar una vista que permita conocer para cada cliente: el apellido y nombres, los números de
cuenta, el saldo de la cuenta, la cantidad de movimientos realizados por cada cuenta y el saldo
acumulado entre todas las cuentas de cada cliente.*/

create view punto1 AS
select cl.APELLIDO+', '+cl.NOMBRE as APELLIDO_Y_NOMBRE, c.IDCUENTA as IdCuenta, c.SALDO, c.TIPO,
(select count(m.IDMOVIMIENTO) from movimientos m where m.IDCUENTA = IDCUENTA) as MOVIMIENTOS,
(select sum(c.SALDO) from cuentas c where c.IDCLIENTE=cl.IDCLIENTE) as SALDO_TOTAL
from CLIENTES cl
inner join CUENTAS c
on cl.IDCLIENTE=c.IDCLIENTE

/*2*/

create procedure alta_cuenta
(@IDCliente bigint, @Tipo char(2), @Limite money)
AS
BEGIN --1

	BEGIN TRY --2
	if @Tipo = 'CA' or @Tipo = 'CC'
		BEGIN --pasa el check de tipo   3
		if @Tipo='CA'
			BEGIN --pasa el check CA    4
			if @Limite=0
				BEGIN --pasa el check lim 0
				insert into CUENTAS(IDCLIENTE, TIPO, LIMITE, ESTADO, SALDO) values (@IDCliente, @Tipo, @Limite, 1, 0) 
				END --5
			ELSE --falla el check lim 0
				BEGIN --6
				RAISERROR ('EL LIMITE DEBE SER 0 PARA UNA C.A.', 16, 1)
				END --6
			END --termina check CA
		if @Tipo='CC'
			BEGIN --pasa el check CC
				if @Limite >=0 
					BEGIN --pasa el check lim
					insert into CUENTAS(IDCLIENTE, TIPO, LIMITE, ESTADO, SALDO) values (@IDCliente, @Tipo, @Limite, 1, 0) 
					END --8
				ELSE
					BEGIN --falla el check lim
					RAISERROR ('EL LIMITE DEBE SER MAYOR O IGUAL A 0 PARA UNA C.C.', 16, 1)
					END --9
			END --termina check CC
		END --termina el check de tipo
	ELSE
		BEGIN --falla el check de tipo
		RAISERROR('LOS TIPOS PERMITIDOS SON CA Y CC', 16, 1)
		END
	END TRY

	BEGIN CATCH
		PRINT ERROR_MESSAGE()
	END CATCH
END


/*3 - Realizar un trigger que al registrar una nueva cuenta le sea otorgada una tarjeta 
de débito. La misma se identifica con un valor 'D' en el Tipo de la tarjeta.*/

create trigger alta_debito on CUENTAS
AFTER INSERT 
AS
BEGIN
	DECLARE @IDCUENTA BIGINT
	SELECT @IDCUENTA = idcuenta from inserted
	insert into TARJETAS(IDCUENTA,ESTADO,TIPO)
	values (@IDCUENTA,1,'D')
END

insert into CUENTAS(IDCLIENTE,TIPO,limite,ESTADO,SALDO)
values (1,'CA',0,1,0)

--4 - Realizar un trigger que al registrar un nuevo usuario le sea otorgada 
--una Caja de Ahorro nueva.

create trigger alta_CA on CLIENTES
after insert
as
begin
	declare @idcliente bigint
	select @idcliente = idcliente from inserted
	insert into CUENTAS(IDCLIENTE,TIPO,LIMITE,ESTADO,SALDO)
	values
	(@idcliente,'CA',0,1,0)
end

insert into CLIENTES(IDCLIENTE,APELLIDO,NOMBRE,ESTADO)
values
(666,'baires','bbita','1')

--5 - Realizar un trigger que al eliminar un usuario realice la baja lógica del mismo. Si 
--se elimina un usuario que ya se encuentra dado de baja lógica y dicho usuario no registra ni
--cuentas ni tarjetas, proceder a la baja física del usuario.

create trigger baja_usuario on clientes
instead of delete
as
begin
	declare @idcliente bigint
	select @idcliente =  idcliente from deleted
	declare @estado bit
	select @estado = estado from deleted where idcliente = @idcliente
		if @estado =0
			begin
				declare @cuentas int
				declare @tarjetas int
				declare @ncuenta int

				select @cuentas = count(cuentas.IDCUENTA) from cuentas where cuentas.IDCLIENTE = @idcliente and cuentas.ESTADO=1
				select @ncuenta = cuentas.IDCUENTA from cuentas where CUENTAS.IDCLIENTE = @idcliente
				select @tarjetas = count(tarjetas.IDTARJETA) from TARJETAS where tarjetas.ESTADO = 1 and TARJETAS.IDCUENTA = @ncuenta

				if @cuentas = 0 and @tarjetas = 0
				begin
				delete from TARJETAS where TARJETAS.IDCUENTA = @ncuenta
				delete from CUENTAS where CUENTAS.IDCLIENTE = @idcliente
				delete from CLIENTES where clientes.IDCLIENTE = @idcliente
				end
			end
		else
		begin
		declare @ncuent int
		select @ncuent = cuentas.IDCUENTA from cuentas where CUENTAS.IDCLIENTE = @idcliente
		update clientes set estado=0 where idcliente in (select idcliente from deleted)
		update tarjetas set estado=0 where IDCUENTA = @cuentas
		update cuentas set estado=0 where IDCLIENTE in (select idcliente from deleted)
		end
end

--6 - Realizar un trigger que al registrar un nuevo movimiento, actualice el saldo de la cuenta. Deberá
--acreditar o debitar dinero en la cuenta dependiendo del tipo de movimiento ('D' - Débito y 'C' - Crédito). Se
--deberá: - Registrar el movimiento
-- Actualizar el saldo de la cuenta

create trigger actualizar_saldo on movimientos
after insert
as
begin
	
	declare @tipo char(1)
	select @tipo = tipo from inserted	
	declare @idcuenta bigint
	select @idcuenta = idcuenta from inserted
	declare @importe money
	select @importe = importe from inserted
		
		if @tipo = 'D'
			begin
				update CUENTAS set cuentas.SALDO = cuentas.SALDO+@importe where cuentas.IDCUENTA = @idcuenta
			end

		else if @tipo = 'C'
			begin
				update CUENTAS set cuentas.SALDO = cuentas.SALDO-@importe where cuentas.IDCUENTA = @idcuenta
			end
end


insert into MOVIMIENTOS(IDCUENTA,FECHA,ESTADO,IMPORTE,TIPO)
values
(13,getdate(),1,666,'D')


--7 - Realizar un trigger que al registrar una nueva transferencia, registre los movimientos y actualice los
--saldos de las cuenta. Deberá verificar que las cuentas de origen y destino sean distintas. Se deberá:
-- Registrar la transferencia
-- Registrar el movimiento de la cuenta de origen
-- Registrar el movimiento de la cuenta de destino

create trigger registrar_mov_actualizar_saldos on transferencias
after insert
as
begin
	declare @origen bigint
	declare @destino bigint
	declare @importe money
	select @origen = origen from inserted
	select @destino = destino from inserted
	select @importe = importe from inserted

		if @origen <> @destino
			begin
				insert into MOVIMIENTOS(FECHA,IDCUENTA,IMPORTE,TIPO,ESTADO)
				values
				(getdate(),@destino,@importe,'D',1),(getdate(),@origen,@importe,'C',1)
				
				insert into MOVIMIENTOS(FECHA,IDCUENTA,IMPORTE,TIPO,ESTADO)
				values
				(getdate(),@origen,@importe,'C',1)
			end
		else
			begin
				raiserror('Las cuentas de origen y destino son la misma',16,1)
			end
end



insert into transferencias(origen,DESTINO,FECHA,ESTADO,IMPORTE)
values
(13,3,getdate(),1,420)
