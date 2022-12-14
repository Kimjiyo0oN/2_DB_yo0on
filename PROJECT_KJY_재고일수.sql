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

------------------------------------------
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
--------------------------------------------------------------------------------------------------------------------------------
-----------------------------전체  매장별 판매 수량,판매 매출
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
UNION 
--
SELECT  DISTINCT PRODUCT_CODE,PRODUCT_NAME ,0 수량,TEAM_CODE, 0 매출 
FROM PRODUCT_TB 
RIGHT JOIN STOCK_TB USING(PRODUCT_CODE)
WHERE TEAM_CODE NOT IN ('DC') AND IN_OUT_SALES_ST ='IN'
AND (PRODUCT_CODE ,TEAM_CODE) NOT IN (SELECT 상품코드 , 팀코드
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
GROUP BY 상품코드, 상품이름, 팀코드)
ORDER BY 4,1;
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------월별 재고수량 판매수량
SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME,재고수량,판매수량
FROM ((SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME,재고수량,판매수량
FROM (SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME,SUM(AMOUNT) 재고수량, 0 판매수량
FROM(SELECT TEAM_CODE ,PRODUCT_CODE ,PRODUCT_TB.PRODUCT_NAME PRODUCT_NAME,
(CASE 
	WHEN IN_OUT_SALES_ST = 'IN'
	THEN TO_NUMBER(TO_CHAR(AMOUNT))   
	WHEN IN_OUT_SALES_ST = 'OUT'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
	WHEN IN_OUT_SALES_ST = 'SALES'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
END) AMOUNT
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE))
GROUP BY TEAM_CODE ,PRODUCT_CODE ,PRODUCT_NAME
ORDER BY 1,2 )
MINUS 
SELECT main.TEAM_CODE TEAM_CODE,main.PRODUCT_CODE PRODUCT_CODE,main.PRODUCT_NAME PRODUCT_NAME, main.수량 재고수량, 0 판매수량
FROM (SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME,SUM(AMOUNT) 수량
FROM(SELECT TEAM_CODE ,PRODUCT_CODE ,PRODUCT_TB.PRODUCT_NAME PRODUCT_NAME,
(CASE 
	WHEN IN_OUT_SALES_ST = 'IN'
	THEN TO_NUMBER(TO_CHAR(AMOUNT))   
	WHEN IN_OUT_SALES_ST = 'OUT'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
	WHEN IN_OUT_SALES_ST = 'SALES'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
END) AMOUNT 
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE))---main 테이블
GROUP BY TEAM_CODE ,PRODUCT_CODE ,PRODUCT_NAME
ORDER BY 1,2) main
LEFT JOIN (SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME, SUM(AMOUNT) 수량
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE)
WHERE IN_OUT_SALES_ST = 'SALES' --AND SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5)='22/07'---이거 판매 수량
GROUP BY TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME) sub ON (main.TEAM_CODE = sub.TEAM_CODE)
WHERE main.PRODUCT_CODE = sub.PRODUCT_CODE
)
UNION
SELECT main.TEAM_CODE TEAM_CODE,main.PRODUCT_CODE PRODUCT_CODE,main.PRODUCT_NAME PRODUCT_NAME, main.수량 재고수량, sub.수량 판매수량
FROM (SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME,SUM(AMOUNT) 수량
FROM(SELECT TEAM_CODE ,PRODUCT_CODE ,PRODUCT_TB.PRODUCT_NAME PRODUCT_NAME,
(CASE 
	WHEN IN_OUT_SALES_ST = 'IN'
	THEN TO_NUMBER(TO_CHAR(AMOUNT))   
	WHEN IN_OUT_SALES_ST = 'OUT'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
	WHEN IN_OUT_SALES_ST = 'SALES'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
END) AMOUNT 
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE))---main 테이블
GROUP BY TEAM_CODE ,PRODUCT_CODE ,PRODUCT_NAME
ORDER BY 1,2) main
LEFT JOIN (SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME, SUM(AMOUNT) 수량
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE)  ----------이거 판매슈령
WHERE IN_OUT_SALES_ST = 'SALES' --AND SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5)='22/07'
GROUP BY TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME) sub ON (main.TEAM_CODE = sub.TEAM_CODE)
WHERE main.PRODUCT_CODE = sub.PRODUCT_CODE)
WHERE TEAM_CODE = 'DM001'
ORDER BY 2;
----------------------------------------------------------------------------------------------
---------------원가 판매 가격
SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME,재고수량,판매수량,PRODUCT_PRICE*판매수량
FROM ((SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME,재고수량,판매수량,PRODUCT_PRICE
FROM (SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME,SUM(AMOUNT) 재고수량, 0 판매수량,PRODUCT_PRICE
FROM(SELECT TEAM_CODE ,PRODUCT_CODE ,PRODUCT_TB.PRODUCT_NAME PRODUCT_NAME,
(CASE 
	WHEN IN_OUT_SALES_ST = 'IN'
	THEN TO_NUMBER(TO_CHAR(AMOUNT))   
	WHEN IN_OUT_SALES_ST = 'OUT'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
	WHEN IN_OUT_SALES_ST = 'SALES'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
END) AMOUNT, PRODUCT_PRICE
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE))
GROUP BY TEAM_CODE ,PRODUCT_CODE ,PRODUCT_NAME,PRODUCT_PRICE
ORDER BY 1,2 )
MINUS 
SELECT main.TEAM_CODE TEAM_CODE,main.PRODUCT_CODE PRODUCT_CODE,main.PRODUCT_NAME PRODUCT_NAME, main.수량 재고수량, 0 판매수량,main.PRODUCT_PRICE
FROM (SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME,SUM(AMOUNT) 수량, PRODUCT_PRICE
FROM(SELECT TEAM_CODE ,PRODUCT_CODE ,PRODUCT_TB.PRODUCT_NAME PRODUCT_NAME,
(CASE 
	WHEN IN_OUT_SALES_ST = 'IN'
	THEN TO_NUMBER(TO_CHAR(AMOUNT))   
	WHEN IN_OUT_SALES_ST = 'OUT'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
	WHEN IN_OUT_SALES_ST = 'SALES'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
END) AMOUNT,PRODUCT_PRICE
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE))---main 테이블
GROUP BY TEAM_CODE ,PRODUCT_CODE ,PRODUCT_NAME,PRODUCT_PRICE
ORDER BY 1,2) main
LEFT JOIN (SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME, SUM(AMOUNT) 수량,PRODUCT_PRICE
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE)
WHERE IN_OUT_SALES_ST = 'SALES' --AND SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5)='22/07'---이거 판매 수량
GROUP BY TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME,PRODUCT_PRICE) sub ON (main.TEAM_CODE = sub.TEAM_CODE)
WHERE main.PRODUCT_CODE = sub.PRODUCT_CODE
)
UNION
SELECT main.TEAM_CODE TEAM_CODE,main.PRODUCT_CODE PRODUCT_CODE,main.PRODUCT_NAME PRODUCT_NAME, main.수량 재고수량, sub.수량 판매수량,main.PRODUCT_PRICE
FROM (SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME,SUM(AMOUNT) 수량,PRODUCT_PRICE
FROM(SELECT TEAM_CODE ,PRODUCT_CODE ,PRODUCT_TB.PRODUCT_NAME PRODUCT_NAME,
(CASE 
	WHEN IN_OUT_SALES_ST = 'IN'
	THEN TO_NUMBER(TO_CHAR(AMOUNT))   
	WHEN IN_OUT_SALES_ST = 'OUT'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
	WHEN IN_OUT_SALES_ST = 'SALES'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
END) AMOUNT,PRODUCT_PRICE 
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE))---main 테이블
GROUP BY TEAM_CODE ,PRODUCT_CODE ,PRODUCT_NAME,PRODUCT_PRICE
ORDER BY 1,2) main
LEFT JOIN (SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME, SUM(AMOUNT) 수량,PRODUCT_PRICE
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE)  ----------이거 판매슈령
WHERE IN_OUT_SALES_ST = 'SALES' --AND SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5)='22/07'
GROUP BY TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME,PRODUCT_PRICE) sub ON (main.TEAM_CODE = sub.TEAM_CODE)
WHERE main.PRODUCT_CODE = sub.PRODUCT_CODE)
WHERE TEAM_CODE = 'DM001'
ORDER BY 2;
--------------------
SELECT TO_CHAR(0.0123) FROM DUAL; 
------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM (SELECT m.TEAM_CODE 팀코드,m.PRODUCT_CODE 상품코드,m.PRODUCT_NAME 상품이름,m.재고수량 기초재고 ,s.기말수량 기말재고,m.판매수량 출고량,/*ROUND((m.판매수량/NULLIF( ((m.재고수량+s.기말수량)/2), 0 )),3) 재고회전율,*/
CASE 
	WHEN m.판매수량 = 0
	THEN 'Not Sales'
	WHEN (m.재고수량+s.기말수량) = 0
	THEN '0'
	ELSE RTRIM(TO_CHAR((m.판매수량/((m.재고수량+s.기말수량)/2)),'FM9990.999'),'.')  
END 재고회전율
,/*ROUND((30/NULLIF(m.판매수량/NULLIF( ((m.재고수량+s.기말수량)/2), 0 ),0)),3) 재고일수,*/
CASE 
	WHEN m.판매수량 = 0
	THEN 'Not Sales'
	WHEN (m.재고수량+s.기말수량) = 0
	THEN '0'
	ELSE RTRIM(TO_CHAR( (30/(m.판매수량/((m.재고수량+s.기말수량)/2))) ,'FM9990.999'),'.')
END 재고일수
FROM (SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME,재고수량,판매수량
FROM ((SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME,재고수량,판매수량
FROM (SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME,NVL(SUM(AMOUNT),0) 재고수량, 0 판매수량
FROM(SELECT TEAM_CODE ,PRODUCT_CODE ,PRODUCT_TB.PRODUCT_NAME PRODUCT_NAME,
(CASE 
	WHEN IN_OUT_SALES_ST = 'IN'
	THEN TO_NUMBER(TO_CHAR(AMOUNT))   
	WHEN IN_OUT_SALES_ST = 'OUT'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
	WHEN IN_OUT_SALES_ST = 'SALES'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
END) AMOUNT
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE)
WHERE STOCK_ST_DATE <= ('22/'||'07'||'/01'))
GROUP BY TEAM_CODE ,PRODUCT_CODE ,PRODUCT_NAME
ORDER BY 1,2 )
MINUS 
SELECT main.TEAM_CODE TEAM_CODE,main.PRODUCT_CODE PRODUCT_CODE,main.PRODUCT_NAME PRODUCT_NAME, main.수량 재고수량, 0 판매수량
FROM (SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME,NVL(SUM(AMOUNT),0) 수량
FROM(SELECT TEAM_CODE ,PRODUCT_CODE ,PRODUCT_TB.PRODUCT_NAME PRODUCT_NAME,
(CASE 
	WHEN IN_OUT_SALES_ST = 'IN'
	THEN TO_NUMBER(TO_CHAR(AMOUNT))   
	WHEN IN_OUT_SALES_ST = 'OUT'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
	WHEN IN_OUT_SALES_ST = 'SALES'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
END) AMOUNT 
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE)
WHERE STOCK_ST_DATE <= ('22/'||'07'||'/01'))---main 테이블
GROUP BY TEAM_CODE ,PRODUCT_CODE ,PRODUCT_NAME
ORDER BY 1,2) main
LEFT JOIN (SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME, SUM(AMOUNT) 수량
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE)
WHERE IN_OUT_SALES_ST IN('SALES','OUT')  AND SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5)='22/07'---이거 판매 수량
GROUP BY TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME) sub ON (main.TEAM_CODE = sub.TEAM_CODE)
WHERE main.PRODUCT_CODE = sub.PRODUCT_CODE
)
UNION
SELECT main.TEAM_CODE TEAM_CODE,main.PRODUCT_CODE PRODUCT_CODE,main.PRODUCT_NAME PRODUCT_NAME, main.수량 재고수량, sub.수량 판매수량
FROM (SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME,NVL(SUM(AMOUNT),0) 수량
FROM(SELECT TEAM_CODE ,PRODUCT_CODE ,PRODUCT_TB.PRODUCT_NAME PRODUCT_NAME,
(CASE 
	WHEN IN_OUT_SALES_ST = 'IN'
	THEN TO_NUMBER(TO_CHAR(AMOUNT))   
	WHEN IN_OUT_SALES_ST = 'OUT'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
	WHEN IN_OUT_SALES_ST = 'SALES'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
END) AMOUNT 
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE)
WHERE STOCK_ST_DATE <= ('22/'||'07'||'/01')  )---main 테이블
GROUP BY TEAM_CODE ,PRODUCT_CODE ,PRODUCT_NAME
ORDER BY 1,2) main
FULL JOIN (SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME, SUM(AMOUNT) 수량
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE)  ----------이거 판매슈령
WHERE IN_OUT_SALES_ST IN('SALES','OUT') AND SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5)='22/07'
GROUP BY TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME) sub ON (main.TEAM_CODE = sub.TEAM_CODE)
WHERE main.PRODUCT_CODE = sub.PRODUCT_CODE)
--WHERE TEAM_CODE = 'DM001'
) m--ORDER BY 1)
--
JOIN 
(SELECT TEAM_CODE,PRODUCT_CODE,NVL(SUM(AMOUNT),0) 기말수량
FROM(SELECT TEAM_CODE ,PRODUCT_CODE ,PRODUCT_TB.PRODUCT_NAME PRODUCT_NAME,
(CASE 
	WHEN IN_OUT_SALES_ST = 'IN'
	THEN TO_NUMBER(TO_CHAR(AMOUNT))   
	WHEN IN_OUT_SALES_ST = 'OUT'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
	WHEN IN_OUT_SALES_ST = 'SALES'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
END) AMOUNT 
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE)
WHERE STOCK_ST_DATE <= ('22/'||'07'||'/30')  )---main 테이블
GROUP BY TEAM_CODE ,PRODUCT_CODE ,PRODUCT_NAME) s
--ORDER BY 1,2
ON(m.TEAM_CODE =s.TEAM_CODE)
WHERE m.PRODUCT_CODE = s.PRODUCT_CODE)
ORDER BY 1,2;
-----------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM (SELECT m.TEAM_CODE 팀코드,m.PRODUCT_CODE 상품코드,m.PRODUCT_NAME 상품이름,m.재고수량 기초재고 ,s.기말수량 기말재고,m.판매수량 출고량,/*ROUND((m.판매수량/NULLIF( ((m.재고수량+s.기말수량)/2), 0 )),3) 재고회전율,*/
CASE 
	WHEN m.판매수량 = 0
	THEN 'Not Sales'
	WHEN (m.재고수량+s.기말수량) = 0
	THEN '0'
	ELSE (TO_CHAR((m.판매수량/((m.재고수량+s.기말수량)/2)),'FM9990.999')  
END 재고회전율
,/*ROUND((30/NULLIF(m.판매수량/NULLIF( ((m.재고수량+s.기말수량)/2), 0 ),0)),3) 재고일수,*/
CASE 
	WHEN m.판매수량 = 0
	THEN 'Not Sales'
	WHEN (m.재고수량+s.기말수량) = 0
	THEN '0'
	ELSE (TO_CHAR( (30/(m.판매수량/((m.재고수량+s.기말수량)/2))) ,'FM9990.999'))
END 재고일수
FROM (SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME,재고수량,판매수량
FROM ((SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME,재고수량,판매수량
FROM (SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME,NVL(SUM(AMOUNT),0) 재고수량, 0 판매수량
FROM(SELECT TEAM_CODE ,PRODUCT_CODE ,PRODUCT_TB.PRODUCT_NAME PRODUCT_NAME,
(CASE 
	WHEN IN_OUT_SALES_ST = 'IN'
	THEN TO_NUMBER(TO_CHAR(AMOUNT))   
	WHEN IN_OUT_SALES_ST = 'OUT'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
	WHEN IN_OUT_SALES_ST = 'SALES'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
END) AMOUNT
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE)
WHERE STOCK_ST_DATE <= ('22/'||'07'||'/01'))
GROUP BY TEAM_CODE ,PRODUCT_CODE ,PRODUCT_NAME
ORDER BY 1,2 )
MINUS 
SELECT main.TEAM_CODE TEAM_CODE,main.PRODUCT_CODE PRODUCT_CODE,main.PRODUCT_NAME PRODUCT_NAME, main.수량 재고수량, 0 판매수량
FROM (SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME,NVL(SUM(AMOUNT),0) 수량
FROM(SELECT TEAM_CODE ,PRODUCT_CODE ,PRODUCT_TB.PRODUCT_NAME PRODUCT_NAME,
(CASE 
	WHEN IN_OUT_SALES_ST = 'IN'
	THEN TO_NUMBER(TO_CHAR(AMOUNT))   
	WHEN IN_OUT_SALES_ST = 'OUT'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
	WHEN IN_OUT_SALES_ST = 'SALES'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
END) AMOUNT 
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE)
WHERE STOCK_ST_DATE <= ('22/'||'07'||'/01'))---main 테이블
GROUP BY TEAM_CODE ,PRODUCT_CODE ,PRODUCT_NAME
ORDER BY 1,2) main
LEFT JOIN (SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME, SUM(AMOUNT) 수량
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE)
WHERE IN_OUT_SALES_ST IN('SALES','OUT')  AND SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5)='22/07'---이거 판매 수량
GROUP BY TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME) sub ON (main.TEAM_CODE = sub.TEAM_CODE)
WHERE main.PRODUCT_CODE = sub.PRODUCT_CODE
)
UNION
SELECT main.TEAM_CODE TEAM_CODE,main.PRODUCT_CODE PRODUCT_CODE,main.PRODUCT_NAME PRODUCT_NAME, main.수량 재고수량, sub.수량 판매수량
FROM (SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME,NVL(SUM(AMOUNT),0) 수량
FROM(SELECT TEAM_CODE ,PRODUCT_CODE ,PRODUCT_TB.PRODUCT_NAME PRODUCT_NAME,
(CASE 
	WHEN IN_OUT_SALES_ST = 'IN'
	THEN TO_NUMBER(TO_CHAR(AMOUNT))   
	WHEN IN_OUT_SALES_ST = 'OUT'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
	WHEN IN_OUT_SALES_ST = 'SALES'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
END) AMOUNT 
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE)
WHERE STOCK_ST_DATE <= ('22/'||'07'||'/01')  )---main 테이블
GROUP BY TEAM_CODE ,PRODUCT_CODE ,PRODUCT_NAME
ORDER BY 1,2) main
FULL JOIN (SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME, SUM(AMOUNT) 수량
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE)  ----------이거 판매슈령
WHERE IN_OUT_SALES_ST IN('SALES','OUT') AND SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5)='22/07'
GROUP BY TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME) sub ON (main.TEAM_CODE = sub.TEAM_CODE)
WHERE main.PRODUCT_CODE = sub.PRODUCT_CODE)
--WHERE TEAM_CODE = 'DM001'
) m--ORDER BY 1)
--
JOIN 
(SELECT TEAM_CODE,PRODUCT_CODE,NVL(SUM(AMOUNT),0) 기말수량
FROM(SELECT TEAM_CODE ,PRODUCT_CODE ,PRODUCT_TB.PRODUCT_NAME PRODUCT_NAME,
(CASE 
	WHEN IN_OUT_SALES_ST = 'IN'
	THEN TO_NUMBER(TO_CHAR(AMOUNT))   
	WHEN IN_OUT_SALES_ST = 'OUT'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
	WHEN IN_OUT_SALES_ST = 'SALES'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
END) AMOUNT 
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE)
WHERE STOCK_ST_DATE <= ('22/'||'07'||'/30')  )---main 테이블
GROUP BY TEAM_CODE ,PRODUCT_CODE ,PRODUCT_NAME) s
--ORDER BY 1,2
ON(m.TEAM_CODE =s.TEAM_CODE)
WHERE m.PRODUCT_CODE = s.PRODUCT_CODE)
ORDER BY 1,2;
---------------------------------------------------------------------------------------------------------------------------------


SELECT m.TEAM_CODE,m.재고수량 기초재고 ,s.기말수량 기말재고,m.판매수량 출고량,ROUND((m.판매수량/NULLIF( ((m.재고수량+s.기말수량)/2), 0 )),3)  재고회전율
,ROUND((30/NULLIF(m.판매수량/NULLIF( ((m.재고수량+s.기말수량)/2), 0 ),0)),3) 재고일수
FROM (SELECT TEAM_CODE,재고수량,판매수량
FROM ((SELECT TEAM_CODE,재고수량,판매수량
FROM (SELECT TEAM_CODE,NVL(SUM(AMOUNT),0) 재고수량, 0 판매수량
FROM(SELECT TEAM_CODE ,PRODUCT_CODE ,PRODUCT_TB.PRODUCT_NAME PRODUCT_NAME,
(CASE 
	WHEN IN_OUT_SALES_ST = 'IN'
	THEN TO_NUMBER(TO_CHAR(AMOUNT))   
	WHEN IN_OUT_SALES_ST = 'OUT'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
	WHEN IN_OUT_SALES_ST = 'SALES'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
END) AMOUNT
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE)
WHERE STOCK_ST_DATE <= ('22-'||'07'||'-01'))
GROUP BY TEAM_CODE)
MINUS 
SELECT main.TEAM_CODE TEAM_CODE, main.수량 재고수량, 0 판매수량
FROM (SELECT TEAM_CODE,NVL(SUM(AMOUNT),0) 수량
FROM(SELECT TEAM_CODE ,PRODUCT_CODE ,PRODUCT_TB.PRODUCT_NAME PRODUCT_NAME,
(CASE 
	WHEN IN_OUT_SALES_ST = 'IN'
	THEN TO_NUMBER(TO_CHAR(AMOUNT))   
	WHEN IN_OUT_SALES_ST = 'OUT'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
	WHEN IN_OUT_SALES_ST = 'SALES'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
END) AMOUNT 
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE)
WHERE STOCK_ST_DATE <= ('22-'||'07'||'-01'))---main 테이블
GROUP BY TEAM_CODE) main
LEFT JOIN (SELECT TEAM_CODE, SUM(AMOUNT) 수량
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE)
WHERE IN_OUT_SALES_ST IN('SALES','OUT')  AND SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5)='22/07'---이거 판매 수량
GROUP BY TEAM_CODE) sub ON (main.TEAM_CODE = sub.TEAM_CODE)
)
UNION
SELECT main.TEAM_CODE TEAM_CODE, main.수량 재고수량, sub.수량 판매수량
FROM (SELECT TEAM_CODE,NVL(SUM(AMOUNT),0) 수량
FROM(SELECT TEAM_CODE ,PRODUCT_CODE ,PRODUCT_TB.PRODUCT_NAME PRODUCT_NAME,
(CASE 
	WHEN IN_OUT_SALES_ST = 'IN'
	THEN TO_NUMBER(TO_CHAR(AMOUNT))   
	WHEN IN_OUT_SALES_ST = 'OUT'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
	WHEN IN_OUT_SALES_ST = 'SALES'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
END) AMOUNT 
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE)
WHERE STOCK_ST_DATE <= ('22-'||'07'||'-01')  )---main 테이블
GROUP BY TEAM_CODE) main
FULL JOIN (SELECT TEAM_CODE, SUM(AMOUNT) 수량
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE)  ----------이거 판매슈령
WHERE IN_OUT_SALES_ST IN('SALES','OUT') AND SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5)='22/07'
GROUP BY TEAM_CODE) sub ON (main.TEAM_CODE = sub.TEAM_CODE))
--WHERE TEAM_CODE = 'DM001'
) m--ORDER BY 1)
--
JOIN 
(SELECT TEAM_CODE,NVL(SUM(AMOUNT),0) 기말수량
FROM(SELECT TEAM_CODE ,PRODUCT_CODE ,PRODUCT_TB.PRODUCT_NAME PRODUCT_NAME,
(CASE 
	WHEN IN_OUT_SALES_ST = 'IN'
	THEN TO_NUMBER(TO_CHAR(AMOUNT))   
	WHEN IN_OUT_SALES_ST = 'OUT'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
	WHEN IN_OUT_SALES_ST = 'SALES'
	THEN TO_NUMBER(TO_CHAR('-'||AMOUNT))
END) AMOUNT 
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE)
WHERE STOCK_ST_DATE <= ('22-'||'07'||'-30')  )---main 테이블
GROUP BY TEAM_CODE) s
--ORDER BY 1,2
ON(m.TEAM_CODE =s.TEAM_CODE)
AND m.TEAM_CODE NOT IN('DC');