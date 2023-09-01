-- hola mundo
create function clinica.HolaMundo() returns varchar(20) as $$
declare
	mensaje varchar(20) := 'Hola Mundo';
begin
	return mensaje;
end;
$$ language plpgsql;

select clinica.HolaMundo();
-------------------------------------------------------------

create or replace function clinica.HolaMundo2(mensaje varchar(20)) returns varchar(20) as $$

begin
	return mensaje;
end;
$$ language plpgsql;

select clinica.HolaMundo2('Hello');
------------------------------------------------------------

create or replace function clinica.SumaNumeros(num1 int, num2 int) 
returns int as $$
begin
	return num1 + num2;

end;
$$ language plpgsql;

select clinica.SumaNumeros(3,5);

-- if else
create or replace function clinica.NumeroMayorMenor(num1 int,num2 int)
returns varchar(30) as $$
begin
	if num1> num2 then
		return 'El numero ' || num1 || ' es mayor que el numero ' || num2;
	elseif num1 < num2 then
		return 'El numero ' || num1 || ' es menor que el numero ' || num2;
	else
		return 'Los numeros son iguales!';
	end if;
end;
$$ language plpgsql;

select clinica.NumeroMayorMenor(4,5)
select clinica.NumeroMayorMenor(6,5)
select clinica.NumeroMayorMenor(5,5)


-- case when
create or replace function clinica.MesesA(numMes int)
returns varchar(30) as $$
declare
	mensaje varchar(30) = 'El numero del mes es: ';
begin
	case
		when numMes = 1 then
			return mensaje || 'Enero.';
		when numMes = 2 then
			return mensaje || 'Febrero.';
		when numMes = 3 then
			return mensaje || 'Marzo.';
		when numMes = 4 then
			return mensaje || 'Abril.';
		when numMes = 5 then
			return mensaje || 'Mayo.';
		when numMes = 6 then
			return mensaje || 'Junio.';
		else
			return 'El numero no existe:';
		end case;
end;
$$ language plpgsql;

select clinica.MesesA(4);

-- for
create or replace function clinica.Loop(num int)
returns int as $$
declare 
	i int := 0;
begin
	for i in 1..num loop
		raise notice 'contador %', i;
	end loop;
end;
$$ language plpgsql;

select clinica.Loop(5);

--
create or replace function clinica.LoopInversa(num int)
returns int as $$
declare 
	i int := 0;
begin
	for i in reverse num..1 loop
		raise notice 'contador %', i;
	end loop;
end;
$$ language plpgsql;

select clinica.LoopInversa(5);
--
create or replace function clinica.Loop2(num int)
returns int as $$
declare 
	i int := 0;
begin
	for i in 1..num by 2 loop
		raise notice 'contador %', i;
	end loop;
end;
$$ language plpgsql;

select clinica.Loop2(10);


-- while
create or replace function clinica.While(num int)
returns int as $$
declare
	i int := 0;
begin
	while i < num loop
		raise notice 'Contador %',i;
		i = i + 1;
	end loop;
		
end;
$$ language plpgsql;


select clinica.While(6);
--
create or replace function clinica.WhilePar(num int)
returns int as $$
declare
	i int := 0;
begin
	while i < num loop
		if (i%2) = 0 then
			raise notice 'Contador %',i;
		end if;
		i = i + 1;
	end loop;
		
end;
$$ language plpgsql;


select clinica.WhilePar(6);