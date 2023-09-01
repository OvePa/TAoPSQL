
create table clinica.datos_pacientes_personal(
	folio serial primary key,
	tipoMovimiento varchar(20),
	idPaciente clinica.id_paciente,
	nombrePaciente varchar(20),
	apellidoPaciente varchar(20),
	usuario varchar(20),
	fecha timestamp
);

--trigger
create or replace function clinica.borradoPaciente() 
returns trigger
as $$
declare
	usuario varchar(20) := (select current_user);
	fechaActual timestamp := (select left( cast(current_timestamp as char(30)),19));
begin
	
	insert into clinica.datos_pacientes_personal
	(tipoMovimiento,idPaciente,nombrePaciente,apellidoPaciente,usuario,fecha)
	values( 'BORRADO',old.pk_idPaciente,old.nombre,old.apellido,usuario,fechaActual);

return new;
end;
$$
language plpgsql;

create or replace trigger Borrado_Paciente after delete on clinica.paciente
for each row
execute procedure clinica.borradoPaciente();

--actualizar
create or replace function clinica.actualizadoPaciente() 
returns trigger
as $$
declare
	usuario varchar(20) := (select current_user);
	fechaActual timestamp := (select left( cast(current_timestamp as char(30)),19));
begin
	
	insert into clinica.datos_pacientes_personal
	(tipoMovimiento,idPaciente,nombrePaciente,apellidoPaciente,usuario,fecha)
	values( 'ACTUALIZADO',old.pk_idPaciente,old.nombre,old.apellido,usuario,fechaActual);

return new;
end;
$$
language plpgsql;


create or replace trigger Actualizado_Paciente after update on clinica.paciente
for each row
execute procedure clinica.actualizadoPaciente();


------
select * from clinica.paciente;


update clinica.paciente set telefono = '1234567890' where pk_idpaciente = 'P-0015';

delete from clinica.paciente where pk_idpaciente = 'P-0015';

select * from clinica.datos_pacientes_personal;

-- elimira trigger
drop trigger Actualizado_Paciente on clinica.paciente;