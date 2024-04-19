-- fk 역할 존재하면 안되는 값이 들어가는 것을 방지한다.
-- member_id를 fk로 받아왔기 때문에 없었던 member_id를 사용하면 불가능
INSERT INTO buy
(mem_id , prod_name ,price , amount)
VALUES
('MMU' , '반지' , 50 ,4);

INSERT INTO buy
(mem_id , prod_name ,price , amount)
VALUES
('IOU' , '반지' , 50 ,4);

/* 문법의 순서임
select 열 이름
from 테이블 이름
join 테이블 명 (다른 테이블과 연결)
on 조인 조건
where 조건식 (and , or  연산자 가능 > 여러개 조건식 사용 가능)
group by 열 이름 (레코드들을 그룹으로 묶을 때 사용)
having 조건식 (group by의 where 절)
order by 열 이름 (여러개 작성 가능 , 레코드 출력의 순서 조정)
limit 숫자 or 숫자 , 숫자 (레코드 수 제한)
*/
-- 다른 데이터베이스가 선택 되어있을때는 이렇게 테이블 조회
SELECT * FROM shop_db.member;

SELECT mem_name FROM member;
SELECT * FROM member;

SELECT mem_name , addr , debut_date 
FROM member;

SELECT mem_name , addr , debut_date AS '데뷔 일자' 
FROM member;
-- 실제 테이블명을 바꾸는게 아니라 셀렉트때만 변경해서 보여줌


-- member에서 멤버 이름이 블랙핑크인 레코드 조회
SELECT * FROM member
WHERE mem_name = '블랙핑크';

-- 멤버 수가 4인아이돌을 조회
SELECT * 
FROM member
WHERE 1=1
AND mem_number = 4;

-- 멤버 평균 키가 165 이상이면서 멤버수가 6 초과인 아이돌 조회
SELECT *
FROM member
WHERE height >= 165
AND mem_number > 6;

-- -- 멤버 평균 키가 165 이상이거나  멤버수가 6 초과인 아이돌 조회
SELECT *
FROM member
WHERE height >= 165
or mem_number > 6;

-- 관계 연산자 사용 , 평균키가 163~165 아이돌 조회
SELECT *
FROM member
WHERE height <= 165
AND  163 <= height;

SELECT *
FROM member
WHERE height BETWEEN 163 AND 165;

-- 주소가 '경기' , '전남' , '경남'인 아이돌 조회
SELECT *
FROM member
WHERE addr = '경기'
or addr = '전남'
or addr = '경남';

SELECT *
FROM member
WHERE addr IN( '경기', '전남','경남');

-- 멤버 이름이 '우'로 시작하는 아이돌그룹 레코드 조회
SELECT *
FROM member
where mem_name LIKE '우%';

SELECT *
FROM member
where mem_name LIKE '%핑크';

SELECT *
FROM member
where mem_name like '_핑크';

SELECT *
FROM member
where mem_name like '__핑크';

-- p.121 서브쿼리 , 쿼리문 안에 select	문 서브 쿼리는 속도가 느려 가능한 안하는 편이 좋

-- 스칼라(Scala)	 콜롬, 레코드 하나
-- 잇지랑 키랑 같은 그룹
SELECT *
FROM member
WHERE height = (SELECT height
					FROM member
					WHERE mem_id = 'ITZ');

-- 잇지보다 키 큰 그룹
SELECT *
FROM member
WHERE height > (SELECT height
					FROM member
					WHERE mem_id = 'ITZ');

-- and 사용할 때 많이 헷갈리는 부분/ 지역을 두개 가질 순 없기 때문
SELECT *
FROM member
WHERE addr = '서울' AND addr = '경남';

-- join 체험 buy 기준
SELECT *
FROM buy
JOIN member
ON buy.mem_id = member.mem_id 
;

SELECT buy.num , member.mem_name ,  member.mem_number ,
buy.prod_name , buy.price , buy.amount , (buy.price * amount) AS total_price
FROM buy
JOIN member
ON buy.mem_id = member.mem_id 
;
-- 누구꺼에서 가져오는건지 확실히 정해주는게 좋다! 
SELECT A.num , B.mem_name ,  B.mem_number ,
A.prod_name , A.price , A.amount , (A.price * A.amount) AS total_price
FROM buy A
JOIN member B
ON A.mem_id = B.mem_id 
;

-- order by 레코드 순서 조정 desc 내림ㅊ사 ASC 오름차
SELECT *
FROM buy 
ORDER BY price;

SELECT *
FROM buy 
ORDER BY price, amount;

SELECT *
FROM buy 
ORDER BY price,amount, prod_name;

SELECT *
FROM buy 
ORDER BY price desc , amount , prod_name ASC;

SELECT *
from member
ORDER BY debut_date;

-- 평균키가 164 이상인 아이돌 조회하는데 , 키 내림차순으로 ㅈ어렬
-- 평균키가 같다면 데뷔날짜 오름차ㅜㄴ으로 정렬
SELECT *
FROM member
WHERE height >= 164
ORDER BY height DESC , debut_date;

select * FROM member
LIMIT 3;

SELECT *
FROM member
ORDER BY mem_number
LIMIT 1 , 3;
-- limit 1 , 3 하면 맨처음 하나를 제외하고  3개 limit 3 하면 처음부터 3개 
SELECT *
FROM member
ORDER BY mem_number
LIMIT 3;

SELECT *
FROM member
ORDER BY mem_number
LIMIT 9 ,3;

-- 중복 제거 distinct
SELECT * FROM member;
-- 이렇게하면 전체 컬럼이 똑같을때만 중복 잡아줌 
select DISTINCT * FROM member;

SELECT addr FROM member;
SELECT DISTINCT addr FROM member;

-- 집계 함수 , 그룹 함수 >> sum , avg , min , max , count
SELECT SUM(price) , AVG(price) , MIN(price) , MAX(price) , COUNT(price) , COUNT(num)
FROM buy;

-- group by는 그룹지정 

SELECT mem_id , SUM(price) , COUNT(num) ,AVG(price)
FROM buy
GROUP BY mem_id;

-- having 절은 group by의 where 절 
SELECT mem_id , SUM(price) , COUNT(num)
FROM buy
GROUP BY mem_id
HAVING SUM(price) >= 1000;
-- where 절은 처음 원본에서 뽑을때 쓰는것 , 뽑아낸 것에서 그룹바이 시켜서 거기서 조건을 걸어 뽑는게
-- 해빙 절!!!!!!!!!!

-- count 함수 주의사항 null은 카운틀르 해주지 않는다.
SELECT * FROM member;

SELECT COUNT(mem_id) FROM member;
SELECT COUNT(phone1) FROM member;

-- 지역별 아이돌 수 조회
SELECT addr , COUNT(mem_id) AS cnt
FROM member
GROUP BY addr;