--학과  (01-컴퓨터학과 / 02-교육학과 / 03-신문방송학과 / 04-인터넷비즈니스과 / 05-기술경영과)
create table subject( 
    no number,                  --pk, sequence
    num varchar2(2) not null,   --학과번호 01, 02, 03, 04, 05
    name varchar2(24) not null --학과이름
);
ALTER TABLE SUBJECT ADD CONSTRAINTS SUBJECT_NO_PK PRIMARY KEY(NO);
ALTER TABLE SUBJECT ADD CONSTRAINTS SUBJECT_NUM_UK UNIQUE(NUM);

CREATE SEQUENCE SUBJECT_SEQ
START WITH 1
INCREMENT BY 1;

select * from subject;
insert into subject(no, num, name) values (subject_seq.nextval, ?, ?);

UPDATE SUBJECT SET NAME = '네트워크'  WHERE NUM = '03';

--동일학과번호 총갯수
SELECT LPAD(COUNT(*)+1,4,'0') AS TOTAL_COUNT FROM STUDENT WHERE S_NUM = 10;
--학생
create table student( 
    no number not null,             --pk,seq
    num varchar2(8) not null,       --학번(년도+학과+번호)   
    name varchar2(12) not null,     --이름
    id varchar2(12) not null,       --아이디
    passwd varchar2(12) not null,   --패스워드
    s_num varchar2(2) not null,     --학과번호(fk)
    birthday varchar2(8) not null,  --생년월일
    phone varchar2(15) not null,    --전화번호
    address varchar2(80) not null,  --주소
    email varchar2(40) not null,    --이메일
    s_date date default sysdate     --등록일
);

ALTER TABLE STUDENT ADD CONSTRAINTS STUDENT_NO_PK PRIMARY KEY(NO);
ALTER TABLE STUDENT ADD CONSTRAINTS STUDENT_NUM_UK UNIQUE(NUM);
ALTER TABLE STUDENT ADD CONSTRAINTS STUDENT_ID_UK UNIQUE(ID);
ALTER TABLE STUDENT ADD CONSTRAINTS STUDENT_SUBJECT_NUM_FK
    FOREIGN KEY(S_NUM) REFERENCES SUBJECT(NUM) ON DELETE SET NULL;
ALTER TABLE STUDENT DROP CONSTRAINTS STUDENT_SUBJECT_NUM_FK;

SELECT * FROM STUDENT;
INSERT INTO STUDENT VALUES(STUDENT_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE);

CREATE SEQUENCE STUDENT_SEQ
START WITH 1
INCREMENT BY 1;

--SUBJECT STUDENT INNER JOIN
SELECT STU.NO,STU.NUM,STU.NAME,ID,PASSWD,S_NUM,SUB.NAME AS S_NAME,BIRTHDAY,PHONE,ADDRESS,EMAIL,S_DATE 
FROM STUDENT STU INNER JOIN SUBJECT SUB ON STU.S_NUM = SUB.NUM;

--LESSON 과목
create table lesson( 
    no NUMBER,                      --PK SEQ
    abbre varchar2(2) not null,     --과목 별칭
    name varchar2(20) not null      --과목 이름
);

ALTER TABLE LESSON ADD CONSTRAINTS LESSON_NO_PK PRIMARY KEY(NO);
ALTER TABLE LESSON ADD CONSTRAINTS LESSON_ABBRE_UK UNIQUE(ABBRE);

CREATE SEQUENCE LESSON_SEQ
START WITH 1
INCREMENT BY 1;

-- TRAINEE 수강신청
drop table trainee;
create table trainee( 
    no number ,                     --pk seq
    s_num varchar2(8) not null,    --FK(STUDENT) 학생번호
    abbre varchar2(2) not null,     --FK(LESSON) 과목별칭
    section varchar2(20) not null,  --전공,부전공,교양
    registdate date default sysdate    --수강신청일
);

ALTER TABLE trainee ADD CONSTRAINTS trainee_NO_PK PRIMARY KEY(NO);
ALTER TABLE trainee ADD CONSTRAINTS trainee_student_NUM_FK
    FOREIGN KEY(s_num) REFERENCES student(NUM) ON DELETE SET NULL;
ALTER TABLE trainee ADD CONSTRAINTS trainee_lesson_abbre_FK
    FOREIGN KEY(abbre) REFERENCES lesson(abbre) ON DELETE SET NULL;

    

create sequence trainee_seq 
start with 1
increment by 1;
