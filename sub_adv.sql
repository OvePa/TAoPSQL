-- subqueries
select * from pg_tables where schemaname = 'general_hospital';

select *
from (select * from general_hospital.patients
      where date_of_birth >= '2000-01-01'
      order by master_patient_id) p
where p.name ilike 'm%';

select * 
from (select * from general_hospital.surgical_encounters
      where surgical_admission_date between '2016-11-01' and '2016-11-30') se
inner join (
	select master_patient_id
	from general_hospital.patients
	where date_of_birth >= '1990-01-01'
	) p on se.master_patient_id = p.master_patient_id;
	
-- common table expressions(CTE's)

with young_patients as (
	select * 
	from general_hospital.patients
	where date_of_birth >= '2000-01-01'
)

select * from young_patients
where name ilike 'm%';


with top_counties as (
	select county, count(*) as num_patients
	from general_hospital.patients
	group by county
	having count(*) > 1500
	),
	county_patients as (
	select 
		p.master_patient_id,
		p.county
	from general_hospital.patients p
	inner join top_counties t on
		p.county = t.county
	)
select 
p.county,count(s.surgery_id) as num_surgery
from general_hospital.surgical_encounters s
inner join county_patients p
on s.master_patient_id = p.master_patient_id
group by p.county;


-- subqueries for comparisons
with total_cost as (
	select 
		surgery_id,
		sum(resource_cost )as total_surgery_cost
	from general_hospital.surgical_costs
	group by surgery_id
) 
select *
from total_cost
where total_surgery_cost > (
	select avg(total_surgery_cost)
	from total_cost
);


select * 
from general_hospital.vitals
where
	bp_diastolic > (select min(bp_diastolic) from general_hospital.vitals)
	and bp_systolic < (select max(bp_systolic) from general_hospital.vitals)

























