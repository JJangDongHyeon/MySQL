/*유니온 
select결과 2개를 합치는 작업
특징: 컬럼 갯수와 타입이 맞아야 한다.

union all(중복 허용) , union(중복 제거 ) 2개의 차이점
*/
-- 아래에만 적용
SELECT 1 AS flag ,   first_name , last_name
FROM customer

UNION ALL

SELECT 2, first_name , last_name
FROM actor
WHERE LEFT(first_name, 1 ) = 'M';

-- 둘다 적용
SELECT ST.*
FROM(
SELECT 1 AS flag ,   first_name , last_name
FROM customer

UNION ALL

SELECT 2, first_name , last_name
FROM actor
) ST 
WHERE LEFT(first_name, 1 ) = 'M';

