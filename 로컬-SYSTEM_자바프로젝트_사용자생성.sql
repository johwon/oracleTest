--사용자가 정의한 테이블 스페이스 만들기
create tablespace firstdata
datafile 'C:\oraclexe\oradata\XE\first01.dbf' size 10M;
--용량 부족시 테이블 스페이스 확장하기
alter tablespace firstdata
add datafile 'C:\oraclexe\oradata\XE\first02.dbf' size 1M;
--용량 부족시 테이블 스페이스 용량 확장하기
alter database
datafile 'C:\oraclexe\oradata\XE\first02.dbf' resize 10M;
--용량 부족시 자동으로 1M 확장하고 최대 20M까지 확장하도록 서정
alter database
datafile 'C:\oraclexe\oradata\XE\first01.dbf'
autoextend on
next 1M
maxsize 20M;
--5. 자바프로젝트를 위해 사용자 계정 및 테이블 스페이스(javadata), 파일명(app_data.dbf) 생성
create tablespace javadata
datafile 'C:\oraclexe\oradata\XE\app_data.dbf' size 20M
autoextend on
next 3M
maxsize 500M;

--6. 자바 프로젝트 사용자 계정 생성
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
DROP USER javauser CASCADE; -- 기존 사용자 삭제
CREATE USER javauser IDENTIFIED BY 123456 -- 사용자 이름: Model, 비밀번호 : 123456
    DEFAULT TABLESPACE javadata   --데이터 저장소
    TEMPORARY TABLESPACE TEMP; --임시파일 저장장소--
GRANT connect, resource, dba TO javauser; -- 권한 부여
