-- roles, usuarios y permisos

-- dba
create role dba with superuser;
grant usage on schema clinica to dba;
grant all privileges on all tables in schema clinica to dba with grant option;
create user administrador with password '12345' in role dba;

-- jefe especialista
create role jefe_especialista;
grant usage on schema clinica to jefe_especialista;

grant select, insert,update
on clinica.expediente, clinica.expediente_diagnostico, clinica.especialista
to jefe_especialista with grant option;

grant delete on clinica.especialista to jefe_especialista with grant option;

create user jefe_especialista_1 with password '12345' connection limit 1 in role jefe_especialista;

-- especialista
create role especialista;
grant usage on schema clinica to especialista;

grant select, insert, update
on clinica.expediente, clinica.expediente_diagnostico, clinica.paciente
to especialista with grant option;

create user especialista_1 with password '12345' connection limit 1 in role especialista;


-- recepcionista
create role recepcionista;
grant usage on schema clinica to recepcionista;

grant select, insert, update
on clinica.paciente, clinica.cita, clinica.agendar_cita
to recepcionista with grant option;

grant delete on clinica.paciente
to recepcionista with grant option;

create user recepcionista_1 with password '12345' connection limit 1 in role recepcionista;


-- revocar permisos, borrar usuarios y roles

drop role recepcionista;

revoke select, insert, update
on clinica.paciente, clinica.cita, clinica.agendar_cita
from recepcionista;

revoke delete on clinica.paciente from recepcionista;

revoke usage on schema clinica from recepcionista;

drop user recepcionista_1;

