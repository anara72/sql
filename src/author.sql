CREATE TABLE job
(
    id         SERIAL PRIMARY KEY,
    profession VARCHAR NOT NULL
);

 CREATE TABLE  employee
 (
     id            SERIAL PRIMARY KEY,
     first_name    VARCHAR NOT NULL,
     last_name     VARCHAR,
     email         VARCHAR UNIQUE,
     data_of_birth DATE ,
     job_id        INT REFERENCES job (id)
 );

DROP TABLE employee;

  INSERT INTO job (profession)
  VALUES
      ('Xiryrg'),
      ('Okulist'),
      ('Terapevt'),
      ('Pediatr');

DROP TABLE job;


INSERT INTO employee (first_name, last_name, email, data_of_birth, job_id)

    VALUES
    ( 'Syltan','Ismailov', 'e@syltam', '2000-11-01',1),
    ('Anara ','Acanbekova','a@amny', '2001-10-02', 2),
      ('Asan ','Asanov', 'ddd@dd','2002-09-03',3),
      ('Mipa ', 'Mypatova','e@eeee','2004-08-02',4);