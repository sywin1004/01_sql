--HR 계정 활성화
--1~3번입력 : HR
--4번입력 : $ORACLE_HOME/demo/schema/log/
--1~4번 입력후 HR 계정 테이블 생성됨.

-- HR로 작업
-- 2. DISTINC
-- 3. ORDER BY
명령의 2 행에서 시작하는 중 오류 발생 -
@C:\app\Administrator\product\18.0.0\dbhomeXE\demo\schema\human_resources
오류 보고 -
SP2-0310: 파일을 열 수 없음: "C:\app\Administrator\product\18.0.0\dbhomeXE\demo\schema\human_resources.sql"

SELECT *
  FROM tab
;
/*
COUNTRIES	TABLE	
DEPARTMENTS	TABLE	
EMPLOYEES	TABLE	
EMP_DETAILS_VIEW	VIEW	
JOBS	    TABLE	
JOB_HISTORY	TABLE	
LOCATIONS	TABLE	
REGIONS	    TABLE	
*/
------ 2.DISTINCT : 중복제거
-- A) 직업을 겹치지않게 나열
SELECT DISTINCT e.job_id
  FROM employees e
;
-- B) 매니저의 아이디를 겹치지않게 나열
SELECT DISTINCT e.manager_id
  FROM employees e
;
-- B.2) NULL 값을 '매니저 없음'으로 변경
SELECT NVL(a.mgr || '', '매니저 없음') "매니저 유무" 
  FROM (SELECT DISTINCT e.manager_id mgr
          FROM employees e) a
 ORDER BY a.mgr
;
-- B.3) DISTICT 서브쿼리 생성
SELECT DISTINCT e.manager_id
  FROM employees e
;
-- C) 지역번호를 겹치지않고 나열
SELECT DISTINCT e.department_id
  FROM employees e
;
-- C.2) NULL 값을 배정부서 없음 으로 변경
SELECT NVL(a.d || '', '배정부서 없음') 배정부서
  FROM (SELECT DISTINCT e.department_id d
          FROM employees e) a
 ORDER BY 배정부서
;

-- C.3) DISTINCT 서브쿼리 생성
SELECT DISTINCT e.department_id
  FROM employees e
;
-- C.4) 2번을 숫자값으로 변경해 정렬
SELECT NVL(a.d || '', '배정부서 없음') 배정부서
  FROM (SELECT DISTINCT e.department_id d
          FROM employees e) a
;
-- C 답) 정렬먼저 한 서브쿼리
SELECT a.deptid
  FROM (SELECT DISTINCT e.department_id deptid
          FROM employees e
         ORDER BY deptid) a
;
-- C 답)의 결과를 FROM에 넣어 문자화
SELECT nvl(a.deptid || '', '배정 부서 없음') deptid
  FROM (SELECT DISTINCT e.department_id deptid
          FROM employees e
         ORDER BY deptid) a
;

SELECT DISTINCT e.department_id deptid
  FROM employees e
 ORDER BY deptid  
;  

------ 3. ORDER BY : 정렬
-- A) EMPlOYEES 의 값을 SALARY 로 정렬
SELECT e.employee_id
     , e.first_name
     , e.last_name
     , e.salary
  FROM employees e
 ORDER BY e.salary
;
-- B) EMAIL을 오름차순 순으로 정렬
SELECT e.employee_id
     , e.first_name
     , e.last_name
     , e.email
  FROM employees e
 ORDER BY e.email
;
-- B.2) 내림차순
SELECT e.employee_id
     , e.first_name
     , e.last_name
     , e.email
  FROM employees e
 ORDER BY e.email
;
-- C) 성이 가장 빠른 순으로 정렬
SELECT e.last_name
  FROM EMPLOYEES e
 ORDER BY e.last_name
;
-- C.2) 성을 내림차순으로 정렬
SELECT e.last_name
  FROM EMPLOYEES e
 ORDER BY e.last_name DESC
;

-- 3. ALIAS : 별칭
-- A) LAST_NAME 성 별칭주기
SELECT e.last_name 성
  FROM employees e
;
-- B) EMAIL 이메일 별칭주기
SELECT e.email 이메일
  FROM employees e
;
-- C)SALARY 급여 별칭주기
SELECT e.salary 급여
  FROM employees e
;

------ 4. WHERE 절 : 조건
-- A) salary 가 7000 보다 높은 사람들 추출
SELECT e.first_name
     , e.salary
  FROM employees e
 WHERE e.salary > 7000
 ORDER BY e.salary
;
-- B) JOB_ID 가 PU_CLERK 이거나 ST_CLERK 인 사람들 추출
SELECT e.employee_id
     , e.last_name
     , e.job_id
  FROM employees e
 WHERE e.job_id = 'PU_CLERK'
    OR e.job_id = 'ST_CLERK'
;
-- C) JOB_ ID가  ST_CLERK 이고 메니저가 122번인 사람들 중 급여가 2500 이상인 사람 추출
SELECT e.employee_id
     , e.last_name
     , e.job_id
     , e.manager_id
  FROM employees e
 WHERE e.job_id = 'ST_CLERK'
   AND e.manager_id = 122
   AND e.salary > 2500
;

------ 5. 연산자 : where select having 절 사용 

-- 산술연산자 (), *, /, +, - select where having 절 사용가능
-- A) salary를 한달급여로 계산
SELECT e.last_name
     , e.salary
     , TO_CHAR(e.salary / 12, '$999,999.99') 한달급여
  FROM employees e
;
-- B) 직무가 SALES 가들어가는 직원들의 수당을 곱하여 한달 급여 계산
SELECT e.last_name
     , e.job_id
     , e.salary 급여
     , e.salary * e.commission_pct 수당값
     , TO_CHAR((e.salary * (e.commission_pct + 1)/ 12), '$999,999.99') 한달급여
     , e.commission_pct 수당
  FROM employees e
 WHERE e.job_id = 'SA_REP'
    OR e.job_id = 'SA_MAN'
;
-- C)급여가 3000 이상이고 5000 이하의 직원들 중 매니저 번호가 120번이 아닌 직원들의 한달급여
SELECT e.last_name 성
     , e.salary 급여
     , TO_CHAR((e.salary / 12), '$999,999.99') 한달급여
     , e.manager_id
  FROM employees e
 WHERE e.salary BETWEEN 3000 AND 5000
   AND e.manager_id <> 120
 ORDER BY e.manager_id
;