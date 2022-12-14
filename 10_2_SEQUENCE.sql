/* SEQUENCE(순서, 연속, 수열)
 * 		- 순차적 번호 자동 발생기 역할의 객체
 * 
 * 		-> SEQUENCE 객체를 생성해서 호출하게 되면 
 * 			지정된 범위 내에서 일정한 간격으로 증가하는 숫자가
 * 			순차적으로 출력됨
 * 
 * 		EX) 1부터 10까지 1씩 증가하고 반복하는 시퀀스 객체
 *      1 2 3 4 5 6 7 8 9 10 1 2 3 4 5 6 7 8 9 10 
 * 
 * 		** SEQUENCE는 주로 PK역할의 컬럼에 삽입되는 값을 만드는 용도로 사용  **
 * 		--> 인위적 주식별자
 * 
 *  	 [작성법]
 	 CREATE SEQUENCE 시퀀스이름
 	 [STRAT WITH 숫자] -- 처음 발생시킬 시작값 지정, 생략하면 자동 1이 기본      -시작점 지정
	 [INCREMENT BY 숫자] -- 다음 값에 대한 증가치, 생략하면 자동 1이 기본
	 [MAXVALUE 숫자 | NOMAXVALUE] -- 발생시킬 최대값 지정 (10의 27승 -1)         -범위 설정하는 아이들
	 [MINVALUE 숫자 | NOMINVALUE] -- 최소값 지정 (-10의 26승)					 -범위 설정하는 아이들 
	 [CYCLE | NOCYCLE] -- 값 순환 여부 지정
	 [CACHE 바이트크기 | NOCACHE] -- 캐쉬메모리 기본값은 20바이트, 최소값은 2바이트

	-- 시퀀스의 캐시 메모리는 할당된 크기만큼 미리 다음 값들을 생성해 저장해둠
	-- --> 시퀀스 호출 시 미리 저장되어진 값들을 가져와 반환하므로 
	--     매번 시퀀스를 생성해서 반환하는 것보다 DB속도가 향상됨.


	    ** 시퀀스 사용 방법 **
	    
	    1) 시퀀스명.NEXTVAL : 다음 시퀀스 번호를 얻어옴. (INCREMENT BY만큼 증가된 값)
	                          단, 시퀀스 생성 후 첫 호출인 경우 START WITH의 값을 얻어옴.
	    
	    2) 시퀀스명.CURRVAL : 현재 시퀀스 번호 얻어옴.
	                          단, 시퀀스 생성 후 NEXTVAL 호출 없이 CURRVAL를 호출하면 오류 발생.
 */
--옵션 없이 SEQUENCE 생성
-- 범위 : 1~ 10^38
-- 시작 : 1
-- 반복 X (NOCYCLE)
-- 캐시메모리 200BYTE
CREATE SEQUENCE SEQ_TEST;

--* CURRCAL 주의사항 *
--> CURRVAL는 마지막 NEXTVAL 호출 값을 다시 보여주는 기능
--> NEXTVAL를 먼저 호출해야 CURRVAL 호출이 가능


--생성 되자마자 바로 현재 값 확인
SELECT SEQ_TEST.CURRVAL FROM DUAL;

SELECT SEQ_TEST.NEXTVAL FROM DUAL;  --1
SELECT SEQ_TEST.CURRVAL FROM DUAL;  --1

SELECT SEQ_TEST.NEXTVAL FROM DUAL; --2
SELECT SEQ_TEST.NEXTVAL FROM DUAL; --3
SELECT SEQ_TEST.NEXTVAL FROM DUAL; --4
SELECT SEQ_TEST.NEXTVAL FROM DUAL; --5

SELECT SEQ_TEST.CURRVAL FROM DUAL; --5

---------------------------------------------------------------------------------------------
-- 실제 사용 예시
CREATE TABLE TEST_TB(
	TEST_ID NUMBER
);

CREATE SEQUENCE SEQ_TEST_TB
INCREMENT BY 1                                      --증감숫자가 양수면 증가 음수면 감소 디폴트는 1
START WITH TO_NUMBER(EXTRACT(YEAR FROM SYSDATE)||'0000')                                        -- 시작숫자의 디폴트값은 증가일때 MINVALUE 감소일때 MAXVALUE
MINVALUE TO_NUMBER(EXTRACT(YEAR FROM SYSDATE)||'0000')                     -- NOMINVALUE : 디폴트값 설정, 증가일때 1, 감소일때 -1028 
                                                    -- MINVALUE : 최소값 설정, 시작숫자와 작거나 같아야하고 MAXVALUE보다 작아야함
MAXVALUE TO_NUMBER(EXTRACT(YEAR FROM SYSDATE)||'9999')                     -- NOMAXVALUE : 디폴트값 설정, 증가일때 1027, 감소일때 -1
                               					    -- MAXVALUE : 최대값 설정, 시작숫자와 같거나 커야하고 MINVALUE보다 커야함
NOCYCLE                                             --CYCLE 설정시 최대값에 도달하면 최소값부터 다시 시작 NOCYCLE 설정시 최대값 생성 시 시퀀스 생성중지
NOCACHE;

DELETE FROM EMPLOYEE2;
SELECT MAX(EMP_ID) FROM EMPLOYEE2;
ROLLBACK;

SELECT EXTRACT(YEAR FROM SYSDATE) FROM DUAL;

SELECT
	CASE 
		WHEN (SELECT MAX(EMP_ID) FROM EMPLOYEE2) IS NULL
		THEN TO_NUMBER(EXTRACT(YEAR FROM SYSDATE)||'0001')
		ELSE TO_NUMBER(EXTRACT(YEAR FROM SYSDATE)||'0000') + (SELECT MAX(EMP_ID) FROM EMPLOYEE2) + 1
	END 번호
FROM DUAL;




SELECT * FROM EMP_TEMP;
INSERT INTO EMP_TEMP VALUES(900,'홍길동');

--223번부터 20씩 증가하는 시퀀스 생성 
CREATE SEQUENCE SEQ_TEMP
START WITH 223      --223시작
INCREMENT BY 10		--10씩 증가
NOCYCLE				--반복X (NOCYCLE은 기본값)
NOCACHE;            --캐시X (CACHE 20 기본값)

--EMP_TEMP 테이블에 사원 정보 삽입
INSERT INTO EMP_TEMP VALUES(SEQ_TEMP.NEXTVAL,'홍길동');

SELECT * FROM EMP_TEMP 
ORDER BY EMP_ID DESC;

--------------------

--SEQUENCE 수정
/*
ALTER SEQUENCE 시퀀스이름
[INCREMENT BY 숫자] -- 다음 값에 대한 증가치, 생략하면 자동 1이 기본
[MAXVALUE 숫자 | NOMAXVALUE] -- 발생시킬 최대값 지정 (10의 27승 -1)         -범위 설정하는 아이들
[MINVALUE 숫자 | NOMINVALUE] -- 최소값 지정 (-10의 26승)					 -범위 설정하는 아이들 
[CYCLE | NOCYCLE] -- 값 순환 여부 지정
[CACHE 바이트크기 | NOCACHE] -- 캐쉬메모리 기본값은 20바이트, 최소값은 2바이트
*/

-- SEQ_TEMP 를 1씩 증가하는 형태로 변경
ALTER SEQUENCE SEQ_TEMP
INCREMENT BY 1;

INSERT INTO EMP_TEMP VALUES(SEQ_TEMP.NEXTVAL,'이길동');

SELECT * FROM EMP_TEMP 
ORDER BY 1 DESC;

-- 
DROP TABLE EMP_TEMP;
DROP VIEW V_DCOPY2;
DROP SEQUENCE SEQ_TEMP;
DELETE FROM EMPLOYEE WHERE EMP_NAME = '홍길동';