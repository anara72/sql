CREATE TABLE Reader
 (
    id            SERIAL PRIMARY KEY,
    full_name     VARCHAR(100)        NOT NULL,
     gender        VARCHAR(10) CHECK (gender IN ('male', 'female')),
    email         VARCHAR(100) UNIQUE NOT NULL,
    date_of_birth DATE                NOT NULL
 );
INSERT INTO Reader (full_name, gender, email, date_of_birth)
VALUES ('Elnura Arapova', 'female', 'elnura@gmail.com', '2002-05-20'),
       ('Sanjar Suanbekov', 'male', 'sanjar@gmail.com', '1995-03-14'),
       ('Chyngyz Zalkarbekov', 'male', 'chyngyz@gmail.com', '1999-10-30'),
       ('Symbat Salyamov', 'male', 'symbat@gmail.com', '1990-11-11'),
       ('Fatima Altynbek kyzy', 'female', 'fati@gmail.com', '2001-07-22'),
       ('Baitenir Busurmanov', 'male', 'baitenir@gmail.com', '1988-01-05'),
       ('Sanjar Orozobekov', 'male', 'sanjar.o@gmail.com', '1994-06-09'),
       ('Nurpazyl Nabiev', 'male', 'nurpazyl@gmail.com', '1998-02-14'),
       ('Junusbek Abdurahmanov', 'male', 'junus@gmail.com', '2004-01-14'),
       ('Abdulkudus Imarov', 'male', 'abdu@gmail.com', '1998-12-14'),
       ('Artur Rakhmanov', 'male', 'artur@gmail.com', '2000-09-04');



CREATE TABLE Book
(
    id             SERIAL PRIMARY KEY,
    book_name      VARCHAR(100) NOT NULL,
    genre          VARCHAR(50),
    published_year INT,
    price          NUMERIC(10, 2),
    is_booked      BOOLEAN DEFAULT false
);

INSERT INTO Book (book_name, genre, published_year, price, is_booked)
VALUES ('War and Peace', 'Historical', 1869, 1500.00, true),
       ('Harry Potter', 'Fantasy', 2001, 900.00, false),
       ('Clean Code', 'Programming', 2008, 1200.00, true),
       ('1984', 'Dystopian', 1949, 800.00, false),
       ('Python Crash Course', 'Programming', 2016, 1300.00, false),
       ('The Great Gatsby', 'Classic', 1925, 950.00, true),
       ('The Hobbit', 'Fantasy', 1937, 1000.00, false),
       ('Sapiens', 'History', 2011, 1600.00, true);

CREATE TABLE Author
(
    id        SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    gender    VARCHAR(10) CHECK (gender IN ('male', 'female')),
    book_id   INT REFERENCES Book (id)
);
INSERT INTO Author (full_name, gender, book_id)
VALUES ('Leo Tolstoy', 'male', 1),
       ('J.K. Rowling', 'female', 2),
       ('Robert C. Martin', 'male', 3),
       ('George Orwell', 'male', 4),
       ('Eric Matthes', 'male', 5),
       ('F. Scott Fitzgerald', 'male', 6),
       ('J.R.R. Tolkien', 'male', 7),
       ('Yuval Noah Harari', 'male', 8);


CREATE TABLE Library
(
    id        SERIAL PRIMARY KEY,
    name      VARCHAR(100) NOT NULL,
    book_id   INT REFERENCES Book (id),
    reader_id INT REFERENCES Reader (id)
);
INSERT INTO Library (name, book_id, reader_id)
VALUES ('Central Library', 1, 1),
       ('Youth Library', 2, 2),
       ('Tech Library', 3, 3),
       ('City Library', 4, 4),
       ('IT Library', 5, 5),
       ('Classic Library', 6, 6),
       ('Children Library', 7, 7),
       ('Historical Library', 8, 8),
       ('Central Library', 2, 9),
       ('Tech Library', 5, 10),
       ('Youth Library', 6, 11),
       ('City Library', 1, 2);
-- Task (Query) Library
-- 1. Получить все записи с таблицы Library
select * from Library;

select l.id, l.name, b.*  from Library l join Book b on l.book_id = b.id
where l.id = 1;
-- 2. Найти библиотеки, где читабт авторов мужского пола
select l.name, a.full_name, a.gender from Library l
                                              join Book b on l.book_id = b.id
                                              join Author a on b.id = a.book_id
where a.gender = 'male';
-- 3. Подсчитать количество книг в каждой библиотеке
select l.name , count(b.id) as book_count from Library l
                                                   join Book b on l.book_id = b.id group by l.name;
-- 4. Получить библиотеки вместе с названием книг
select l.* , b.book_name from Library l
                                  join Book b on l.book_id = b.id;
-- 5. Получить библиотеки и полные имена читателей
select l.* , r.full_name from Library l
                                  join Reader r on l.reader_id = r.id;
-- 6. Вывести библиотеки которые забронированы (is_booked = true)
select * from Library l
                  join Book b on l.book_id = b.id where b.is_booked = true;
-- 7. Вывести библиотеки, где читатель - женщина
select * from Library l
                  join Reader r on l.reader_id = r.id where r.gender = 'female';
-- 8. Получить библиотеку и автора ее книг
select l.* , a.full_name , a.book_id from Library l
                                              join Author a on a.book_id = l.book_id;
-- 9. Вывести библиотеки, у которых книги стоят больше 1000
select l.* , b.book_name , b.price from  Library l
                                             join Book b on l.book_id = b.id
where b.price > 1000;
- Task (Query) Reader
-- 1. Получить всех читателей
select * from Reader;
-- 2. Читатели и библиотеки, где они зарегистрированы:
select r.full_name , l.name from Reader r
                                     join Library l on r.id = l.reader_id;
-- 3.Читатели и названия книг, которые они читают
select r.full_name, b.book_name, l.id from Reader r
                                               left join Library l on r.id = l.reader_id
                                               left join Book b on l.book_id = B.id;
-- 4.Получить читателей и книги, которые они читают
select r.full_name, b.book_name from Reader r
                                         join Library l on r.id = l.reader_id
                                         join Book b on l.book_id = b.id;
-- 5.Читатели и авторы прочитанных книг
select r.full_name, a.full_name from Reader r
                                         join Library l on l.reader_id = r.id
                                         join Book b on l.book_id = b.id
                                         join Author a on b.id = a.book_id;
-- 6.Вывести читателей, читающих определённый жанр
SELECT r.full_name, b.genre FROM Reader r
                                     JOIN Library l on l.reader_id = r.id
                                     JOIN Book b on l.book_id = b.id;
-- 7.Получить всех читателей, читающих книги, изданные после 2010
SELECT r.full_name, b.published_year FROM Reader r
                                              JOIN Library l on l.reader_id = r.id
                                              JOIN Book b on l.book_id = b.id
WHERE b.published_year > 2010;
-- 8.Найти читателей, у которых книги написаны женщинами
SELECT r.full_name, a.full_name, a.gender FROM Reader r
                                                   JOIN Library l on r.id = l.reader_id
                                                   JOIN Book b on l.book_id = b.id
                                                   JOIN Author a on b.id = a.book_id
WHERE a.gender = 'female';
--Tasks(Query) Book
--1.Получить все книги
SELECT * FROM Book;
--2.Книги и библиотеки, где они находятся
SELECT b.book_name, l.name AS librari_name, FROM Book b
                                                               JOIN Library l on b.id = l.book_id;
--3.Получить книги и авторы
SELECT b.book_name, a.full_name AS Author FROM Book b
                                                   JOIN Author a ON b.id = a.book_id;
--4.Получить книги и читатели
SELECT b.book_name, r.full_name AS reader FROM Book b
                                                   JOIN Library l ON b.id = l.book_id
                                                   JOIN Reader r ON l.reader_id = r.id;
--5.Книги, изданные после 2010 года
SELECT book_name, published_year FROM Book
WHERE published_year > 2010;
--6.Книги с определенным жанром
SELECT book_name, genre FROM Book
WHERE genre = 'Fantasy';
--7.Книги, которые забронированы
SELECT book_name FROM Book
WHERE is_booked = true;
--8.Количество книг по жанрам
SELECT genre, COUNT(*) AS total_books FROM Book
GROUP BY genre;
--9.Книга и библиотека, отсортированные по цене
SELECT b.book_name, l.name AS library_name, b.price FROM Book b
                                                             JOIN Library l ON b.id = l.book_id
ORDER BY b.price ASC;

select * from Author;
select a.full_name, b.book_name from Author a
    join Book b ON a.id = a.id;
select a.full_name as author_name, l.name as library_name
from Author a
join Book b ON a.id = a.id
join Library l ON l.id = b.id;
select a.full_name as author_name,Reader.name as library_name
from Author a join Reader r. on l.id = reader_id;
select a.full_name as author_name,
       r.full_name as reader_name
from Author a
join Book b ON a.id = a.id
join Reader r ON b.id = b.id;
select a.full_name as author_name from Author a
left join Book B on B.id = a.book_id
where b.id is null;
select  a.full_name as author_name
from Author a join Book B on b.id =a.book_id
 where b.is_booked = false or b.is_booked is null;
select distinct a.full_name as author_name
from Author a join Book B on a.id = a.book_id
where b.genre = 'Programming';
select * from Author order by full_name;
select  b.book_name,b.price from Book b
join Library l on l.book_id = l.id order by b.price desc;











