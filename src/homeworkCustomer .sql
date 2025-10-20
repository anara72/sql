CREATE TABLE customer
(   id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    contactName VARCHAR NOT NULL,
    address VARCHAR NOT NULL,
    city VARCHAR NOT NULL,
    postalCode VARCHAR UNIQUE,
    country VARCHAR NOT NULL
);
Бардык клиенттердин шаарлары уникалдуу чыксын
SELECT DISTINCT c.city
FROM customers c;
Туулган жылы 1950 жана 1960 - жылдардын арасындагы ишкерлер чыксын
Франциялык поставщиктердин аттары жана мамлекети чыксын
SELECT s.comtactname AS supplier_name,
       s.country
FROM suppliers s
WHERE s.country = 'France';
Олкосу Испаниядан башка, аты “A” дан башталган клиенттердин аты, адресси жана олкосу чыксын
SELECT c.contactname AS customer_name,
       c.address,
       c.country
FROM customers c
WHERE c.country <> 'Spain'
  AND c.companyname LIKE 'A%';
PostalCode бош болгон клиенттер чыксын
SELECT c.customerid,
       c.contactname,
       c.address,
       c.city,
       c.postalcode,
       c.country
FROM customers c
WHERE c.postalcode IS NULL
   OR TRIM(c.postalcode) = '';
Лондондон болгон клиенттердин биринчи эки клиентин чыгаргыла
SELECT TOP 2 CustomerName, City
FROM (
    SELECT c.CustomerID, c.CustomerName, c.City
    FROM Customers AS c
    INNER JOIN Orders AS o ON c.CustomerID = o.CustomerID
    WHERE c.City = 'London'
    GROUP BY c.CustomerID, c.CustomerName, c.City
) AS UniqueLondonCustomers
ORDER BY CustomerID;
Фамилиясы 4 тамгадан турган ишкерлердин аты жана туулган жылдары чыксын
SELECT e.firstname,
       e.lastname,
       EXTRACT(YEAR FROM e.birthdate) AS birth_year
FROM employees e
WHERE CHAR_LENGTH(e.lastname) = 4;
Ар бир олкодо канчадан поставщик бар экенин чыгаргыла
SELECT s.country,
       COUNT(*) AS supplier_count
FROM suppliers s
GROUP BY s.country
ORDER BY supplier_count DESC;
Поставщиктердин саны 1 эле болгон өлкөлөрдү аты менен сорттоп чыгаргыла

WITH single_country AS (
    SELECT country
    FROM suppliers
    GROUP BY country
    HAVING COUNT(*) = 1
)
SELECT s.country,
       s.companyname AS supplier_name
FROM suppliers s
         JOIN single_country sc ON s.country = sc.country
ORDER BY s.companyname;
Ар бир категориядагы продуктылардын жалпы суммасын чыгаргыла
SELECT c.categoryid,
       c.categoryname,
       COUNT(p.productid) AS product_count,
       SUM(COALESCE(p.unitsinstock, 0)) AS total_units_in_stock
FROM categories c
         LEFT JOIN products p ON c.categoryid = p.categoryid
GROUP BY c.categoryid, c.categoryname
ORDER BY c.categoryid;
 6 жана 8 категориясындагы продуктылардын эң арзан баасын жана атын чыгаргыла
WITH min_price AS (
    SELECT categoryid, MIN(unitprice) AS min_price
    FROM products
    WHERE categoryid IN (6, 8)
    GROUP BY categoryid
)
SELECT p.categoryid,
       c.categoryname,
       p.productname,
       p.unitprice
FROM products p
         JOIN min_price m ON p.categoryid = m.categoryid
    AND p.unitprice = m.min_price
         JOIN categories c ON p.categoryid = c.categoryid
ORDER BY p.categoryid;
️ Продуктылар жана алардын поставщиктеринин аттары чыксын

SELECT p.productid,
       p.productname,
       s.companyname AS supplier_name
FROM products p
         JOIN suppliers s ON p.supplierid = s.supplierid
ORDER BY p.productname;
Продуктылар жана алардын поставщиктеринин аттары чыксын(сортировка болсун)
SELECT Products.ProductName, Suppliers.SupplierName
FROM Products
         INNER JOIN Suppliers
                    ON Products.SupplierID= Suppliers.SupplierID
ORDER BY Products.ProductName;
Ар бир поставщиктин канчадан продуктысы бар экени кемуу тартибинде сорттолуп чыксын
SELECT s.supplierid,
       s.companyname,
       COUNT(p.productid) AS product_count
FROM suppliers s
         LEFT JOIN products p ON p.supplierid = s.supplierid
GROUP BY s.supplierid, s.companyname
ORDER BY product_count DESC, s.companyname;
Клиенттердин аты CustomerName деп,
ага саткан ишкерлердин аты жана
алар кандай служба доставки колдонгону тууралуу маалымат чыксын

SELECT DISTINCT
    c.companyname AS customer_name,
    e.firstname || ' ' || e.lastname AS employee_name,
    sh.companyname AS shipper_name
FROM orders o
         JOIN customers c ON o.customerid = c.customerid
         JOIN employees e ON o.employeeid = e.employeeid
         JOIN shippers sh ON o.shipvia = sh.shipperid
ORDER BY c.companyname, employee_name;

Кайсы ишкер канча клиент обслуживайтеткен чыксын
SELECT e.firstname || ' ' || e.lastname AS employee_name,
       COUNT(DISTINCT o.customerid) AS unique_customer_count
FROM employees e
         LEFT JOIN orders o ON e.employeeid = o.employeeid
GROUP BY e.employeeid, e.firstname, e.lastname
ORDER BY unique_customer_count DESC, employee_name;







