-- day09 : 

-- 2. ������ �Լ�(�׷� �Լ�)

-- 1) COUNT(*) : FROM���� ������
--               Ư�� ���̺��� ���� ����(������ ����)�� �����ִ� �Լ�
--               NULL���� ó���ϴ� "����"�� �׷��Լ�

--    COUNT(expr) : expr ���� ������ ���� NULL �����ϰ� �����ִ� �Լ�
-- ����) dept, salgrade ���̺��� ��ü ������ ���� ��ȸ
-- 1. dept ���̺� ��ȸ
SELECT d.*
  FROM dept d
;
/* ������ �Լ��� ���� ����:
------------------------------------
10	ACCOUNTING	NEW YORK     ====> SUBSTR (dname, 1, 5) ACCOU
20	RESEARCH	DALLAS      =====> SUBSTR (dname, 1, 5) RESEA
30	SALES	    CHICAGO     =====> SUBSTR (dname, 1, 5) SALES
40	OPERATIONS	BOSTON      =====> SUBSTR (dname, 1, 5) OPERA
*/
/* �׷��Լ� (COUNT(*))�� ���� ����:
--------------------------------------------
10	ACCOUNTING	NEW YORK     ====>
20	RESEARCH	DALLAS      =====> COUNT (*) ==> 4
30	SALES	    CHICAGO     =====>
40	OPERATIONS	BOSTON      =====>
*/
-- 2. dept ���̺��� ������ ���� ��ȸ : COUNT(*) ���
SELECT COUNT(*) "�μ� ����"
  FROM dept d
;
/*
�μ� ����
---------
        4 -> ������ ���� �ʴ� ������
*/

-- salgrade(�޿����) ���̺��� �޿� ��� ������ ��ȸ
SELECT COUNT(*)
  FROM salgrade
;
/*
�޿� ��� ����
-------------------
            5
*/
SELECT s.*
  FROM salgrade s
;
/*
1	700	    1200 ==>
2	1201	1400 ==>
3	1401	2000 ==> COUNT(*) ==>5
4	2001	3000 ==>
5	3001	9999 ==>
*/

-- COUNT (expr) �� NULL �����͸� ó������ ���ϴ� �� Ȯ���� ���� ������ �߰�
INSERT INTO "SCOTT"."EMP" (EMPNO, ENAME) VALUES ('7777', 'JJ');
COMMIT;

-- emp ���̺��� job �÷��� ������ ������ ī��Ʈ
SELECT COUNT(e.job) "������ ������ ������ ��"
  FROM emp e
;
/*
������ ������ ������ ��
------------------
14
*/
/*
9999	J_JAMES	CLERK       ==>
8888	J%JAMES	CLERK       ==>
7777	JJ	    (null)      ==>
7369	SMITH	CLERK       ==>
7499	ALLEN	SALESMAN    ==>
7521	WARD	SALESMAN    ==>
7566	JONES	MANAGER     ==>
7654	MARTIN	SALESMAN    ==>������ ���� ���� �÷��� job�� 
7698	BLAKE	MANAGER     ==>null�� �� ���� ó���� ���� �ʴ´�.
7782	CLARK	MANAGER     ==>COUNT(e.job) ==> 14
7839	KING	PRESIDENT   ==>
7844	TURNER	SALESMAN    ==>
7900	JAMES	CLERK       ==>
7902	FORD	ANALYST     ==>
7934	MILLER	CLERK       ==>
*/

-- ����) ȸ�翡 �Ŵ����� ������ ������ ����ΰ�
SELECT COUNT(e.mgr) "��簡 �ִ� ������ ��"
  FROM emp e
;
/*
��簡 �ִ� ������ ��
----------------
        11
*/

-- ����) �Ŵ��� ���� �ð� �ִ� ������ ����ΰ�?
-- 1. emp ���̺��� mgr �÷��� ������ ���¸� �ľ�
-- 2. mgr �÷��� �ߺ� �����͸� ����
SELECT DISTINCT e.mgr
  FROM emp e
;
/*
MGR
------
7782
7698
7902
7566
(null)
7839
*/
-- 3. �ߺ� �����Ͱ� ���ŵ� ����� ī��Ʈ
SELECT COUNT(DISTINCT e.mgr) "�Ŵ��� ��"
  FROM emp e
;
/*
�Ŵ��� ��
-----------------
        5
*/

-- ����) �μ��� ������ ������ ����̳� �ִ°�?
SELECT COUNT(e.deptno) "�μ��� ������ ����"
  FROM emp e
;
/*
�μ��� ������ ����
--------------------
            12
*/

-- COUNT(*)�� �ƴ� COUNT(e.edptno)�� ����� ��쿡��
SELECT e.deptno
  FEOM emp e
 WHERE e.deptno IS NOT NULL
;
-- �� ������ ����� ī��Ʈ �� ������ ������ �� ����.

-- ����) ��ü�ο�, �μ� ���� �ο�, �μ� �̹��� �ο��� ���Ͻÿ�
SELECT COUNT(*) "��ü �ο�"
     , COUNT(e.deptno) "�μ� ���� �ο�"
     , COUNT(*) - COUNT(e.deptno) "�μ� �̹��� �ο�"
  FROM emp e
;

-- SUM(expr) : NULL �׸� �����ϰ�
--             �ջ� ������ ���� ��� ���� ����� ���

-- SALSEMAN ���� ���� ������ ���غ���.
SELECT SUM(e.comm) "���� ����"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;
/*
/*
COMM
------------
300    ====>
500    ====>SUM(e.comm) ====> 2200: �ڵ����� NULL�÷� ����
1400   ====>
0      ====>
*/

*/
SELECT SUM(e.comm) "���� ����"
  FROM emp e
;
/*
COMM
------------
(null) 
(null)
(null)
(null) 
300    ====>
500    ====>
(null)  SUM(e.comm) ====> 2200: �ڵ����� NULL�÷� ����
1400   ====>
(null) 
(null) 
(null) 
0      ====>
(null)
(null)
(null) 
*/

-- ���� ���� ����� ���� ��� ������ ���� $, ���ڸ� ���� �б� ����
SELECT to_char(SUM(e.comm), '$9,999') "���� ����"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;
/*
���� ����
-----------
 $2,200
*/

-- 3) AVG(expr) : NULL ���� �����ϰ� ���� ������ �׸��� ��� ����� ����
-- SALESMAN�� ���� ����� ���غ���
-- ���� ��� ����� ���� ��� ���� $, ���ڸ� ���� �б� ����
SELECT to_char(AVG(e.comm), '$9,999') "���� ���"
  FROM emp e
 WHERE e.job = 'SALESMAN'
;

SELECT to_char(AVG(e.comm), '$9,999') "���� ���"
  FROM emp e
;

-- 4) MAX(expr) : expr�� ������ �� �� �ִ��� ����
--                expr�� ������ ���� ���ĺ��� ���ʿ� ��ġ�� ���ڸ� �ִ����� ���

-- �̸��� ���� ������ ����
SELECT MAX(e.ename) "�̸��� ���� ������ ����"
  FROM emp e
;
/*
�̸��� ���� ������ ����
----------------
WARD
*/
SELECT MIN(e.ename) "�̸��� ���� ���� ����"
  FROM emp e
;
/*
�̸��� ���� ���� ����
---------------------
ALLEN
*/

-- 3. GROUP BY ���� ���
-- ����) �� �μ����� �޿��� ����, ���, �ִ�, �ּҸ� ��ȸ

-- 1. �� �μ����� �޿��� ������ ��ȸ�Ϸ���
--    ���� : SUM() �� ���
--    �׷�ȭ ������ �μ���ȣ(deptno)�� ���
--    GROUP BY ���� �����ؾ� ��

-- a) ���� emp ���̺��� �޿� ������ ���ϴ� ���� �ۼ�
SELECT SUM(e.sal)
  FROM emp e
;

-- b) �μ� ��ȣ�� �������� �׷�ȭ ����
--    SUM()�� �׷��Լ���.
--    GROUP BY ���� �����ϸ� �׷�ȭ �����ϴ�.
--    �׷�ȭ�� �Ϸ��� �����÷��� GROUP BY ���� �����ؾ� ��.
SELECT e.deptno �μ���ȣ -- �׷�ȭ �����÷�
     , SUM(e.sal) "�μ� �޿� ����" -- �׷��Լ��� ���� �÷�
  FROM emp e
 GROUP BY e.deptno -- �׷�ȭ �����÷����� GROUP BY ���� ����
 ORDER BY e.deptno -- �μ���ȣ ����
;

-- GROUP BY ���� �׷�ȭ ���� �÷����� ������ �÷��� �ƴ� ����
-- SELECT ���� �����ϸ� ����, ����Ұ�
SELECT e.deptno �μ���ȣ -- �׷�ȭ �����÷�
     , e.job -- �׷�ȭ �����÷��� �ƴѵ� SELECT ���� ���� -> ������ ����
     , SUM(e.sal) "�μ� �޿� ����" -- �׷��Լ��� ���� �÷�
  FROM emp e
 GROUP BY e.deptno -- �׷�ȭ �����÷����� GROUP BY ���� ����
 ORDER BY e.deptno -- �μ���ȣ ����
;
/*
ORA-00979: GROUP BY ǥ������ �ƴմϴ�.
00979. 00000 -  "not a GROUP BY expression"
*/

-- ����) �μ��� �޿��� ����, ���, �ִ�, �ּ�

SELECT e.deptno �μ���ȣ 
     , SUM(e.sal) "�μ� �޿� ����" 
     , AVG(e.sal) "�μ� �޿� ���"
     , MAX(e.sal) "�μ� �޿� �ִ�"
     , MIN(e.sal) "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;

-- ���� ���� ����
SELECT e.deptno �μ���ȣ 
     , to_char(SUM(e.sal), '$9,999') "�μ� �޿� ����" 
     , to_char(AVG(e.sal), '$9,999,999.99') "�μ� �޿� ���"
     , to_char(MAX(e.sal), '$9,999') "�μ� �޿� �ִ�"
     , to_char(MIN(e.sal), '$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;
/*
�μ���ȣ, �μ� �޿� ����, �μ� �޿� ���, �μ� �޿� �ִ�, �μ� �޿� �ּ�
----------------------------------------------------------------------------
10	         $8,750	         $2,916.67	     $5,000	            $1,300
20	         $6,775	         $2,258.33	     $3,000	              $800
30	         $9,400	         $1,566.67	     $2,850	              $950
				
*/
-- �μ���ȣ�� ������ ����
SELECT to_char(SUM(e.sal), '$9,999') "�μ� �޿� ����" 
     , to_char(AVG(e.sal), '$9,999.99') "�μ� �޿� ���"
     , to_char(MAX(e.sal), '$9,999') "�μ� �޿� �ִ�"
     , to_char(MIN(e.sal), '$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;

/*
���� ������ ��������� ��Ȯ�ϰ� ��� �μ��� ������� �� �� ���ٴ� ������ ����
�׷���, GROUP BY ���� �����ϴ� ����Į���� SELECT ���� �Ȱ��� �����ϴ� ����
��� �ؼ��� ���ϴ�.

SELECT ���� ������ �÷����߿��� �׷��Լ��� ������ �ʴ� �÷��� ���� ������
���� ������ ����Ǵ� ���̴�.
*/

-- ����) �μ���, ������ �޿��� ����, ���, �ִ�, �ּҸ� ���غ���.
SELECT e.deptno �μ���ȣ
     , e.job ����
     , SUM(e.sal) "�μ� �޿� ����" 
     , AVG(e.sal) "�μ� �޿� ���"
     , MAX(e.sal) "�μ� �޿� �ִ�"
     , MIN(e.sal) "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno, e.job
 ORDER BY e.deptno 
;
/*
�μ���ȣ, ����, �μ� �޿� ����, �μ� �޿� ���, �μ� �޿� �ִ�, �μ� �޿� �ּ�
--------------------------------------------------------------------------------
10	    CLERK	    1300	      1300          	1300	        1300
10	    MANAGER	    2450	      2450	            2450	        2450
10	    PRESIDENT	5000	    5000	            5000	        5000
20	    ANALYST	    3000	    3000            	3000	        3000
20	    CLERK	    800	        800             	800	            800
20	    MANAGER	    2975	    2975	            2975        	2975
30	    CLERK	    950	        950	                950	            950
30	    MANAGER	    2850	    2850            	2850        	2850
30	    SALESMAN	5600	    1400	            1600        	1250
        CLERK				
					
*/


-- ������Ȳ
-- a) GROUP BY ���� �׷�ȭ ������ ������ ���
SELECT e.deptno �μ���ȣ
     , e.job ����                          --SELECT ���� ����
     , SUM(e.sal) "�μ� �޿� ����" 
     , AVG(e.sal) "�μ� �޿� ���"
     , MAX(e.sal) "�μ� �޿� �ִ�"
     , MIN(e.sal) "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno                          --GROUP BY ���� ������ job �÷�
 ORDER BY e.deptno 
;

/*
ORA-00979: GROUP BY ǥ������ �ƴմϴ�.
00979. 00000 -  "not a GROUP BY expression"
*/

-- b) SELECT ���� �׷��Լ��� �Ϲ� �÷��� ���� ����
--    GROUP BY �� ��ü�� ������ ���
SELECT e.deptno �μ���ȣ
     , e.job ����                          
     , SUM(e.sal) "�μ� �޿� ����" 
     , AVG(e.sal) "�μ� �޿� ���"
     , MAX(e.sal) "�μ� �޿� �ִ�"
     , MIN(e.sal) "�μ� �޿� �ּ�"
  FROM emp e
-- GROUP BY e.deptno, e.job
 ORDER BY e.deptno 
;
/*
ORA-00937: ���� �׷��� �׷� �Լ��� �ƴմϴ�
00937. 00000 -  "not a single-group group function"
*/

-- ����) ����(job) �� �޿��� ����, ���, �ִ�, �ּҸ� ���غ���
--       ��Ī : ����, �޿�����, �޿����, �ִ�޿�, �ּұ޿�
SELECT e.job ����
     , to_char(SUM(e.sal), '$9,999') �޿����� 
     , to_char(AVG(e.sal), '$9,999.99') �޿����
     , to_char(MAX(e.sal), '$9,999') �ִ�޿�
     , to_char(MIN(e.sal), '$9,999') �ּұ޿�
  FROM emp e
 GROUP BY e.job
;
-- ������ null�� ������� ������ ��� '���� �̹���' ���� ����ϵ��� �սô�.
SELECT NVL(e.job, '���� �̹���') ����
     , to_char(SUM(e.sal), '$9,999') �޿����� 
     , to_char(AVG(e.sal), '$9,999.99') �޿����
     , to_char(MAX(e.sal), '$9,999') �ִ�޿�
     , to_char(MIN(e.sal), '$9,999') �ּұ޿�
  FROM emp e
 GROUP BY e.job
;

-- �μ��� ����, ���, �ִ�, �ּ�
-- �μ���ȣ�� null�ΰ�� '�μ� �̹���'���� �з��ǵ��� ��ȸ
SELECT NVL(e.deptno), '�μ� �̹���') �μ���ȣ
     , to_char(SUM(e.sal), '$9,999') "�μ� �޿� ����" 
     , to_char(AVG(e.sal), '$9,999.99') "�μ� �޿� ���"
     , to_char(MAX(e.sal), '$9,999') "�μ� �޿� �ִ�"
     , to_char(MIN(e.sal), '$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;

/* deptno �� ����, '�μ� �̹���'�� ���� ������ �̹Ƿ� Ÿ�Ժ���ġ
   NVL()�� �۵����� ���Ѵ�
ORA-01722: ��ġ�� �������մϴ�
01722. 00000 -  "invalid number"
*/

-- �ذ��� : deptno �� ���� ����ȭ
-- ���ڸ� ���ڷ� ����: ���տ�����||�� ���
SELECT NVL(e.deptno|| '', '�μ� �̹���') �μ���ȣ
     , to_char(SUM(e.sal), '$9,999') "�μ� �޿� ����" 
     , to_char(AVG(e.sal), '$9,999.99') "�μ� �޿� ���"
     , to_char(MAX(e.sal), '$9,999') "�μ� �޿� �ִ�"
     , to_char(MIN(e.sal), '$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;

SELECT NVL(to_char(e.deptno), '�μ� �̹���') �μ���ȣ
     , to_char(SUM(e.sal), '$9,999') "�μ� �޿� ����" 
     , to_char(AVG(e.sal), '$9,999.99') "�μ� �޿� ���"
     , to_char(MAX(e.sal), '$9,999') "�μ� �޿� �ִ�"
     , to_char(MIN(e.sal), '$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;
-- NVL, DECODE, to_char �������� �ذ�
SELECT DECODE(NVL(e.deptno, 0), e.deptno, to_char(e.deptno)
                              , 0       , '�μ� �̹���') �μ���ȣ
     , to_char(SUM(e.sal), '$9,999') "�μ� �޿� ����" 
     , to_char(AVG(e.sal), '$9,999.99') "�μ� �޿� ���"
     , to_char(MAX(e.sal), '$9,999') "�μ� �޿� �ִ�"
     , to_char(MIN(e.sal), '$9,999') "�μ� �޿� �ּ�"
  FROM emp e
 GROUP BY e.deptno 
 ORDER BY e.deptno 
;

-------- 4. HAVING ���� ���

-- GROUP BY ����� ������ �ɾ 
-- �� ����� ������ �������� ���Ǵ� ��.
-- WHERE ���� ��������� SELECT ������ ���� ����������
-- GROUP BY �� ���� ���� ����Ǵ� WHERE ���δ�
-- GROUP BY ����� ������ �� ����.

-- ���� GROUP BY ������ ��������� ������
-- HAVING ���� �����Ѵ�.

-- ����) �μ��� �޿� ����� 2000 �̻��� �μ��� ��ȸ�Ͽ���.

-- a) �켱 �μ��� �޿� ����� ���Ѵ�.
SELECT e.deptno �μ���ȣ
     , AVG(e.sal) �޿����
  FROM emp e
 GROUP BY e.deptno
;

-- b) a�� ������� �޿������ 2000�̻��� ���� �����.
--    HAVING ���� ��� ����
SELECT e.deptno �μ���ȣ
     , AVG(e.sal) �޿����
  FROM emp e
 GROUP BY e.deptno
HAVING AVG(e.sal) >= 2000
;
--����� ���� ����
SELECT e.deptno �μ���ȣ
     , to_char(AVG(e.sal),'$9,999.99') �޿����
  FROM emp e
 GROUP BY e.deptno
HAVING AVG(e.sal) >= 2000
;

-- ����: HAVING ���� ��Ī�� ����� �� ����
SELECT e.deptno �μ���ȣ
     , to_char(AVG(e.sal),'$9,999.99') �޿����
  FROM emp e
 GROUP BY e.deptno
HAVING �޿���� >= 2000
;

/*
ORA-00904: "�޿����": �������� �ĺ���
00904. 00000 -  "%s: invalid identifier"
*/

-- HAVING ���� �����ϴ� ��� SELECT ������ ���� ���� ����
/*
 1. FROM        ���� ���̺� �� �� ��θ� �������
 2. WHERE       ���� ���ǿ� �´� �ุ �����ϰ�
 3. GROUP BY    ���� ���� �÷�, ��(�Լ� ��) ���� �׷�ȭ ����
 4. HAVING      ���� ������ ������Ű�� �׷��ุ ����
 5.             4���� ���õ� �׷� ������ ���� �࿡ ���ؼ�
 6. SELECT       ���� ��õ� Į��, ��(�Լ� ��)�� ���
 7. ORDER BY     �� �ִٸ� ���� ���ǿ� ���߾� ���� �����Ͽ� ��� ���
*/

-----------------------------------------------------------------------------------------
--������ �ǽ�
-- 1. �Ŵ�����, ���������� ���� ���ϰ�, ���� ������ ����
--   : mgr �÷��� �׷�ȭ ���� �÷�
SELECT e.mgr
     , COUNT(e.mgr) "�������� ��"
  FROM emp e
 GROUP BY e.mgr
 ORDER BY "�������� ��" DESC
;
/*
MGR, �������� ��
-------------------------
7698	5
7839	3
7566	1
7782	1
7902	1
(null)  0
*/
-- 2.1 �μ��� �ο��� ���ϰ�, �ο��� ���� ������ ����
--    : deptno �÷��� �׷�ȭ ���� �÷�
SELECT e.deptno
     , COUNT(e.deptno) "�μ��� �ο�"
  FROM emp e
 GROUP BY e.deptno
 ORDER BY  "�μ��� �ο�" DESC
;
/*
DEPTNO, �μ��� �ο�
30	        6
20	        3
10	        3
(null)      0
*/
-- 2.2  deptno �� null�� �÷��� '�μ� ��ġ �̹���' ���� ��µǵ��� ó��
SELECT NVL(to_char(e.deptno),'�μ� �̹���') �μ���ȣ
  FROM emp e
 GROUP BY e.deptno
;
/*
�μ���ȣ
-----------
30
�μ� �̹���
10
20
*/
-- 3.1 ������ �޿� ��� ���ϰ�, �޿���� ���� ������ ����
--   : job �� �׷�ȭ ���� �÷�
SELECT e.job
     , to_char(AVG(e.sal), '$9,999.99') �޿����
  FROM emp e
 GROUP BY e.job
 ORDER BY �޿���� DESC
;
/*
JOB,        �޿����
-------------------------	
PRESIDENT	 $5,000.00
ANALYST	     $3,000.00
MANAGER	     $2,758.33
SALESMAN	 $1,400.00
CLERK	     $1,016.67
*/
-- 3.2 job �� null �� ������ ó��
SELECT NVL(e.job, '��������') ����
     , NVL(to_char(AVG(e.sal), '$9,999.99'),'�޿� ����') �޿����
  FROM emp e
 GROUP BY e.job
 ORDER BY �޿���� DESC
;
/*
����,         �޿����
--------------------------
��������	�޿� ����
PRESIDENT	 $5,000.00
ANALYST	     $3,000.00
MANAGER	     $2,758.33
SALESMAN	 $1,400.00
CLERK	     $1,016.67
*/
-- 4. ������ �޿� ���� ���ϰ�, ���� ���� ������ ����
--   : job �� �׷�ȭ ���� �÷�
SELECT e.job
     , SUM(e.sal) �޿�����
  FROM emp e
 GROUP BY e.job
 ORDER BY �޿����� DESC
;
/*
JOB,    �޿�����	
---------------------
MANAGER	    8275
SALESMAN	5600
PRESIDENT	5000
CLERK	    3050
ANALYST	    3000
*/
-- 5. �޿��� �մ����� 1000�̸�, 1000, 2000, 3000, 5000 ���� �ο����� ���Ͻÿ�
--    �޿� ���� ������������ ����
SELECT trunc(e.sal,-3) �޿�����
     , COUNT(trunc(e.sal,-3)) �ο���
  FROM emp e
 GROUP BY trunc(e.sal,-3)
 ORDER BY �޿����� 
;
SELECT trunc(e.sal,-3) �޿�����
     , COUNT(*) �ο���
  FROM emp e
 GROUP BY trunc(e.sal,-3)
 ORDER BY �޿����� 
;
SELECT trunc(e.sal,-3)  �޿�����
     , COUNT(*) �ο���
  FROM emp e
 GROUP BY trunc(e.sal,-3)
 ORDER BY �޿����� 
;
-- 6. ������ �޿� ���� ������ ���ϰ�, �޿� ���� ������ ū ������ ����
SELECT e.job
     , trunc(SUM(e.sal), -3) �޿�����  
  FROM emp e
 GROUP BY e.job
 ORDER BY �޿����� DESC
;
/*
JOB,    �޿�����
------------------------
SALESMAN	5600
PRESIDENT	5000
MANAGER	    8275
CLERK	    3050
ANALYST 	3000
*/

-- 7. ������ �޿� ����� 2000������ ��츦 ���ϰ� ����� ���� ������ ����
SELECT e.job
     , AVG(e.sal) �޿����
  FROM emp e
 GROUP BY e.job
HAVING AVG(e.sal) <= 2000
 ORDER BY �޿���� DESC
;
/*
JOB,        �޿����
------------------------
SALESMAN	1400
CLERK	    1016.666666666666666666666666666666666667
*/
-- 8. �⵵�� �Ի� �ο��� ���Ͻÿ�
SELECT e.hiredate �⵵
     , to_date(COUNT(e.hiredate), 'YYYY') �Ի��ο�
     , COUNT(*) 
  FROM emp e
 GROUP BY e.hiredate
;
/*
�⵵,     �Ի��ο�
-------------------------

*/



-- 9. �⵵��, ���� �Ի� �ο��� ���Ͻÿ�.
--    : (1)hiredate �� Ȱ�� ==>
--    : (2)hiredate ���� �⵵, ���� ����
--    : (3)����� �� ���� �׷�ȭ �������� ���\
--    : (4)�Ի� �ο��� ���϶� �Ͽ����Ƿ� COUNT(*) �׷��Լ� ���

-- a) �⵵ ���� : TO_CHAR(e.hiredate, 'YYYY')
--    �� ����   : TO_CHAR(e.hiredate, 'MM')

-- b) �� ���� �������� �׷�ȭ ����
SELECT to_char(e.hiredate, 'YYYY') "�Ի� �⵵"
     , to_char(e.hiredate, 'MM')   "�Ի� ��"
     , COUNT(*) "�ο�(��)"
  FROM emp e
 GROUP BY to_char(e.hiredate, 'YYYY'), to_char(e.hiredate, 'MM')
 ORDER BY "�Ի� �⵵", "�Ի� ��"
 ;

-- c) �⵵��, ���� �Ի� �ο��� ��� ���¸� ���� ǥ ���·�
-- : �⵵ ���� : TO_CHAR(e.hiredate, 'YYYY')
-- : �� ����   : TO_CHAR(e.hiredate, 'MM')

-- : hiredate ���� ������ ���� ���� 01�� ���� ��
--   �� ���� ���� ������ 1�� ���� ī��Ʈ(COUNT(*))
--   �� ������ 12������ �ݺ�

SELECT e.empno
     , e.ename
     , TO_CHAR(e.hiredate, 'YYYY') "�Ի� �⵵"
     , TO_CHAR(e.hiredate, 'MM')   "�Ի� ��"
     , DECODE(to_char(e.hiredate, 'MM'), '01', 1) "1��"
     , DECODE(to_char(e.hiredate, 'MM'), '02', 1) "2��"
     , DECODE(to_char(e.hiredate, 'MM'), '03', 1) "3��"
     , DECODE(to_char(e.hiredate, 'MM'), '04', 1) "4��"
     , DECODE(to_char(e.hiredate, 'MM'), '05', 1) "5��"
     , DECODE(to_char(e.hiredate, 'MM'), '06', 1) "6��"
     , DECODE(to_char(e.hiredate, 'MM'), '07', 1) "7��"
     , DECODE(to_char(e.hiredate, 'MM'), '08', 1) "8��"
     , DECODE(to_char(e.hiredate, 'MM'), '09', 1) "9��"
     , DECODE(to_char(e.hiredate, 'MM'), '10', 1) "10��"
     , DECODE(to_char(e.hiredate, 'MM'), '11', 1) "11��"
     , DECODE(to_char(e.hiredate, 'MM'), '12', 1) "12��"
  FROM emp e
 ORDER BY "�Ի� �⵵"
;

-- �׷�ȭ ���� �÷��� "�Ի� �⵵"�� ��´�.
-- �� ���� 1��~ 12�� �� 1�� �����ϴ� ������ ����� �ϹǷ� COUNT() ���
SELECT TO_CHAR(e.hiredate, 'YYYY') "�Ի� �⵵"
     , COUNT(DECODE(to_char(e.hiredate, 'MM'), '01', 1)) "1��"
     , COUNT(DECODE(to_char(e.hiredate, 'MM'), '02', 1)) "2��"
     , COUNT(DECODE(to_char(e.hiredate, 'MM'), '03', 1)) "3��"
     , COUNT(DECODE(to_char(e.hiredate, 'MM'), '04', 1)) "4��"
     , COUNT(DECODE(to_char(e.hiredate, 'MM'), '05', 1)) "5��"
     , COUNT(DECODE(to_char(e.hiredate, 'MM'), '06', 1)) "6��"
     , COUNT(DECODE(to_char(e.hiredate, 'MM'), '07', 1)) "7��"
     , COUNT(DECODE(to_char(e.hiredate, 'MM'), '08', 1)) "8��"
     , COUNT(DECODE(to_char(e.hiredate, 'MM'), '09', 1)) "9��"
     , COUNT(DECODE(to_char(e.hiredate, 'MM'), '10', 1)) "10��"
     , COUNT(DECODE(to_char(e.hiredate, 'MM'), '11', 1)) "11��"
     , COUNT(DECODE(to_char(e.hiredate, 'MM'), '12', 1)) "12��"
  FROM emp e
 GROUP BY TO_CHAR(e.hiredate, 'YYYY')
 ORDER BY "�Ի� �⵵"
;

-- ���� �� �Ի� �ο��� ���� ���η� ���
-- �׷�ȭ ���� �÷��� �ʿ� ����
SELECT '�ο�(��)' "�Ի� ��"
     , COUNT(DECODE(to_char(e.hiredate, 'MM'), '01', 1)) "1��"
     , COUNT(DECODE(to_char(e.hiredate, 'MM'), '02', 1)) "2��"
     , COUNT(DECODE(to_char(e.hiredate, 'MM'), '03', 1)) "3��"
     , COUNT(DECODE(to_char(e.hiredate, 'MM'), '04', 1)) "4��"
     , COUNT(DECODE(to_char(e.hiredate, 'MM'), '05', 1)) "5��"
     , COUNT(DECODE(to_char(e.hiredate, 'MM'), '06', 1)) "6��"
     , COUNT(DECODE(to_char(e.hiredate, 'MM'), '07', 1)) "7��"
     , COUNT(DECODE(to_char(e.hiredate, 'MM'), '08', 1)) "8��"
     , COUNT(DECODE(to_char(e.hiredate, 'MM'), '09', 1)) "9��"
     , COUNT(DECODE(to_char(e.hiredate, 'MM'), '10', 1)) "10��"
     , COUNT(DECODE(to_char(e.hiredate, 'MM'), '11', 1)) "11��"
     , COUNT(DECODE(to_char(e.hiredate, 'MM'), '12', 1)) "12��"
  FROM emp e 
;








































