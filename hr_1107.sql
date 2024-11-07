--EMPLOYEES 복사
CREATE TABLE EMP03
AS 
SELECT * FROM EMPLOYEES;
--모든 사원 부서번호 수정
SELECT * FROM EMP03;
UPDATE EMP03 SET DEPARTMENT_ID=30;
ROLLBACK;
--모든 사원 급여 10% 인상
UPDATE EMP03
SET SALARY = SALARY*1.1;
--입사일 오늘로 수정
UPDATE EMP03
SET HIRE_DATE = SYSDATE;
--부서번호가 10번인 사원 30번으로 수정
UPDATE EMP03
SET DEPARTMENT_ID = 30
WHERE DEPARTMENT_ID = 10;
--급여가 3000이상인 사원 급여 10% 인상
UPDATE EMP03
SET SALARY=SALARY*1.1
WHERE SALARY>=3000;
--2007년 입사 사원 입사일 오늘로 수정
UPDATE EMP03
SET HIRE_DATE = SYSDATE
WHERE SUBSTR(HIRE_DATE,1,2)='07';
--SUSAN 부서번호 20, 직급 FI_MGR로 수정
ROLLBACK;
UPDATE EMP03
SET DEPARTMENT_ID=20, JOB_ID='FI_MGR'
WHERE UPPER(FIRST_NAME)=UPPER('susan');

SELECT * FROM EMP03;
--
UPDATE EMP03
SET SALARY=17000,COMMISSION_PCT=0.45
WHERE UPPER(LAST_NAME)=UPPER('RUSSELL');
ROLLBACK;

DELETE FROM EMP03 WHERE DEPARTMENT_ID=30;
--
CREATE TABLE MY_CUSTOMER(
    CODE VARCHAR2(7),
    NAME VARCHAR2(10) CONSTRAINT MY_CUSTOMER_NAME_NN NOT NULL,
    GENDER CHAR(1) NOT NULL,
    BIRTHDAY VARCHAR2(8) NOT NULL,
    PHONE VARCHAR2(16)
);
ALTER TABLE MY_CUSTOMER ADD CONSTRAINT MY_CUSTOMER_CODE_PK PRIMARY KEY(CODE);
ALTER TABLE MY_CUSTOMER ADD CONSTRAINT MY_CUSTOMER_GENDER_CK CHECK(GENDER IN('M','W'));
ALTER TABLE MY_CUSTOMER ADD CONSTRAINT MY_CUSTOMER_PHONE_UK UNIQUE(PHONE);
DESC MY_CUSTOMER;
--UK 해제
ALTER TABLE CUSTOMER DROP CONSTRAINT CUSTOMER_EMAIL_UK;
--MERGE MY_CUSTOMER -> CUSTOMER 병합진행, 없으면 INSERT, 있으면 UPDATE
INSERT INTO MY_CUSTOMER 
VALUES ('2017108','박승대','M','19711430','010-2580-9919');
INSERT INTO MY_CUSTOMER 
VALUES ('2019302','전미래','W','19740812','010-8864-0232');
SELECT * FROM MY_CUSTOMER;

MERGE INTO CUSTOMER C 
    USING MY_CUSTOMER M
    ON (C.CUST_ID = M.CODE)
    WHEN MATCHED THEN
        UPDATE SET C.CUST_NAME=M.NAME, C.GENDER=M.GENDER, C.BIRTHDAY=M.BIRTHDAY, C.TEL=M.PHONE
    WHEN NOT MATCHED THEN
        INSERT (C.CUST_ID, C.CUST_NAME, C.GENDER, C.BIRTHDAY, C.TEL) VALUES(M.CODE,M.NAME,M.GENDER,M.BIRTHDAY,M.PHONE);
    
SELECT * FROM CUSTOMER;
SELECT * FROM MY_CUSTOMER;
UPDATE MY_CUSTOMER SET NAME ='박승우' WHERE NAME='박승대';

--제약조건 검색기능(외우기)
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'MY_CUSTOMER';
SELECT * FROM user_tables;
SELECT * FROM user_cons_columns WHERE TABLE_NAME='CUSTOMER';
DESC CUSTOMER;


DROP TABLE EMP01;


--
DROP TABLE DEPT01;
DROP TABLE MEMBER;
CREATE TABLE DEPT01(
    NO NUMBER(8),
    NAME VARCHAR2(10) NOT NULL,
    REGION VARCHAR2(10)
);
ALTER TABLE DEPT01 ADD CONSTRAINT DEPT01_NO_PK PRIMARY KEY(NO);
CREATE TABLE MEMBER(
    NO NUMBER(8),
    NAME VARCHAR2(10) NOT NULL,
    JOB_ID VARCHAR2(10),
    DEPT_NO NUMBER(8)
    );
ALTER TABLE MEMBER ADD CONSTRAINT MEMBER_NO_PK PRIMARY KEY(NO);
ALTER TABLE MEMBER ADD CONSTRAINT MEMBER_DEPT_NO_FK FOREIGN KEY(DEPT_NO) REFERENCES DEPT01(NO);

INSERT INTO DEPT01 VALUES(10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT01 VALUES(20, 'RESERACH', 'DALLAS');
INSERT INTO DEPT01 VALUES(30, 'SALES', 'CHICAGO');
INSERT INTO DEPT01 VALUES(40, 'OPERATIONS', 'BOSTON');

SELECT * FROM DEPT01;
SELECT * FROM MEMBER;

INSERT INTO MEMBER VALUES(7577, 'JONES', 'MANAGER', 40);
INSERT INTO MEMBER VALUES(7499, 'ALLEN', 'SALESMAN', 30);

DELETE FROM MEMBER WHERE DEPT_NO = 40;
DELETE FROM DEPT01 WHERE NO = 40;

ALTER TABLE MEMBER DROP CONSTRAINT MEMBER_DEPT_NO_FK;
ALTER TABLE MEMBER ADD CONSTRAINT MEMBER_DEPT_NO_FK FOREIGN KEY(DEPT_NO) REFERENCES DEPT01(NO) ON DELETE CASCADE ;
