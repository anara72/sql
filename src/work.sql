create table works(
    id serial primary key,
    name varchar not null

);
alter table works
 add column foundation_date date;

alter table works
add  column age int;
alter table works
add column address varchar;
alter table  works
add column ferst_name varchar;

alter table works
add column last_name varchar;
alter table works
drop column address;
