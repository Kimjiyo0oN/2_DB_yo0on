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
