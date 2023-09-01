-- Insertar datos paciente

insert into clinica.paciente values('P-0001','JUAN','GONZALEZ','M','1988-05-24','MEXICO','MEXICO','5512343234');

select * from clinica.paciente;

-- cuando hay valores default
insert into clinica.paciente (pk_idPaciente,nombre,apellido,sexo,fechanacimiento,ciudad,estado,telefono)
values('P-0002','RAMON','GONZALEZ','M','1990-07-04','MEXICO','MONTERREY','5512343254');

insert into clinica.paciente values
('P-0003', 'FERNANDA', 'MORALES', 'F', '1973-07-01', 'MEXICO', 'MEXICO', '5412309872'),
('P-0004', 'ANDREA', 'ZUÑIGA', 'F', '2000-12-02', 'GUADALAJARA', 'JALISCO', '3309876522'),
('P-0005', 'ALBERTO', 'PEREYRA', 'M', '1986-10-23', 'MEXICO', 'MEXICO', '5565423983'),
('P-0006', 'KAREN', 'SOTO', 'F', '1978-07-07', 'MEXICO', 'MEXICO', '5565423097'),
('P-0007', 'ANDRES', 'ORTIZ', 'M','1990-10-09', 'MONTERREY', 'MEXICO', '5698782347'),
('P-0008', 'LESLY', 'RODRIGUEZ', 'F', '2001-02-11', 'MEXICO', 'MEXICO', '5543454352'),
('P-0009', 'ENRIQUE', 'VERA', 'M', '1996-11-12', 'GUADALAJARA', 'JALISCO', '3309815273'),
('P-0010', 'VICTORIA', 'SOLIS', 'F', '2002-03-10', 'MEXICO', 'MEXICO', '5565278126');



--INSERTAR DATOS DE ESPECIALISTA

INSERT INTO CLINICA.ESPECIALISTA VALUES 
('ME-0001', 'REYNA', 'GUADALUPE', 'F', '1986-01-01', 'MEDICO GENERAL'),
('ME-0002', 'ENRIQUE', 'ORTIZ', 'M', '1968-10-01', 'NEFROLOGIA'),
('ME-0003', 'FELIPE', 'HERNANDEZ', 'M', '1980-10-02', 'MEDICO GENERAL'),
('ME-0004', 'KENIA', 'LOPEZ', 'F', '1973-01-01', 'PEDIATRA'),
('ME-0005', 'JUAN', 'MARTINEZ', 'M', '1980-02-23', 'MEDICO GENERAL');

select * from clinica.especialista;

--INSERTAR DATOS DE CITA

INSERT INTO CLINICA.CITA VALUES 
('CM-0001', 'P-0001', '2022-10-01', '12:00'),
('CM-0002', 'P-0002', '2022-10-01', '12:20'),
('CM-0003', 'P-0003', '2022-10-02', '12:20'),
('CM-0004', 'P-0004', '2022-10-02', '10:00'),
('CM-0005', 'P-0005', '2022-10-03', '08:20'),
('CM-0006', 'P-0006', '2022-10-03', '12:20'),
('CM-0007', 'P-0007', '2022-10-04', '12:20'),
('CM-0008', 'P-0008', '2022-10-04', '10:00'),
('CM-0009', 'P-0009', '2022-10-04', '08:20'),
('CM-0010', 'P-0010', '2022-10-05', '08:20');

select * from clinica.cita;

--INSERTAR DATOS DE AGENDAR CITA

INSERT INTO CLINICA.AGENDAR_CITA VALUES 
('CM-0001', 'ME-0001', 'CONSULTORIO 1', '2022-10-04', '12:00', 'MATUTINO', 'ESPERA', 'NA'),
('CM-0002', 'ME-0001', 'CONSULTORIO 1', '2022-10-04', '12:20', 'MATUTINO', 'ESPERA', 'NA'),
('CM-0003', 'ME-0002', 'CONSULTORIO 2', '2022-10-05', '12:00', 'MATUTINO', 'ESPERA', 'NA'),
('CM-0004', 'ME-0002', 'CONSULTORIO 2', '2022-10-05', '12:00', 'MATUTINO', 'ESPERA', 'NA'),
('CM-0005', 'ME-0003', 'CONSULTORIO 3', '2022-10-06', '12:00', 'MATUTINO', 'ESPERA', 'NA'),
('CM-0006', 'ME-0003', 'CONSULTORIO 3', '2022-10-07', '14:00', 'VESPERTINO', 'ESPERA', 'NA'),
('CM-0007', 'ME-0003', 'CONSULTORIO 3', '2022-10-07', '14:20', 'VESPERTINO', 'ESPERA', 'NA'),
('CM-0008', 'ME-0004', 'CONSULTORIO 4', '2022-10-08', '13:00', 'VESPERTINO', 'ESPERA', 'NA'),
('CM-0009', 'ME-0004', 'CONSULTORIO 4', '2022-10-08', '13:20', 'VESPERTINO', 'ESPERA', 'NA'),
('CM-0010', 'ME-0005', 'CONSULTORIO 5', '2022-10-08', '15:00', 'VESPERTINO', 'ESPERA', 'NA');

select * from clinica.agendar_cita;


--INSERTAR DATOS DE EXPEDIENTE

alter table clinica.expediente alter column tipoalergias type varchar(50);

INSERT INTO CLINICA.EXPEDIENTE VALUES
('P-0001', 'B POSITIVO', 'NA', 'NA', '2022-06-10'),
('P-0002', 'B NEGATIVO', 'ALERGIA AL POLVO', 'NA', '2022-06-10'),
('P-0003', 'O NEGATIVO', 'NA', 'DIABETES', '2022-06-14'),
('P-0004', 'B POSITIVO', 'ALERGIA A LOS MARISCOS', 'ASMA', '2022-06-15'),
('P-0005', 'B POSITIVO', 'NA', 'DIABETES', '2022-06-16'),
('P-0006', 'B POSITIVO', 'ALERGIA AL POLVO', 'NA', '2022-06-17'),
('P-0007', 'B POSITIVO', 'NA', 'CANCER', '2022-06-20'),
('P-0008', 'B POSITIVO', 'NA', 'NA', '2022-06-24'),
('P-0009', 'B POSITIVO', 'NA', 'NA', '2022-07-02'),
('P-0010', 'B POSITIVO', 'NA', 'NA', '2022-07-06');

select * from clinica.expediente;

--INSERTAR DATOS DE EXPEDIENTE_DIAGNOSTICO
INSERT INTO CLINICA.EXPEDIENTE_DIAGNOSTICO 
(fk_idespecialista, fk_idpaciente, edad, peso, altura, imc, nivelpeso, presionarterial, diagnostico, recetario, fechacreacion)
VALUES 
('ME-0001', 'P-0001', '24', '70', '1.70', '24.0', 'NORMAL', '120/70', 'NA', 'NA', '2022-11-22'),
('ME-0001', 'P-0002', '33', '80', '1.77', '27.0', 'SOBREPESO', '125/73', 'NA', 'NA', '2022-11-23'),
('ME-0001', 'P-0003', '45', '62', '1.64', '26.6', 'NORMAL', '130/70', 'NA', 'NA', '2022-11-24'),
('ME-0002', 'P-0003', '45', '62', '1.64', '26.6', 'NORMAL', '129/70', 'NA', 'NA', '2022-11-24'),
('ME-0002', 'P-0004', '23', '65', '1.60', '23.0', 'NORMAL', '125/70', 'NA', 'NA', '2022-11-25'),
('ME-0003', 'P-0005', '37', '90', '1.77', '29.0', 'OBESIDAD', '129/80', 'NA', 'NA', '2022-11-25'),
('ME-0003', 'P-0005', '37', '90', '1.77', '29.0', 'OBESIDAD', '128/78', 'NA', 'NA', '2022-11-25'),
('ME-0003', 'P-0006', '46', '72', '1.68', '24.0', 'NORMAL', '120/69', 'NA', 'NA', '2022-11-26'),
('ME-0003', 'P-0007', '31', '76', '1.77', '24.0', 'NORMAL', '125/73', 'NA', 'NA', '2022-11-27'),
('ME-0004', 'P-0007', '31', '76', '1.77', '24.0', 'NORMAL', '125/67', 'NA', 'NA', '2022-11-27'),
('ME-0004', 'P-0008', '21', '68', '1.63', '24.0', 'NORMAL', '119/69', 'NA', 'NA', '2022-11-29'),
('ME-0005', 'P-0009', '26', '90', '1.75', '29.0', 'SOBREPESO', '132/76', 'NA', 'NA', '2022-12-01'),
('ME-0005', 'P-0009', '26', '90', '1.75', '29.0', 'SOBREPESO', '130/74', 'NA', 'NA', '2022-12-01'),
('ME-0005', 'P-0010', '18', '60', '1.59', '23.0', 'NORMAL', '120/68', 'NA', 'NA', '2022-12-02'),
('ME-0005', 'P-0010', '18', '60', '1.59', '23.0', 'NORMAL', '119/65', 'NA', 'NA', '2022-12-02');

select * from clinica.expediente_diagnostico;



-- Update
select * from clinica.paciente;

update clinica.paciente set estado = 'MEXICO'; -- MAL, actualiza todos los registros

update clinica.paciente set estado = 'MEXICO'
	where pk_idPaciente = 'P-0004';
	
update clinica.paciente set ciudad = 'XALAPA' 
	where sexo = 'M' and estado = 'MONTERREY';
	
update clinica.paciente set ciudad = 'XALAPA'
	where sexo = 'F' or estado = 'MEXICO';
	
-- Delete
select * from clinica.paciente;

delete from clinica.paciente
	where pk_idPaciente = 'P-0009';
	

