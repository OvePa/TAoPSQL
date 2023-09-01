select * from clinica.paciente
	where right(nombre,1) = 'A' or right(apellido,1) = 'Z'
	order by pk_idpaciente desc;

select * from clinica.paciente
	where nombre like '%A' or apellido like '%Z'
	order by pk_idpaciente desc;
	
select especialidad,count(*) as Num_espcialistas from clinica.especialista
	group by especialidad;
	
select fk_idpaciente,edad,peso,altura from clinica.expediente_diagnostico
	where (cast (peso as int) > 50) or (cast(edad as int) > 30);
	
select fk_idpaciente,edad,peso,altura from clinica.expediente_diagnostico
	where (peso > '50') or (edad > '30');
	

select distinct (fk_idespecialista,fk_idpaciente) from clinica.expediente_diagnostico;

select folio,fk_idpaciente,fk_idespecialista,fechacreacion, nivelpeso from clinica.expediente_diagnostico
	where edad > '25' and nivelpeso <> 'NORMAL' and fechacreacion > '2021-10-01'
	order by fk_idespecialista;



select folio,fk_idpaciente,fk_idespecialista,fechacreacion, nivelpeso from clinica.expediente_diagnostico
	where edad > '25' and nivelpeso not in ('NORMAL') and fechacreacion > '2021-10-01'
	order by fk_idespecialista;


select pk_idespecialista,nombre,apellido
from clinica.especialista
	where pk_idespecialista in (select fk_idespecialista from clinica.expediente_diagnostico
	                            where nivelpeso = 'SOBREPESO');


select fk_idpaciente,count(*) as Num_diagnostico from clinica.expediente_diagnostico
	group by fk_idpaciente
	order by Num_diagnostico desc;


select * from clinica.expediente_diagnostico
	where nivelpeso in ('NORMAL','SOBREPESO') 
	and fk_idespecialista in (select pk_idespecialista
								  from clinica.especialista
								  where especialidad <> 'MEDICO GENERAL')



select * from clinica.paciente
where ciudad = 'MEXICO' and fechanacimiento >= '1980-01-01'
and pk_idpaciente in (select pk_idpaciente from clinica.expediente
					  where tipoalergias = 'NA' or padecimientoscro = 'NA')
and pk_idpaciente in (select fk_idpaciente from clinica.expediente_diagnostico
					  where fk_idespecialista in ('ME-0001','ME-0002','ME-0003'));


select * from clinica.paciente
inner join clinica.cita
on paciente.pk_idpaciente = cita.fk_idpaciente
inner join clinica.agendar_cita
on cita.pk_idcita = agendar_cita.fk_idcita
inner join clinica.especialista
on agendar_cita.fk_idespecialista = especialista.pk_idespecialista
where pk_idpaciente in (select fk_idpaciente from clinica.expediente_diagnostico
						where peso > '70' or edad > '20')



select *,
(select nombre from clinica.especialista where pk_idespecialista = expediente_diagnostico.fk_idespecialista),
(select apellido from clinica.especialista where pk_idespecialista = expediente_diagnostico.fk_idespecialista)
from clinica.expediente_diagnostico
where fk_idpaciente in (select pk_idpaciente from clinica.paciente
						where sexo = 'M')


select * from clinica.paciente
inner join clinica.cita
on paciente.pk_idpaciente = cita.fk_idpaciente
inner join clinica.agendar_cita
on cita.pk_idcita = agendar_cita.fk_idcita
where agendar_cita.fechacita between '2022-10-05' and '2022-10-08'
and ciudad in ('MEXICO','MONTERREY')
and pk_idpaciente in (select pk_idpaciente from clinica.expediente
					 where tiposangre = 'O POSITIVO');











