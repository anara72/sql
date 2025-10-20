create table devices(
    id serial primary key,
    product_name varchar,
    product_company varchar,
    price int
);
insert into devices (product_name,product_company,price)
values  ('Apple iPhone 15', 'Apple', 50000),
    ('Galaxy S24', 'Samsung', 45000),
    ('ThinkPad X1', 'Lenovo', 60000),
    (' laptop MacBook Air', 'Apple', 75000),
    ('Redmi Note 13', 'Xiaomi', 30000);

create table customers(
    id serial primary key,
    name varchar
);
insert into customers (name)
values ('John Smith'),
    ('Emily Brown'),
    ('Michael Johnson'),
    ('Sarah Davis'),
    ('Robert Wilson');

create table cheques
(
    id               serial primary key,
    devices_id       int references devices (id),
    customers_id     int references customers (id),
    price            int,
    date_of_purchase date
);
insert into cheques(devices_id, customers_id, price, date_of_purchase)
values
(1, 1, 50000, '2024-05-10'),
(2, 3, 45000, '2024-06-15'),
(3, 2, 60000, '2024-07-20'),
(4, 5, 75000, '2024-08-05'),
(5, 4, 30000, '2024-09-01');

select distinct c.name from customers c
join cheques ch ON c.id = ch.customers_id
join devices d ON ch.devices_id = d.id
where d.price > (select avg(price) from devices);
select * from devices where id not in
     (select d.product_company from devices d
    join cheques ch ON ch.id = ch.devices_id);
SELECT devices from devices where id in
    (select devices_id from cheques group by devices_id having count(*)>1);
select  distinct c.name from customers c
join cheques ch ON c.id = ch.customers_id where ch.devices_id in
    (select id from devices where price = (select max(price) from devices));
 select c.name from customers c join cheques c2 on c.id = c2.customers_id ;
       (select devices from devices where product_name ='Apple');
select name from customers where id not in
  (select distinct ch.customers_id from cheques ch
 join devices d ON ch.devices_id = d.id where d.price < 500);

SELECT name
FROM customers
WHERE id IN (
    SELECT ch.customers_id
    FROM cheques ch
             JOIN devices d ON ch.devices_id = d.id
    GROUP BY ch.customers_id
    HAVING SUM(d.price) > (
        SELECT AVG(total_sum)
        FROM (
                 SELECT SUM(d2.price) AS total_sum
                 FROM cheques ch2
                          JOIN devices d2 ON ch2.devices_id = d2.id
                 GROUP BY ch2.customers_id
             ) AS sub
    )
);

select devices from devices where id =
  (select devices_id from cheques group by  devices_id order by count(*) desc limit 1);
select  d.product_name, price from devices d where price >
    (select avg(d.price) from devices d where d.product_name =d.price);
select name from customers where id in (select ch.customers_id from cheques ch
 join devices d ON ch.devices_id = d.id
    where d.product_name = 'Laptop');
 select name from customers where id in (select ch.customers_id from cheques ch
 join devices d ON ch.devices_id = d.id group by ch.customers_id
  having count(distinct d.product_company) = 1);
select devices product_name from devices where id in (select devices_id from cheques
  group by devices_id having count(distinct customers_id) = (select count(*) from customers));





