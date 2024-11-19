
--성적처리 테이블 생성
DROP TABLE SCORE;
CREATE TABLE SCORE(
    STU_NUM NUMBER(4),
    STU_NAME VARCHAR2(20) NOT NULL,
    KOR NUMBER(4) NOT NULL,
    ENG NUMBER(4) NOT NULL,
    MATH NUMBER(4) NOT NULL, 
    TOTAL NUMBER(4),
    AVG NUMBER(5,1),
    RANK NUMBER(4)
);
ALTER TABLE SCORE ADD CONSTRAINTS SCORE_PK_STU_NUM PRIMARY KEY(STU_NUM);


--시퀀스생성
DROP SEQUENCE SCORE_SEQ;
CREATE SEQUENCE SCORE_SEQ
START WITH 1
INCREMENT BY 1
MINVALUE 1;


--테이블에 학번, 이름, 국어, 영어, 수학 점수를 입력하면 총점과 평균이 계산되어 입력되도록 프로시저(SUNG_INPUT)를 작성하라. 
CREATE OR REPLACE PROCEDURE SCORE_CAL_PROC(
    VSTU_NUM IN SCORE.STU_NUM%TYPE,
    VSTU_NAME IN SCORE.STU_NAME%TYPE,
    VKOR IN SCORE.KOR%TYPE,
    VENG IN SCORE.ENG%TYPE,
    VMATH IN SCORE.MATH%TYPE
    )
IS
    VTOTAL SCORE.TOTAL%TYPE;
    VAVG SCORE.AVG%TYPE;
BEGIN
    INSERT INTO SCORE(STU_NUM,STU_NAME,KOR,ENG,MATH,TOTAL,AVG)
    VALUES(VSTU_NUM,VSTU_NAME,VKOR,VENG,VMATH,
    VKOR+VENG+VMATH,(VKOR+VENG+VMATH)/3);
--    UPDATE SCORE SET VTOTAL = VKOR+VENG+VMATH;
--    UPDATE SCORE SET VTOTAL = (VKOR+VENG+VMATH)/3 ;    
END;
/

EXECUTE SCORE_CAL_PROC(SCORE_SEQ.NEXTVAL,'A',50,60,70);
EXECUTE SCORE_CAL_PROC(SCORE_SEQ.NEXTVAL,'B',10,20,30);
EXECUTE SCORE_CAL_PROC(SCORE_SEQ.NEXTVAL,'C',90,90,80);


SELECT * FROM SCORE;
DELETE FROM SCORE;



DROP TRIGGER SCORE_CAL_TRIGGER;

--테이블에  학번,  이름,  국어,  영어,  수학  점수를  입력하면  총점과  평균이  자동  계산되도록  트리거(SUNGCAL_TRG)를 작성하라. 
--오류
--방법 1. FOR EACH ROW 빼기
CREATE OR REPLACE TRIGGER SCORE_TRIGGER
    AFTER INSERT ON SCORE
--    FOR EACH ROW 생략하면 오류안남
BEGIN
    UPDATE SCORE SET TOTAL = (KOR+ENG+MATH);
    UPDATE SCORE SET AVG = (KOR+ENG+MATH)/3;
END;
/

--방법2. BEFORE 처리
CREATE OR REPLACE TRIGGER SCORE_TRIGGER
    BEFORE INSERT ON SCORE
    FOR EACH ROW
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    :NEW.TOTAL := :NEW.KOR + :NEW.ENG + :NEW.MATH;
    :NEW.AVG := (:NEW.KOR + :NEW.ENG + :NEW.MATH)/3;
END;
/

--방법3. 원래 방법에 PRAGMA 추가 안됨...
CREATE OR REPLACE TRIGGER SCORE_TRIGGER
    AFTER INSERT ON SCORE
    FOR EACH ROW
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    UPDATE SCORE SET TOTAL = :NEW.KOR + :NEW.ENG + :NEW.MATH WHERE STU_NUM = :NEW.STU_NUM;
    UPDATE SCORE SET AVG = (:NEW.KOR + :NEW.ENG + :NEW.MATH)/3 WHERE STU_NUM = :NEW.STU_NUM;
END;
/


--방법 4. 계산값 넣을 테이블 생성
CREATE TABLE SCORE_CAL(
    STU_NUM NUMBER(4),
    STU_NAME VARCHAR2(20) NOT NULL,
    KOR NUMBER(4) NOT NULL,
    ENG NUMBER(4) NOT NULL,
    MATH NUMBER(4) NOT NULL, 
    TOTAL NUMBER(4),
    AVG NUMBER(5,1),
    RANK NUMBER(4)
);
ALTER TABLE SCORE_CAL ADD CONSTRAINTS SCORE_CAL_PK_STU_NUM PRIMARY KEY(STU_NUM);

DROP TRIGGER SCORE_CAL_TRIGGER;
CREATE OR REPLACE TRIGGER SCORE_CAL_TRIGGER
    AFTER INSERT ON SCORE
    FOR EACH ROW
BEGIN
    INSERT INTO SCORE_CAL(STU_NUM, STU_NAME, KOR, ENG, MATH)
    VALUES(:NEW.STU_NUM, :NEW.STU_NAME, :NEW.KOR, :NEW.ENG, :NEW.MATH);
    UPDATE SCORE_CAL SET TOTAL = :NEW.KOR + :NEW.ENG + :NEW.MATH WHERE STU_NUM = :NEW.STU_NUM;
    UPDATE SCORE_CAL SET AVG = (:NEW.KOR + :NEW.ENG + :NEW.MATH)/3 WHERE STU_NUM = :NEW.STU_NUM;
END;
/

INSERT INTO SCORE(STU_NUM,STU_NAME,KOR,ENG,MATH) 
VALUES((SELECT(NVL(MAX(STU_NUM),0)+1)FROM SCORE),'A',50,60,70);
INSERT INTO SCORE(STU_NUM,STU_NAME,KOR,ENG,MATH) 
VALUES((SELECT(NVL(MAX(STU_NUM),0)+1)FROM SCORE),'B',10,20,30);
INSERT INTO SCORE(STU_NUM,STU_NAME,KOR,ENG,MATH) 
VALUES((SELECT(NVL(MAX(STU_NUM),0)+1)FROM SCORE),'C',90,90,80);

SELECT * FROM SCORE;
DELETE FROM SCORE;
SELECT * FROM SCORE_CAL;


--등수 구하는 프로시저
CREATE OR REPLACE PROCEDURE RANK_PROC
IS
BEGIN
    UPDATE SCORE SET RANK = 
    (SELECT TEM_RANK 
    FROM (SELECT RANK()OVER(ORDER BY TOTAL DESC, AVG DESC) AS TEM_RANK, S.* FROM SCORE S)
    WHERE STU_NUM = SCORE.STU_NUM);
--    SELECT RANK()OVER(ORDER BY TOTAL DESC, AVG DESC) AS RANK FROM SCORE;
END;
/

--프로시저 돌려보기
SELECT * FROM SCORE;
EXECUTE RANK_PROC;


--TEST
SELECT RANK 
FROM(SELECT RANK()OVER(ORDER BY TOTAL DESC, AVG DESC) AS RANK, S.*  FROM SCORE S)
WHERE STU_NUM = 1;

SELECT RANK
FROM (SELECT RANK()OVER(ORDER BY S.TOTAL DESC, S.AVG DESC) AS RANK, S.*  FROM SCORE S);

--윈도우 함수를 이용해서 생성
SELECT RANK() OVER(ORDER BY TOTAL DESC) AS RANK, STU_NAME, TOTAL FROM SCORE ORDER BY RANK;

CREATE OR REPLACE PROCEDURE RANK_PROC
IS
    VSCORE_RT SCORE%ROWTYPE;
    CURSOR C1 IS
    SELECT RANK() OVER(ORDER BY TOTAL DESC) AS RANK, STU_NUM, TOTAL FROM SCORE ORDER BY RANK;
BEGIN
    FOR VSCORE_RT IN C1 LOOP
        UPDATE SCORE SET RANK = VSCORE_RT.RANK WHERE STU_NUM = VSCORE_RT.STU_NUM;
    END LOOP;
    COMMIT; --해야 적용됨
END;
/

EXECUTE RANK_PROC;
SELECT * FROM SCORE;



