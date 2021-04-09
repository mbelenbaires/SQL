USE PARCIAL2_EJ2
GO
/* A) Realizar un trigger que no permita ingresar una encomienda que: este relacionada a un viaje que ya se realizó ó que sobrecargue el peso máximo del camión que realiza el viaje, teniendo en cuenta el peso del paquete a ingresar con respecto a la sumatoria de pesos de los paquetes que actualmente transportará dicho camión en dicho viaje. El importe de la encomienda surge del cálculo PESO_PAQUETE * $5 */
CREATE TRIGGER tr_AGREGARENCOMIENDA ON ENCOMIENDAS
INSTEAD OF INSERT
AS
BEGIN
  --VALIDAR LA FECHA DEL VIAJE
  IF (SELECT FECHAHORA FROM VIAJES WHERE IDVIAJE = (SELECT IDVIAJE FROM INSERTED)) < (SELECT GETDATE()) BEGIN
    PRINT 'VIAJE YA REALIZADO'
    RETURN;
  END
  --VALIDAR EL PESO DEL CAMIÓN
  DECLARE @PESO_MAXIMO INT
  DECLARE @PESO_ACUMULADO INT
  DECLARE @PESO_ENCOMIENDA INT
  
  SELECT @PESO_MAXIMO = PESO_MAXIMO FROM CAMIONES INNER JOIN VIAJES ON VIAJES.IDCAMION = CAMIONES.IDCAMION WHERE IDVIAJE = (SELECT IDVIAJE FROM INSERTED)
  SELECT @PESO_ACUMULADO = SUM(PESO) FROM ENCOMIENDAS WHERE IDVIAJE = (SELECT IDVIAJE FROM INSERTED)
  SELECT @PESO_ENCOMIENDA = PESO FROM INSERTED
  
  IF (@PESO_ACUMULADO + @PESO_ENCOMIENDA) > @PESO_MAXIMO BEGIN
    PRINT 'PAQUETE MUY PESADO PARA TRANSPORTAR.'
    RETURN;
  END
  
  INSERT INTO ENCOMIENDAS (IDPAQUETE, IDVIAJE, PESO, COSTO)
  SELECT IDPAQUETE, IDVIAJE, PESO, PESO*5 FROM INSERTED
  
END

/* B) Realizar una vista que informe las ciudades que no hayan recibido ningún paquete */
CREATE VIEW vwCIUDADES_SIN_PAQUETES
AS
SELECT CI.CIUDAD FROM CIUDADES CI
LEFT JOIN VIAJES V ON V.IDCIUDAD = CI.IDCIUDAD
LEFT JOIN ENCOMIENDAS E ON E.IDVIAJE = V.IDVIAJE
GROUP BY CI.CIUDAD
HAVING COUNT(E.IDVIAJE) = 0

/* C) Realizar un procedimiento almacenado que permita a partir de los parámetros de IDCiudad y un rango de fechas, obtener un listado de viajes que podrían llevar dicha encomienda. Se deberá asegurar que el viaje se diriga a la ciudad de destino, la fecha del viaje sea futura y que se encuentre dentro de los paráemtros deseados. El listado deberá contener: IDViaje, Nombre de ciudad, Código de camión y cantidad de peso disponible para transportar por el camión. El mismo deberá aparecer ordenado del más próximo al último */

CREATE PROCEDURE spCONSULTAR_VIAJES(
  @IDCIUDAD BIGINT,
  @FECHAINICIO DATETIME,
  @FECHAFIN DATETIME
)
AS
BEGIN
  SELECT V.IDVIAJE, C.CIUDAD, V.IDCAMION, CA.PESO_MAXIMO - (SELECT SUM(EN.PESO) FROM ENCOMIENDAS EN WHERE EN.IDVIAJE = V.IDVIAJE) AS DISPONIBLE
  FROM VIAJES V
  INNER JOIN CIUDADES C ON C.IDCIUDAD = V.IDCIUDAD
  INNER JOIN CAMIONES CA ON CA.IDCAMION = V.IDCAMION
  WHERE C.IDCIUDAD = @IDCIUDAD AND V.FECHAHORA > GETDATE() AND V.FECHAHORA BETWEEN @FECHAINICIO AND @FECHAFIN
  ORDER BY V.FECHAHORA ASC
END

/* D) Realizar un procedimiento almacenado que a partir de un código de camión y una fecha determinada permita saber si el camión se encuentra disponible para realizar viajes. El procedimiento debe listar 'EL CAMIÓN SE ENCUENTRA DISPONIBLE' ó 'EL CAMIÓN NO SE ENCUENTRA DISPONIBLE'*/
CREATE PROCEDURE spCONSULTAS_CAMION(
  @IDCAMION VARCHAR(6),
  @FECHA DATETIME
)
AS
BEGIN
  IF (SELECT COUNT(*) FROM VIAJES WHERE IDCAMION = @IDCAMION AND FECHAHORA = @FECHA) = 0 BEGIN
    PRINT 'EL CAMIÓN SE ENCUENTRA DISPONIBLE'
  END
  ELSE BEGIN
    PRINT 'EL CAMIÓN NO SE ENCUENTRA DISPONIBLE'
  END
END
