--순위함수 RANK(), DENSE_RANK(), ROWNUM
--ROWNUM 순위구하기 (공동순위 없음) 
DROP TABLE EMP02;
CREATE TABLE EMP02
AS
SELECT * FROM EMPLOYEES;
SELECT ROWNUM, FIRST_NAME, SALARY FROM EMP02 ORDER BY SALARY DESC;

SELECT ROWNUM, FIRST_NAME, SALARY
FROM (SELECT FIRST_NAME, SALARY FROM EMP02 ORDER BY SALARY DESC);

--RANK(), DENSE_RANK() 공동순위 구하기
SELECT RANK()OVER(ORDER BY SALARY DESC) AS RANK, FIRST_NAME, SALARY 
FROM EMPLOYEES ORDER BY SALARY DESC;

SELECT DENSE_RANK()OVER(ORDER BY SALARY DESC) AS DENSE_RANK, FIRST_NAME, SALARY 
FROM EMPLOYEES ORDER BY SALARY DESC;

SELECT ROWNUM, DENSE_RANK()OVER(ORDER BY SALARY DESC) AS DENSE_RANK, RANK()OVER(ORDER BY SALARY DESC) AS RANK, FIRST_NAME, SALARY 
FROM (SELECT FIRST_NAME, SALARY FROM EMP02 ORDER BY SALARY DESC);

--중복순위 없애기
SELECT DENSE_RANK()OVER(ORDER BY SALARY DESC, COMMISSION_PCT DESC, EMPLOYEE_ID DESC) AS DENSE_RANK, 
FIRST_NAME, SALARY, COMMISSION_PCT, EMPLOYEE_ID
FROM EMPLOYEES ORDER BY SALARY DESC;

--부서별 순위 구하기
SELECT DEPARTMENT_ID, RANK()OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC, COMMISSION_PCT DESC, DEPARTMENT_ID DESC) AS RANK, 
FIRST_NAME, SALARY, COMMISSION_PCT
FROM EMPLOYEES ORDER BY DEPARTMENT_ID, SALARY DESC, COMMISSION_PCT;

--ROWNUM 규칙 **
--2PAGE m_page_no = 2 # 페이지번호 
--num_page_size = 10 # 한페이지출력개수(사이즈) 
--num_start_row = ((num_page_no-1) * num_page_size) + 1  # 출력 페이지 시작 행 (ex. 11) 
--num_end_row = (num_page_no * num_page_size)          

SELECT ROWNUM, E.* FROM EMPLOYEES E WHERE ROWNUM BETWEEN 11 AND 20;

--순위구하기1 (속도 느림)
SELECT * FROM (SELECT ROWNUM AS RNUM, E.* FROM EMPLOYEES E)
WHERE RNUM BETWEEN 11 AND 20;

--순위구하기2 (속도 빠름)
SELECT * FROM (SELECT ROWNUM AS RNUM, E.* FROM EMPLOYEES E WHERE ROWNUM <= 110)
WHERE RNUM >= 100;