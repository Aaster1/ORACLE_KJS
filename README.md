# Oracle
<span>
-- 커서 실행 단축키 : ctrl + enter
-- 문서 전체 실행 : F5
--jjins

--1. 계정 접속 명령어
--conn 계정명/비밀번호;

--2. SQL은 대/소문자 구분이 없이 인식
--명령어 키워드 대문자, 식별자는 소문자로 루조 사용됨 (스타일대로)
SELECT user_id, username
FROM all_users;
--WHERE username = 'HR';        <- HR계정이 없기 때문에 사용불가

--3.HR계정 생성

--유의 사항
--11g버전 이하 : 어떤 이름으로도 계정 생성 가능
--12g버전 이상 : 'c##'이라는 접두어를 붙여서 계정을 생성하도록 정해놓음.
--하지만 c##붙이면 거슬리잖아? 없이 생성하는방법!
--ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

--테이블 스페이스 변경
-- = HR 계정의 기본 테이블 영역을 'users' 영역으로 지정

--계정이 사용할 수 있는 용량 설정
-- = HR계정의 사용 용량을 무한대로 지정

--계정에 권한을 부여
--GRANT 권한명1,권한명2 TO 계정명;


ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER HR IDENTIFIED BY 123456;
ALTER USER HR DEFAULT TABLESPACE users;
ALTER USER HR QUOTA UNLIMITED ON users;
GRANT connect, resource TO HR;


--계정 삭제
--DROP USER 계정명 [CASCADE];
--계정 잠금 해제
--ALTER USER 계정명 ACCOUNT UNLOCK;

ALTER USER HR ACCOUNT UNLOCK;
DROP USER HR CASCADE;

--HR샘플 스키마(데이터) 가져오기
--1. SQLPLUS
--2. HR 계정 접속
--3. 명령어 입력
--  @[경로]/hr_main.sql
    --@ : 오라클이 설치된 기본 경로
    -- @ ? /demo / schema / human_resources / hr_main.sql
--4. 123456[비밀번호]
--5. users [tablespace]
--6. temp[temp tablespace]
--7. [log 경로] - @ ? /demo / schema / log

C:\Users\tj-bu\Desktop\aster\WINDOWS.X64_193000_db_home\demo\schema\human_resources/hr_main.sql

SELECT * FROM EMP;

--HR샘플 스키마(데이터) 가져오기
--1. SQLPLUS
--2. HR 계정 접속
--3. 명령어 입력
--  @[경로]/hr_main.sql
    --@ : 오라클이 설치된 기본 경로
    -- @ ? /demo / schema / human_resources / hr_main.sql
--4. 123456[비밀번호]
--5. users [tablespace]
--6. temp[temp tablespace]
--7. [log 경로] - @ ? /demo / schema / log

-- C:\Users\tj-bu\Desktop\aster\WINDOWS.X64_193000_db_home\demo\schema\human_resources/hr_main.sql

--간단하게 테이블 구조를 확인하는 방법
DESC employees;

--사원 ID와 이름을 조회하는 SQL문
SELECT employee_id,first_name
FROM employees;

--띄어쓰기가 없으면, 따옴표 생략가능 ex) exployee_id AS 사원 번호 (x) -> 사원번호(o)
-- AS 도 생략 가능 ex) employee_id 사원번호
SELECT employee_id AS 사원번호
,first_name AS 이름
,last_name AS 성
,email AS 이메일
,phone_number AS 전화번호
,hire_date AS 입사일자
,salary AS 급여
FROM employees;

--중복제거 = DISTINCT
--job_id를 중복된 데이터를 제거하고 조희하는 SQL문을 작성하시오
SELECT DISTINCT job_id
FROM employees;

--조건 = WHERE
--급여가 6000을 초과하는 사원의 모든 컬럼을 조회하시오
select *
FROM employees
WHERE salary > 6000;

--급여가 10000인 사원의 모든 컬럼을 조회하는 SQL문을 작성하시오
SELECT *
FROM employees
WHERE salary = 10000;

--내림차순 정렬 = ORDER BY 속성명 DESC.
--오름차순 정렬 = ORDER BY 속성명  또는   ORDER BY 속성명 ASC
--정렬 순서 = 1차적으로 정렬할 것을 먼저, 같은 값에 대한 2차 정렬을 그 다음
-- ex) ORDER 속성1 정렬옵션, 속성2 정렬옵션
--모든 속성들을 salary를 기준으로 내림차순 정렬하고, first_name을 기준으로 오름차순 정렬하여 SQL문을 작성하시오
SELECT *
FROM employees
ORDER BY salary DESC,first_name;

--조건절에서의 같은 속성명에 대해 OR을 수행할 때에는 IN으로 묶어줄 수 있다.

SELECT *
FROM employees
WHERE job_id in ('FI_ACCOUNT','IT_PROG');

--or 사용시

SELECT *
FROM employees
WHERE job_id = 'FI_ACCOUNT'
OR job_id = 'IT_PROG';


-- ~가 아닌 경우는 속성명 앞에 NOT를 붙임으로써 반전시켜준다.
--job_id가 'FI_ACCOUNT'이거나'IT_PROG'가 아닌 사원의 모든 컬럼 조회

SELECT *
FROM employees
WHERE NOT job_id IN ('FI_ACCOUNT','IT_PROG');

--job_id가 'IT_PROG'이면서 salary가 6000이상인 사원의 모든 컬럼 조회
SELECT *
FROM employees
WHERE job_id = 'IT_PROG'
AND salary >= 6000;

--first_name이 'S'로 시작하는 사원의 모든 컬럼 조회
--와일드 카드는 조건절에서 LIKE와 함께 사용 ex) LIKE '_c%'
SELECT *
FROM employees
WHERE first_name LIKE 'S%';

--frist_name이 's'로 끝나는 사원의 모든 칼럼을 조회
SELECT *
FROM employees
WHERE first_name LIKE '%s';

--first_name에 's'가 포함되는 사원의 모든 컬럼을 조회
SELECT *
FROM employees
WHERE first_name LIKE '%s%';

--first_name이 5글자인 사원의 모든 컬럼을 조회
SELECT *
FROM employees
WHERE first_name LIKE'_____'
;
--or
--단일행 함수 legnth()사용
SELECT *
FROM employees
WHERE length(first_name) =2;

--null의 경우는 속성명 = null이 아닌, 속성명 IN NULL을 사용
--COMMISSION_PCT가 null인 사원의 모든 컬럼을 조회
SELECT *
FROM employees
WHERE COMMISSION_PCT IS NULL;

--null이 아닌 경우는 NOT 속성명 = null이 아닌 속성명 IS NOT NULL을 사용
--COMMISSION_PCT가 NULL이 아닌 사원의 모든 컬럼을 조회
SELECT *
FROM employees
WHERE COMMISSION_PCT IS NOT NULL;

--DATE타입의 경우, TO_CHAR()함수로 포맷하며 WHERE절에서 비교가능
--오라클 포맷 방법 : TO_CHAR(데이트 값,'변환할 문자형태')
--mysql 포맷 방법 : DATE_FORMAT(데이트 값, '변환할 문자형태')
--sqlServer 포맷 방법 : CONVERT(데이트 값, 101<mm/dd/yyyy>or 120<yyyy-MM-dd HH:mm:ss>
--103<dd/MM/yyyy> or 126<yyyy-MM-ddTHH:mm:ss.sss> or 12<yy/MM/dd>
--hire_date 가 04년 이상인 모든 컬럼을 조회
SELECT *
FROM employees
WHERE TO_CHAR(hire_date,'YY') >=04;

--또는

SELECT *
FROM employees
WHERE hire_date>=TO_DATE('20040101','yyyyMMDD')
;


--또는

SELECT *
FROM employees
WHERE hire_date >= '04/01/01'       --SQL DEVELOPER에서 문자형 데이터를 DATE로 자동변환함
;
--조건절에서 ~에서 ~ 사이인 경우 속성명 BETWEEN 최소범위비교속성 NAD 최대범위비교속성
--hire_date 가 04년도부터 05년도인 모든 컬럼을 조회
SELECT *
FROM employees
WHERE TO_CHAR(hire_date,'yy') BETWEEN 04 AND 05;

--해당 자리수에서 올림 발생시키는 단일행함수 = CEIL(숫자,올림발생반영위치)
--12.45,-12.45 보다 크거나 같은 정수 중 제일 작은 수를 계산하는 SQL문을 각각 작성하시오.
SELECT CEIL(12.45),CEIL(-12.45)
FROM DUAL
;

--해당 자리에서 내림을 발생시키는 단일행함수 = FLOOR(숫자,내림발생반영위치)
--12.55,-12.55 보다 작거나 같은 정수 중 가장 큰 수를 계산하는 SQL문
SELECT FLOOR(12.55),FLOOR(-12.55)
FROM DUAL
;

--반올림 단일행함수 = ROUND(숫자, 발생반영위치) <-여기까지만 보이게 하겠다는 위치
--0.54 소수 첫째자리 반올림
SELECT ROUND(0.54,0)
FROM DUAL
;

--0.54 소수 둘째자리 반올림
SELECT ROUND(0.54,1)
FROM DUAL
;

--125.67을 1의 자리에서 반올림
SELECT ROUND(125.67,-1) --마이너스로 진행
FROM DUAL
;

--125.67을 10의 자리에서 반올림
SELECT ROUND(125.67,-2)
FROM DUAL
;

--'나머지'를 구하는 단일행 함수 = MOD(당하는 값, 나눌 값)
--3을 8로 나눈 나머지 구하시오
SELECT MOD(3,8)
FROM DUAL
;

SELECT MOD(30,4)
FROM DUAL
;

--제곱을 구하는 단일행 함수 = POWER(제곱할 수, 인수)
--2의 10제곱
SELECT power(2,10)
FROM DUAL
;

--2의 31제곱
SELECT POWER(2,31)
FROM DUAL
;

--제곱근을 구하는 단일행함수 = SQRT(수)
--2의 제곱근
SELECT SQRT(2)
FROM DUAL
;

--100의 제곱근
SELECT SQRT(100)
FROM DUAL
;

--특정 위치를 절삭하는 단일햄함수 = TRUNC(숫자,잘라버릴위치)
--527425.1234를 소수점 첫째 자리에서 절삭
SELECT TRUNC(527425.1234,1)
FROM DUAL
;

--527425.1234를 소수점 둘째 자리에서 절삭
SELECT TRUNC(527425.1234,2)
FROM DUAL
;

--527425.1234를 1의 자리에서 절삭
SELECT TRUNC(527425.1234,0)
fROM DUAL
;

--527425.1234를 10의 자리에서 절삭
SELECT TRUNC(527425.1234,-1)
FROM DUAL
;
</span>
