-- PENELOPE GUINESS 가 출연한 영화를 조회
-- (영화 pk  , 영화 제목 , 영호 ㅏ소개 , 개봉연도)
SELECT *
FROM actor
WHERE first_name = 'penelope';

SELECT *
FROM film;

SELECT B.film_id , B.title, B.DESCRIPTION , B.release_year
FROM film B
JOIN film_actor A
ON A.film_id = B.film_id
WHERE actor_id = 1;

						
/* 혹은 (SELECT actor_id
						FROM actor
						WHERE first_name = 'penelope' AND last_name = 'guiness');
*/

SELECT actor_id
FROM actor
WHERE first_name = 'penelope' AND last_name = 'guiness';

-- 영화 rating G 이거나 rental_duration이 7일 이상인 영화 조회 (영화 제목만)
SELECT title
FROM film
WHERE rating = 'g' OR rental_duration >= 7;

/*
영화 rating ‘G’ 이면서 rental_duration이 7일 이상인 영화와 rating ‘PG-13’ 이면서
 rental_duration이 4일 미만인 영화 조회 (영화 제목, rating, rental_duration) - 팀
*/

SELECT title , rating , rental_duration
FROM film
WHERE (rating = 'g' AND rental_duration >= 7) OR
		(rating = 'PG-13' AND rental_duration < 4); 
		
/*
40편 이상의 영화를 대여한 모든 고객을 조회 (고객 이름, 고객 성, 대여 수)
*/
SELECT A.first_name , A.last_name , COUNT(B.customer_id) AS rental_count
FROM customer A
JOIN rental B
ON A.customer_id = B.customer_id
GROUP BY A.customer_id -- a b 암거나 해도됨 같은 customer _id 라서
HAVING rental_count >= 40;


SELECT A.first_name , A.last_name, b.rentalcnt
FROM customer A 
JOIN (SELECT customer_id , COUNT(customer_id) AS rentalcnt 
		FROM rental 
		GROUP BY customer_id) B
ON A.customer_id = B.customer_id
WHERE b.rentalcnt >= 40 ;



SELECT CUSTOMER_ID, FIRST_NAME, LAST_NAME FROM customer;

SELECT * FROM rental;



SELECT CUSTOMER_ID, FIRST_NAME, LAST_NAME FROM customer;

SELECT customer_id , COUNT(customer_id) AS rentalcnt 
		FROM rental 
		GROUP BY customer_id;

-- 2005년 6월 14일에 영화를 대여한 모든 고객 목록 조회
-- 정렬은 성을 기준으로 오름차순, (고객명 , 고객 성 , 렌탈 시간)

SELECT*
FROM rental
WHERE date(rental_date) = '2005-06-14';

SELECT B.first_name ,B.last_name , TIME(A.rental_date) AS rental_time
FROM rental A
JOIN customer B
ON A.customer_id = B.customer_id
WHERE DATE(A.rental_date) = '2005-06-14'
ORDER BY rental_time DESC;

-- 2005년 06월 14일에 렌탈을 하지 않은 고객의 이메일을 조회
SELECT email
FROM customer A
JOIN rental B
ON A.customer_id = B.customer_id
WHERE DATE(B.rental_date) != '2005-06-14'
GROUP by A.customer_id;

SELECT A.email
  FROM  customer A
LEFT JOIN (SELECT A.CUSTOMER_ID
		   	 FROM customer A, rental B
		  	   WHERE 1 = 1
		        AND A.customer_id = B.customer_id
		        AND DATE(RENTAL_DATE) = '2005-06-14'
		     ORDER BY A.LAST_NAME) B
ON A.CUSTOMER_ID = B.customer_id
WHERE B.customer_id IS NULL;


-- sakila 대여가능한 영화 
SELECT *
FROM film;

-- 1번 영화 (아카데미 다이노사우루스)에 출연하지 않은 배우 목록 조회

-- 1번 영화에 출연한 배우 pk들
SELECT actor_id
FROM film_actor
WHERE film_id = 1;

-- 1번째 방법 where 절에서 서브쿼리로 해결
SELECT *
FROM actor
WHERE actor_id not IN(SELECT actor_id
					FROM film_actor
					WHERE film_id = 1);

-- 2번째 방법
SELECT *
FROM actor A
LEFT JOIN(SELECT actor_id
				FROM film_actor
				WHERE film_id = 1
				) B
ON A.actor_id = B.actor_id
WHERE B.actor_id IS NULL;

-- 3번째 방법
SELECT *
FROM actor A
LEFT JOIN film_actor B
ON A.actor_id = B.actor_id
AND B.film_id = 1
WHERE B.actor_id IS NULL;

-- 2006년에 대여한 대여 목록
SELECT *
FROM rental
WHERE YEAR(rental_date) = 2006;

-- 2005-05-25 전의 대여 정보 (고객 ID , 대여일시)
SELECT *
FROM rental
WHERE rental_date < '2005-05-25 00:00:00';
ORDER BY remtal_date DESC;

-- 2005-06-14 ~ 2005 06 15 사이의 대여 정보 (고객 ID ,  대여일시)
SELECT customer_id , rental_date
FROM rental
WHERE rental_date >= '2005-06-14'
  and rental_date <  '2005-06-16';

-- 결제 금액이 10~11.99달러 까지 결제 정보 조회(고객 id , 결제 일시 , 결제 금액)
SELECT customer_id , payment_date , amount
FROM payment
WHERE amount >= 10
AND amount < 12
ORDER BY amount;

SELECT customer_id , payment_date , amount
FROM payment
WHERE amount BETWEEN 10 AND 12
ORDER BY amount;

-- 이름이 FA ~ FR로 시작하는 고개 정보 조회 (이름 , 성)
SELECT *
FROM customer
WHERE first_name like 'Fa%' AND first_name LIKE 'FR%';

SELECT *
FROM customer 
WHERE first_name >= 'f'
AND first_name <= 'fs'
ORDER BY first_name;

SELECT *
FROM customer 
WHERE first_name BETWEEN 'f' AND 'frb'
ORDER BY first_name;

-- 범위 수정
SELECT *
FROM customer 
WHERE first_name BETWEEN 'f' AND 'fs'
ORDER BY first_name;

-- 영화 등급이 g랑 pg
SELECT *
FROM film
WHERE rating = 'g' OR rating = 'pg'
ORDER BY rating;

SELECT *
FROM film
WHERE rating IN('g', 'pg')
ORDER BY rating;

-- ( 서브 쿼리 ) 영화 이름에 pet이 포함된 영화의 등급이랑 같은 영화 목록 조회
SELECT *
FROM film
WHERE rating IN (SELECT rating
FROM film
WHERE title LIKE '%pet%') 
ORDER BY rating;

SELECT DISTINCT A.title, A.rating
FROM film A
INNER JOIN film B
ON A.rating = B.rating
AND B.title LIKE '%pet%';

SELECT DISTINCT rating
FROM film
WHERE title LIKE '%pet%';
-- 이건 좀 별로인듯

-- 영화 등급이 'pg - 13' , 'r' , 'nc - 17' 이 아닌 영화 목록 (제목 ,등급)
SELECT title, rating
FROM film
WHERE rating NOT IN ( 'pg-13' , 'r', 'nc-17')
ORDER BY rating;

SELECT title, rating
FROM film
WHERE rating != 'pg-13' AND rating != 'r' AND rating != 'nc-17'
ORDER BY rating;

-- 성이 Q로 시작하는 고객 조회 (이름 ,성 ) 
SELECT *
FROM customer
WHERE LEFT(last_name, 1) = 'q';