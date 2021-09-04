/* Question 10 */

create table "Teams".sudent (
	id uuid not null default uuid_generate_v4(),
	team_id uuid not null default uuid_generate_v4(),
	freelancer_id uuid not null default uuid_generate_v4(),
	hours_worked int not null,
	primary key(id),
	foreign key(team_id) references "Teams".team(id),
	foreign key(freelancer_id) references "Freelancers".freelancer(id)
);


/* Question 12 */

insert into "Freelancers".availability 
(availability_name, id)
values ("Free", uuid_generate_v4());


/* Question 13 */

/*Add new column*/
alter table student 
add new_col varchar(20);

/*Drop a column*/
alter table student 
drop hours_worked;


/* Question 14 */

drop table student;


/* Question 17 - Part a */

select s.skill_name, sl."level" 
from freelancer f inner join has_skill hs on f.id = hs.freelancer_id 
inner join skill s on hs.skill_id = s.id 
inner join skill_level sl on sl.id = hs.skill_level_id 
where f.user_name = 'eliza';


/* Question 17 - Part b */

select p.id, p.project_name 
from "Customers_&_Projects".project p
where p.id not in (select o.project_id
					from "Teams".on_project o);


/* Question 17 - Part c */	

select count(*) as success_count
from project p inner join project_outcome po on p.project_outcome_id = po.id
where po.is_completed_successfully = TRUE;


/* Question 17 - Part d */	

select distinct s.skill_name 
from "Teams".team t inner join "Teams".team_member tm on t.id = tm.team_id 
inner join "Freelancers".freelancer f on tm.freelancer_id = f.id
inner join "Freelancers".has_skill hs on hs.freelancer_id = f.id
inner join "Freelancers".skill s on hs.skill_id = s.id 
where t.id = '7ed69e89-cd26-4611-b261-eb796a052015';


/* Question 17 - Part e */	

select count(distinct f.user_name)
from "Freelancers".freelancer f, "Teams".team t1, "Teams".team t2, 
"Teams".team_member tm1, "Teams".team_member tm2
where f.id = tm1.freelancer_id and f.id = tm2.freelancer_id 
and tm1.team_id = t1.id and tm2.team_id = t2.id and t1.id <> t2.id;


/* Question 17 - Part f */	

select f.user_name, count(*) as success_count
from "Freelancers".freelancer f inner join "Teams".team_member tm on f.id = tm.freelancer_id 
inner join "Teams".team t on t.id = tm.team_id 
inner join "Teams".on_project o on o.team_id = t.id 
inner join "Customers_&_Projects".project p on p.id = o.project_id 
inner join "Customers_&_Projects".project_outcome po on po.id = p.project_outcome_id 
where po.is_completed_successfully = TRUE
group by f.user_name
order by count(*) desc 
limit 1;


/* Question 17 - Part g */	

CREATE OR REPLACE FUNCTION status_count (status varchar(20), username varchar(20))
RETURNS integer AS $total$
declare
	total integer;
begin
	select count(*) into total
	from "Freelancers".freelancer f inner join "Teams".team_member tm on f.id = tm.freelancer_id 
	inner join "Teams".team t on t.id = tm.team_id 
	inner join "Teams".on_project o on o.team_id = t.id 
	inner join "Customers_&_Projects".project p on p.id = o.project_id 
	inner join "Customers_&_Projects".project_outcome po on po.id = p.project_outcome_id
	where f.user_name = username and
		((status = 'success' and po.is_completed_successfully = TRUE)
		or (status = 'failure' and po.is_completed_unsuccessfull = TRUE));
   RETURN total;
END;
$total$ LANGUAGE plpgsql;

create or replace view Freelancer_Score as
select f.user_name , 
	status_count('success', f.user_name) * 2 - status_count('failure', f.user_name) * 3 as score
from "Freelancers".freelancer f;

select * from Freelancer_Score;


/* Question 17 - Part h */				

/* Question 1 */
select c.customer_name , p.project_name 
from customer c  left outer join project p on c.id = p.customer_id;	

/* Question 2 */	
select s.skill_name 
from project p inner join skill_required sr on p.id = sr.project_id 
inner join "Freelancers".skill s on s.id = sr.skill_id 
where p.project_name = 'bobolestan';