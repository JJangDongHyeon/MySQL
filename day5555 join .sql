SELECT A.num , A.prod_name, A.mem_id , B.mem_id , B.mem_name
FROM buy A
JOIN member B
ON A.mem_id = B.mem_id
ORDER BY A.mem_id;
-- join  쓰는 방법 where 함께 쓰는ㄱ ㅓㅅ과 on절이 있는데 on절을 추천

-- 문제 구매번호, 구매물품 , 단가 , 구매 수량 , 총 구매가격 , 구매자(아이돌명) , 아이돌 데뷔 일자 
-- 한 셀렉트 문으로 뜰 수 있도록  
SELECT *
FROM buy;

SELECT A.num , A.prod_name , A.price , A.amount , (A.price * A.amount) AS total_price , B.mem_name , B.debut_date
FROM buy A
JOIN member B
ON A.mem_id = B.mem_id
ORDER BY A.mem_id;

SELECT A.num , A.prod_name , A.price , A.amount , (A.price * A.amount) AS total_price , 
		 B.mem_name , B.debut_date
FROM buy A
JOIN member B
ON A.mem_id = B.mem_id
ORDER BY A.mem_id;
-- left(outer) join과 inner join의 차이
-- inner join은 양쪽 다 가지고 있는 데이터를 가져오지만 outer는 그냥 다 가져옴  
SELECT *
FROM member A
LEFT JOIN buy B
ON A.mem_id = B.mem_id;
-- left (outer) join은 outer부분 생략 가능함
SELECT *
FROM member A
LEFT outer JOIN buy B
ON A.mem_id = B.mem_id;

SELECT *
FROM member A
inner JOIN buy B
ON A.mem_id = B.mem_id;

-- DB에선 절대 안씀!
SELECT * , case when price >= 500 then 'A'
			  		 when price >= 100 then 'B'
			  ELSE 'C' END AS grade ,
		if(price >= 100, 'A', 'B')
FROM buy