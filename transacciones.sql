\c Clinica_2; --conectar a la base de datos, el nombre de la BD
\d -- ver las tablas
set search_path to clinica; -- para buscar las tablas, se pone el nombre del schema

-- Iniciar transaccion
begin transaction; -- poner ;
--OPERACIONES
savepoint nombre_sp; -- salvar en un punto
rollback to nombre_sp; -- regresar al punto guardado
ROOLBACK; -- SI HAY ALGO MAL Y NO SE QUIEREN GUARDAR LOS CAMBIOS
COMMIT; -- SI SE VAN A GUARDAR TODOS LOS CAMBIOS