--PL/SQL
--EMPLOYEE에서 부서번호를 랜덤으로 생성한뒤 해당된 부서번호의 최고연봉을 출력한뒤, 평가하여라(낮음,높음,중간,최고,없음)
DECLARE
   VNUM1 NUMBER := 1;
   VNUM2 NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('****구구단 '||VNUM1||'단****');
        LOOP
            DBMS_OUTPUT.PUT_LINE(VNUM1||'*'||VNUM2||'='||(VNUM1*VNUM2));
            VNUM2 := VNUM2 + 1;
            IF(VNUM2>9) THEN
                EXIT;
            END IF;
        END LOOP;
        VNUM1 := VNUM1+1;
        VNUM2 := 1;
        IF(VNUM1 >9) THEN
            EXIT;
        END IF;
    END LOOP;
END;
/

--1. EMPLOYEES 테이블에 등록된 총사원의 수와 급여의 합, 급여의 평균을 변수를 대입하여 출력
DECLARE
    VCOUNT NUMBER;
    VSALARY_SUM NUMBER;
    VSALARY_AVG NUMBER;
BEGIN
    SELECT COUNT(*), SUM(SALARY), ROUND(AVG(SALARY)) INTO VCOUNT,VSALARY_SUM,VSALARY_AVG FROM EMPLOYEES;
    DBMS_OUTPUT.PUT_LINE('총사원의 수 : '||VCOUNT);
    DBMS_OUTPUT.PUT_LINE('급여의 합 : '||VSALARY_SUM);
    DBMS_OUTPUT.PUT_LINE('급여의 평균 : '||VSALARY_AVG);
END;
/

--2. Clara 사원의 직무,급여,입사일자,커미션,부서명을 변수에 대입하여 출력
DECLARE
    VFIRST_NAME EMPLOYEES.FIRST_NAME%TYPE;
    VJOB_ID EMPLOYEES.JOB_ID%TYPE;
    VSALARY EMPLOYEES.SALARY%TYPE;
    VHIRE_DATE EMPLOYEES.HIRE_DATE%TYPE;
    VCOMMISSION_PCT EMPLOYEES.COMMISSION_PCT%TYPE;
    VDEPARTMENT_NAME DEPARTMENTS.DEPARTMENT_NAME%TYPE;
BEGIN
    SELECT FIRST_NAME, JOB_ID, SALARY, HIRE_DATE, COMMISSION_PCT, DEPARTMENT_NAME
    INTO VFIRST_NAME, VJOB_ID, VSALARY, VHIRE_DATE, VCOMMISSION_PCT, VDEPARTMENT_NAME
    FROM EMPLOYEES E INNER JOIN DEPARTMENTS D ON e.department_id=d.department_id
    WHERE FIRST_NAME = 'Clara';

    DBMS_OUTPUT.PUT_LINE('이름 : '||VFIRST_NAME);
    DBMS_OUTPUT.PUT_LINE('직무 : '||VJOB_ID);
    DBMS_OUTPUT.PUT_LINE('급여 : '||VSALARY);
    DBMS_OUTPUT.PUT_LINE('입사일자 : '||VHIRE_DATE);
    DBMS_OUTPUT.PUT_LINE('커미션 : '||VCOMMISSION_PCT);
    DBMS_OUTPUT.PUT_LINE('부서명 : '||VDEPARTMENT_NAME);
END;
/

--PL/SQL
--EMPLOYEE에서 부서번호를 랜덤으로 생성한뒤 해당된 부서번호의 최고연봉을 출력한뒤, 평가하여라(낮음,높음,중간,최고,없음)
DECLARE
    -- 부서번호, 최고연봉 선언
    VNO NUMBER(4);
    VTOP_SALARY NUMBER(12,2);
    VRESULT VARCHAR2(20);
BEGIN
    --임의의 부서번호 생성(랜덤)
    VNO := ROUND(DBMS_RANDOM.VALUE(10,110),-1);
    SELECT SALARY INTO VTOP_SALARY
    FROM(SELECT SALARY FROM EMPLOYEES WHERE DEPARTMENT_ID = VNO ORDER BY SALARY DESC)
    WHERE ROWNUM <=1;
    --평가내리기 1~5000:낮음 5000~10000:중간 10000~20000:높음 20000~ 최고, 없으면 예외처리
    IF(VTOP_SALARY BETWEEN 1 AND 5000)THEN
        VRESULT := '낮음';
    ELSIF(VTOP_SALARY BETWEEN 5001 AND 10000)THEN
        VRESULT := '중간';
    ELSIF(VTOP_SALARY BETWEEN 10001 AND 20000)THEN
        VRESULT := '높음';
    ELSE
        VRESULT := '최고';
    END IF;
    DBMS_OUTPUT.PUT_LINE('부서번호: '||VNO);
    DBMS_OUTPUT.PUT_LINE('연봉: '||VTOP_SALARY);
    DBMS_OUTPUT.PUT_LINE('최고연봉평가: '||VRESULT);
    
EXCEPTION 
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE(VNO||' 해당 부서에 해당되는 사원이 없습니다.');
END;
/

SELECT SALARY, DEPARTMENT_ID FROM EMPLOYEES ORDER BY DEPARTMENT_ID, SALARY DESC;
SELECT ROWNUM, SALARY
    FROM(SELECT SALARY FROM EMPLOYEES WHERE DEPARTMENT_ID =  ORDER BY SALARY DESC)
    WHERE ROWNUM <=1;



SELECT ROUND(DBMS_RANDOM.VALUE(1,5),0)FROM DUAL;
SELECT DBMS_RANDOM.STRING('A',5) FROM DUAL;

SELECT ROWNUM, SALARY,DEPARTMENT_ID,FIRST_NAME
FROM(SELECT SALARY,DEPARTMENT_ID,FIRST_NAME FROM EMPLOYEES WHERE DEPARTMENT_ID = 50 ORDER BY SALARY DESC)
WHERE ROWNUM >=1;

--PL/SQL
--DEPARTMENTS에서 반복문을 이용해서 부서 10~90 정보를 출력
DECLARE
    VDEP DEPARTMENTS%ROWTYPE;    
BEGIN
    FOR I IN REVERSE 1..9 LOOP
        SELECT * INTO VDEP FROM DEPARTMENTS WHERE DEPARTMENT_ID=I*10;
        DBMS_OUTPUT.PUT_LINE(VDEP.DEPARTMENT_ID||'  /  '||VDEP.DEPARTMENT_NAME);
    END LOOP;
END;
/
SELECT * FROM DEPARTMENTS WHERE DEPARTMENT_ID=10;

--PL/SQL
--FOR IN LOOP 구구단 작성하기
DECLARE
    VDAN NUMBER;
    VCOUNT NUMBER;
BEGIN
    FOR VDAN IN 1..9 LOOP
        DBMS_OUTPUT.PUT_LINE(VDAN||'단');
        FOR VCOUNT IN 1..9 LOOP
                DBMS_OUTPUT.PUT_LINE(VDAN||'X'||VCOUNT||'='||VDAN*VCOUNT);
        END LOOP;
    END LOOP;
END;
/
--PL/SQL
--DEPARTMENTS 테이블에 전체내용을 CURSOR 저장하고 패치해서 전체정보를 출력
DECLARE
    VDEP DEPARTMENTS%ROWTYPE;
--    CURSOR C1 IS SELECT * FROM DEPARTMENTS;
BEGIN
    FOR VDEP IN (SELECT * FROM DEPARTMENTS) LOOP
            DBMS_OUTPUT.PUT_LINE(VDEP.DEPARTMENT_ID||'/'||VDEP.DEPARTMENT_NAME);
    END LOOP;
    /*
    OPEN C1;
    LOOP
        FETCH C1 INTO VDEP;
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(VDEP.DEPARTMENT_ID||'/'||VDEP.DEPARTMENT_NAME);
    END LOOP;
    CLOSE C1;
    */
END;
/
