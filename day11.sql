-- day11
---- 7. ���ΰ� ��������
-- (2) �������� : Sub-Query

-- SELECT, FROM, WHERE ���� ���� �� �ִ�.

-- ����) BLAKE�� ����(job)�� ������ ������ ������ ��ȸ
-- 1. BLAKE �� ������ ��ȸ
SELECT e.job
  FROM emp e
 WHERE e.ename = 'BLAKE'
;
/*
MANAGER
*/
-- 2. 1�� ����� ����
-- => ����(job)�� MANAGER �� ����� ��ȸ�Ͽ���
SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.job = 'MANAGER'
;
-- ���������� WHERE ���� �ִ�
-- MANAGER �� �ڸ��� 1�� ������ ���� �ǵ���
SELECT e.empno
     , e.ename
  FROM emp e
 WHERE e.job = (SELECT e.job -- ���������� ������ �� (���� job�� ���� job �� Ÿ���� ���ڷ� ����)
                  FROM emp e
                 WHERE e.ename = 'BLAKE')
;

-- => ���������� WHERE �� ()

-------------------------------------------
-- �������� ������ �ǽ�
-- 1. �� ȸ���� ��� �޿����� �޿��� ���� �޴� ������ ��� ��ȸ�Ͽ���
--    ���, �̸�, �޿�

-- a)ȸ���� �޿� ��հ��� ���ϴ� ����
SELECT AVG(e.sal) ���
  FROM emp e
;
/*
���
1933.928571428571428571428571428571428571
*/

-- b) �� ��հ��� ���� �����Ͽ� �� ������ �޿��� ���� ������ ���ϴ� ���� �ۼ�
SELECT e.empno
     , e.ename
     , e.sal
  FROM emp e
 WHERE e.sal > 1933.9285
;

-- c) b �� �������� ��� �� �ڸ��� (a)�� ������ ��ü
SELECT e.empno
     , e.ename
     , e.sal
  FROM emp e
 WHERE e.sal > (SELECT AVG(e.sal)
                  FROM emp e)
 ORDER BY e.sal
;
/*
EMPNO,  ENAME,  SAL
-----------------------
7782	CLARK	2450
7698	BLAKE	2850
7566	JONES	2975
7902	FORD	3000
7839	KING	5000
*/







--2. �޿��� ��� �޿����� ũ�鼭
--   ����� 7700�� ���� ���� ������ ��ȸ�Ͻÿ�.
--   ���, �̸�, �޿��� ��ȸ
-- a) ��� �޿�
SELECT AVG(e.sal) ���
  FROM emp e
;
-- b) ����� 7700���� ���� ������ ��� �̸� �޿� ��ȸ
SELECT e.empno
     , e.ename
     , e.sal
  FROM emp e
 WHERE e.empno > 7700
;
-- c) (a) (b) �� ����� ��ġ��
SELECT e.empno
     , e.ename
     , e.sal
  FROM emp e
 WHERE e.empno > 7700
   AND e.sal > (SELECT AVG(e.sal) ���
                  FROM emp e)
;
-- 3. �� �������� �ִ� �޿��� �޴� ���� ����� ��ȸ�Ͽ���.
--    ���, �̸�, ����, �޿��� ��ȸ
-- a) �������� �ִ� �޿��� ���ϴ� ���� : �׷��Լ�(MAX), �׷�ȭ �����÷�(job)
SELECT e.job
     , MAX(e.sal) max
  FROM emp e
 GROUP BY e.job
;
-- b) (a)���� ������ �ִ� �޿��� job �� ��ġ�ϴ��� �����ϴ� ����.
SELECT e.empno
     , e.ename
     , e.job
     , e.sal
  FROM emp e
 WHERE (e.job = 'CLERK' AND e.sal = 1300)
    OR (e.job = 'SALESMAN' AND e.sal = 1600)
    OR (e.job = 'ANALYST' AND e.sal = 3000)
    OR (e.job = 'PRESIDENT' AND e.sal = 5000)
    OR (e.job = 'MANAGER' AND e.sal = 2975)
;
-- c)  b���� ���� ���� a�� ������ ��ü
SELECT e.empno
     , e.ename
     , e.job
     , e.sal
  FROM emp e
 WHERE (e.job, e.sal) IN (SELECT e.job
                      , MAX(e.sal) max
                   FROM emp e
                  GROUP BY e.job)
;
/*
==> ���ϴ� ���� �÷��� ������
    ��ġ���� ���� �� �߻��ϴ� ����

ORA-00913: ���� ���� �ʹ� �����ϴ�
00913. 00000 -  "too many values"
*/

-- 4. �� ���� �Ի��ο��� ���η� ����Ͻÿ�.
-- ������� : 1�� ~ 12�� ���� �����Ͽ� ���
/*
"�Ի��, �ο�(��)
    1��        3
    2��        2
    ...       
    12��       2
-----------------------
*/
-- a) �Ի� �� ����
SELECT to_char(e.hiredate, 'MON') "�Ի��"
  FROM emp e
;
-- b) �Ի� ���� �ο��� ī��Ʈ
SELECT to_char(e.hiredate, 'MON') "�Ի��"
     , COUNT(*) "�ο�(��)"
  FROM emp e
 GROUP BY to_char(e.hiredate, 'MON')
 ORDER BY �Ի��
;
-- c) �ٽ� ���ڰ����� ������ ���ĸ���
SELECT TO_NUMBER(TO_CHAR(e.hiredate, 'FMMM')) "�Ի��"
     , COUNT(*) "�ο�(��)"
  FROM emp e
 GROUP BY to_char(e.hiredate, 'FMMM')
 ORDER BY �Ի��
;
-- d) (c)�� ����� FROM ���� ��°�� �� �� '��'�� �ٿ��� ��
SELECT a."�Ի��" || '��'  "�Ի��"
     , a."�ο�(��)" "�ο�(��)"
  FROM (SELECT TO_NUMBER(TO_CHAR(e.hiredate, 'FMMM')) "�Ի��"
     , COUNT(*) "�ο�(��)"
  FROM emp e
 GROUP BY to_char(e.hiredate, 'FMMM')
 ORDER BY �Ի��) a
;



















































































































































































































