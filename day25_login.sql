-- day 25
-- JDBC ���� Statement �� ����ϸ� �ȵǴ���
-- login �� ���� ���̺� ���� User ���̺� ����
 DROP TABLE LOGIN;
 CREATE TABLE LOGIN
 ( userid VARCHAR2(10)
 , password VARCHAR2(10) NOT NULL
 , CONSTRAINT PK_USER PRIMARY KEY (userid)
 )
 ;
 --Table LOGIN��(��) �����Ǿ����ϴ�.
 INSERT INTO LOGIN VALUES('java', 'jdbc');
 INSERT INTO LOGIN VALUES('html', 'javascript');
 COMMIT;
SELECT l.*
  FROM LOGIN l
;

-- �α����� ���� ���� �ۼ�
SELECT l.userid
  FROM LOGIN l
 WHERE l.userid = 'java'
   AND l.password = ''
    OR 1=1 --'
;