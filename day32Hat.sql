DROP TABLE hat;
CREATE TABLE hat
(  code_id  VARCHAR2(5)
 , type     VARCHAR2(20) NOT NULL
 , material VARCHAR2(20) NOT NULL
 , size     NUMBER
 , color    VARCHAR2 (20)
 , price    NUMBER
 , quantity NUMBER 
 , gender   VARCHAR2(1)
 , CONSTRAINT PK_HAT PRIMARY KEY (code_id)
);

INSERT INTO hat h ( h.code_id, h.type, h.material, h.size, h.color, h.price, h.quantity, h.gender)
VALUES ('HT' || LPAD());

CREATE SEQUENCE SEQ_HAT_CODE_ID
START WITH 1
INCREMENT BY 1
MAXVALUE 100
NOCYCLE
;
