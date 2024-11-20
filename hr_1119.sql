--employees
SELECT * FROM EMPLOYEES;
desc employees;

DROP TABLE BOOKS;
CREATE TABLE books (
    id number(4), 
    title varchar2(50), 
    publisher varchar2(30), 
    year varchar2(10), 
    price number(6)
);
ALTER TABLE BOOKS ADD CONSTRAINTS BOOKS_ID_PK PRIMARY KEY(ID);

CREATE SEQUENCE BOOKS_ID_SEQ
START WITH 1
INCREMENT BY 1;

DESC BOOKS;
SELECT * FROM USER_CONS_COLUMNS WHERE TABLE_NAME = 'BOOKS';
select * from books;

INSERT INTO books VALUES (books_id_seq.nextval, 'Operating System Concepts', 'Wiley', '2003',30700);
INSERT INTO books VALUES (books_id_seq.nextval, 'Head First PHP and MYSQL', 'OReilly', '2009', 58000);
INSERT INTO books VALUES (books_id_seq.nextval, 'C Programming Language', 'Prentice-Hall', '1989', 35000);
INSERT INTO books VALUES (books_id_seq.nextval, 'Head First SQL', 'OReilly', '2007', 43000);
commit;

DELETE FROM BOOKS WHERE ID = 1;
commit;

UPDATE BOOKS SET TITLE = 'KKK', PUBLISHER = 'JAVA', YEAR = '2024', PRICE = 33000 WHERE ID = 3;
commit;

rollback;

