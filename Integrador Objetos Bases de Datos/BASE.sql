create database BANCO
go
USE [BANCO]
GO
CREATE TABLE [dbo].[CLIENTES](
	[IDCLIENTE] [bigint] NOT NULL PRIMARY KEY,
	[APELLIDO] [varchar](50) NOT NULL,
	[NOMBRE] [varchar](50) NOT NULL,
	[ESTADO] [bit] NOT NULL
)
GO
INSERT [dbo].[CLIENTES] ([IDCLIENTE], [APELLIDO], [NOMBRE], [ESTADO]) VALUES (1, N'SEINFELD', N'JERRY', 1)
INSERT [dbo].[CLIENTES] ([IDCLIENTE], [APELLIDO], [NOMBRE], [ESTADO]) VALUES (2, N'COSTANZA', N'GEORGE', 1)
INSERT [dbo].[CLIENTES] ([IDCLIENTE], [APELLIDO], [NOMBRE], [ESTADO]) VALUES (3, N'BENES', N'ELAINE', 1)
INSERT [dbo].[CLIENTES] ([IDCLIENTE], [APELLIDO], [NOMBRE], [ESTADO]) VALUES (4, N'KRAMER', N'COSMO', 1)
GO
CREATE TABLE [dbo].[CUENTAS](
	[IDCUENTA] [bigint] NOT NULL identity(1, 1) primary key,
	[IDCLIENTE] [bigint] NOT NULL,
	[TIPO] [varchar](2) NOT NULL,
	[LIMITE] [money] NOT NULL,
	[SALDO] [money] NOT NULL,
	[ESTADO] [bit] NOT NULL
)
GO
SET IDENTITY_INSERT [dbo].[CUENTAS] ON
INSERT [dbo].[CUENTAS] ([IDCUENTA], [IDCLIENTE], [TIPO], [LIMITE], [SALDO], [ESTADO]) VALUES (1, 1, N'CA', 0.0000, 1000.0000, 1)
INSERT [dbo].[CUENTAS] ([IDCUENTA], [IDCLIENTE], [TIPO], [LIMITE], [SALDO], [ESTADO]) VALUES (2, 2, N'CC', -5000.0000, 0.0000, 1)
INSERT [dbo].[CUENTAS] ([IDCUENTA], [IDCLIENTE], [TIPO], [LIMITE], [SALDO], [ESTADO]) VALUES (3, 3, N'CA', 0.0000, 0.0000, 1)
INSERT [dbo].[CUENTAS] ([IDCUENTA], [IDCLIENTE], [TIPO], [LIMITE], [SALDO], [ESTADO]) VALUES (4, 4, N'CC', -1000.0000, 0.0000, 1)
SET IDENTITY_INSERT [dbo].[CUENTAS] OFF
GO
CREATE TABLE [dbo].[TRANSFERENCIAS](
	[IDTRANSFERENCIA] [bigint] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[ORIGEN] [bigint] NOT NULL,
	[DESTINO] [bigint] NOT NULL,
	[IMPORTE] [money] NOT NULL,
	[FECHA] [smalldatetime] NOT NULL,
	[ESTADO] [bit] NOT NULL
)
GO
CREATE TABLE [dbo].[TARJETAS](
	[IDTARJETA] [bigint] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[IDCUENTA] [bigint] NOT NULL,
	[TIPO] [char](1) NOT NULL,
	[ESTADO] [bit] NOT NULL
)
GO
CREATE TABLE [dbo].[MOVIMIENTOS](
	[IDMOVIMIENTO] [bigint] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[IDCUENTA] [bigint] NOT NULL,
	[IMPORTE] [money] NOT NULL,
	[TIPO] [char](1) NOT NULL,
	[FECHA] [smalldatetime] NOT NULL,
	[ESTADO] [bit] NOT NULL
) 
GO
ALTER TABLE [dbo].[MOVIMIENTOS] ADD  DEFAULT ((1)) FOR [ESTADO]
GO
ALTER TABLE [dbo].[TRANSFERENCIAS] ADD  DEFAULT ((1)) FOR [ESTADO]
GO
ALTER TABLE [dbo].[CUENTAS]  WITH CHECK ADD  CONSTRAINT [CHK_SALDO] CHECK  (([SALDO]>=[LIMITE]))
GO
ALTER TABLE [dbo].[CUENTAS] CHECK CONSTRAINT [CHK_SALDO]
GO
ALTER TABLE [dbo].[MOVIMIENTOS]  WITH CHECK ADD CHECK  (([IMPORTE]>(0)))
GO
ALTER TABLE [dbo].[MOVIMIENTOS]  WITH CHECK ADD CHECK  (([TIPO]='C' OR [TIPO]='D'))
GO
ALTER TABLE [dbo].[TARJETAS]  WITH CHECK ADD CHECK  (([TIPO]='C' OR [TIPO]='D'))
GO
ALTER TABLE [dbo].[TRANSFERENCIAS]  WITH CHECK ADD CHECK  (([IMPORTE]>(0)))
GO
ALTER TABLE [dbo].[CUENTAS]  WITH CHECK ADD FOREIGN KEY([IDCLIENTE])
REFERENCES [dbo].[CLIENTES] ([IDCLIENTE])
GO
ALTER TABLE [dbo].[MOVIMIENTOS]  WITH CHECK ADD FOREIGN KEY([IDCUENTA])
REFERENCES [dbo].[CUENTAS] ([IDCUENTA])
GO
ALTER TABLE [dbo].[TARJETAS]  WITH CHECK ADD FOREIGN KEY([IDCUENTA])
REFERENCES [dbo].[CUENTAS] ([IDCUENTA])
GO
ALTER TABLE [dbo].[TRANSFERENCIAS]  WITH CHECK ADD FOREIGN KEY([DESTINO])
REFERENCES [dbo].[CUENTAS] ([IDCUENTA])
GO
ALTER TABLE [dbo].[TRANSFERENCIAS]  WITH CHECK ADD FOREIGN KEY([ORIGEN])
REFERENCES [dbo].[CUENTAS] ([IDCUENTA])