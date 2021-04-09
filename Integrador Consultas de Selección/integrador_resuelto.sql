USE TP_INTEGRADOR_PARTE1
go
--A) Listar todos los m�dicos de sexo femenino.
select * from MEDICOS where SEXO like 'f'

-- B) Listar todos los m�dicos cuyo apellido finaliza con 'EZ'
select * from medicos where apellido like '%ez'

--C) Listar todos los m�dicos que hayan ingresado a la cl�nica entre el 1/1/1995 y el 31/12/1999.
select * from medicos where FECHAINGRESO between '01/01/1995' and '31/12/1999'

--D) Listar todos los m�dicos que tengan un costo de consulta mayor a $ 650.
select * from medicos where costo_consulta>650

--E) Listar todos los m�dicos que tengan una antig�edad mayor a 10 a�os.
select * from medicos where datediff(year,fechaingreso,getdate())>10

--F) Listar todos los pacientes que posean la Obra social 'Dasuten'.
select * from pacientes inner join OBRAS_SOCIALES on pacientes.IDOBRASOCIAL=OBRAS_SOCIALES.IDOBRASOCIAL where OBRAS_SOCIALES.NOMBRE like 'Dasuten'

--G) Listar todos los pacientes que hayan nacido en los meses de Enero, Febrero o Marzo.
select * from pacientes where month(fechanac) in (01,02,03)

--H) Listar todos los pacientes que hayan tenido alg�n turno m�dico en los �ltimos 45 d�as.
select * from pacientes inner join turnos on pacientes.IDPACIENTE = turnos.IDPACIENTE where datediff(day,turnos.FECHAHORA,getdate())<45

--I) Listar todos los pacientes que hayan tenido alg�n turno con alg�n m�dico con especialidad 'Gastroenterolog�a'.
select pacientes.idpaciente, pacientes.APELLIDO, pacientes.NOMBRE from pacientes inner join turnos on pacientes.IDPACIENTE = turnos.IDPACIENTE
inner join MEDICOS on turnos.IDMEDICO = medicos.IDMEDICO
inner join ESPECIALIDADES on medicos.IDESPECIALIDAD = ESPECIALIDADES.IDESPECIALIDAD
where ESPECIALIDADES.NOMBRE like 'Gastroenterolog�a'

--J) Listar Apellido, nombre, sexo y especialidad de todos los m�dicos que tengan especialidad en alg�n tipo de 'An�lisis'
select m.APELLIDO, m.NOMBRE, m.SEXO, ESPECIALIDADES.NOMBRE as Especialidad from medicos m
inner join ESPECIALIDADES on m.IDESPECIALIDAD = ESPECIALIDADES.IDESPECIALIDAD
where ESPECIALIDADES.NOMBRE like '%An�lisis%'

--K) Listar Apellido, nombre, sexo y especialidad de todos los m�dicos que no posean la especialidad 
--'Gastroenterolog�a', 'Oftalmolog�a', 'Pediatr�a', 'Ginecolog�a' ni 'Oncolog�a'.
select m.APELLIDO, m.NOMBRE, m.SEXO, e.NOMBRE as ESPECIALIDAD from medicos m inner join ESPECIALIDADES e
on m.IDESPECIALIDAD = e.IDESPECIALIDAD
where e.NOMBRE <> 'Gastroenterolog�a' 
and e.NOMBRE <> 'Oftalmolog�a' and e.NOMBRE <> 'Pediatr�a'
and e.NOMBRE <> 'Ginecolog�a' and e.NOMBRE <> 'Oncolog�a'

--L) Listar por cada turno, la fecha y hora, nombre y apellido del m�dico, nombre y apellido del
--paciente, especialidad del m�dico, duraci�n del turno, costo de la consulta sin descuento, obra
--social del paciente y costo de la consulta con descuento de la obra social. Ordenar el listado de
--forma cronol�gica. Del �ltimo turno al primero.

select t.FECHAHORA, m.NOMBRE as Nombre_med, m.APELLIDO as Apellido_med, p.APELLIDO as Ape_pac, p.NOMBRE as Nom_pac, e.NOMBRE as Especialidad, t.DURACION, m.COSTO_CONSULTA,
o.NOMBRE, m.COSTO_CONSULTA*o.COBERTURA as Costo_con_desc
from turnos t inner join medicos m on t.IDMEDICO = m.IDMEDICO
inner join pacientes p on p.IDPACIENTE = T.IDPACIENTE
inner join ESPECIALIDADES e on e.IDESPECIALIDAD = m.IDESPECIALIDAD
inner join OBRAS_SOCIALES o on o.IDOBRASOCIAL = p.IDOBRASOCIAL
order by t.FECHAHORA desc

--M) Listar todos los pacientes que no se hayan atendido con ning�n m�dico.
select distinct p.IDPACIENTE, p.nombre, p.APELLIDO from pacientes p
where p.IDPACIENTE not in (select t.IDPACIENTE from turnos t)

--N) Listar por cada a�o, mes y paciente la cantidad de turnos solicitados. Del paciente mostrar Apellido y nombre.
select count(t.IDTURNO) as Cant_turnos, year(t.FECHAHORA) as A�o, month(t.FECHAHORA) as Mes, p.APELLIDO, p.NOMBRE from turnos t 
inner join PACIENTES p  on t.idpaciente=p.IDPACIENTE
group by p.APELLIDO, p.NOMBRE, t.FECHAHORA
order by t.FECHAHORA desc

--�) Listar el/los paciente que haya tenido el turno con mayor duraci�n.
select top (1) with ties p.idpaciente, p.nombre, p.apellido, t.duracion from pacientes p 
inner join turnos t on p.IDPACIENTE=t.IDPACIENTE
order by t.DURACION desc

--O) Listar el promedio de duraci�n de un turno que pertenezcan a m�dicos con especialidad 'Pediatr�a'.
select avg(t.duracion) as Promedio from turnos t inner join medicos m
on t.IDMEDICO = m.IDMEDICO
inner join ESPECIALIDADES e on m.IDESPECIALIDAD = e.IDESPECIALIDAD
where e.NOMBRE like 'Pediatr�a'

--P) Listar por cada m�dico, el total facturado (sin descuentos) agrupado por a�o. Listar apellido y nombre del m�dico.
select m.APELLIDO, m.NOMBRE, (count(t.IDMEDICO))*(m.COSTO_CONSULTA) as Total, year(t.FECHAHORA) as A�o
from medicos m inner join turnos t 
on t.IDMEDICO = m.IDMEDICO
group by year(t.FECHAHORA), m.APELLIDO, m.NOMBRE, m.COSTO_CONSULTA
order by Apellido Asc

--Q) Listar por cada especialidad la cantidad de turnos que se solicitaron en total. Listar nombre de la especialidad.
select e.NOMBRE, count(t.IDMEDICO) as Cant_turnos from ESPECIALIDADES e inner join medicos m
on m.IDESPECIALIDAD = e.IDESPECIALIDAD
inner join turnos t
on t.IDMEDICO = m.IDMEDICO
group by e.NOMBRE

--R) Listar por cada obra social, la cantidad de turnos.
select o.NOMBRE as Obra_Social, count(t.IDPACIENTE) as cant_turnos from pacientes p inner join turnos t
on t.IDPACIENTE = p.IDPACIENTE
inner join OBRAS_SOCIALES o
on p.IDOBRASOCIAL = o.IDOBRASOCIAL
group by o.NOMBRE


use TP_INTEGRADOR_PARTE1
--S) Listar todos los m�dicos que nunca atendieron a pacientes con Obra Social 'Dasuten'.
select m.IDMEDICO, m.NOMBRE, m.APELLIDO from medicos m where m.IDMEDICO not in (
select t.IDMEDICO from TURNOS t inner join pacientes p on t.IDPACIENTE = p.IDPACIENTE
where p.IDOBRASOCIAL = (select o.IDOBRASOCIAL from OBRAS_SOCIALES o where o.NOMBRE like 'Dasuten'))


--T) Listar todos los pacientes que no se atendieron durante todo el a�o 2015.
select p.IDPACIENTE, p.NOMBRE, p.APELLIDO from pacientes p where p.IDPACIENTE not in (
select t.IDPACIENTE from turnos t where year(t.FECHAHORA) = 2015)
order by p.IDPACIENTE asc

--U) Listar para cada paciente la cantidad de turnos solicitados con m�dicos que realizan
--"An�lisis" y la cantidad de turnos solicitados con m�dicos de otras especialidades.
select t.IDPACIENTE,(select count(t.IDTURNO) from turnos t inner join medicos m
on t.IDMEDICO=m.IDMEDICO
where m.IDESPECIALIDAD not in (select e.IDESPECIALIDAD from ESPECIALIDADES e where e.NOMBRE like 'An�lisis%')
) AS OTROS_TURNOS, count(t.IDTURNO) as TURNOS_ANALISIS from turnos t inner join medicos m
on t.IDMEDICO=m.IDMEDICO
where m.IDESPECIALIDAD in (select e.IDESPECIALIDAD from ESPECIALIDADES e where e.NOMBRE like 'An�lisis%')
group by t.IDPACIENTE


select t.IDPACIENTE, count(t.IDTURNO) as TURNOS_ANALISIS from turnos t inner join medicos m
on t.IDMEDICO=m.IDMEDICO
where m.IDESPECIALIDAD in (select e.IDESPECIALIDAD from ESPECIALIDADES e where e.NOMBRE like 'An�lisis%')
group by t.IDPACIENTE
union
select t.IDPACIENTE, count(t.IDTURNO) AS OTROS_TURNOS from turnos t inner join medicos m
on t.IDMEDICO=m.IDMEDICO
where m.IDESPECIALIDAD not in (select e.IDESPECIALIDAD from ESPECIALIDADES e where e.NOMBRE like 'An�lisis%')
group by t.IDPACIENTE




--V) Listar todos los m�dicos que no atendieron nunca por la ma�ana. Horario de 08:00 a 12:00.
select distinct t.IDMEDICO, m.NOMBRE, m.APELLIDO from turnos t inner join medicos m
on t.IDMEDICO = m.IDMEDICO
where t.idmedico not in (select t.IDMEDICO from turnos t where DATEPART(hour,(t.FECHAHORA)) in (08,09,10,11,12))
order by t.idmedico asc

--W) Listar el paciente que m�s veces se atendi� para una misma especialidad.
select top(1) with ties t.IDPACIENTE, count(t.IDPACIENTE) as Atenciones, m.IDESPECIALIDAD from turnos t
inner join medicos m
on t.IDMEDICO = m.idmedico
group by t.Idpaciente, m.IDESPECIALIDAD
order by count(t.IDPACIENTE) desc

--X) Listar las obras sociales que tengan m�s de 10 afiliados en la cl�nica.
select p.IDOBRASOCIAL, o.NOMBRE, count(p.idobrasocial) as Asociades from OBRAS_SOCIALES o inner join pacientes p
on o.IDOBRASOCIAL = p.IDOBRASOCIAL
where p.idobrasocial in (select p.idobrasocial from pacientes p group by p.IDOBRASOCIAL having ((count(p.IDOBRASOCIAL)) > 10))
group by p.IDOBRASOCIAl, o.NOMBRE


--Y) Listar todos los pacientes que se hayan atendido con m�dicos de otras especialidades pero
--no se hayan atendido con m�dicos que realizan "An�lisis".


select distinct t.IDPACIENTE, p.NOMBRE, p.APELLIDO from turnos t inner join pacientes p
on t.IDPACIENTE = p.IDPACIENTE
where t.IDMEDICO in(
select distinct t.IDMEDICO from turnos t inner join medicos m
on t.IDMEDICO=m.IDMEDICO
where m.IDESPECIALIDAD not in (select e.IDESPECIALIDAD from ESPECIALIDADES e where e.NOMBRE like 'An�lisis%'))
order by t.Idpaciente asc

--Z) Listar todos los pacientes cuyo promedio de duraci�n por turno sea mayor a 20 minutos.

select avg(t.DURACION) as Promedio_duracion, p.NOMBRE, p.APELLIDO, t.IDPACIENTE from turnos t
inner join pacientes p
on t.IDPACIENTE = p.IDPACIENTE
group by t.IDPACIENTE, p.NOMBRE, p.APELLIDO
having avg(t.DURACION) > 20
order by avg(t.duracion) asc
