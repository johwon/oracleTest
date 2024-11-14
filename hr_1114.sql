--PL/SQL
--EMPLOYEE에 MANAGER_ID가 NULL인 사원의 사원번호, 이름, 업무명, 부서번호 출력(레코드 변수 활용)
DECLARE
    --레코드타입(사원번호, 이름, 업무명, 부서번호)
    TYPE EMP_RECORD_TYPE IS RECORD(
        VEMPLOYEE_ID EMPLOYEES.EMPLOYEE_ID%TYPE,
        VFIRST_NAME EMPLOYEES.FIRST_NAME%TYPE,
        VJOB_ID EMPLOYEES.JOB_ID%TYPE,
        VDEPARTMENT_ID EMPLOYEES.DEPARTMENT_ID%TYPE
    );
    --레코드 타입 변수 선언
    EMP_RECORD EMP_RECORD_TYPE;
BEGIN
    SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, DEPARTMENT_ID 
    INTO EMP_RECORD
    FROM EMPLOYEES
    WHERE MANAGER_ID IS NULL;
    DBMS_OUTPUT.PUT_LINE('사원번호: '||EMP_RECORD.VEMPLOYEE_ID);
    DBMS_OUTPUT.PUT_LINE('이름: '||EMP_RECORD.VFIRST_NAME);
    DBMS_OUTPUT.PUT_LINE('업무명: '||EMP_RECORD.VJOB_ID);
    DBMS_OUTPUT.PUT_LINE('부서번호: '||EMP_RECORD.VDEPARTMENT_ID);
END;
/

DECLARE  
    --로우 타입 변수 선언
    EMP_RECORD EMPLOYEES%ROWTYPE;
BEGIN
    SELECT * 
    INTO EMP_RECORD
    FROM EMPLOYEES
    WHERE MANAGER_ID IS NULL;
    DBMS_OUTPUT.PUT_LINE('사원번호: '||EMP_RECORD.EMPLOYEE_ID);
    DBMS_OUTPUT.PUT_LINE('이름: '||EMP_RECORD.FIRST_NAME);
    DBMS_OUTPUT.PUT_LINE('업무명: '||EMP_RECORD.JOB_ID);
    DBMS_OUTPUT.PUT_LINE('부서번호: '||EMP_RECORD.DEPARTMENT_ID);
END;
/

SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, DEPARTMENT_ID FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;