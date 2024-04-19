-- PENELOPE GUINESS 가 출연한 영화를 조회
-- (영화 pk  , 영화 제목 , 영호 ㅏ소개 , 개봉연도)

SELECT A.film_id , A.title , A.DESCRIPTION , A.release_year
FROM film A
JOIN film_actor B
ON A.film_id = B.film_id
WHERE actor_id = (SELECT actor_id FROM actor WHERE actor_id = 1);

-- 40편 이상의 영화를 대여한 모든 고객을 조회 (고객 이름, 고객 성, 대여 수)
SELECT B.customer_id , B.first_name , B.last_name , COUNT(A.customer_id) AS rental_count
FROM rental A
JOIN customer B
ON A.customer_id = B.customer_id
GROUP BY A.customer_id
HAVING rental_count >= 40;

SELECT *
FROM customer;
-- customer에서 40편 이상 대여한 손님 제외하기 
-- 방법1
SELECT *
FROM customer
WHERE customer_id NOT IN(SELECT a.customer_id
								 FROM rental A
								 JOIN customer B
							  	 ON A.customer_id = B.customer_id
								 GROUP BY A.customer_id
								 HAVING COUNT(A.customer_id) >= 40);
-- 방ㅂ법2
SELECT *
FROM customer A
LEFT JOIN (SELECT a.customer_id
			  FROM rental A
			  JOIN customer B
		  	  ON A.customer_id = B.customer_id
			  GROUP BY A.customer_id
			  HAVING COUNT(A.customer_id) >= 40) B
ON A.customer_id = B.customer_id
WHERE B.customer_id IS NULL;
-- 2005년 6월 14일에 영화를 대여한 모든 고객 목록 조회

SELECT *
FROM rental
WHERE DATE(rental_date) = '2005-06-14';

SELECT A.first_name , A.last_name 
FROM customer A
JOIN rental B
ON A.customer_id = B.customer_id
WHERE DATE(B.rental_date) = '2005-06-14';
