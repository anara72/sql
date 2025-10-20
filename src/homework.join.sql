create table department
(
    id   serial
        primary key,
    name varchar not null
);
create table employees
(
    id      serial
        primary key,
    name    varchar not null,
    salary  integer,
    dept_id integer
        references department
);

select name, salary from employees
where salary >
      (select avg(salary) from employees);

select dept_id, count(*) as emp_count
from (select dept_id from employees) as sub
group by dept_id;

select e.name, d.name from employees as e
                               join department as d on e.dept_id = d.id;

select e.name,
       (select name from department where id = e.dept_id)
from employees as e;


select name, salary from employees where salary =
                                         (select max(salary) from employees);

insert into employees(name, salary, dept_id)
values ('Aibiyke', 39000,
        (select id from department where name = 'IT')
       );




