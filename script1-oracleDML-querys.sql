/* CONSULTA 1

	Listado de entradas durante el último año de la persona cuyo documento de identidad
	es el DNI número 111222333A.
*/

select * 
	from PARTEENTRADA
  	where numID='111222333A' 
	and fechaEntrada BETWEEN SYSDATE - INTERVAL '1' YEAR and SYSDATE;

/* CONSULTA 2

	Listado de entradas durante el último mes de pasajeros con nacionalidad no
	comunitaria (países que no son miembros de la Unión Europea, UE).
*/

select p.* 
	from PARTEENTRADA p, VIAJERO v 
	where p.numID=v.numId and v.paisNacionalidad not in ('Alemania','Austria','Belgica', 'Bulgaria', 'Chipre', 'Republica Checa', 'Cro	  acia', 'Dinamarca', 'Eslovaquia', 'Eslovenia', 'España', 'Estonia', 'Finlandia', 'Francia', 'Grecia', 'Hungria', 'Irlanda', 'Itali	    a', 'Letonia', 'Lituania', 'Luxemburgo', 'Malta', 'Paises Bajos', 'Polonia', 'Portugal', 'Rumania', 'Suecia') 
	and p.fechaEntrada BETWEEN SYSDATE - INTERVAL '1' MONTH and SYSDATE;

/* CONSULTA 3

	Promedio de viajeros, por nacionalidad, recibidos por el establecimiento hotelero
	durante el último año. 
*/

select paisNacionalidad, count(*) 	
	from PARTEENTRADA p, VIAJERO v 
	where p.numID = v.numId 
	and p.fechaEntrada BETWEEN SYSDATE - INTERVAL '1' YEAR and SYSDATE 
	group by paisNacionalidad 
	having count(*) > 0;

/* CONSULTA 4

	Viajeros que han visitado el establecimiento un mínimo de tres veces durante los
	últimos tres años, indicando las fechas de entrada de cada visita.
*/

select distinct v.*, p.fechaEntrada 
	from PARTEENTRADA p, VIAJERO v 
	where p.numID=v.numId and p.numID in (
	select p.numID 
		from PARTEENTRADA p 
		group by p.numID 
		having count(*)>=3) 
		and fechaEntrada BETWEEN SYSDATE - INTERVAL '3' YEAR and SYSDATE;

/* CONSULTA 5

	Viajeros para los cuales, a pesar de no coincidir el número del documento de identidad
	proporcionado, coinciden los valores de al menos tres de los atributos siguientes: fecha
	de expedición del documento, sexo, fecha de nacimiento, país de nacionalidad.
*/

Select distinct * 
	from VIAJERO 
	where numId in(
	Select v1.numId 
		from VIAJERO v1, VIAJERO v2 
		where v1.numId<>v2.numId 
		and v1.fechaExpId=v2.fechaExpId 
		and v1.sexo=v2.sexo 
		and v1.paisNacionalidad=v2.paisNacionalidad
	UNION
	Select v1.numId 
		from VIAJERO v1, VIAJERO v2 
		where v1.numId<>v2.numId 
		and v1.fechaExpId=v2.fechaExpId 
		and v1.sexo=v2.sexo 
		and v1.fechaNacimiento=v2.fechaNacimiento
	UNION
	Select v1.numId 
		from VIAJERO v1, VIAJERO v2 
		where v1.numId<>v2.numId 
		and v1.fechaExpId=v2.fechaExpId 
		and v1.fechaNacimiento=v2.fechaNacimiento 
		and v1.paisNacionalidad=v2.paisNacionalidad
	UNION
	Select v1.numId 
		from VIAJERO v1, VIAJERO v2 
		where v1.numId<>v2.numId 
		and v1.fechaNacimiento=v2.fechaNacimiento 
		and v1.sexo=v2.sexo 
		and v1.paisNacionalidad=v2.paisNacionalidad);

/*
*	Consultas de transacciones propuestas
*/

/*
*	Consultar el nombre y apellidos de un determinado viajero
*/

select nombre, apellido1, apellido2 
	from VIAJERO 
	where numId = '111222333A';

/*
*	Consultar el numero total de huespedes registrados a lo largo del ultimo año
*/

select count(numId)
	from REGISTRAR
	where fechaEntrada BETWEEN SYSDATE - INTERVAL '1' YEAR and SYSDATE;

/*
*	Consultar el numero de hombres y mujeres que hay registrados
*/

select sexo, count(*)
	from VIAJERO
	group by sexo;





