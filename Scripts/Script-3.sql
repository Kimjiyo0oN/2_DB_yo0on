SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME,SUM(AMOUNT)
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
ORDER BY 1,2;




-----재고 현황
SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME,NVL(재고수량,'0') 
FROM (SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME,SUM(AMOUNT) 재고수량
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
ORDER BY 1,2)
WHERE TEAM_CODE ='DM002';
---수량,상품코드,팀코드
INSERT INTO STOCK_TB VALUES(SEQ_STOCK_NO.NEXTVAL,'IN',?,SYSDATE,'N',?,?,'DC');

----DC에서 빠지는 거 수량,상품코드,팀코드
INSERT INTO STOCK_TB VALUES(SEQ_STOCK_NO.NEXTVAL,'OUT',?,SYSDATE,'N',?,'DC',?);
---------------------------------------------------------------
SELECT TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME, SUM(AMOUNT) 재고수량
FROM STOCK_TB
FULL JOIN PRODUCT_TB USING(PRODUCT_CODE)
WHERE IN_OUT_SALES_ST = 'IN' AND SUBSTR(TO_CHAR(STOCK_ST_DATE),1,5) = '22/07'
--AND TEAM_CODE = 'DM001'
GROUP BY TEAM_CODE,PRODUCT_CODE,PRODUCT_NAME
HAVING TEAM_CODE = 'DM001';

-----------------------------
SELECT ORDER_NO ,ORDER_CODE , PRODUCT_CODE , ORDER_AMOUNT, TO_CHAR(ORDER_DATE, 'YYYY-MM-DD') 날짜,TEAM_CODE  
FROM ORDER_TB  -----------------------------공통
WHERE TEAM_CODE = ''  -----------------------로그인 권한
AND SUBSTR(ORDER_CODE,1,6) ='220705'; ----------------------------------나중에 flag이 true일때

SELECT ORDER_NO ,ORDER_CODE , PRODUCT_CODE , ORDER_AMOUNT, TO_CHAR(ORDER_DATE, 'YYYY-MM-DD') 날짜,TEAM_CODE  
FROM ORDER_TB  
WHERE TEAM_CODE = '';

-----------------------------
SELECT ORDER_NO ,ORDER_CODE , PRODUCT_CODE , ORDER_AMOUNT, TO_CHAR(ORDER_DATE, 'YYYY-MM-DD') 날짜,TEAM_CODE  
FROM ORDER_TB
WHERE SUBSTR(ORDER_CODE,1,6) ='220705'  -----------------------로그인 권한
AND TEAM_CODE = '';
SELECT ORDER_NO ,ORDER_CODE , PRODUCT_CODE , ORDER_AMOUNT, TO_CHAR(ORDER_DATE, 'YYYY-MM-DD') 날짜,TEAM_CODE  
FROM ORDER_TB;
---수량,상품코드,팀코드
INSERT INTO ORDER_TB VALUES(SEQ_ORDER_NO.NEXTVAL,?,TO_DATE(SYSDATE,'YYYY-MM-DD'),
?,?,'220912DM002');

INSERT INTO ORDER_TB VALUES(SEQ_ORDER_NO.NEXTVAL,1,TO_DATE(SYSDATE,'YYYY-MM-DD'),
'BC00001','DM001','220928DM001');
