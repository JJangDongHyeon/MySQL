CREATE TABLE `customer` (
	`member_id`	BIGINT	NOT null,
	`name`	VARCHAR(5)	not null,
	`addr`	VARCHAR(40)	not NULL,
	PRIMARY KEY (`member_id`)
);

CREATE TABLE `product` (
	`product_code`	CHAR(4)	PRIMARY key,
	`name`	VARCHAR(10)	not null,
	`price`	INT	not null
);

CREATE TABLE `purchase` (
	`purchase_id`	BIGINT AUTO_INCREMENT	NOT null,
	`member_id`	BIGINT	NOT null,
	`product_code`	CHAR(4)	NOT NULL,
	PRIMARY KEY(`purchase_id`)
);


ALTER TABLE `purchase` ADD CONSTRAINT `FK_customer_TO_purchase_1` FOREIGN KEY (
	`member_id`
)
REFERENCES `customer` (
	`member_id`
);

ALTER TABLE `purchase` ADD CONSTRAINT `FK_product_TO_purchase_1` FOREIGN KEY (
	`product_code`
)
REFERENCES `product` (
	`product_code`
);

