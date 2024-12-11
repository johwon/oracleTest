CREATE SEQUENCE visit_seq  -- 시퀀스이름
   START WITH 1             -- 시작을 1로 설정
   INCREMENT BY 1          -- 증가 값을 1씩 증가
   NOMAXVALUE             -- 최대 값이 무한대
   NOCACHE
   NOCYCLE;

CREATE table VISIT (
    NO         NUMBER(5,0) NOT NULL,
    WRITER     VARCHAR2(20) NOT NULL,
    MEMO       VARCHAR2(4000) NOT NULL,
    REGDATE    DATE NOT NULL
);

ALTER TABLE VISIT ADD CONSTRAINTS VISIT_NO_PK PRIMARY KEY(NO);

INSERT INTO VISIT VALUES(VISIT_SEQ.NEXTVAL, 'YS', '처음으로 메모장 입력', SYSDATE);
SELECT * FROM VISIT;
select * from visit order by no desc;


--로그인 테이블 생성
CREATE TABLE LOGIN(
    ID VARCHAR2(12) NOT NULL,
    PASS VARCHAR2(12) NOT NULL
);
ALTER TABLE LOGIN ADD CONSTRAINTS LOGIN_ID_PK PRIMARY KEY(ID);

select * from login;

--TEMPMEMBER
CREATE TABLE  "TEMPMEMBER" (
    "ID" VARCHAR2(20), 
    "PASSWD" VARCHAR2(20), 
    "NAME" VARCHAR2(20), 
    "MEM_NUM1" VARCHAR2(6), 
    "MEM_NUM2" VARCHAR2(7), 
    "E_MAIL" VARCHAR2(30), 
    "PHONE" VARCHAR2(30), 
    "ZIPCODE" VARCHAR2(7), 
    "ADDRESS" VARCHAR2(60), 
    "JOB" VARCHAR2(30)
   );
ALTER TABLE TEMPMEMBER ADD CONSTRAINTS TEMPMEMBER_ID_PK PRIMARY KEY(ID);   
   
insert into tempMember values('aaaa', '1111', '홍길동', '123456', '7654321', 
'hong@hanmail.net', '02-1234', '100-100', '서울', '프로그래머');
insert into tempMember values('bbbb', '1111', '홍길동', '123456', '7654321', 
'hong@hanmail.net', '02-1234', '100-100', '서울', '프로그래머');
insert into tempMember values('cccc', '1111', '홍길동', '123456', '7654321', 
'hong@hanmail.net', '02-1234', '100-100', '서울', '프로그래머');
SELECT * FROM TEMPMEMBER;
COMMIT;
   
   
--학생 테이블
CREATE table "STUDENT" (
    "ID"           VARCHAR2(12)  NOT NULL,
    "PASS"        VARCHAR2(12)  NOT NULL,
    "NAME"       VARCHAR2(10)  NOT NULL,
    "PHONE1"     VARCHAR2(3)   NOT NULL,
    "PHONE2"     VARCHAR2(4)   NOT NULL,
    "PHONE3"     VARCHAR2(4)   NOT NULL,
    "EMAIL"       VARCHAR2(30)  NOT NULL,
    "ZIPCODE"    VARCHAR2(7)   NOT NULL,
    "ADDRESS1"   VARCHAR2(120) NOT NULL,
    "ADDRESS2"   VARCHAR2(50)  NOT NULL
 );
 ALTER TABLE STUDENT ADD CONSTRAINTS STUDENT_ID_PK PRIMARY KEY(ID);   
 SELECT COUNT(*) AS COUNT FROM STUDENT WHERE ID = 'aaa';
 SELECT * FROM STUDENT;

--우편번호 테이블
create table zipcode  (
   seq                  NUMBER(10)  not null,
   zipcode              VARCHAR2(50),
   sido                 VARCHAR2(50),
   gugun                VARCHAR2(50),
   dong                 VARCHAR2(50),
   bunji                VARCHAR2(50)
 );
 ALTER TABLE zipcode ADD CONSTRAINTS zipcode_SEQ_PK PRIMARY KEY(SEQ);   
ALTER TABLE ZIPCODE MODIFY BUNJI VARCHAR2(100);
select * from zipcode where dong like '구%';

SELECT * FROM ZIPCODE;
DROP TABLE CUSTOMER;

--개인 회원가입 테이블
CREATE TABLE CUSTOMER(
    ID          VARCHAR2(15),
    PWD         VARCHAR2(15) NOT NULL,
    NAME        VARCHAR2(15) NOT NULL,
    PHONE1      VARCHAR2(3)   NOT NULL,
    PHONE2      VARCHAR2(4)   NOT NULL,
    PHONE3      VARCHAR2(4)   NOT NULL,
    EMAIL       VARCHAR2(50)   NOT NULL,
    ZIPCODE     VARCHAR2(7)   NOT NULL,
    ADDRESS1    VARCHAR2(100)  NOT NULL,
    ADDRESS2    VARCHAR2(50)    NOT NULL
);
ALTER TABLE CUSTOMER ADD CONSTRAINTS CUSTOMER_ID_PK PRIMARY KEY(ID); 
SELECT * FROM CUSTOMER;
SELECT * FROM CUSTOMER WHERE ID='a';
SELECT * FROM CUSTOMER;

SELECT * FROM ZIPCODE WHERE DONG = '강남%'
