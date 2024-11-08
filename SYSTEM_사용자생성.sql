--사용자 계정 만들기(시스템관리자모드에서 진행해야함)
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
DROP USER STUDENTDB CASCADE; -- 기존 사용자 삭제
CREATE USER STUDENTDB IDENTIFIED BY 123456 -- 사용자 이름: Model, 비밀번호 : 1234
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP; --임시파일 저장장소--
GRANT connect, resource, dba TO STUDENTDB; -- 권한 부여

