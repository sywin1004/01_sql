SELECT e.empno
     , e.ename
     , e.deptno
     , '|' 구분자
     , d.deptno
     , d.dname
  FROM emp e
     , dept d
 WHERE e.deptno = d.deptno -- 오라클의 전통적인 조인 조건 작성 방법
 ORDER BY d.deptno
;

-- 사번, 이름, 부서명 만 남기면
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e
     , dept d
 WHERE e.deptno = d.deptno -- 오라클의 전통적인 조인 조건 작성 방법
 ORDER BY d.deptno
;

-- 조인 연산자를 사용하여 조인(다른 DBMS 에서 주로 사용)
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e JOIN dept d ON (e.deptno = d.deptno)
 ORDER BY d.deptno
;

-- 위의 결과에서 ACCOUNTING 부서 직원만 알고 싶다.
-- 10번부서 직원을 조회하여라
SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.dept = 10
;

SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e
     , dept d
 WHERE e.deptno = d.deptno    --조인조건
   AND d.dname = 'ACCOUNTING' --일반조건
 ORDER BY d.deptno
;

-- ACCOUNTING 부서 소속인 직원 조회를
-- 조인 연산자를 사용한 쿼리로 변경해보세요
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e JOIN dept d ON (e.deptno = d.deptno)
 WHERE d.dname = 'ACCOUNTING'
;

-- 2) 조인 : 카티션 곱(카티션 조인)
--           조인 대상 테이블의 데이터를 가능한 모든 조합으로 엮는 것
--           WHERE 절에 조인 조건 누락시 발생
--           CROSS JOIN 연산자로 발생시킴(오라클 9i 버전 이후로 사용가능)

-- emp, dept, salgrade 세 개의 테이블로 카티션 곱 발생
SELECT e.ename
     , d.dname
     , s.grade
  FROM emp e
     , dept d
     , salgrade s
;
-- ==> 12 * 4 * 5 = 240 행의 결과 발생

-- CROSS JOIN 연산자를 사용하면
SELECT e.ename
     , d.dname
     , s.grade
  FROM emp e CROSS JOIN dept d
             CROSS JOIN salgrade s
;

-- 3) EQUI JOIN : 조인의 가장 기본 형태
--                조인 대상 테이블 사이의 공통 컬럼을 '=' 로 연결
--                공통 컬럼을 (join-attribute)라고 부름

-- a) 오라클 전통기법으로 WHERE 절 첫번째 줄에 조인 조건을 주는 방법
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e
     , dept d
 WHERE e.deptno = d.deptno -- 오라클의 전통적인 조인 조건 작성 방법
;

-- b) JOIN ~ ON
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e JOIN dept d ON (e.deptno = d.deptno)
;

-- c) NATURAL JOIN 키워드로 자동 조인
--    : ON 절이 없음
--      join-attribute 를 오라클 DBMS 가 자동으로 판단
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e NATURAL JOIN dept d -- 조인 공통 컬럼 명시가 없음.
;

-- d) JOIN ~ USING 
SELECT e.empno
     , e.ename
     , d.dname
  FROM emp e JOIN dept d USING(deptno) 
  --USING 뒤에 공통 컬럼을 별칭 없이 명시
;

-- 4) 네 가지 EQUI-JOIN 구문 작성 법
-- a) 오라클 전통 조인 구조
SELECT [별칭1.]컬럼명1, [별칭2.]컬럼명2
  FROM 테이블 1 별칭1, 테이블2 별칭2[, ...]
 WHERE 별칭1.공통컬럼1 = 별칭2.공통컬럼1 -- 조인조건 WHERE 나열
 [AND 별칭1.공통컬럼2 = 별칭n. 공통컬럼2] -- 조인 대상 테이블이 여러개일 경우
 [AND ...]                                -- WHERE 절에 나열되는 조인조건도 늘어남
 [AND ... 추가 가능한 일반 조건들]
;
-- b) JOIN ~ ON
SELECT [별칭1.]컬럼명1, [별칭2.]컬럼명2
  FROM 테이블 1 별칭1 JOIN 테이블2 별칭2[, ...] ON (별칭1.공통컬럼1 = 별칭2.공통컬럼1)
                      [JOIN 테이블3 별칭3[, ...] ON (별칭1.공통컬럼2 = 별칭3.공통컬럼2)]
                      [JOIN 테이블3 별칭3[, ...] ON (별칭n-1.공통컬럼n-1 = 별칭n.공통컬럼n)]
[WHERE 일반조건]
  [AND 일반조건]
-- c) NATURAL JOIN
SELECT [별칭1.]컬럼명1, [별칭2.]컬럼명2
  FROM 테이블 별칭1 NATURAL JOIN 테이블2 별칭2
                   [NATURAL JOIN 테이블n 별칭n]
;
-- d) JOIN ~ USING
SELECT [별칭1.]컬럼명1, [별칭2.]컬럼명2[,...]
  FROM 테이블 별칭1 JOIN 테이블2 별칭2 USING (공통컬럼)
                   [JOIN 테이블n 별칭n USING(공통컬럼)] -- 별칭 사용없음
;                  

--------------------------------------------------------------------------------
-- 5) NON-EQU JOIN : WHERE 조건절에 join-attribute 사용하는 대신
--                   다른 비교 연산자를 사용하여 여러 테이블을 엮는 기법

-- 문제) emp, salgrade 테이블을 사용해서 직원의 급여에 따른 등급을 함께 조회









































































































































































































































































