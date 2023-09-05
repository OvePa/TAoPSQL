-- directorios
show data_directory;

--windows, en cmd
pg_ctl -D 'c:/ruta' status -- ver el estado del servidor
pg_ctl -D 'c:/ruta' restart -- reiniciar el servidor
pg_ctl -D 'c:/ruta' stop -- detener el servidor
pg_ctl -D 'c:/ruta' start -- iniciar el servidor

-- archivo bat
pg_ctl

-- cambiar sistema
max_connections; -- se busca en el archivo postgresql.conf
show max_connections;
alter system set max_connections = '250'; -- consola de postgresql

-- resetear
alter system reset max_connetions;

--mensajes
lc_messages -- se busca en el archivo postgresql.conf
alter systema set lc_messages = 'en_US.UTF-8'; -- cambiarlos a ingles
show lc_messages -- consola de postgresql

-- archivos log
-- vistas del sistema
select * from pg_views;
select * from pg_user;


-- analizar consulta
explain analyze
select * from clinica.paciente;


explain (format json)
select * from clinica.paciente;


-- indices

explain analyze
select edad, peso,altura from clinica.expediente_diagnostico;

create index Edad_Peso_Altura on clinica.expediente_diagnostico(edad,peso,altura);

select * from pg_indexes where schemaname = 'clinica';

drop index clinica.Edad_Peso_Altura;

--tablespace
select * from pg_tablespace;

select * from pg_tables where schemaname = 'clinica';


create tablespace ts_ejemplo location 'c:/ts';

create table clinica.ejemplo(i int);
alter table clinica.ejemplo set tablespace ts_ejemplo;

drop tablespace ts_ejemplo;

-- backup
-- buscar la carpeta de instalacion y la de bin, entrar a cmd en esa ruta
-- postgreSQL/14/bin
pg_dump -C -f 'c:\ruta-donde-guardar' -U usuario_que_la_crea nombre_respaldo -- respaldo por volcado


--por cmd
psql -U usuario_que_la_crea < 'c:\ruta-donde-guardar.dump'



-- migracion a sql server
-DMToolkit