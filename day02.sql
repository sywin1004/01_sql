-- DAY 02 
-- SCOTT ���� EMP ���̺� ��ȸ
SELECT *
  FROM emp
  ;
-- SCOTT ���� DEPT ���̺� ��ȸ
SELECT *
  FROM dept
;
-- emp ���̺��� job �÷��� ��ȸ
SELECT job
  FROM emp
;
/*
CLERK
SALESMAN
SALESMAN
MANAGER
SALESMAN
MANAGER
MANAGER
PRESIDENT
SALESMAN
CLERK
ANALYST
CLERK
*/
--  2)  emp ���̺��� �ߺ��� �����Ͽ�
--      job �÷��� ��ȸ
SELECT DISTINCT job
  FROM emp
  ;
  -- => �� JOB �� �ѹ����� ��ȸ�� ���
  --  �� ���� �� �ִ�.
  -- �� ����� ȸ�翡�� �ټ�������
  -- JOB�� ������ Ȯ���� �� �ִ�.
 /* ���� �� �ּ�
job
-------------
CLERK
SALESMAN
ANALYST
MANAGER
PRESIDENT
*/