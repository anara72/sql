create table publishers
(
    id   serial primary key,
    name varchar
);
insert into (name)
values
create table languages(
    id serial primary key,
    languages varchar
);
insert into (languager)
values
create type gender as enum ('Male','Female');
create table authors(
    id serial primary key,
    first_name varchar,
    last_name varchar,
    email varchar,
    data_of_ birth date,
    county varchar,
    gender gender
);
insert into (first_name,last_name,email,data_of_birth,county,gender)
values
create type genre as enum ('DETECTIVE','ROMANTIC','HORROR');
create table  books
(
    id             serial primary key,
    name           varchar,
    country        varchar,
    published_year date,
    price          numeric,
    gender         gender,
   publishers_Id int references publishers(id);
   languages_id int references languages(Id);
    authors_id int references authors(id)
      );
 insert into (name,country,publisher_year,price,gender,  )


select gender sum(price) from books where gender in ('ROMANTIC','DETECTIVE')group by gender;
select gender,min(price) from books where gender in ('ROMANTIC','HORROR')group by gender;
select b.name,p.name,l.language from books