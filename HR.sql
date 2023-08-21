-- Ŀ�� ���� ����Ű : ctrl + enter
-- ���� ��ü ���� : F5


--1. ���� ���� ��ɾ�
--conn ������/��й�ȣ;

--2. SQL�� ��/�ҹ��� ������ ���� �ν�
--��ɾ� Ű���� �빮��, �ĺ��ڴ� �ҹ��ڷ� ���� ���� (��Ÿ�ϴ��)
SELECT user_id, username
FROM all_users;
--WHERE username = 'HR';        <- HR������ ���� ������ ���Ұ�

--3.HR���� ����

--���� ����
--11g���� ���� : � �̸����ε� ���� ���� ����
--12g���� �̻� : 'c##'�̶�� ���ξ �ٿ��� ������ �����ϵ��� ���س���.
--������ c##���̸� �Ž����ݾ�? ���� �����ϴ¹��!
--ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

--���̺� �����̽� ����
-- = HR ������ �⺻ ���̺� ������ 'users' �������� ����

--������ ����� �� �ִ� �뷮 ����
-- = HR������ ��� �뷮�� ���Ѵ�� ����

--������ ������ �ο�
--GRANT ���Ѹ�1,���Ѹ�2 TO ������;


ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER HR IDENTIFIED BY 123456;
ALTER USER HR DEFAULT TABLESPACE users;
ALTER USER HR QUOTA UNLIMITED ON users;
GRANT connect, resource TO HR;


--���� ����
--DROP USER ������ [CASCADE];
--���� ��� ����
--ALTER USER ������ ACCOUNT UNLOCK;

ALTER USER HR ACCOUNT UNLOCK;
DROP USER HR CASCADE;

--HR���� ��Ű��(������) ��������
--1. SQLPLUS
--2. HR ���� ����
--3. ��ɾ� �Է�
--  @[���]/hr_main.sql
    --@ : ����Ŭ�� ��ġ�� �⺻ ���
    -- @ ? /demo / schema / human_resources / hr_main.sql
--4. 123456[��й�ȣ]
--5. users [tablespace]
--6. temp[temp tablespace]
--7. [log ���] - @ ? /demo / schema / log

C:\Users\tj-bu\Desktop\aster\WINDOWS.X64_193000_db_home\demo\schema\human_resources/hr_main.sql

SELECT * FROM EMP;

--HR���� ��Ű��(������) ��������
--1. SQLPLUS
--2. HR ���� ����
--3. ��ɾ� �Է�
--  @[���]/hr_main.sql
    --@ : ����Ŭ�� ��ġ�� �⺻ ���
    -- @ ? /demo / schema / human_resources / hr_main.sql
--4. 123456[��й�ȣ]
--5. users [tablespace]
--6. temp[temp tablespace]
--7. [log ���] - @ ? /demo / schema / log

-- C:\Users\tj-bu\Desktop\aster\WINDOWS.X64_193000_db_home\demo\schema\human_resources/hr_main.sql

--�����ϰ� ���̺� ������ Ȯ���ϴ� ���
DESC employees;

--��� ID�� �̸��� ��ȸ�ϴ� SQL��
SELECT employee_id,first_name
FROM employees;

--���Ⱑ ������, ����ǥ �������� ex) exployee_id AS ��� ��ȣ (x) -> �����ȣ(o)
-- AS �� ���� ���� ex) employee_id �����ȣ
SELECT employee_id AS �����ȣ
,first_name AS �̸�
,last_name AS ��
,email AS �̸���
,phone_number AS ��ȭ��ȣ
,hire_date AS �Ի�����
,salary AS �޿�
FROM employees;

--�ߺ����� = DISTINCT
--job_id�� �ߺ��� �����͸� �����ϰ� �����ϴ� SQL���� �ۼ��Ͻÿ�
SELECT DISTINCT job_id
FROM employees;

--���� = WHERE
--�޿��� 6000�� �ʰ��ϴ� ����� ��� �÷��� ��ȸ�Ͻÿ�
select *
FROM employees
WHERE salary > 6000;

--�޿��� 10000�� ����� ��� �÷��� ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�
SELECT *
FROM employees
WHERE salary = 10000;

--�������� ���� = ORDER BY �Ӽ��� DESC.
--�������� ���� = ORDER BY �Ӽ���  �Ǵ�   ORDER BY �Ӽ��� ASC
--���� ���� = 1�������� ������ ���� ����, ���� ���� ���� 2�� ������ �� ����
-- ex) ORDER �Ӽ�1 ���Ŀɼ�, �Ӽ�2 ���Ŀɼ�
--��� �Ӽ����� salary�� �������� �������� �����ϰ�, first_name�� �������� �������� �����Ͽ� SQL���� �ۼ��Ͻÿ�
SELECT *
FROM employees
ORDER BY salary DESC,first_name;

--������������ ���� �Ӽ��� ���� OR�� ������ ������ IN���� ������ �� �ִ�.

SELECT *
FROM employees
WHERE job_id in ('FI_ACCOUNT','IT_PROG');

--or ����

SELECT *
FROM employees
WHERE job_id = 'FI_ACCOUNT'
OR job_id = 'IT_PROG';


-- ~�� �ƴ� ���� �Ӽ��� �տ� NOT�� �������ν� ���������ش�.
--job_id�� 'FI_ACCOUNT'�̰ų�'IT_PROG'�� �ƴ� ����� ��� �÷� ��ȸ

SELECT *
FROM employees
WHERE NOT job_id IN ('FI_ACCOUNT','IT_PROG');

--job_id�� 'IT_PROG'�̸鼭 salary�� 6000�̻��� ����� ��� �÷� ��ȸ
SELECT *
FROM employees
WHERE job_id = 'IT_PROG'
AND salary >= 6000;

--first_name�� 'S'�� �����ϴ� ����� ��� �÷� ��ȸ
--���ϵ� ī��� ���������� LIKE�� �Բ� ��� ex) LIKE '_c%'
SELECT *
FROM employees
WHERE first_name LIKE 'S%';

--frist_name�� 's'�� ������ ����� ��� Į���� ��ȸ
SELECT *
FROM employees
WHERE first_name LIKE '%s';

--first_name�� 's'�� ���ԵǴ� ����� ��� �÷��� ��ȸ
SELECT *
FROM employees
WHERE first_name LIKE '%s%';

--first_name�� 5������ ����� ��� �÷��� ��ȸ
SELECT *
FROM employees
WHERE first_name LIKE'_____'
;
--or
--������ �Լ� legnth()���
SELECT *
FROM employees
WHERE length(first_name) =2;

--null�� ���� �Ӽ��� = null�� �ƴ�, �Ӽ��� IN NULL�� ���
--COMMISSION_PCT�� null�� ����� ��� �÷��� ��ȸ
SELECT *
FROM employees
WHERE COMMISSION_PCT IS NULL;

--null�� �ƴ� ���� NOT �Ӽ��� = null�� �ƴ� �Ӽ��� IS NOT NULL�� ���
--COMMISSION_PCT�� NULL�� �ƴ� ����� ��� �÷��� ��ȸ
SELECT *
FROM employees
WHERE COMMISSION_PCT IS NOT NULL;

--DATEŸ���� ���, TO_CHAR()�Լ��� �����ϸ� WHERE������ �񱳰���
--����Ŭ ���� ��� : TO_CHAR(����Ʈ ��,'��ȯ�� ��������')
--mysql ���� ��� : DATE_FORMAT(����Ʈ ��, '��ȯ�� ��������')
--sqlServer ���� ��� : CONVERT(����Ʈ ��, 101<mm/dd/yyyy>or 120<yyyy-MM-dd HH:mm:ss>
--103<dd/MM/yyyy> or 126<yyyy-MM-ddTHH:mm:ss.sss> or 12<yy/MM/dd>
--hire_date �� 04�� �̻��� ��� �÷��� ��ȸ
SELECT *
FROM employees
WHERE TO_CHAR(hire_date,'YY') >=04;

--�Ǵ�

SELECT *
FROM employees
WHERE hire_date>=TO_DATE('20040101','yyyyMMDD')
;


--�Ǵ�

SELECT *
FROM employees
WHERE hire_date >= '04/01/01'       --SQL DEVELOPER���� ������ �����͸� DATE�� �ڵ���ȯ��
;
--���������� ~���� ~ ������ ��� �Ӽ��� BETWEEN �ּҹ����񱳼Ӽ� NAD �ִ�����񱳼Ӽ�
--hire_date �� 04�⵵���� 05�⵵�� ��� �÷��� ��ȸ
SELECT *
FROM employees
WHERE TO_CHAR(hire_date,'yy') BETWEEN 04 AND 05;

--�ش� �ڸ������� �ø� �߻���Ű�� �������Լ� = CEIL(����,�ø��߻��ݿ���ġ)
--12.45,-12.45 ���� ũ�ų� ���� ���� �� ���� ���� ���� ����ϴ� SQL���� ���� �ۼ��Ͻÿ�.
SELECT CEIL(12.45),CEIL(-12.45)
FROM DUAL
;

--�ش� �ڸ����� ������ �߻���Ű�� �������Լ� = FLOOR(����,�����߻��ݿ���ġ)
--12.55,-12.55 ���� �۰ų� ���� ���� �� ���� ū ���� ����ϴ� SQL��
SELECT FLOOR(12.55),FLOOR(-12.55)
FROM DUAL
;

--�ݿø� �������Լ� = ROUND(����, �߻��ݿ���ġ) <-��������� ���̰� �ϰڴٴ� ��ġ
--0.54 �Ҽ� ù°�ڸ� �ݿø�
SELECT ROUND(0.54,0)
FROM DUAL
;

--0.54 �Ҽ� ��°�ڸ� �ݿø�
SELECT ROUND(0.54,1)
FROM DUAL
;

--125.67�� 1�� �ڸ����� �ݿø�
SELECT ROUND(125.67,-1) --���̳ʽ��� ����
FROM DUAL
;

--125.67�� 10�� �ڸ����� �ݿø�
SELECT ROUND(125.67,-2)
FROM DUAL
;

--'������'�� ���ϴ� ������ �Լ� = MOD(���ϴ� ��, ���� ��)
--3�� 8�� ���� ������ ���Ͻÿ�
SELECT MOD(3,8)
FROM DUAL
;

SELECT MOD(30,4)
FROM DUAL
;

--������ ���ϴ� ������ �Լ� = POWER(������ ��, �μ�)
--2�� 10����
SELECT power(2,10)
FROM DUAL
;

--2�� 31����
SELECT POWER(2,31)
FROM DUAL
;

--�������� ���ϴ� �������Լ� = SQRT(��)
--2�� ������
SELECT SQRT(2)
FROM DUAL
;

--100�� ������
SELECT SQRT(100)
FROM DUAL
;

--Ư�� ��ġ�� �����ϴ� �������Լ� = TRUNC(����,�߶������ġ)
--527425.1234�� �Ҽ��� ù° �ڸ����� ����
SELECT TRUNC(527425.1234,1)
FROM DUAL
;

--527425.1234�� �Ҽ��� ��° �ڸ����� ����
SELECT TRUNC(527425.1234,2)
FROM DUAL
;

--527425.1234�� 1�� �ڸ����� ����
SELECT TRUNC(527425.1234,0)
fROM DUAL
;

--527425.1234�� 10�� �ڸ����� ����
SELECT TRUNC(527425.1234,-1)
FROM DUAL
;