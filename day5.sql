SELECT mem_id , SUM(price) , COUNT(num)
FROM buy
WHERE mem_id = 'BLK'
GROUP BY mem_id;


SELECT mem_id , COUNT(mem_id) as buy_count 
FROM buy 
GROUP BY mem_id;

SELECT mem_id , COUNT(mem_id) AS buy_count FROM buy GROUP BY mem_id;

SELECT *
FROM member;

INSERT INTO member
(mem_id, mem_name, mem_number, addr, phone1, phone2, height, debut_date)
VALUES ('NJS', '뉴진스', 5, '대구', '053', '09809', 164, '2020-12-12');

SELECT *
FROM buy
WHERE mem_id = 'BLK';