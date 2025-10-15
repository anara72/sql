CREATE TABLE hotel
(
    id          SERIAL PRIMARY KEY,
    name        VARCHAR NOT NULL,
    address     VARCHAR NOT NULL,
    numberPhone VARCHAR,
    email       VARCHAR UNIQUE
);


INSERT INTO hotel (name, address, numberPhone, email)
VALUES ('Golden Palace', 'Bishkek, Chuy Ave 10', '+996500123456', 'info@goldenpalace.kg'),
       ('Ala-Too Hotel', 'Bishkek, Soviet St 55', '+996555987654', 'contact@alatoo.kg'),
       ('Asia Mountains', 'Bishkek, Togolok Moldo 34', '+996700654321', 'booking@asiamount.kg');

CREATE TABLE employee
(
    id         SERIAL PRIMARY KEY,
    first_name VARCHAR NOT NULL,
    last_name  VARCHAR NOT NULL,
    age        INT,
    data       DATE,
    email      VARCHAR UNIQUE,
    hotel      INTEGER REFERENCES hotel (id)
);
INSERT INTO employee (first_name, last_name, age, data, email, hotel)
VALUES  ('Aibek', 'Samatov', 29, '2023-04-15','Aibek@hotel.kg' , 1),
        ('Meerim', 'Toktobekova', 32, '2022-09-10', 'meerim@hotel.kg', 2),
        ('Nurbek', 'Bekov', 25, '2024-01-22', 'nurbek@hotel.kg', 1),
        ('Aizada', 'Kadyrova', 27, '2023-02-11', 'aizada@hotel.kg', 3),
        ('Ruslan', 'Abdiev', 35, '2021-12-01', 'ruslan@hotel.kg', 2),
        ('Gulzat', 'Asanova', 30, '2023-07-19', 'gulzat@hotel.kg', 3),
        ('Emil', 'Turatov', 26, '2024-03-05', 'emil@hotel.kg', 1),
        ('Nazira', 'Tilekova', 28, '2023-10-09', 'nazira@hotel.kg', 2),
        ('Bakyt', 'Kubatov', 40, '2022-05-30', 'bakyt@hotel.kg', 3),
        ('Ainura', 'Muratbekova', 31, '2024-06-18', 'ainura@hotel.kg', 2);

CREATE TABLE menedger
(   id SERIAL PRIMARY KEY,
    first_name VARCHAR,
    last_name VARCHAR,
    hotel_id INT REFERENCES hotel(id),
    employee_id int references employee(id)
);

INSERT INTO menedger(first_name, last_name, hotel_id, employee_id)
VALUES ('Aibek', 'Samatov', 1,  1),
       ('Meerim', 'Toktobekova', 2, 2),
       ('Nurbek', 'Bekov', 3, 3);

CREATE TABLE housmin
(
    id         SERIAL PRIMARY KEY,
    first_name VARCHAR,
    hotel_id   INT REFERENCES hotel (id),
    employee_id int references employee(id)
);
insert into housmin(first_name, hotel_id, employee_id)
values  ('Aizada', 2, 4),
        ('Ruslan', 3, 5),
        ('Gulzat', 3,  6),
        ('Emil', 2, 7),
        ('Nazira', 2, 8),
        ('Bakyt', 1, 9),
        ('Ainura',1 ,10);


CREATE TABLE users
(
    id         SERIAL PRIMARY KEY,
    first_name VARCHAR NOT NULL,
    last_name  VARCHAR NOT NULL,
    birth_date DATE,
    email      VARCHAR UNIQUE,
    hotel_id   INT REFERENCES hotel (id)
);


INSERT INTO users (first_name, last_name, birth_date, email, hotel_id)
VALUES
    ('Aijan', 'Erkinbaeva', '1995-03-12', 'aijan@hotel.kg', 1),
    ('Ulan', 'Tursunov', '1990-07-25', 'ulan@hotel.kg', 2),
    ('Meerim', 'Toktomamatova', '1998-11-03', 'meerim@hotel.kg', 3),
    ('Bakyt', 'Bekbolotov', '1987-04-17', 'bakyt@hotel.kg', 1),
    ('Nurzhan', 'Satarov', '1993-09-29', 'nurzhan@hotel.kg', 1),
    ('Ainura', 'Omurbekova', '1996-02-08', 'ainura@hotel.kg', 3),
    ('Ruslan', 'Kadyrov', '1992-06-20', 'ruslan@hotel.kg', 2),
    ('Gulzat', 'Tilekova', '1997-10-14', 'gulzat@hotel.kg', 1),
    ('Emil', 'Abdiev', '1994-01-05', 'emil@hotel.kg', 2),
    ('Zhyldyz', 'Samatova', '1999-08-23', 'zhyldyz@hotel.kg', 3);

CREATE TABLE cinema
(
    id          SERIAL PRIMARY KEY,
    name        VARCHAR NOT NULL,
    address     VARCHAR,
    numberPhone VARCHAR,
    email       VARCHAR UNIQUE
);
INSERT INTO cinema(name, address, numberPhone, email)
VALUES ('Cinema Paradise', '123 Main St, Bishkek', '+996700123456', 'info@cinemaparadise.kg'),
       ('Silver Screen', '456 Elm St, Osh', '+996700654321', 'contact@silverscreen.kg'),
       ('Golden Reel', '789 Pine St, Jalal-Abad', '+996700987654', 'hello@goldenreel.kg'),
       ('Star Movies', '321 Oak St, Karakol', '+996700112233', 'support@starmovies.kg'),
       ('Movie Hub', '654 Maple St, Naryn', '+996700445566', 'info@moviehub.kg');
CREATE TABLE movie
(
    id        SERIAL PRIMARY KEY,
    name      VARCHAR NOT NULL,
    cinema_id INT REFERENCES cinema (id)
);

INSERT INTO movie(name, cinema_id)
VALUES ('The Great Adventure', 1),
       ('Sunset Dreams', 2),
       ('Mystery Night', 3),
       ('Star Chasers', 1),
       ('Hidden Secrets', 4);


CREATE TABLE producer
(
    id          SERIAL PRIMARY KEY,
    first_name  VARCHAR NOT NULL,
    last_name   VARCHAR NOT NULL,
    numberPhone VARCHAR,
    email       VARCHAR UNIQUE,
    movie_id    INT REFERENCES movie(id)
);

INSERT INTO producer(first_name, last_name, numberPhone, email,movie_id)
VALUES ('Aida', 'Samatova', '+996700111222', 'aida.samatova@example.kg',1),
       ('Ermek', 'Tursunov', '+996700333444', 'ermek.tursunov@example.kg',2),
       ('Nazira', 'Bekmamatova', '+996700555666', 'nazira.bekmamatova@example.kg',3),
       ('Bektur', 'Aitbaev', '+996700777888', 'bektur.aitbaev@example.kg',1),
       ('Ainura', 'Zholdoshova', '+996700999000', 'ainura.zholdoshova@example.kg',2);

CREATE TABLE actor
(
    id          SERIAL PRIMARY KEY,
    first_name  VARCHAR NOT NULL,
    last_name   VARCHAR NOT NULL,
    numberPhone VARCHAR,
    email       VARCHAR UNIQUE,
    movie_id     INT REFERENCES movie(id)

);
DROP TABLE actor;
INSERT INTO actor(first_name, last_name, numberPhone, email,movie_id)
VALUES ('Bekzat', 'Akmatov', '+996700111223', 'bekzat.akmatov@example.kg',1),
       ('Aigerim', 'Sadykova', '+996700334455', 'aigerim.sadykova@example.kg',2),
       ('Ruslan', 'Zheenbekov', '+996700556677', 'ruslan.zheenbekov@example.kg',3),
       ('Meerim', 'Tashbaeva', '+996700778899', 'meerim.tashbaeva@example.kg',1),
       ('Erbol', 'Muratov', '+996700990011', 'erbol.muratov@example.kg',2);



CREATE TABLE ticket
(
    id        SERIAL PRIMARY KEY,
    number    VARCHAR UNIQUE,
    cinema_id INT REFERENCES cinema (id)
);
DROP TABLE ticket;
INSERT INTO ticket(number, cinema_id)
VALUES
    ('123', 1),
    ('124', 2),
    ('125', 3),
    ('126', 4),
    ('127', 5);






