--STORED PROCEDURE
--프로시저를 통해서 사원번호를 입력하면 사원 이름, 월급, 직책을 매개변수를 통해 전달
CREATE OR REPLACE PROCEDURE EMP_PROC_OUTMODE(
    VEMPNO IN EMPLOYEES.EMPLOYEE_ID%TYPE,
    VNAME OUT EMPLOYEES.FIRST_NAME%TYPE,
    VSALARY OUT EMPLOYEES.SALARY%TYPE,
    VJOB_ID OUT EMPLOYEES.JOB_ID%TYPE)
IS
    --지역변수
BEGIN
    SELECT FIRST_NAME,SALARY,JOB_ID INTO VNAME, VSALARY, VJOB_ID 
    FROM EMPLOYEES WHERE EMPLOYEE_ID=VEMPNO;
END;
/

SELECT FIRST_NAME,SALARY,JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID=100;


DECLARE
    VNAME VARCHAR2(100);
    VIEW_ROWTYPE EMPLOYEES%ROWTYPE;
BEGIN
    EMP_PROC_OUTMODE( 200, 
    VNAME,
    VIEW_ROWTYPE.SALARY,
    VIEW_ROWTYPE.JOB_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : '||VNAME);
    DBMS_OUTPUT.PUT_LINE('월급 : '||VIEW_ROWTYPE.SALARY);
    DBMS_OUTPUT.PUT_LINE('직책 : '||VIEW_ROWTYPE.JOB_ID);
END;
/

--프로시저를 워크시트에서 불러서 사용
VARIABLE VNAME VARCHAR2(100)
VARIABLE VSALARY NUMBER(10)
VARIABLE VJOBID VARCHAR2(100)
EXECUTE EMP_PROC_OUTMODE(100, :VNAME, :VSALARY, :VJOBID);
PRINT VNAME;
PRINT VASALARY;


--PROCEDURE IN OUT MODE 동시사용
CREATE OR REPLACE PROCEDURE PROC_INOUTMODE(VSALARY IN OUT VARCHAR2)
IS
BEGIN
    VSALARY := TO_CHAR(VSALARY, '$999999999');
    VSALARY := '$'||SUBSTR(VSALARY, -9, 3)||','||SUBSTR(VSALARY, -6, 3)||','||SUBSTR(VSALARY, -3, 3);
END;
/

DECLARE
    VSALARY VARCHAR2(20) := '123456789';
BEGIN
    PROC_INOUTMODE(VSALARY);
    DBMS_OUTPUT.PUT_LINE('VSALARY : '||VSALARY);
END;
/