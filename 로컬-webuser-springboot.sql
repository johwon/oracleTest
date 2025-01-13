CREATE  TABLE  jdbcBoard( 
    board_no NUMBER, 
    title VARCHAR2(100) NOT NULL, 
    content VARCHAR2(1000) NULL, 
    writer VARCHAR2(50) NOT NULL, 
    reg_date DATE DEFAULT SYSDATE,
    PRIMARY KEY (board_no) 
); 
desc jdbcBoard;

create sequence jdbcBoard_seq 
start with 1 
increment by 1;

insert into jdbcboard(board_no,title,content,writer) 
values(jdbcBoard_seq.NEXTVAL, 'aaa', 'aaa', 'aaa');
SELECT board_no, title, content, writer, reg_date FROM 
jdbcBoard WHERE board_no = 1;
SELECT board_no, title, content, writer, reg_date FROM 
jdbcBoard WHERE board_no > 0 ORDER BY board_no desc, reg_date DESC;

CREATE TABLE jpaboard( 
    board_no NUMBER, 
    title VARCHAR2(100) NOT NULL, 
    content VARCHAR2(1000) NULL, 
    writer VARCHAR2(50) NOT NULL, 
    reg_date DATE DEFAULT SYSDATE, 
    PRIMARY KEY (board_no) 
);

create sequence jpaboard_seq 
start with 1 
increment by 1; 

select * from jpaboard;