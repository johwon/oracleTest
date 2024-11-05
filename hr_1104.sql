-- hr resource 있는 테이블 정보(프로젝트 클래스 종류)
select * from tab;
-- employees 테이블 구조 보여주기
desc employees;
-- employees 속에 들어있는 레코드(객체) 보여주기
select * from employees;
-- departments 테이블 객체(레코드=인스턴스) 확인
select * from departments;
-- departments 구조 확인
desc departments;
-- departments의 특정 필드만 보고싶음
select department_id, department_name from departments;

--필드명에 별칭 사용하기
select department_id as "부서번호", department_name as "부서명" from departments;
select department_id as "dept_id", department_name as "dept_name" from departments;
-- + ||
select '5' + 5 from dual;
select '5'|| 5 from dual;
-- 문자열 기능을 이용해서 필드명을 보여주기
select first_name, job_id from employees;
select first_name || '의 직급은 ' || job_id || '입니다.' from employees;
select first_name || '의 직급은 ' || job_id || '입니다.' AS DATA from employees;
--중복되지않게 보여주기 DISTINCT
SELECT DISTINCT JOB_ID FROM EMPLOYEES;
SELECT *
FROM EMPLOYEES;
SELECT  FIRST_NAME, LAST_NAME, SALARY, HIRE_DATE FROM EMPLOYEES;

--연봉을 3000이상 받는 사람 정보
SELECT * 
FROM EMPLOYEES 
WHERE SALARY>=3000;

DESC EMPLOYEES;
--2008년 이후 입사한 직원 정보
SELECT * FROM EMPLOYEES WHERE HIRE_DATE >= '2008/01/01';
SELECT * FROM EMPLOYEES WHERE TO_CHAR(HIRE_DATE, 'YYYY/MM/DD') >= '2008/01/01';
SELECT * FROM EMPLOYEES WHERE HIRE_DATE >= TO_DATE('2008/01/01','YYYY/MM/DD HH24:MI:SS');

--AND, BETWEEN A AND B
SELECT * FROM EMPLOYEES WHERE SALARY >= 2000 AND SALARY <= 3000;
SELECT * FROM EMPLOYEES WHERE SALARY BETWEEN 2000 AND 3000;
-- OR, IN(,) 직원번호 67, 101, 184
SELECT * FROM employees WHERE employee_id = 67 OR employee_id = 101 OR employee_id = 184;
SELECT * FROM employees WHERE employee_id IN(67, 101, 184);

--NULL 연산, 비교, 할당 안됨
SELECT 100 + NULL FROM DUAL;
DESC EMPLOYEES;
SELECT * FROM EMPLOYEES;
SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT = NULL;
SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT IS NULL;
SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT IS NOT NULL;






