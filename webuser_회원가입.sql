CREATE TABLE LOGIN(
    NO NUMBER(5),
    NAME VARCHAR2(15) NOT NULL,
    ID VARCHAR2(15) NOT NULL,
    PASSWORD VARCHAR2(20) NOT NULL,
    PHONE VARCHAR2(14) NOT NULL,
    ADDRESS VARCHAR2(50) NOT NULL
);

alter table LOGIN add constraint LOGIN_NO_PK primary key (NO);
alter table LOGIN add constraint LOGIN_ID_UQ UNIQUE(ID);

CREATE SEQUENCE MEMBER_SEQ
    START WITH 1
    INCREMENT BY 1;
    
INSERT INTO LOGIN VALUES(LOGIN_SEQ.NEXTVAL, 'KIM','ID','PWD','PHONE','ADDRESS');

DROP TABLE LOGIN;
delete from login;
select * from login;
SELECT * FROM LOGIN WHERE ID = 'admin';

ALTER TABLE LOGIN ADD PHONE VARCHAR2(50);
ALTER TABLE LOGIN ADD ADDRESS VARCHAR2(100);
ALTER TABLE LOGIN ADD NAME VARCHAR2(50);
delete from member;

create table ACCOUNT(
    NO         NUMBER(5,0) NOT NULL,
    NAME     VARCHAR2(20) NOT NULL,
    ID     VARCHAR2(4000) NOT NULL,
    PWD     VARCHAR2(4000) NOT NULL,
    REGDATE   DATE NOT NULL
);
SELECT * FROM ACCOUNT;
INSERT INTO ACCOUNT VALUES(1, 'AAA', 'AAA', 'AAA', SYSDATE);
alter table ACCOUNT add constraint ACCOUNT_NO_PK primary key (NO);
alter table ACCOUNT add constraint ACCOUNT_ID_UQ UNIQUE(ID);

SELECT PWD FROM ACCOUNT WHERE ID = 'AAA';
INSERT INTO ACCOUNT VALUES((select NVL(max(no),0)+1 from ACCOUNT),1,2,3,SYSDATE);
commit;

------------------------------------------
-- jsp 회원가입 테이블
CREATE TABLE SIGNUP (
    ID VARCHAR2(12) ,                         -- 아이디 (4~12자의 영문 대소문자와 숫자)
    PWD VARCHAR2(12) NOT NULL,                -- 비밀번호 (4~12자의 영문 대소문자와 숫자)
    EMAIL VARCHAR2(100) NOT NULL,             -- 이메일 주소
    NAME VARCHAR2(50) NOT NULL,               -- 이름
    BIRTH NUMBER(10)                          -- 생년월일 (20001010)
);

ALTER TABLE SIGNUP ADD CONSTRAINT SIGNUP_ID_PK PRIMARY KEY(ID);

SELECT * FROM SIGNUP;

-- jsp로그인테이블
CREATE TABLE LOGIN2(
    ID VARCHAR2(12),
    PWD VARCHAR2(12) NOT NULL
);
ALTER TABLE LOGIN2 ADD CONSTRAINT LOGIN2_ID_PK PRIMARY KEY(ID);

DROP TABLE LOGIN2;

--김동욱 login 테이블
CREATE table LOGIN2 (
    ID         VARCHAR2(30) not null,
    PASS      VARCHAR2(30) NOT NULL,
    name varchar2(30) not null
);
alter table login2 add constraint login2_id_pk primary key(id);
select * from login2;
