--vistas
--crear vista

create view clinica.pacientes_masculinos as 
select * from clinica.paciente
	where sexo = 'M';
	
select * from clinica.pacientes_masculinos;

--borrar vista

drop view clinica.pacientes_masculinos;

--renombra vista
alter view clinica.pacientes_masculinos rename to otro_nombre;

--subconsultas

select * from clinica.especialista
	where pk_idEspecialista in (select fk_idEspecialista
							   from clinica.agendar_cita
							   where fechaCita between '2022-10-04' and '2022-10-08');


select * from clinica.especialista
	where pk_idEspecialista not in (select fk_idEspecialista
							   from clinica.agendar_cita
							   where fechaCita between '2022-10-04' and '2022-10-05');

select * from clinica.paciente
inner join clinica.expediente_diagnostico
on paciente.pk_idPaciente = expediente_diagnostico.fk_idPaciente
	where(sexo = 'M')
	and expediente_diagnostico.fk_idEspecialista in (select pk_idEspecialista
													 from clinica.especialista
													 	where pk_idEspecialista in ('ME-0001','ME-0003'));




select * from clinica.expediente_diagnostico
	where peso in (select max(peso) from clinica.expediente_diagnostico);




select * from clinica.expediente_diagnostico
	where peso in (select max(peso) from clinica.expediente_diagnostico)
	or edad in (select max(edad) from clinica.expediente_diagnostico);



select *, (select tipoSangre from clinica.expediente
		  	where pk_idPaciente = paciente.pk_idPaciente),
		  (select padecimientoscro from clinica.expediente
		  	where pk_idPaciente = paciente.pk_idPaciente)
from clinica.paciente
	where pk_idPaciente = 'P-0003';


--funciones de texto

--left
select left('hola este es un mensaje',4) as mensaje;

select nombre, apellido from clinica.paciente
	where left(nombre,1) = 'A';
	
--right
select right('hola este es un mensaje',7) as mensaje;

select nombre, apellido from clinica.paciente
	where right(apellido,1) = 'Z';

--concat
select concat('El paciente con ID:',fk_idPaciente,' tiene un peso de ',peso,' kg.')
from clinica.expediente_diagnostico;

select concat(nombre || ' ' ||apellido) as nombre_completo from clinica.paciente;

--length
select length('hola este es un mensaje');

select concat(nombre,' ', apellido) as nombre_paciente,length(nombre||''||apellido) as cantidad
from clinica.paciente;


--replace

select replace('Mensajz','z','e');

select * from clinica.expediente;

update clinica.expediente set tipoSangre = replace(tipoSangre,'B','O')
	where tipoAlergias='NA' and padecimientoscro = 'NA';

--fecha y hora
select now(); -- 2023-08-29 12:14:28.525299-06
select current_time; -- 12:14:43.372166-06:00
select left(cast(current_time as varchar(8)),8);

select current_date;

select(now() + '1 day') as tiempo_mañana;
select(now() + '1 hour') as tiempo_mañana;
select timeofday();

--date part
select date_part('year','2012-01-01'::date) - date_part('year','2005-01-01'::date) as diff_agno;

select date_part('month','2012-10-01'::date) - date_part('month','2005-01-01'::date) as diff_month;

select date_part('day','2012-10-21'::date) - date_part('day','2005-01-01'::date) as diff_day;

select date_part('hour','2012-10-21 15:00'::timestamp) - date_part('hour','2005-01-01 09:00'::timestamp) as diff_hour;

select date_part('min','2012-10-21 15:45'::timestamp) - date_part('min','2005-01-01 09:00'::timestamp) as diff_min;


select concat(date_part('sec','2012-10-21 15:45:30'::timestamp) - date_part('sec','2005-01-01 09:00:05'::timestamp),' segundos')