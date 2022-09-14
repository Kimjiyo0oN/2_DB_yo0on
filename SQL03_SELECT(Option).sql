--1.
SELECT STUDENT_NAME , STUDENT_ADDRESS 
FROM TB_STUDENT
ORDER BY STUDENT_NAME;

--2.
SELECT STUDENT_NAME , STUDENT_SSN 
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY SUBSTR(STUDENT_SSN,1,6) DESC; --TRUNC(MONTHS_BETWEEN(SYSDATE,SUBSTR(STUDENT_SSN,1,6))/12)

--3.
SELECT STUDENT_NAME , STUDENT_NO ,STUDENT_ADDRESS
FROM TB_STUDENT
WHERE STUDENT_NO LIKE '9%'
AND SUBSTR(STUDENT_ADDRESS,1,3) IN ('경기도','강원도');

--4. 
SELECT PROFESSOR_NAME , PROFESSOR_SSN 
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME = '법학과')
ORDER BY SUBSTR(PROFESSOR_SSN,1,2);

--5.
SELECT STUDENT_NO , POINT 
FROM (SELECT RANK() OVER(ORDER BY POINT DESC,STUDENT_NO) 순서, STUDENT_NO , POINT 
FROM TB_GRADE 
WHERE TERM_NO = '200402' AND CLASS_NO = 'C3118100')
ORDER BY 순서;

--SELECT RANK() OVER(ORDER BY POINT DESC,STUDENT_NO), STUDENT_NO , POINT 
--FROM TB_GRADE 
--WHERE TERM_NO = '200402' AND CLASS_NO = 'C3118100';

--6
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME 
FROM TB_STUDENT
LEFT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
ORDER BY STUDENT_NAME;

SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME 
FROM TB_STUDENT
LEFT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
ORDER BY (SUBSTR(STUDENT_NAME,2,3));

--7
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO);

--8
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS_PROFESSOR
JOIN TB_PROFESSOR USING(PROFESSOR_NO)
JOIN TB_CLASS USING(CLASS_NO);



--9
--8번의 결과 중 '인문 사회' 계열에 속한 과목의 교수 이름을 찾으려고 한다.
--이에 해당하는 과목 이름과 교수 이름을 출력하는 SQL문을 작성하시오.
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS_PROFESSOR
JOIN TB_PROFESSOR USING(PROFESSOR_NO)
JOIN TB_CLASS USING(CLASS_NO)
WHERE PROFESSOR_NO IN (SELECT PROFESSOR_NO
					FROM TB_PROFESSOR 
					JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
					WHERE CATEGORY = '인문사회');

--10.
--'음악학과' 학생들의 평점을 구하려고 한다. 음악학과 학생들의 "학번", "학생 이름", "전체 평점"을 출력하는
--SQL 문장을 작성하시오.(단, 평점은 소수점 1자리까지만 반올림하여 표시한다.)
				
--SELECT STUDENT_NAME "학생 이름", ROUND(AVG(POINT),1) "전체 평점"
--FROM TB_STUDENT 
--JOIN TB_GRADE USING(STUDENT_NO)
--JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
--WHERE DEPARTMENT_NAME ='음악학과'
--GROUP BY STUDENT_NAME;

SELECT STUDENT_NO, STUDENT_NAME ,ROUND(AVG(POINT),1) "전체 평점"
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME ='음악학과'
GROUP BY STUDENT_NO , STUDENT_NAME;

--11
--학번이 A313047인 학생이 학교에 나오고 있지 않다. 지도 교수에게 내용을 전달하기 위한 학과 이름, 학생
--이름과 지도 교수 이름이 필요하다. 이때 사용할 SQL문을 작성하시오.
--단, 출력헤더는 “학과이름”, “학생이름”, “지도교수이름” 으로 출력되도록 한다.

SELECT DEPARTMENT_NAME,STUDENT_NAME, PROFESSOR_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_PROFESSOR ON (PROFESSOR_NO = COACH_PROFESSOR_NO)
WHERE STUDENT_NO = 'A313047';

--12
--2007년도에 '인간관계론' 과목을 수강한 학생을 찾아
--학생이름과 수강학기를 표시하는 SQL 문장을 작성하시오.

SELECT STUDENT_NAME, TERM_NO
FROM TB_GRADE
JOIN TB_STUDENT USING(STUDENT_NO)
JOIN TB_CLASS USING(CLASS_NO)
WHERE CLASS_NAME = '인간관계론' AND SUBSTR(TERM_NO, 1,4) = '2007';

--13번 (담당과목교슈 배정 안받은 게 뭐임?)
--예체능 계열 과목 중 과목 담당교수를 한 명도 배정받지 못한 과목을 찾아
--그 과목 이름과 학과 이름을 출력하는 SQL 문장을 작성하시오.
--(기존 워크북 PDF에 나타난 조회 결과는 DB 버전이 낮아 현재와 조회 방식이 다름.
--결과 행의 수만 동일하게 조회하자)

SELECT DEPARTMENT_NAME,CLASS_NAME
FROM TB_DEPARTMENT
JOIN TB_CLASS USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NO NOT IN (SELECT DISTINCT DEPARTMENT_NO 
                     FROM TB_PROFESSOR WHERE DEPARTMENT_NO IS NOT NULL)
AND CATEGORY = '예체능';

---이게 정답쓰
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS 
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
LEFT JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
WHERE PROFESSOR_NO IS NULL AND CATEGORY = '예체능';

--14번
--춘 기술대학교 서반아어학과 학생들의 지도교수를 게시하고자 한다.
--학생이름과 지도교수 이름을 찾고 만일 지도 교수가 없는 학생일 경우
--"지도교수 미지정"으로 표시하도록 하는 SQL 문을 작성하시오.
--단 출력헤더는 "학생이름", "지도교수"로 표시하며 고학번 학생이 먼저 표시되도록 한다.


SELECT STUDENT_NAME ,NVL(PROFESSOR_NAME ,'지도교수 미지정')  
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
LEFT JOIN TB_PROFESSOR ON (PROFESSOR_NO = COACH_PROFESSOR_NO)
WHERE DEPARTMENT_NAME ='서반아어학과'
ORDER BY STUDENT_NO;

--15.
--휴학생이 아닌 학생 중 평점이 4.0 이상인 학생을 찾아 그 학생의 학번, 이름, 학과, 이름, 평점을 출력하는
--SQL문을 작성하시오.

SELECT STUDENT_NO , STUDENT_NAME , DEPARTMENT_NAME, AVG(POINT) 
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
JOIN TB_GRADE USING (STUDENT_NO)
WHERE ABSENCE_YN = 'N'
GROUP BY STUDENT_NO , STUDENT_NAME , DEPARTMENT_NAME
HAVING AVG(POINT) >= 4.0;

--16.
--환경조경학과 전공과목들의 과목 별 평점을 파악할 수 있는 SQL 문을 작성하시오.
--SELECT CLASS_NO, CLASS_NAME, AVG(POINT) 
--FROM TB_GRADE
--JOIN TB_CLASS USING (CLASS_NO)
--WHERE CLASS_NO = 
--(SELECT CLASS_NO FROM TB_CLASS JOIN TB_DEPARTMENT USING(DEPARTMENT_NO) WHERE DEPARTMENT_NAME = '환경조경학과')
--GROUP BY CLASS_NO,CLASS_NAME;

SELECT CLASS_NO, CLASS_NAME, AVG(POINT) 
FROM TB_GRADE
JOIN TB_CLASS USING (CLASS_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
GROUP BY CLASS_NO,CLASS_NAME ,DEPARTMENT_NAME,CLASS_TYPE
HAVING DEPARTMENT_NAME ='환경조경학과' AND CLASS_TYPE LIKE '전공%';


--17.
--춘 기술대학교에 다니고 있는 최경희 학생과 같은 과 학생들의 이름과 주소를 출력하는 SQL 문을
--작성하시오.

SELECT STUDENT_NAME , STUDENT_ADDRESS 
FROM TB_STUDENT
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO FROM TB_STUDENT WHERE STUDENT_NAME='최경희') ;

--18
--국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 표시하는 SQL문을 작성하시오

--SELECT STUDENT_NO ,STUDENT_NAME, RANK() OVER(ORDER BY AVG(POINT) DESC),AVG(POINT)
--FROM TB_STUDENT
--JOIN TB_GRADE USING(STUDENT_NO)
--JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
--WHERE DEPARTMENT_NAME ='국어국문학과'
--GROUP BY STUDENT_NO ,STUDENT_NAME;

SELECT STUDENT_NO ,STUDENT_NAME
FROM (SELECT STUDENT_NO ,STUDENT_NAME, RANK() OVER(ORDER BY AVG(POINT) DESC) 순위
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME ='국어국문학과'
GROUP BY STUDENT_NO ,STUDENT_NAME)
WHERE 순위 = 1;

--19.
--춘 기술대학교의 "환경조경학과"가 속한 같은 계열 학과들의 학과 별 전공과목 평점을 파악하기 위한
--적절한 SQL문을 찾아내시오.
--단, 출력헤더는 "계열 학과명", "전공평점"으로 표시되도록 하고, 평점은 소수점 한자리까지만 반올림하여
--표시되도록 한다.

SELECT DEPARTMENT_NAME, ROUND(AVG(POINT),1)
FROM TB_GRADE
JOIN TB_CLASS USING(CLASS_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE CATEGORY =(SELECT CATEGORY FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME ='환경조경학과')
GROUP BY DEPARTMENT_NAME;







