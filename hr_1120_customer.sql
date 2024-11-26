DROP TABLE CUSTOMER;
CREATE TABLE CUSTOMER(
    ID NUMBER(4),
    NAME VARCHAR2(20) NOT NULL,
    PHONE VARCHAR2(13),
    ADDRESS VARCHAR2(100),
    MEMBERSHIP VARCHAR2(30) DEFAULT 'WELCOME',
    POINT NUMBER(15) DEFAULT 0
);
ALTER TABLE CUSTOMER ADD CONSTRAINTS CUSTOMER_ID_PK PRIMARY KEY(ID);

CREATE SEQUENCE CUS_SEQ
START WITH 1
INCREMENT BY 1;

INSERT INTO CUSTOMER(ID,NAME,PHONE,ADDRESS)
VALUES(CUS_SEQ.NEXTVAL,'KIM','010-1234-5678','서울시 강남구');
INSERT INTO CUSTOMER(ID,NAME,PHONE,ADDRESS)
VALUES(CUS_SEQ.NEXTVAL,'PARK','010-9876-5432','경기도 고양시') ;
INSERT INTO CUSTOMER(ID,NAME,PHONE,ADDRESS)
VALUES(CUS_SEQ.NEXTVAL,'CHO','010-1111-1111','부산광역시') ;
commit; 

SELECT * FROM CUSTOMER;
--업데이트
UPDATE CUSTOMER SET NAME = 'JO', PHONE = '010-2222-2222', ADDRESS = '부산광역시', POINT = 100 WHERE ID = 3;
SELECT * FROM CUSTOMER;
ROLLBACK;

--삭제
DELETE FROM CUSTOMER WHERE ID = 3;

--포인트 추가 프로시저
CREATE OR REPLACE PROCEDURE CUS_ADD_POINT_PROC(VID CUSTOMER.ID%TYPE, VPOINT CUSTOMER.POINT%TYPE)
IS
BEGIN
    UPDATE CUSTOMER SET POINT = POINT+VPOINT WHERE ID = VID;
END;
/

EXECUTE CUS_ADD_POINT_PROC(1, 1);
SELECT * FROM CUSTOMER;
commit;

--초기화
UPDATE CUSTOMER SET POINT = 0;
UPDATE CUSTOMER SET MEMBERSHIP = 'WELCOME';

--고객등급 조회하는 function
CREATE OR REPLACE FUNCTION CUS_MEMBERSHIP_PRINT_FUNC(VID IN CUSTOMER.ID%TYPE) RETURN VARCHAR2
IS
    VMESSAGE VARCHAR2(100);
    CUSTOMER_RT CUSTOMER%ROWTYPE;
BEGIN
    SELECT * INTO CUSTOMER_RT FROM CUSTOMER WHERE ID = VID;
    VMESSAGE := CUSTOMER_RT.NAME||' 고객님의 현재 등급은 '||CUSTOMER_RT.MEMBERSHIP||'입니다.';
    RETURN VMESSAGE;
END;
/

COMMIT;

--자동 승급하는 트리거
CREATE OR REPLACE TRIGGER CUS_TRIGGER
    BEFORE UPDATE ON CUSTOMER
    FOR EACH ROW
BEGIN
    IF(:NEW.POINT >= 1000) THEN
    :NEW.MEMBERSHIP := 'VIP';
    END IF;
END;
/

SELECT * FROM CUSTOMER WHERE MEMBERSHIP = 'VIP';
EXECUTE CUS_ADD_POINT_PROC(1,1);

COMMIT;

