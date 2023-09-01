--Procedures
--Paciente y expediente
create or replace procedure clinica.InsertarPacienteExpediente
(nombre varchar(20), apellido varchar(20),sexo char(1),fechaNacimiento date,
ciudad varchar(3),estado varchar(20),telefono char(10),tipoSangre varchar(10),
tipoAlergia varchar(30),padecimientosCro varchar(30))
language plpgsql
as $$
declare
	idPaciente char(6);
	idPacienteAux char(6);
	fechaCreacion timestamp := (SELECT LEFT(CAST (CURRENT_TIMESTAMP AS CHAR(30)), 19 ));
begin
	if not exists (select pk_idPaciente from clinica.paciente where pk_idPaciente = 'P-0001') then
		idPaciente := 'P-0001';
	else
		idPaciente := (select pk_idPaciente from clinica.paciente order by pk_idpaciente desc limit 1);
		idPacienteAux := (select substring(idPaciente,3,6));
		idPacienteAux := cast(idPacienteAux as int) + 1;
		
		IF idPacienteAux < '9' THEN
			idPaciente = 'P-00' || idPacienteAux;
		ELSEIF idPacienteAux BETWEEN '10' AND '99' THEN
			idPaciente = 'P-0' ||  idPacienteAux;
		ELSEIF idPacienteAux BETWEEN '100' AND '999' THEN
			idPaciente = 'P-' ||  idPacienteAux;	
		END IF;
		
	end if;
	
	insert into clinica.paciente values
		(idPaciente,nombre,apellido,fechaNacimiento,ciudad,estado,telefono);
		
	insert into clinica.expediente values
		(idPaciente,tipoSangre,tipoAlergia,padecimientosCro,fechaCreacion);
		
	raise notice 'Paciente y expediente ingresado correctamente.';
end;
$$
--------------------
CREATE OR REPLACE PROCEDURE CLINICA.InsertarPacienteExpediente
(nombre VARCHAR(20), apellido VARCHAR(20), sexo CHAR(1), fechaNacimiento DATE, 
	ciudad VARCHAR(30), estado VARCHAR(30), telefono CHAR(10), tipoSangre VARCHAR(10),
		tipoAlergia VARCHAR(30), padecimientosCro VARCHAR(30)) 
LANGUAGE plpgsql
AS $$
DECLARE
	idPaciente CHAR(6);
	idPacienteAux CHAR(4);
	fechaCreacion TIMESTAMP:= (SELECT LEFT(CAST (CURRENT_TIMESTAMP AS CHAR(30)), 19 ));
BEGIN
	
	IF NOT EXISTS (SELECT pk_idPaciente FROM CLINICA.PACIENTE WHERE pk_idPaciente = 'P-0001' ) THEN
		idPaciente = 'P-0001';
	ELSE
		idPaciente := (SELECT pk_idPaciente FROM CLINICA.PACIENTE ORDER BY pk_idPaciente DESC LIMIT 1);
		idPacienteAux := (SELECT SUBSTRING(idPaciente, 3, 6));
		idPacienteAux := CAST(idPacienteAux AS INT)+1;
		
		IF idPacienteAux < '9' THEN
			idPaciente = 'P-00' || idPacienteAux;
		ELSEIF idPacienteAux BETWEEN '10' AND '99' THEN
			idPaciente = 'P-0' ||  idPacienteAux;
		ELSEIF idPacienteAux BETWEEN '100' AND '999' THEN
			idPaciente = 'P-' ||  idPacienteAux;	
		END IF;
	END IF;
	
	INSERT INTO CLINICA.PACIENTE 
	VALUES (idPaciente, nombre, apellido, sexo, fechanacimiento, ciudad, estado, telefono );
	
	INSERT INTO CLINICA.EXPEDIENTE
	VALUES (idPaciente, tipoSangre, tipoAlergia, padecimientosCro, fechaCreacion);

	RAISE NOTICE 'PACIENTE Y EXPEDIENTE INGRESADO CORRECTAMENTE';
END; $$
----------------

call clinica.InsertarPacienteExpediente
('RAMON','VELARDE','M','1980-02-03','MONTERREY','NUEVO LEON','2341098745','O POSITIVO','NA','NA');


CALL CLINICA.InsertarPacienteExpediente
('DANIEL', 'CARMONA', 'M', '1999-01-01', 'MEXICO', 'MEXICO', '5549809822', 'O POSITIVO', 'NA', 'NA' );

select * from clinica.paciente;



---- especialista
DROP PROCEDURE clinica.insertarespecialista;

create or replace procedure clinica.InsertarEspecialista
(nombre varchar(20),apellido varchar(20),sexo char(1), fechaNacimiento date,especialidad varchar(20))
language plpgsql
as $$
declare
	idEspecialista char(7);
	idEspecialistaAux char(7);
begin
	if not exists (select pk_idEspecialista from clinica.especialista where pk_idEspecialista = 'ME-0001' ) then
		idEspecialista = 'ME-0001';
	else
		idEspecialista := (select pk_idEspecialista from clinica.especialista order by pk_idEspecialista desc limit 1 );
		idEspecialistaAux := (select substring(idEspecialista,4,7) );
		idEspecialistaAux := cast(idEspecialistaAux as int) + 1;
		
		if idEspecialistaAux < '9' then
			idEspecialista = 'ME-000' || idEspecialistaAux;
		elseif idEspecialistaAux between '10' and '99' then
			idEspecialista = 'ME-00' || idEspecialistaAux;
		elseif idEspecialistaAux between '100' and '999' then
			idEspecialista = 'ME-0' || idEspecialistaAux;
		end if;
	end if;
	
	
	insert into clinica.especialista
	values(idEspecialista,nombre,apellido,sexo,fechaNacimiento,especialidad);
	
	raise notice 'Especialista ingresado correctamente.';
end; $$

call clinica.InsertarEspecialista
('JORGE','SANCHEZ','M','1980-04-06','CARDIOLOGIA');

select * from clinica.especialista;

-- cita y agendar cita
create or replace procedure clinica.InsertarCitaAgendarCita
(idPaciente clinica.id_paciente, idEspecialista clinica.id_meespecialista, consultorio varchar(20),
fechaCita date, horaCita time, observaciones varchar(100))
language plpgsql
as $$
declare
	idCita char(7);
	idCitaAux char(7);
	fechaActual date := (select current_date);
	horaActual time := (select current_time);
	turno varchar(10);
begin
	
	if not exists (select pk_idCita from clinica.cita where pk_idCita = 'CM-0001' ) then
		idCita = 'CM-0001';
	else
		idCita := (select pk_idCita from clinica.cita order by pk_idCita desc limit 1 );
		idCitaAux := (select substring(idCita, 4,7 ) );
		idCitaAux := cast( idCitaAux as int ) + 1;
		
		if idCitaAux < '9' then
			idCita = 'CM-00' || idCitaAux;
		elseif idCitaAux between '10' and '99' then
			idCita = 'CM-0' || idCitaAux;
		elseif idCitaAux between '100' and '999' then
			idCita = 'CM-' || idCitaAux;
		end if;
	end if;
	
	if horaCita >= '12:00' then
		turno = 'VESPERTINO';
	else
		turno = 'MATUTINO';
	end if;
	
	if fechaCita < fechaActual then
		raise notice 'No se pueden hacer citas en fechas anteriores - CITA NO INGRESADA. ' ;
	else
		insert into clinica.cita
			values ( idCita, idPaciente, fechaActual, horaActual );
	
			
		insert into clinica.agendar_cita
			values ( idCita, idEspecialista, consultorio, fechaCita,horaCita ,turno, 'ESPERA', observaciones );
			
		raise notice 'Cita ingresada correctamente.';
	end if;
end; $$


call clinica.InsertarCitaAgendarCita
( 'P-0004','ME-0004','CONSULTORIO 5','2023-07-10','09:00','NA' );


select * from clinica.cita;
select * from clinica.agendar_cita;

-- diagnostico
create or replace procedure clinica.intertarDiagnostico
( idEspecialista clinica.id_meespecialista, idPaciente clinica.id_paciente, edad char(3), peso char(3),
altura char(3),presionArterial char(6), diagnostico varchar(100), recetario varchar(100)  )
language plpgsql
as $$
declare
	imc real;
	pesoNum int;
	alturaNum real;
	nivelPeso char(10);
	fechaCreacion timestamp := ( select left(cast(current_timestamp as char(30)),19) );
begin
	pesoNum := peso;
	alturaNum := altura;
	imc := pesoNum / (alturaNum * alturaNum);
	imc := cast(imc as char(5));
	
	if imc < '18.5' then
		nivelPeso = 'BAJO';
	elseif imc between '18.5' and '24.9' then
		nivelPeso = 'NORMAL';
	elseif imc between '25.0' and '29.9' then
		nivelPeso = 'SOBREPESO';
	else
		nivelPeso = 'OBESIDAD';
	end if;
	
	insert into clinica.expediente_diagnostico(
	fk_idEspecialista,fk_idPaciente,edad, peso,altura,imc,nivelPeso,presionArterial,
	diagnostico,recetario,fechaCreacion)
	values(idEspecialista,idPaciente,edad,peso,altura,imc,nivelPeso,presionArterial,
		  diagnostico,recetario,fechaCreacion);
	
	raise notice 'Expediente diagnostico ingresado correctamente.';
	
end;$$

call clinica.intertarDiagnostico
( 'ME-0001','P-0003','20','80','1.78','120/70','NA','NA' );

select * from clinica.expediente_diagnostico;

-- cancelar cita
create or replace procedure clinica.CitaStatusCancelada(idCita clinica.id_cita)
language plpgsql
as $$
declare
	status char(10) := (select status from clinica.agendar_cita where fk_idcita = idCita);
begin
	
	if not exists (select pk_idCita from clinica.cita where pk_idCita = idCita) then
		raise notice 'El id de cita no existe.';
	elseif status = 'REALIZADO' then
		raise notice 'La cita ya ha sido realizada.';
	else
		update clinica.agendar_cita set status = 'CANCELADA'
		where fk_idCita = idCita;
		
		raise notice 'Cita cancelada exitosamente.';
	end if;
end;$$

call clinica.CitaStatusCancelada('CM-0210');

select * from clinica.agendar_cita;

-- realizar cita
create or replace procedure clinica.CitaStatusRealizada(idCita clinica.id_Cita)
language plpgsql
as $$
declare
	status char(10) := ( select status from clinica.agendar_cita where fk_idCita = idCita ) ;
begin

	if not exists ( select pk_idCita from clinica.cita where pk_idCita = idCita ) then
		raise notice 'El id de la cita no existe.';
	elseif status = 'CANCELADA' then
		raise notice 'La cita ya ha sido cancelada.';
	else
		update clinica.agendar_cita set status = 'REALIZADA'
		where fk_idCita = idCita;
		
		raise notice 'Cita realizada correctamente.';
	end if;
end; $$

call clinica.CitaStatusRealizada('CM-0010');
select * from clinica.agendar_cita;