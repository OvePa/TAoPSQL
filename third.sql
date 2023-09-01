-- consultas
select * from clinica.paciente;

select nombre, apellido from clinica.paciente;

-- condicional
select * from clinica.paciente
	where sexo = 'M';

select * from clinica.paciente
	where ciudad = 'MEXICO';
	
select * from clinica.paciente
	where ciudad = 'MEXICO' or sexo = 'M';
	
	
select * from clinica.paciente
	where ciudad in ('MONTERREY','GUADALAJARA');
	
select * from clinica.paciente
	where ciudad not in ('MONTERREY','GUADALAJARA');
	
select * from clinica.paciente 
	where apellido like '%Z';

select * from clinica.paciente 
	where ciudad like 'MO%';

select * from clinica.paciente 
	where nombre like '%A%';
	
	
select * from clinica.agendar_cita
	where (fechaCita between '2022-10-01' and '2022-10-06') and (turno = 'MATUTINO');
	
	
select * from clinica.expediente_diagnostico 
	where edad < '30';
	
select * from clinica.expediente_diagnostico 
	where nivelPeso <> 'OBESIDAD';
	
	
select folio, fk_idespecialista, fk_idPaciente, fechacreacion, edad
from clinica.expediente_diagnostico
	where nivelPeso <> 'NORMAL' and edad between '30' and '40';
	
-- count
select count(*) as cantidad_paciente from clinica.paciente;

select count(*) as cantidad_paciente from clinica.paciente
	where ciudad = 'MEXICO';
	
--sum

select sum(folio) from clinica.expediente_diagnostico;

select sum(cast(edad as int)) from clinica.expediente_diagnostico;
select sum(cast(peso as int)) from clinica.expediente_diagnostico;

-- max
select max(peso)as peso_max from clinica.expediente_diagnostico;
select max(edad)as edad_max from clinica.expediente_diagnostico;
select min(edad)as edad_min from clinica.expediente_diagnostico;

--avg
select avg(cast (edad as int)) as prom_edad from clinica.expediente_diagnostico;
select avg(cast (peso as int)) as prom_peso from clinica.expediente_diagnostico;

--combinar funciones de agregacion
select max(edad) as edad_max, min(edad) as edad_min, sum(cast(edad as int)) as suma_edad,
avg(cast(edad as int)) as edad_promedio, count(*) as cantidad_diagnostico
from clinica.expediente_diagnostico;

--group by and order by

select fk_idEspecialista from clinica.expediente_diagnostico
	group by fk_idEspecialista;
	
select count(nivelPeso) as cantidad_peso, nivelPeso from clinica.expediente_diagnostico
	group by nivelPeso;

select fk_idPaciente, avg( cast (peso as int)) from clinica.expediente_diagnostico
	group by fk_idPaciente
	order by fk_idPaciente desc;

--having
select fk_idEspecialista, count(fk_idEspecialista) as citas_a_realizar
from clinica.expediente_diagnostico
	group by fk_idEspecialista
	having count(fk_idEspecialista) > 2;
	
select fk_idEspecialista from clinica.expediente_diagnostico;

select fk_idPaciente, avg( cast (peso as int)) as avg_edad
from clinica.expediente_diagnostico
	group by fk_idPaciente,peso
	having avg( cast (peso as int)) < 80;

--distinct
select distinct fk_idEspecialista from clinica.expediente_diagnostico
	order by fk_idEspecialista;

--limit
select * from clinica.paciente
	limit 5;
	
select * from clinica.expediente_diagnostico
	order by folio desc
	limit 5;

--join
--inner join
select * from clinica.paciente
inner join clinica.expediente
on paciente.pk_idPaciente = expediente.pk_idPaciente
	where paciente.pk_idPaciente = 'P-0001';


--left join
select * from clinica.paciente
left join clinica.expediente
on paciente.pk_idPaciente = expediente.pk_idPaciente;


--right join
select * from clinica.paciente
right join clinica.expediente
on paciente.pk_idPaciente = expediente.pk_idPaciente;

--inner join anidados
select * from clinica.paciente
inner join clinica.cita
on paciente.pk_idPaciente = cita.fk_idPaciente
inner join clinica.agendar_cita
on cita.pk_idCita = agendar_cita.fk_idCita
inner join clinica.especialista
on agendar_cita.fk_idEspecialista = especialista.pk_idEspecialista
inner join clinica.expediente_diagnostico
on especialista.pk_idEspecialista = expediente_diagnostico.fk_idEspecialista
inner join clinica.expediente
on expediente_diagnostico.fk_idPaciente = expediente.pk_idPaciente
	where paciente.pk_idPaciente = 'P-0001';









	