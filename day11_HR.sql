--HR ���� Ȱ��ȭ
--1~3���Է� : HR
--4���Է� : $ORACLE_HOME/demo/schema/log/
--1~4�� �Է��� HR ���� ���̺� ������.

-- HR�� �۾�
-- 2. DISTINC
-- 3. ORDER BY
����� 2 �࿡�� �����ϴ� �� ���� �߻� -
@C:\app\Administrator\product\18.0.0\dbhomeXE\demo\schema\human_resources
���� ���� -
SP2-0310: ������ �� �� ����: "C:\app\Administrator\product\18.0.0\dbhomeXE\demo\schema\human_resources.sql"

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
------ 2.DISTINCT : �ߺ�����
-- A) ������ ��ġ���ʰ� ����
SELECT DISTINCT e.job_id
  FROM employees e
;
-- B) �Ŵ����� ���̵� ��ġ���ʰ� ����
SELECT DISTINCT e.manager_id
  FROM employees e
;
-- B.2) NULL ���� '�Ŵ��� ����'���� ����
SELECT NVL(a.mgr || '', '�Ŵ��� ����') "�Ŵ��� ����" 
  FROM (SELECT DISTINCT e.manager_id mgr
          FROM employees e) a
 ORDER BY a.mgr
;
-- B.3) DISTICT �������� ����
SELECT DISTINCT e.manager_id
  FROM employees e
;
-- C) ������ȣ�� ��ġ���ʰ� ����
SELECT DISTINCT e.department_id
  FROM employees e
;
-- C.2) NULL ���� �����μ� ���� ���� ����
SELECT NVL(a.d || '', '�����μ� ����') �����μ�
  FROM (SELECT DISTINCT e.department_id d
          FROM employees e) a
 ORDER BY �����μ�
;

-- C.3) DISTINCT �������� ����
SELECT DISTINCT e.department_id
  FROM employees e
;
-- C.4) 2���� ���ڰ����� ������ ����
SELECT NVL(a.d || '', '�����μ� ����') �����μ�
  FROM (SELECT DISTINCT e.department_id d
          FROM employees e) a
;
-- C ��) ���ĸ��� �� ��������
SELECT a.deptid
  FROM (SELECT DISTINCT e.department_id deptid
          FROM employees e
         ORDER BY deptid) a
;
-- C ��)�� ����� FROM�� �־� ����ȭ
SELECT nvl(a.deptid || '', '���� �μ� ����') deptid
  FROM (SELECT DISTINCT e.department_id deptid
          FROM employees e
         ORDER BY deptid) a
;

SELECT DISTINCT e.department_id deptid
  FROM employees e
 ORDER BY deptid  
;  

------ 3. ORDER BY : ����
-- A) EMPlOYEES �� ���� SALARY �� ����
SELECT e.employee_id
     , e.first_name
     , e.last_name
     , e.salary
  FROM employees e
 ORDER BY e.salary
;
-- B) EMAIL�� �������� ������ ����
SELECT e.employee_id
     , e.first_name
     , e.last_name
     , e.email
  FROM employees e
 ORDER BY e.email
;
-- B.2) ��������
SELECT e.employee_id
     , e.first_name
     , e.last_name
     , e.email
  FROM employees e
 ORDER BY e.email
;
-- C) ���� ���� ���� ������ ����
SELECT e.last_name
  FROM EMPLOYEES e
 ORDER BY e.last_name
;
-- C.2) ���� ������������ ����
SELECT e.last_name
  FROM EMPLOYEES e
 ORDER BY e.last_name DESC
;

-- 3. ALIAS : ��Ī
-- A) LAST_NAME �� ��Ī�ֱ�
SELECT e.last_name ��
  FROM employees e
;
-- B) EMAIL �̸��� ��Ī�ֱ�
SELECT e.email �̸���
  FROM employees e
;
-- C)SALARY �޿� ��Ī�ֱ�
SELECT e.salary �޿�
  FROM employees e
;

------ 4. WHERE �� : ����
-- A) salary �� 7000 ���� ���� ����� ����
SELECT e.first_name
     , e.salary
  FROM employees e
 WHERE e.salary > 7000
 ORDER BY e.salary
;
-- B) JOB_ID �� PU_CLERK �̰ų� ST_CLERK �� ����� ����
SELECT e.employee_id
     , e.last_name
     , e.job_id
  FROM employees e
 WHERE e.job_id = 'PU_CLERK'
    OR e.job_id = 'ST_CLERK'
;
-- C) JOB_ ID��  ST_CLERK �̰� �޴����� 122���� ����� �� �޿��� 2500 �̻��� ��� ����
SELECT e.employee_id
     , e.last_name
     , e.job_id
     , e.manager_id
  FROM employees e
 WHERE e.job_id = 'ST_CLERK'
   AND e.manager_id = 122
   AND e.salary > 2500
;

------ 5. ������ : where select having �� ��� 

-- ��������� (), *, /, +, - select where having �� ��밡��
-- A) salary�� �Ѵޱ޿��� ���
SELECT e.last_name
     , e.salary
     , TO_CHAR(e.salary / 12, '$999,999.99') �Ѵޱ޿�
  FROM employees e
;
-- B) ������ SALES ������ �������� ������ ���Ͽ� �Ѵ� �޿� ���
SELECT e.last_name
     , e.job_id
     , e.salary �޿�
     , e.salary * e.commission_pct ���簪
     , TO_CHAR((e.salary * (e.commission_pct + 1)/ 12), '$999,999.99') �Ѵޱ޿�
     , e.commission_pct ����
  FROM employees e
 WHERE e.job_id = 'SA_REP'
    OR e.job_id = 'SA_MAN'
;
-- C)�޿��� 3000 �̻��̰� 5000 ������ ������ �� �Ŵ��� ��ȣ�� 120���� �ƴ� �������� �Ѵޱ޿�
SELECT e.last_name ��
     , e.salary �޿�
     , TO_CHAR((e.salary / 12), '$999,999.99') �Ѵޱ޿�
     , e.manager_id
  FROM employees e
 WHERE e.salary BETWEEN 3000 AND 5000
   AND e.manager_id <> 120
 ORDER BY e.manager_id
;