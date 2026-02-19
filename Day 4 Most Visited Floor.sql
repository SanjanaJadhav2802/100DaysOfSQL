create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR');

select * from entries;

-- we need to find out total visit, most visited floor and resources used

with visit_count as
(select name,count(name) as total_visits
 from entries
group by name),

floor_rank as
(
select name,floor,count(*) as visited_floor, 
rank() over (partition by name order by count(*) desc) as rn
from entries
group by name,floor
),
distinct_resources as (
select distinct name, resources from entries
)

select v.name,v.total_visits,f.floor as most_visted_floor,
string_agg(d.resources,',') as resources_used
from visit_count v inner join floor_rank f
on v.name = f.name and f.rn = 1
inner join distinct_resources d 
on v.name = d.name
group by v.name,v.total_visits,f.floor




