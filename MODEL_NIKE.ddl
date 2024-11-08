-- 생성자 Oracle SQL Developer Data Modeler 24.3.0.275.2224
--   위치:        2024-11-08 16:56:58 KST
--   사이트:      Oracle Database 11g
--   유형:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE customer (
    id     VARCHAR2(50) NOT NULL,
    c_name VARCHAR2(50) NOT NULL,
    phone  NUMBER(11) NOT NULL
);

ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( id );

CREATE TABLE market (
    marketname VARCHAR2(50) NOT NULL,
    tel        NUMBER(11) NOT NULL,
    manager    VARCHAR2(50) NOT NULL
);

ALTER TABLE market ADD CONSTRAINT market_pk PRIMARY KEY ( marketname );

CREATE TABLE product (
    p_name VARCHAR2(50) NOT NULL,
    code   VARCHAR2(50) NOT NULL,
    price  NUMBER(7) NOT NULL,
    amout  NUMBER(5) NOT NULL
);

ALTER TABLE product ADD CONSTRAINT product_pk PRIMARY KEY ( code );

CREATE TABLE purchase (
    code       VARCHAR2(50 CHAR) NOT NULL,
    id         VARCHAR2(50 CHAR) NOT NULL,
    marketname VARCHAR2(50) NOT NULL,
    num        NUMBER(20) NOT NULL
);

ALTER TABLE purchase ADD CONSTRAINT purchase_pk PRIMARY KEY ( num );

ALTER TABLE purchase
    ADD CONSTRAINT purchase_customer_id_fk FOREIGN KEY ( id )
        REFERENCES customer ( id );

ALTER TABLE purchase
    ADD CONSTRAINT purchase_market_marketname_fk FOREIGN KEY ( marketname )
        REFERENCES market ( marketname );

ALTER TABLE purchase
    ADD CONSTRAINT purchase_product_code_fk FOREIGN KEY ( code )
        REFERENCES product ( code );



-- Oracle SQL Developer Data Modeler 요약 보고서: 
-- 
-- CREATE TABLE                             4
-- CREATE INDEX                             0
-- ALTER TABLE                              7
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
