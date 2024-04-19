SELECT 
COUNT(payment_id) AS num_rows,
COUNT(DISTINCT customer_id) AS num_customer
FROM payment;

-- 배우 별 영화 출연 횟수film_actor 를 이요하여 (pk , 출연수 )
SELECT actor_id , COUNT(actor_id) AS scen_count
FROM film_actor
GROUP BY actor_id;

SELECT *
FROM actor A
INNER JOIN (
		SELECT actor_id , COUNT(actor_id) AS scen_count
		FROM film_actor
		GROUP BY actor_id
) B
ON A.actor_id = B.actor_id;

-- 영화별 출연 배우 수 


-- 영화 출연을 가장 많이 한 배우 이름 , 성 ,출연 횟수
SELECT A.actor_id , A.first_name , A.last_name, COUNT(B.actor_id)
FROM actor A
INNER JOIN film_actor B
ON A.actor_id = B.actor_id
GROUP BY B.actor_id;


		SELECT A.actor_id , B.first_name , B.last_name ,  COUNT(A.actor_id) AS scen_count
		FROM film_actor A
		INNER JOIN actor B
		ON A.actor_id = B.actor_id 
		GROUP BY actor_id
		having scen_count = (SELECT MAX(umm)
									FROM(SELECT COUNT(*) umm
										  FROM film_actor
										  GROUP BY actor_id
									)AS fuck
								  );
											
SELECT MAX(umm)
									FROM(SELECT COUNT() umm
										  FROM film_actor
										  GROUP BY actor_id
									)AS maxval;

										SELECT COUNT(*) umm 
										  FROM film_actor
										  GROUP BY actor_id;

SELECT A.actor_id, A.first_name , A.last_name , B.scen_count
FROM actor A
INNER JOIN (
		SELECT actor_id , COUNT(actor_id) AS scen_count
		FROM film_actor  
		GROUP BY actor_id
		having scen_count = (
									SELECT COUNT(actor_id) AS scen_count
									FROM film_actor
									GROUP BY actor_id
									ORDER BY scen_count desc
									LIMIT 1 )) B
ON A.actor_id = B.actor_id;


