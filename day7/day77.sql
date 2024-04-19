-- day7
/*

like with wild-card ( &, _ )
_가 속도는 더 빠름(고정이라)
*/
SELECT *
FROM customer 
WHERE last_name LIKE '_A_T%s';

-- last_name이 Q 혹은 Y로 시작하는 고객 정보 조회 (이름 ,성)

SELECT first_name , last_name
FROM customer
WHERE last_name LIKE 'Q%' OR 
		last_name LIKE 'Y%';
		
-- 정규 표현식 비밀번호에 특수기호 , 대문자를 넣고싶을때 등 형식을 맞출 때 

SELECT first_name , last_name
FROM customer 
WHERE last_name REGEXP '^[QY]';

-- null 인 값을 찾고 싶을 때
SELECT *
FROM rental
WHERE return_date IS NULL;

-- null을 뺴고싶을때
SELECT *
FROM rental
WHERE return_date IS not NULL;

-- 2005 년 5월 ~ 8월에 반납한 걸 뺀 모든  대여정보를 찾기
SELECT *
FROM rental
WHERE return_date NOT BETWEEN '2005-05-01' AND '2005-09-01'
OR    return_date IS NULL;

-- payment 테이블에서 금액이 1.97 , 7.98 또는 9.98 인 모든 행을 검색하는 쿼리를 작성하세요
SELECT *
FROM payment
WHERE amount IN (1.97 , 7.98 , 9.98);

-- 성(last name)의 두 번째 위치에 A 가있고 A  다음에 W가 있는 모든 고객을 찾는 쿼리를 작성하세요.
SELECT *
FROM customer
WHERE LAST_name LIKE '_AW%';

-- 모든 고객 정보 조회(고객 이름 , 고객 성 , 주소)
SELECT A.first_name , A.last_name , B.address
FROM customer A
inner JOIN address B
ON A.address_id = B.address_id;

-- 모든 고객 정보 조회 (고객 이름, 고객 성, 주소, 도시 이름) -
SELECT A.first_name , A.last_name , B.address , C.city
FROM customer A
INNER JOIN address B
INNER JOIN city C
ON A.address_id = B.address_id
and B.city_id = C.city_id
WHERE B.district = 'California';

-- ‘CATE MCQUEEN’, ‘CUBA BIRCH’가 출연한 모든 영화 조회 (영화PK, 영화 제목) 
SELECT *
FROM actor
WHERE actor_id = 128 or actor_id = 189;

SELECT distinct A.film_id , A.title 
FROM film A
INNER JOIN film_actor B
INNER JOIN actor C
ON A.film_id = B.film_id
AND B.actor_id = C.actor_id
WHERE (C.first_name , C.last_name) IN (('CATE','MCQUEEN') , ('CUBA','BIRCH'));

WHERE C.first_name IN ('CATE','CUBA') AND C.last_name IN ('MCQUEEN' , 'BIRCH');

WHERE CONCAT(C.first_name, ' ' , C.last_name) IN (‘CATE MCQUEEN’ , ‘CATE MCQUEEN’); -- 성능 배드

WHERE B.actor_id = 128 or B.actor_id = 189; 


-- 'jhon' 이라는 이름의 배우가 출현한 모든 영화 조회(영화 pk , 영화 제목 ,영화 장르categorycategorycategory)
SELECT A.film_id , A.title , E.name AS '장르'
FROM film A
inner JOIN film_actor B
INNER JOIN actor C
INNER JOIN film_category D
INNER JOIN category E
ON A.film_id = B.film_id 
AND B.actor_id = C.actor_id
AND B.film_id = D.film_id
AND D.category_id = E.category_id
WHERE C.first_name = 'JOHN'
AND D.category_id = 11; -- 존의 공포영화 태그만 보고싶을 때 


WHERE C.actor_id = 192;

