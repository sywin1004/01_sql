-- day 25
-- JDBC 에서 Statement 를 사용하면 안되는지
-- login 을 위한 테이블 생성 User 테이블 생성
 DROP TABLE LOGIN;
 CREATE TABLE LOGIN
 ( userid VARCHAR2(10)
 , password VARCHAR2(10) NOT NULL
 , CONSTRAINT PK_USER PRIMARY KEY (userid)
 )
 ;
 --Table LOGIN이(가) 생성되었습니다.
 INSERT INTO LOGIN VALUES('java', 'jdbc');
 INSERT INTO LOGIN VALUES('html', 'javascript');
 COMMIT;
SELECT l.*
  FROM LOGIN l
;

-- 로그인을 위한 쿼리 작성
SELECT l.userid
  FROM LOGIN l
 WHERE l.userid = 'java'
   AND l.password = ''
    OR 1=1 --'
;