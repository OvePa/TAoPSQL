create schema clinica;
drop schema public;

-- Creacion de dominios
create domain clinica.ID_PACIENTE as CHAR(6) not null
	CHECK (VALUE ~ '^[P]{1}[-]{1}\d{4}$'); --P-0001
	
create domain clinica.ID_MEESPECIALISTA as char(7) not null
	CHECK (VALUE ~ '^[ME]{2}[-]{1}\d{4}$'); --ME-0001
	
create domain clinica.ID_CITA as char(7) not null
	CHECK (VALUE ~ '^[CM]{2}[-]{1}\d{4}$'); --CM-0001
	
-- Creacion de tablas
create table clinica.paciente (
	pk_idPaciente clinica.ID_PACIENTE,
	nombre varchar(20) not null,
	apellido varchar(20) not null,
	sexo char(1) not null,
	fechaNacimiento date not null,
	ciudad varchar(20) not null,
	estado varchar(20) not null,
	telefono char(10) unique,
	primary key (pk_idPaciente)
);

create table clinica.especialista(
	pk_idEspecialista clinica.ID_MEESPECIALISTA,
	nombre varchar(20) not null,
	apellido varchar(20) not null,
	sexo char(1) not null,
	fechaNacimiento date not null,
	especialidad varchar(30) not null,
	primary key (pk_idEspecialista)
	
);

create table clinica.cita(
	pk_idCita clinica.ID_CITA,
	fk_idPaciente clinica.ID_PACIENTE,
	fecha date not null,
	hora time not null,
	primary key (pk_idCita),
	foreign key (fk_idPaciente) references clinica.paciente(pk_idPaciente)
	on update cascade on delete cascade
	
);

create table clinica.agendar_cita(
	fk_idCita clinica.ID_CITA,
	fk_idEspecialista clinica.ID_MEESPECIALISTA,
	consultorio varchar(20) not null,
	fechaCita date not null,
	horaCita time not null,
	turno varchar(10) not null,
	status varchar(10) not null,
	observaciones varchar(100) not null,
	primary key (fk_idCita,fk_idEspecialista),
	foreign key (fk_idCita) references clinica.cita (pk_idCita)
	on update cascade on delete cascade,
	foreign key (fk_idEspecialista) references clinica.especialista (pk_idEspecialista)
	on update cascade on delete cascade
);

create table clinica.expediente(
	pk_idPaciente clinica.ID_PACIENTE,
	tipoSangre varchar(20) not null,
	tipoAlergias varchar(20) not null,
	padecimientosCro varchar(50) not null,
	fechaCreacion timestamp not null,
	primary key (pk_idPaciente),
	foreign key (pk_idPaciente) references clinica.paciente (pk_idPaciente)
	on update cascade on delete cascade
);

create table clinica.expediente_diagnostico(
	folio serial not null,
	fk_idEspecialista clinica.ID_MEESPECIALISTA,
	fk_idPaciente clinica.ID_PACIENTE,
	edad char(3) not null,
	peso char(3) not null,
	altura char(4) not null,
	IMC char(5) not null,
	nivelPeso char(10) not null,
	presionArterial char(8) not null,
	diagnostico varchar(150) not null,
	recetario varchar(150) not null,
	fechaCreacion timestamp not null,
	primary key (folio),
	foreign key (fk_idEspecialista) references clinica.especialista (pk_idEspecialista)
	on update cascade on delete cascade,
	foreign key (fk_idPaciente) references clinica.paciente (pk_idPaciente)
	on update cascade on delete cascade
);

-- Agregar una columna
alter table clinica.paciente add column ejemplo varchar(30);
-- Borrar columna
alter table clinica.paciente drop column ejemplo;
-- Cambiar tipo de dato
alter table clinica.paciente alter column ejemplo type char(50);
-- Renombrar columna
alter table clinica.paciente rename columns ejemplo to ejemplo1;
-- Renombrar tabla
alter table clinica.paciente rename to paciente_nuevo;

-- Drop table
drop table clinica.paciente;

