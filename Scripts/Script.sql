SELECT PRODUCT_CODE ,PRODUCT_NAME, SUM(AMOUNT), PRODUCT_PRICE 
FROM STOCK_TB 
LEFT JOIN PRODUCT_TB USING(PRODUCT_CODE)
WHERE TEAM_CODE = 'DM001' AND  IN_OUT_SALES_ST = 'SALES' AND SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5) = '22/07'  
GROUP BY PRODUCT_CODE, PRODUCT_NAME, PRODUCT_PRICE;


SELECT PRODUCT_CODE ,PRODUCT_NAME, SUM(AMOUNT), PRODUCT_PRICE,TEAM_CODE ,IN_OUT_SALES_ST,STOCK_ST_DATE
FROM STOCK_TB 
LEFT JOIN PRODUCT_TB USING(PRODUCT_CODE) 
WHERE IN_OUT_SALES_ST = 'SALES'
GROUP BY TEAM_CODE, IN_OUT_SALES_ST, PRODUCT_CODE, STOCK_ST_DATE, PRODUCT_NAME, PRODUCT_PRICE;


SELECT PRODUCT_CODE ,PRODUCT_NAME, SUM(AMOUNT), PRODUCT_PRICE,TEAM_CODE ,IN_OUT_SALES_ST,SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5)
FROM STOCK_TB 
LEFT JOIN PRODUCT_TB USING(PRODUCT_CODE) 
WHERE IN_OUT_SALES_ST = 'SALES'
GROUP BY TEAM_CODE, IN_OUT_SALES_ST, PRODUCT_CODE, SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5) , PRODUCT_NAME, PRODUCT_PRICE;

INSERT INTO STOCK_TB VALUES(SEQ_STOCK_NO.NEXTVAL,'SALES',1,TO_DATE('2022-09-15','YYYY-MM-DD'),'Y','SC00003','DM002',NULL);

SELECT SUBSTR(PRODUCT_CODE,1,2) , SUM(AMOUNT), TEAM_CODE ,IN_OUT_SALES_ST,SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5)
FROM STOCK_TB 
LEFT JOIN PRODUCT_TB USING(PRODUCT_CODE) 
WHERE IN_OUT_SALES_ST = 'SALES'
GROUP BY TEAM_CODE, IN_OUT_SALES_ST, SUBSTR(PRODUCT_CODE,1,2), SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5);






SELECT STOCK_ST_DATE, STOCK_NO, PRICE_NO, MAIN.PRODUCT_CODE , SALES_CODE ,START_DATE ,END_DATE , SALES_PER, PRODUCT_PRICE*(1-SALES_PER), PRODUCT_PRICE
FROM PRODUCT_PRICE_TB PPT
LEFT JOIN SALES_TB USING(SALES_CODE)
LEFT JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = PPT.PRODUCT_CODE)
LEFT JOIN STOCK_TB ST ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
WHERE IN_OUT_SALES_ST = 'SALES'
--	WHERE PRODUCT_CODE = 'HC00003'
--AND TO_CHAR(STOCK_ST_DATE, 'YY/MM') = '22/08' 
AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE
--AND PRICE_NO = (SELECT MAX(PRICE_NO) 
--				FROM PRODUCT_TB P 
--			    JOIN PRODUCT_PRICE_TB R ON(P.PRODUCT_CODE = R.PRODUCT_CODE)
--			    WHERE P.PRODUCT_CODE = MAIN.PRODUCT_CODE)
ORDER BY 1 DESC, 2 DESC;



SELECT STOCK_NO, STOCK_ST_DATE, ST.PRODUCT_CODE, PRODUCT_PRICE*(1-SALES_PER) PRODUCT_PRICE, AMOUNT ,TEAM_CODE 
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
SELECT STOCK_NO, STOCK_ST_DATE,ST.PRODUCT_CODE,PRODUCT_PRICE, AMOUNT,TEAM_CODE 
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


SELECT DISTINCT STOCK_NO
FROM STOCK_TB ST
JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
JOIN PRODUCT_PRICE_TB PPT ON (ST.PRODUCT_CODE = PPT.PRODUCT_CODE)
JOIN SALES_TB USING(SALES_CODE)
WHERE IN_OUT_SALES_ST = 'SALES'
AND STOCK_ST_DATE BETWEEN START_DATE AND END_DATE
ORDER BY 1;




AND PRICE_NO = (SELECT MAX(PRICE_NO) 
				FROM PRODUCT_TB P 
			    JOIN PRODUCT_PRICE_TB R ON(P.PRODUCT_CODE = R.PRODUCT_CODE)
			    WHERE P.PRODUCT_CODE = MAIN.PRODUCT_CODE)
ORDER BY 1 DESC;

SELECT STOCK_NO, STOCK_ST_DATE
FROM STOCK_TB ST
JOIN PRODUCT_TB MAIN ON (MAIN.PRODUCT_CODE = ST.PRODUCT_CODE)
WHERE IN_OUT_SALES_ST = 'SALES';

-- ?????? ????????? ?????? ???????????? ?????? ?????? ????????? ????????????, ????????? ?????? ?????? ??????
SELECT * FROM PRODUCT_TB;
SELECT * FROM SALES_TB;
SELECT * FROM PRODUCT_PRICE_TB;


SELECT * 
FROM PRODUCT_TB;





SELECT STOCK_TB.PRODUCT_CODE ,PRODUCT_NAME, AMOUNT, PRODUCT_PRICE ,IN_OUT_SALES_ST,TEAM_CODE,STOCK_ST_DATE 
FROM STOCK_TB 
LEFT JOIN PRODUCT_TB ON(STOCK_TB.PRODUCT_CODE=PRODUCT_TB.PRODUCT_CODE)
WHERE TEAM_CODE = 'DM001' AND  IN_OUT_SALES_ST = 'SALES' AND SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5) = '22/07';


SELECT PRODUCT_CODE , SALES_CODE ,START_DATE ,END_DATE , SALES_PER, PRODUCT_PRICE*(1-SALES_PER), PRODUCT_PRICE
FROM PRODUCT_PRICE_TB
LEFT JOIN SALES_TB USING(SALES_CODE)
LEFT JOIN PRODUCT_TB USING(PRODUCT_CODE);


SELECT SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5)
FROM STOCK_TB;