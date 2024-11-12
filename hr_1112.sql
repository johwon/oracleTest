--susan 부서아이디 보기
select department_id from employees where first_name = 'Susan';

--부서테이블에서 부서명 조회
select department_name from departments where department_id = 40;

--susan 소속되어있는 부서명
select * from employees where first_name = 'Susan';
select * from departments where department_id = 40;

--join
select e.first_name, d.department_name
from employees e inner join departments d on d.department_id = e.department_id
where e.first_name = 'Susan';

--단일행은 비교,크기,연산이 가능하다
--다중행은 비교,크기,연산 불가능하다(IN=OR, ANY=1개이상, ALL=모두, EXITS)
select department_id from employees where first_name = 'Susan';
select * from departments where department_id = (select department_id from employees where first_name = 'Susan');

--EMPLOYEES 테이블에서 Lex와 같은 부서에 있는 모든 사원의 이름과 입사일자(형식: 1981-11-17)를 출력
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 90;
SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Lex';
SELECT FIRST_NAME, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') FROM EMPLOYEES WHERE DEPARTMENT_ID =(SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Lex');

SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;

SELECT * FROM EMPLOYEES 
WHERE MANAGER_ID=(SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE MANAGER_ID IS NULL);

SELECT ROUND(AVG(SALARY),1) AS 평균연봉 FROM EMPLOYEES;
SELECT ROUND(AVG(SALARY),1) AS 평균연봉 FROM EMPLOYEES GROUP BY DEPARTMENT_ID;
--평균연봉보다 높은사람의 정보
SELECT * FROM EMPLOYEES WHERE SALARY > (SELECT ROUND(AVG(SALARY),1) AS 평균연봉 FROM EMPLOYEES);
--다중행이면 비교 가능?
SELECT * FROM EMPLOYEES WHERE SALARY > ANY(SELECT ROUND(AVG(SALARY),1) AS 평균연봉 FROM EMPLOYEES GROUP BY DEPARTMENT_ID);

--테이블복사
create table imsiTBL
as select * from employees where 1=1; --or 1=0

--연봉 13000 이상인 사람의 부서를 보여줘
select distinct department_id from employees where salary >= 13000;
select * from employees where department_id in(90,80,20);
select * from employees where department_id in(select distinct department_id from employees where salary >= 13000);

select salary from employees where first_name in('Susan', 'Lex'); --다중행--

select first_name, job_id, salary from employees 
where salary in(select salary from employees where first_name in('Susan', 'Lex')) 
and first_name not in('Lex', 'Susan');

--한명이상으로부터 보고를 받는다 = 나는 매니저로 등록되어있다. ceo는 null
select distinct manager_id as 상사 from employees;

select employee_id, first_name, job_id, department_id from employees
where employee_id in(select distinct manager_id from employees);

--EMPLOYEES 테이블에서 Accounting 부서에서 근무하는 직원과 같은 업무를 하는 직원의 이름, 
--업무명를 출력하는 SELECT문을 작성하시오.
select job_id from employees where department_id = 110;
select first_name, job_id from employees 
where job_id in(select job_id from employees where department_id = (select department_id from departments where department_name = 'Accounting'));
select department_id from departments where department_name = 'Accounting';

--EXIST
select * from employees where department_id = 110;
--테이블 복사
drop table emp02;
create table emp02
as
select employee_id, first_name from employees;
select * from emp02;

--서브쿼리 이용해서 데이터 복사
--구조만 복사 departments 테이블 생성(dep01)
create table dept02
as 
select * from departments where 1=0;

select * from dept02;

--내용을 서브쿼리를 이용하여 저장
insert into dept02 (select * from departments);

--UPDATE 서브쿼리 활용
--부서 10번의 지역위치를 부서 40번 지역위치로 수정하시오
UPDATE DEPT02 SET LOCATION_ID = (SELECT LOCATION_ID FROM DEPT02 
WHERE DEPARTMENT_ID=40) WHERE DEPARTMENT_ID = 10;
SELECT LOCATION_ID FROM DEPT02 WHERE DEPARTMENT_ID=40;

--연습문제
--select salary from employees where job_id = 'ST_MAN';
select first_name, salary, department_id from employees 
where salary > any(select salary from employees where job_id = 'ST_MAN') and department_id != 20;

--select job_id, salary from employees where first_name = 'Valli';
select * from employees 
where job_id = (select job_id from employees where first_name = 'Valli') 
and salary = (select salary from employees where first_name = 'Valli')
and first_name != 'Valli';

select avg(salary) from employees where department_id=(select department_id from employees where first_name='Valli') group by department_id;
select department_id, first_name, salary from employees 
where salary > (select avg(salary) from employees where department_id=(select department_id from employees where first_name='Valli'));

--과제 1
select salary from employees where last_name = 'Tucker';
select last_name, first_name as Name, job_id, salary from employees 
where salary > (select salary from employees where last_name = 'Tucker');

--과제2
select last_name, first_name as Name, job_id, salary, hire_date from employees
where (job_id,salary) in(select job_id, min(salary) from employees group by job_id);

select last_name, first_name as Name, job_id, salary, hire_date from employees e2
where salary in(select min(salary) from employees where job_id = e2.job_id);


--job_id별 최소 salary
select min(salary),job_id from employees group by job_id;

--과제3
select avg(salary) from employees group by department_id;

select last_name, first_name as Name, salary, department_id, job_id from employees e2
where salary > (select avg(salary) from employees where department_id = e2.department_id);

select department_id, avg(salary) from employees group by department_id;

--과제4
select last_name, first_name as Name, job_id, salary, department_id, 
(select trunc(avg(salary)) from employees e1 where e1.department_id = e2.department_id) "Department Avg Salary" from employees e2;
