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