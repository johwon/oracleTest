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