CREATE DATABASE shop_db3;

USE shop_db;
-- 주석 만드는 법 -- 
-- primary key 하면 자동으로 not null 됨
CREATE TABLE MEMBER(
	member_id CHAR(8) PRIMARY KEY,
	MEMBER_name CHAR(5) NOT NULL,
	member_addr CHAR(20)
);

-- 복수 데이터 삽입
-- 중복 pk값 입력시도 >> 에러
INSERT INTO MEMBER 
(member_id , member_name , member_addr)
VALUES 
('jyp' , '박진영' , '경기 고양시 장항동'),
('iyou' , '아이유' , '인천 남구 주안동'),
('hero' , '임영웅' , '서울 은평구 주안동');

-- 주소 생략
INSERT INTO member
(member_id , member_name)
VALUES 
('mian' , '태진아');
-- 쿼리문
SELECT * FROM member;


-- 제품 테이블
-- int(10)는 길이제한이 아님 문자열만 길이제한 의미있따
CREATE TABLE product(
	product_name CHAR(4) primary KEY,
	cost INT NOT NULL ,
	make_data DATE ,
	company CHAR(5) ,
	amount INT NOT NULL
);

INSERT INTO product
(product_name , cost , make_data , company , amount)
VALUES
('바나나' , 1500 , '2021-07-01' , '델몬트' , 17);


INSERT INTO product
(product_name , cost , make_data , company , amount)
VALUES
('카스' , 2500 , '2022-03-01' , 'OB' , 3),
('삼각김밥' , 800 , '2023-09-01' , 'CJ' , 22);

-- Read , SECELCT문
SELECT * FROM member
WHERE member_addr LIKE '경기%';

SELECT * FROM member
WHERE member_name LIKE '박%';

SELECT * FROM member
WHERE member_name LIKE '%진%';

SELECT * FROM member
WHERE member_name LIKE '%진영';

SELECT * FROM member
WHERE member_name = '박진영';
-- pk는 라이크 잘 안씀
SELECT * FROM member
WHERE member_id LIKE 'jy%';

SELECT * FROM member
WHERE member_id = 'jyp';

-- update 수정문
UPDATE member 
SET member_name = '미안';
-- 절대 실행 XXX다 바뀌어버림

UPDATE member
SET member_name = '미안'
WHERE member_id = 'mian';

-- Delete 이거도 이렇게 실행하면 다 삭제됨
DELETE FROM member;

DELETE FROM member
WHERE member_id = 'mian';