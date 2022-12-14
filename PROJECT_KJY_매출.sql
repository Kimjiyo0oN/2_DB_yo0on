

SELECT STOCK_NO, STOCK_ST_DATE, ST.PRODUCT_CODE, PRODUCT_PRICE*(1-SALES_PER) PRODUCT_PRICE, AMOUNT ,TEAM_CODE ,PRODUCT_PRICE*AMOUNT 매출
FROM STOCK_TB ST
JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
JOIN PRODUCT_PRICE_TB PPT ON (ST.PRODUCT_CODE = PPT.PRODUCT_CODE)
JOIN SALES_TB USING(SALES_CODE)
WHERE IN_OUT_SALES_ST = 'SALES'
AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE
AND PRICE_NO= (SELECT MAX(PRICE_NO)
				FROM STOCK_TB ST2
				JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST2.PRODUCT_CODE)
				JOIN PRODUCT_PRICE_TB PPT ON (ST2.PRODUCT_CODE = PPT.PRODUCT_CODE)
				JOIN SALES_TB USING(SALES_CODE)
				WHERE IN_OUT_SALES_ST = 'SALES'
				AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE
				AND ST2.STOCK_NO = ST.STOCK_NO)
UNION 
SELECT STOCK_NO, STOCK_ST_DATE,ST.PRODUCT_CODE,PRODUCT_PRICE, AMOUNT,TEAM_CODE  , PRODUCT_PRICE*AMOUNT 매출
FROM STOCK_TB ST
JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
WHERE IN_OUT_SALES_ST = 'SALES'
AND STOCK_NO NOT IN (SELECT DISTINCT STOCK_NO
	FROM STOCK_TB ST
	JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
	JOIN PRODUCT_PRICE_TB PPT ON (ST.PRODUCT_CODE = PPT.PRODUCT_CODE)
	JOIN SALES_TB USING(SALES_CODE)
	WHERE IN_OUT_SALES_ST = 'SALES'
	AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE)
ORDER BY 1;



SELECT STOCK_NO, STOCK_ST_DATE, ST.PRODUCT_CODE, PRODUCT_PRICE*(1-SALES_PER) PRODUCT_PRICE, AMOUNT ,TEAM_CODE ,PRODUCT_PRICE*(1-SALES_PER)*AMOUNT 매출
FROM STOCK_TB ST
JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
JOIN PRODUCT_PRICE_TB PPT ON (ST.PRODUCT_CODE = PPT.PRODUCT_CODE)
JOIN SALES_TB USING(SALES_CODE)
WHERE IN_OUT_SALES_ST = 'SALES'
AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE
AND PRICE_NO= (SELECT MAX(PRICE_NO)
				FROM STOCK_TB ST2
				JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST2.PRODUCT_CODE)
				JOIN PRODUCT_PRICE_TB PPT ON (ST2.PRODUCT_CODE = PPT.PRODUCT_CODE)
				JOIN SALES_TB USING(SALES_CODE)
				WHERE IN_OUT_SALES_ST = 'SALES'
				AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE
				AND ST2.STOCK_NO = ST.STOCK_NO)
UNION 
SELECT STOCK_NO, STOCK_ST_DATE,ST.PRODUCT_CODE,PRODUCT_PRICE, AMOUNT,TEAM_CODE  , PRODUCT_PRICE*AMOUNT 매출
FROM STOCK_TB ST
JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
WHERE IN_OUT_SALES_ST = 'SALES'
AND STOCK_NO NOT IN (SELECT DISTINCT STOCK_NO
	FROM STOCK_TB ST
	JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
	JOIN PRODUCT_PRICE_TB PPT ON (ST.PRODUCT_CODE = PPT.PRODUCT_CODE)
	JOIN SALES_TB USING(SALES_CODE)
	WHERE IN_OUT_SALES_ST = 'SALES'
	AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE)
ORDER BY 1;

--------------------------------------------------------------------------------------------------------------------------------
SELECT SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5),SUM(AMOUNT)  ,TEAM_CODE ,SUM(PRODUCT_PRICE*(1-SALES_PER)*AMOUNT)  매출
FROM STOCK_TB ST
JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
JOIN PRODUCT_PRICE_TB PPT ON (ST.PRODUCT_CODE = PPT.PRODUCT_CODE)
JOIN SALES_TB USING(SALES_CODE)
WHERE IN_OUT_SALES_ST = 'SALES'
AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE
AND PRICE_NO= (SELECT MAX(PRICE_NO)
				FROM STOCK_TB ST2
				JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST2.PRODUCT_CODE)
				JOIN PRODUCT_PRICE_TB PPT ON (ST2.PRODUCT_CODE = PPT.PRODUCT_CODE)
				JOIN SALES_TB USING(SALES_CODE)
				WHERE IN_OUT_SALES_ST = 'SALES'
				AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE
				AND ST2.STOCK_NO = ST.STOCK_NO)
GROUP BY SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5) ,TEAM_CODE;

----------------------------------------------------------------------------------------------------------------------------------------------
SELECT SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5),SUM(AMOUNT)  ,TEAM_CODE ,SUM(매출)  매출
FROM (SELECT STOCK_ST_DATE, AMOUNT ,TEAM_CODE ,PRODUCT_PRICE*(1-SALES_PER)*AMOUNT 매출
FROM STOCK_TB ST
JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
JOIN PRODUCT_PRICE_TB PPT ON (ST.PRODUCT_CODE = PPT.PRODUCT_CODE)
JOIN SALES_TB USING(SALES_CODE)
WHERE IN_OUT_SALES_ST = 'SALES'
AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE
AND PRICE_NO= (SELECT MAX(PRICE_NO)
				FROM STOCK_TB ST2
				JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST2.PRODUCT_CODE)
				JOIN PRODUCT_PRICE_TB PPT ON (ST2.PRODUCT_CODE = PPT.PRODUCT_CODE)
				JOIN SALES_TB USING(SALES_CODE)
				WHERE IN_OUT_SALES_ST = 'SALES'
				AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE
				AND ST2.STOCK_NO = ST.STOCK_NO)
UNION 
SELECT STOCK_ST_DATE, AMOUNT, TEAM_CODE  , PRODUCT_PRICE*AMOUNT 매출
FROM STOCK_TB ST
JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
WHERE IN_OUT_SALES_ST = 'SALES'
AND STOCK_NO NOT IN (SELECT DISTINCT STOCK_NO
	FROM STOCK_TB ST
	JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
	JOIN PRODUCT_PRICE_TB PPT ON (ST.PRODUCT_CODE = PPT.PRODUCT_CODE)
	JOIN SALES_TB USING(SALES_CODE)
	WHERE IN_OUT_SALES_ST = 'SALES'
	AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE)
ORDER BY 1)
GROUP BY SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5) ,TEAM_CODE
--HAVING TEAM_CODE = 'DM001'
ORDER BY 3,1;








--------------------------------------------------
--BEST 상품
-------------------------------------------------------------------------------------------------------------------------------------------
SELECT 월, 상품코드, 상품이름, SUM(수량) 수량, 팀코드, SUM(매출) 매출
FROM (SELECT SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5) 월, ST.PRODUCT_CODE 상품코드, PRODUCT_NAME 상품이름, AMOUNT 수량,TEAM_CODE 팀코드,PRODUCT_PRICE*(1-SALES_PER)*AMOUNT 매출
FROM STOCK_TB ST
JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
JOIN PRODUCT_PRICE_TB PPT ON (ST.PRODUCT_CODE = PPT.PRODUCT_CODE)
JOIN SALES_TB USING(SALES_CODE)
WHERE IN_OUT_SALES_ST = 'SALES'
AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE
AND PRICE_NO= (SELECT MAX(PRICE_NO)
				FROM STOCK_TB ST2
				JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST2.PRODUCT_CODE)
				JOIN PRODUCT_PRICE_TB PPT ON (ST2.PRODUCT_CODE = PPT.PRODUCT_CODE)
				JOIN SALES_TB USING(SALES_CODE)
				WHERE IN_OUT_SALES_ST = 'SALES'
				AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE
				AND ST2.STOCK_NO = ST.STOCK_NO)
UNION 
SELECT SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5) 월,ST.PRODUCT_CODE 상품코드,PRODUCT_NAME 상품이름, AMOUNT 수량,TEAM_CODE 팀코드, PRODUCT_PRICE*AMOUNT 매출
FROM STOCK_TB ST
JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
WHERE IN_OUT_SALES_ST = 'SALES'
AND STOCK_NO NOT IN (SELECT DISTINCT STOCK_NO
	FROM STOCK_TB ST
	JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
	JOIN PRODUCT_PRICE_TB PPT ON (ST.PRODUCT_CODE = PPT.PRODUCT_CODE)
	JOIN SALES_TB USING(SALES_CODE)
	WHERE IN_OUT_SALES_ST = 'SALES'
	AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE)
ORDER BY 1)
GROUP BY 월 ,상품코드 , 상품이름, 팀코드
ORDER BY 1,5,6 DESC;
-----------------------------------------------------------------------------------------------------------------
SELECT 상품코드, 상품이름, SUM(수량) 수량, 팀코드, SUM(매출) 매출
FROM (SELECT SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5) 월, ST.PRODUCT_CODE 상품코드, PRODUCT_NAME 상품이름, AMOUNT 수량,TEAM_CODE 팀코드,PRODUCT_PRICE*(1-SALES_PER)*AMOUNT 매출
FROM STOCK_TB ST
JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
JOIN PRODUCT_PRICE_TB PPT ON (ST.PRODUCT_CODE = PPT.PRODUCT_CODE)
JOIN SALES_TB USING(SALES_CODE)
WHERE IN_OUT_SALES_ST = 'SALES'
AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE
AND PRICE_NO= (SELECT MAX(PRICE_NO)
				FROM STOCK_TB ST2
				JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST2.PRODUCT_CODE)
				JOIN PRODUCT_PRICE_TB PPT ON (ST2.PRODUCT_CODE = PPT.PRODUCT_CODE)
				JOIN SALES_TB USING(SALES_CODE)
				WHERE IN_OUT_SALES_ST = 'SALES'
				AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE
				AND ST2.STOCK_NO = ST.STOCK_NO)
UNION 
SELECT SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5) 월,ST.PRODUCT_CODE 상품코드,PRODUCT_NAME 상품이름, AMOUNT 수량,TEAM_CODE 팀코드, PRODUCT_PRICE*AMOUNT 매출
FROM STOCK_TB ST
JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
WHERE IN_OUT_SALES_ST = 'SALES'
AND STOCK_NO NOT IN (SELECT DISTINCT STOCK_NO
	FROM STOCK_TB ST
	JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
	JOIN PRODUCT_PRICE_TB PPT ON (ST.PRODUCT_CODE = PPT.PRODUCT_CODE)
	JOIN SALES_TB USING(SALES_CODE)
	WHERE IN_OUT_SALES_ST = 'SALES'
	AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE)
ORDER BY 1)
GROUP BY 상품코드, 상품이름, 팀코드
ORDER BY 4,5 DESC;

------------------------------------------------------------------------------본사직원이 본다고 생각하면
-------------------------------------------------------------------------------------------------------------------------------------------
SELECT 월, 상품코드, 상품이름, SUM(수량) 수량, SUM(매출) 매출
FROM (SELECT SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5) 월, ST.PRODUCT_CODE 상품코드, PRODUCT_NAME 상품이름, AMOUNT 수량,TEAM_CODE 팀코드,PRODUCT_PRICE*(1-SALES_PER)*AMOUNT 매출
FROM STOCK_TB ST
JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
JOIN PRODUCT_PRICE_TB PPT ON (ST.PRODUCT_CODE = PPT.PRODUCT_CODE)
JOIN SALES_TB USING(SALES_CODE)
WHERE IN_OUT_SALES_ST = 'SALES'
AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE
AND PRICE_NO= (SELECT MAX(PRICE_NO)
				FROM STOCK_TB ST2
				JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST2.PRODUCT_CODE)
				JOIN PRODUCT_PRICE_TB PPT ON (ST2.PRODUCT_CODE = PPT.PRODUCT_CODE)
				JOIN SALES_TB USING(SALES_CODE)
				WHERE IN_OUT_SALES_ST = 'SALES'
				AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE
				AND ST2.STOCK_NO = ST.STOCK_NO)
UNION 
SELECT SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5) 월,ST.PRODUCT_CODE 상품코드,PRODUCT_NAME 상품이름, AMOUNT 수량,TEAM_CODE 팀코드, PRODUCT_PRICE*AMOUNT 매출
FROM STOCK_TB ST
JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
WHERE IN_OUT_SALES_ST = 'SALES'
AND STOCK_NO NOT IN (SELECT DISTINCT STOCK_NO
	FROM STOCK_TB ST
	JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
	JOIN PRODUCT_PRICE_TB PPT ON (ST.PRODUCT_CODE = PPT.PRODUCT_CODE)
	JOIN SALES_TB USING(SALES_CODE)
	WHERE IN_OUT_SALES_ST = 'SALES'
	AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE)
ORDER BY 1)
GROUP BY 월 ,상품코드 , 상품이름
ORDER BY 1,5 DESC;

-----------------------------------------------------------------------------------------------------------------
SELECT 상품코드, 상품이름, SUM(수량) 수량, SUM(매출) 매출
FROM (SELECT SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5) 월, ST.PRODUCT_CODE 상품코드, PRODUCT_NAME 상품이름, AMOUNT 수량,TEAM_CODE 팀코드,PRODUCT_PRICE*(1-SALES_PER)*AMOUNT 매출
FROM STOCK_TB ST
JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
JOIN PRODUCT_PRICE_TB PPT ON (ST.PRODUCT_CODE = PPT.PRODUCT_CODE)
JOIN SALES_TB USING(SALES_CODE)
WHERE IN_OUT_SALES_ST = 'SALES'
AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE
AND PRICE_NO= (SELECT MAX(PRICE_NO)
				FROM STOCK_TB ST2
				JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST2.PRODUCT_CODE)
				JOIN PRODUCT_PRICE_TB PPT ON (ST2.PRODUCT_CODE = PPT.PRODUCT_CODE)
				JOIN SALES_TB USING(SALES_CODE)
				WHERE IN_OUT_SALES_ST = 'SALES'
				AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE
				AND ST2.STOCK_NO = ST.STOCK_NO)
UNION 
SELECT SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5) 월,ST.PRODUCT_CODE 상품코드,PRODUCT_NAME 상품이름, AMOUNT 수량,TEAM_CODE 팀코드, PRODUCT_PRICE*AMOUNT 매출
FROM STOCK_TB ST
JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
WHERE IN_OUT_SALES_ST = 'SALES'
AND STOCK_NO NOT IN (SELECT DISTINCT STOCK_NO
	FROM STOCK_TB ST
	JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
	JOIN PRODUCT_PRICE_TB PPT ON (ST.PRODUCT_CODE = PPT.PRODUCT_CODE)
	JOIN SALES_TB USING(SALES_CODE)
	WHERE IN_OUT_SALES_ST = 'SALES'
	AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE)
ORDER BY 1)
GROUP BY 상품코드, 상품이름
ORDER BY 4 DESC;

-------------------------------------------------------------------------------------------------------------------------------------
--매출 실적 달성률
SELECT sub.월, sub.매출, stt.TARGET_AMOUNT 목표금액,ROUND((sub.매출/stt.TARGET_AMOUNT*100),1) 달성률 ,sub.팀코드
FROM (SELECT SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5) 월,SUM(AMOUNT) 수량,TEAM_CODE 팀코드,SUM(매출)  매출
FROM (SELECT STOCK_ST_DATE, AMOUNT ,TEAM_CODE ,PRODUCT_PRICE*(1-SALES_PER)*AMOUNT 매출
FROM STOCK_TB ST
JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
JOIN PRODUCT_PRICE_TB PPT ON (ST.PRODUCT_CODE = PPT.PRODUCT_CODE)
JOIN SALES_TB USING(SALES_CODE)
WHERE IN_OUT_SALES_ST = 'SALES'
AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE
AND PRICE_NO= (SELECT MAX(PRICE_NO)
				FROM STOCK_TB ST2
				JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST2.PRODUCT_CODE)
				JOIN PRODUCT_PRICE_TB PPT ON (ST2.PRODUCT_CODE = PPT.PRODUCT_CODE)
				JOIN SALES_TB USING(SALES_CODE)
				WHERE IN_OUT_SALES_ST = 'SALES'
				AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE
				AND ST2.STOCK_NO = ST.STOCK_NO)
UNION 
SELECT STOCK_ST_DATE, AMOUNT, TEAM_CODE  , PRODUCT_PRICE*AMOUNT 매출
FROM STOCK_TB ST
JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
WHERE IN_OUT_SALES_ST = 'SALES'
AND STOCK_NO NOT IN (SELECT DISTINCT STOCK_NO
	FROM STOCK_TB ST
	JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
	JOIN PRODUCT_PRICE_TB PPT ON (ST.PRODUCT_CODE = PPT.PRODUCT_CODE)
	JOIN SALES_TB USING(SALES_CODE)
	WHERE IN_OUT_SALES_ST = 'SALES'
	AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE)
ORDER BY 1)
GROUP BY SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5) ,TEAM_CODE
--HAVING TEAM_CODE = 'DM001'
ORDER BY 3,1) sub
JOIN SALES_TARGET_TB stt ON(stt.TEAM_CODE = sub.팀코드)
WHERE sub.월 = SUBSTR(TO_CHAR(stt.TARGET_DATE),1,5)
AND sub.팀코드 = 'DM001'
ORDER BY 1;
----------------------------------------------------------------------------------------------------------------
SELECT 월, 분류코드,수량, 팀코드,매출 ,TARGET_AMOUNT 총목표금액,TARGET_AMOUNT*SKINCR_RATIO SKINCR목표금액,TARGET_AMOUNT*HAIRCR_RATIO HAIRCR목표금액
       ,TARGET_AMOUNT*MAKEUP_RATIO MAKEUP목표금액,TARGET_AMOUNT*BODYCR_RATIO BODYCR목표금액
FROM 
(SELECT 월, 분류코드, SUM(수량) 수량, 팀코드, SUM(매출) 매출
FROM (SELECT SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5) 월, CATEGORY_CODE 분류코드, AMOUNT 수량,TEAM_CODE 팀코드,PRODUCT_PRICE*(1-SALES_PER)*AMOUNT 매출
FROM STOCK_TB ST
JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
JOIN PRODUCT_PRICE_TB PPT ON (ST.PRODUCT_CODE = PPT.PRODUCT_CODE)
JOIN SALES_TB USING(SALES_CODE)
WHERE IN_OUT_SALES_ST = 'SALES'
AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE
AND PRICE_NO= (SELECT MAX(PRICE_NO)
				FROM STOCK_TB ST2
				JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST2.PRODUCT_CODE)
				JOIN PRODUCT_PRICE_TB PPT ON (ST2.PRODUCT_CODE = PPT.PRODUCT_CODE)
				JOIN SALES_TB USING(SALES_CODE)
				WHERE IN_OUT_SALES_ST = 'SALES'
				AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE
				AND ST2.STOCK_NO = ST.STOCK_NO)
UNION 
SELECT SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5) 월,CATEGORY_CODE 분류코드, AMOUNT 수량,TEAM_CODE 팀코드, PRODUCT_PRICE*AMOUNT 매출
FROM STOCK_TB ST
JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
WHERE IN_OUT_SALES_ST = 'SALES'
AND STOCK_NO NOT IN (SELECT DISTINCT STOCK_NO
	FROM STOCK_TB ST
	JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
	JOIN PRODUCT_PRICE_TB PPT ON (ST.PRODUCT_CODE = PPT.PRODUCT_CODE)
	JOIN SALES_TB USING(SALES_CODE)
	WHERE IN_OUT_SALES_ST = 'SALES'
	AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE)
ORDER BY 1)
GROUP BY 월 ,분류코드, 팀코드
ORDER BY 1 ,4,5 DESC) sub
JOIN SALES_TARGET_TB stt ON(stt.TEAM_CODE = sub.팀코드)
WHERE sub.월 = SUBSTR(TO_CHAR(stt.TARGET_DATE),1,5);
---------------------------------------------------------------------------------------------------------------------------
SELECT 월, 분류코드,수량, 팀코드,매출 , 
(CASE
	WHEN 분류코드 = 'SKIN_CR'
	THEN TARGET_AMOUNT*SKINCR_RATIO /*AS SKINCR목표금액*/
	WHEN 분류코드 = 'HAIR_CR'
	THEN TARGET_AMOUNT*HAIRCR_RATIO /*AS HAIRCR목표금액*/
	WHEN 분류코드 = 'MAKE_UP'
	THEN TARGET_AMOUNT*MAKEUP_RATIO /*AS MAKEUP목표금액*/
	WHEN 분류코드 = 'BODY_CR'
	THEN TARGET_AMOUNT*BODYCR_RATIO /*AS BODYCR목표금액*/
END) 목표금액,
(CASE
	WHEN 분류코드 = 'SKIN_CR'
	THEN ROUND(매출/(TARGET_AMOUNT*SKINCR_RATIO)*100,1) /*AS SKINCR목표금액*/
	WHEN 분류코드 = 'HAIR_CR'
	THEN ROUND(매출/(TARGET_AMOUNT*HAIRCR_RATIO)*100,1) /*AS HAIRCR목표금액*/
	WHEN 분류코드 = 'MAKE_UP'
	THEN ROUND(매출/(TARGET_AMOUNT*MAKEUP_RATIO)*100,1) /*AS MAKEUP목표금액*/
	WHEN 분류코드 = 'BODY_CR'
	THEN ROUND(매출/(TARGET_AMOUNT*BODYCR_RATIO)*100,1) /*AS BODYCR목표금액*/
END) 달성률
FROM 
(SELECT 월, 분류코드, SUM(수량) 수량, 팀코드, SUM(매출) 매출
FROM (SELECT SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5) 월, CATEGORY_CODE 분류코드, AMOUNT 수량,TEAM_CODE 팀코드,PRODUCT_PRICE*(1-SALES_PER)*AMOUNT 매출
FROM STOCK_TB ST
JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
JOIN PRODUCT_PRICE_TB PPT ON (ST.PRODUCT_CODE = PPT.PRODUCT_CODE)
JOIN SALES_TB USING(SALES_CODE)
WHERE IN_OUT_SALES_ST = 'SALES'
AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE
AND PRICE_NO= (SELECT MAX(PRICE_NO)
				FROM STOCK_TB ST2
				JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST2.PRODUCT_CODE)
				JOIN PRODUCT_PRICE_TB PPT ON (ST2.PRODUCT_CODE = PPT.PRODUCT_CODE)
				JOIN SALES_TB USING(SALES_CODE)
				WHERE IN_OUT_SALES_ST = 'SALES'
				AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE
				AND ST2.STOCK_NO = ST.STOCK_NO)
UNION 
SELECT SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5) 월,CATEGORY_CODE 분류코드, AMOUNT 수량,TEAM_CODE 팀코드, PRODUCT_PRICE*AMOUNT 매출
FROM STOCK_TB ST
JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
WHERE IN_OUT_SALES_ST = 'SALES'
AND STOCK_NO NOT IN (SELECT DISTINCT STOCK_NO
	FROM STOCK_TB ST
	JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
	JOIN PRODUCT_PRICE_TB PPT ON (ST.PRODUCT_CODE = PPT.PRODUCT_CODE)
	JOIN SALES_TB USING(SALES_CODE)
	WHERE IN_OUT_SALES_ST = 'SALES'
	AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE)
ORDER BY 1)
GROUP BY 월 ,분류코드, 팀코드
ORDER BY 1 ,4,5 DESC) sub
JOIN SALES_TARGET_TB stt ON(stt.TEAM_CODE = sub.팀코드)
WHERE sub.월 = SUBSTR(TO_CHAR(stt.TARGET_DATE),1,5)
AND sub.팀코드 = 'DM001'
ORDER BY 1;