
DROP TABLE Member;

	--- 멤버 테이블


CREATE TABLE Member
(
	userid		VARCHAR2(20) NOT NULL	,
	passwd      VARCHAR2(20)	,
	username   VARCHAR2(20)	NOT NULL,
	usernickname VARCHAR2(20) NOT NULL,
	email         VARCHAR2(100)	NOT NULL ,
	tel             VARCHAR2(20)   NOT NULL,
	regdate 		DATE				NOT NULL,
	zipcode   	CHAR(10),
	address1    VARCHAR2(200),
	address2    VARCHAR2(100),
	CONSTRAINT member_userid_pk PRIMARY KEY(userid)
)

----일반 회원가입 
CREATE OR REPLACE PROCEDURE member_insert
(
	userid		IN		member.userid%TYPE,
	passwd   	IN		member.passwd%TYPE,
	username	IN		member.username%TYPE,
	usernickname IN member.usernickname%TYPE,
	email			IN		member.email%TYPE,
	tel            IN    member.tel%TYPE,
	zipcode		IN		member.zipcode%TYPE,
	address1	IN		member.address1%TYPE,
	address2	IN		member.address2%TYPE
)
IS 
BEGIN
	INSERT INTO Member(userid,passwd,username,usernickname,email,tel, regdate, zipcode,address1,address2)
	VALUES(userid, passwd, username, usernickname, email, tel,  SYSDATE, zipcode, address1, address2);
	COMMIT;
END; 


----카카오,네이버 전용 회원가입
CREATE OR REPLACE PROCEDURE kakao_insert
(
	userid        IN    member.userid%TYPE,
	username	IN		member.username%TYPE,
	usernickname IN member.usernickname%TYPE,
	email			IN		member.email%TYPE,
	tel         IN    member.tel%TYPE
)
IS 
BEGIN
	INSERT INTO Member(userid,username,usernickname, email,tel, regdate)
	VALUES(userid, username, usernickname, email, tel, SYSDATE);
	COMMIT;
END; 

-- 로그인 체크
CREATE OR REPLACE procedure member_login
(
	p_userid			IN 	member.userid%TYPE,
	login_record 	OUT SYS_REFCURSOR
)
AS 
BEGIN
	OPEN login_record FOR
	SELECT userid, passwd
	FROM Member 
	WHERE userid = p_userid;
END; 


--회원 ID로 전체정보 조회
CREATE OR REPLACE procedure member_select
(
	p_userid	 			IN 		member.userid%TYPE,
	member_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN member_record FOR
	SELECT * 
	FROM Member
	WHERE userid = p_userid;
END; 

--회원 email로 전체정보 조회
CREATE OR REPLACE procedure member_select1
(
	p_useremail 			IN 		member.email%TYPE,
	member_record1  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN member_record1 FOR
	SELECT * 
	FROM Member
	WHERE email = p_useremail;
END; 

CREATE OR REPLACE procedure member_delete
(
	p_userid 			IN 		member.userid%TYPE
)
IS
BEGIN
	DELETE FROM Member
	WHERE userid = p_userid;
	COMMIT;
END; 

CREATE OR REPLACE procedure member_update
(
	p_userid			IN		member.userid%TYPE,
	p_email			IN		member.email%TYPE,
	p_zipcode		IN		member.zipcode%TYPE,
	p_address1		IN		member.address1%TYPE,
	p_address2		IN		member.address2%TYPE
)
IS 
BEGIN
	UPDATE Member
	SET email = p_email, zipcode = p_zipcode, 
		   address1=p_address1, address2=p_address2
	WHERE userid = p_userid;
	COMMIT;
END; 

--- 상품 테이블
CREATE TABLE Product
(
  productid	NUMBER(3) PRIMARY KEY, -- 상품id
  producttype NUMBER(3),  -- 상품타입
  productname VARCHAR2(50), -- 상품이름
  productimg   VARCHAR2(50), -- 상품이미지
  productex VARCHAR2(150), -- 상품설명
  price    NUMBER(8), -- 상품 가격
  sell_count NUMBER(5) -- 판매수량
)

--- 상품 idx 시퀀스
CREATE SEQUENCE product_seq
	MAXVALUE 9999
	NOCYCLE
	
-- 상품 종류로 상품 가져오기
CREATE OR REPLACE procedure product_select
(
	p_producttype 			IN 		product.producttype%TYPE,
	product_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN product_record FOR
	SELECT * 
	FROM Product
	WHERE producttype = p_producttype;
END; 

-- 상품 id로 상품 가져오기
CREATE OR REPLACE procedure product_select1
(
	p_productid 			IN 		product.productid%TYPE,
	product_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN product_record FOR
	SELECT * 
	FROM Product
	WHERE productid = p_productid;
END; 

---장바구니 상세테이블
CREATE TABLE cartDetail
(
	cartidx NUMBER(3) NOT NULL PRIMARY KEY, -- 장바구니 일련번호
	cartid NUMBER(3) NOT NULL, -- 장바구니 번호
	productid NUMBER(3) NOT NULL,  -- 상품 번호
	p_count NUMBER(3) NOT NULL, -- 상품 수량
	validation NUMBER(3) NOT NULL,  -- 장바구니 존재유무(하나의상품) 
	price    NUMBER(8) NOT NULL,  -- 상품 가격
  CONSTRAINTS fk_cartDetail_cartid FOREIGN KEY (cartid) 
	REFERENCES cartBasic(cartid) ON DELETE CASCADE, -- cartDetail테이블의 cartid참조
  CONSTRAINTS fk_cartDetail_productid FOREIGN KEY (productid) 
REFERENCES product(productid) ON DELETE CASCADE -- product테이블의 productid참조
)

-- cartDetail 입력 프로시저
CREATE OR REPLACE PROCEDURE cartDetail_insert
(
	cartid        IN    cartDetail.cartid%TYPE,
	productid        IN    cartDetail.productid%TYPE,
	p_count        IN    cartDetail.p_count%TYPE,
	price             IN   cartDetail.price%TYPE
)
IS 
BEGIN
	INSERT INTO cartDetail(cartidx,cartid,productid,p_count,orderid,price)
	VALUES(cart_idx_seq.NEXTVAL, cartid, productid, p_count, 1,price);
	COMMIT;
END; 

--외래키 선언 식
ALTER TABLE cartDetail
ADD CONSTRAINTS fk_cartid FOREIGN KEY (cartid)
REFERENCES cartBasic(cartid) ON DELETE CASCADE;

ALTER TABLE cartDetail
ADD CONSTRAINTS fk_productid FOREIGN KEY (productid)
REFERENCES Product(productid) ON DELETE CASCADE;

DROP TABLE cartBasic
--회원id로 상바구니기본 테이블

-- cartBasic 테이블 (Member테이블의 userid참조)
CREATE TABLE cartBasic
(
cartid NUMBER(3) NOT NULL PRIMARY KEY, -- 장바구니 번호
userid VARCHAR2(20) NOT NULL, -- 회원 id
cartstate NUMBER(3) NOT NULL, -- 카트상태 (1:카트에담겨있는,2:주문했을시)
CONSTRAINTS fk_cartBasic_userid FOREIGN KEY (userid) 
REFERENCES member(userid) ON DELETE CASCADE -- member테이블의 userid참조
)

ALTER TABLE cartBasic
ADD CONSTRAINTS fk_userid FOREIGN KEY (userid)
REFERENCES Member(userid) ON DELETE CASCADE;
DESC TABLE cartbasic;

-- cartBasic 입력 프로시저
CREATE OR REPLACE PROCEDURE cartBasic_insert
(
	userid        IN    member.userid%TYPE,
)
IS 
BEGIN
	INSERT INTO cartBasic(cartid,userid,cartstate)
	VALUES(cart_id_seq.NEXTVAL, userid,1);
	COMMIT;
END; 

--유저id로 카트id 가져오기
CREATE OR REPLACE procedure search_cartid
(
	p_userid 			IN 		cartbasic.userid%TYPE,
	member_record1  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN member_record1 FOR
	SELECT cartid 
	FROM cartBasic
	WHERE userid = p_userid;
END; 

--- 카트 일련번호 시퀀스
CREATE SEQUENCE cart_idx_seq
	MAXVALUE 9999
	NOCYCLE
  
  --카트번호 시퀀스
  CREATE SEQUENCE cart_id_seq
	MAXVALUE 9999
	NOCYCLE

DROP TABLE orderBasic
--- 주문(기본정보) 테이블
--- 주문상세(주문내역) 테이블 
CREATE TABLE orderBasic -- 곂치는 부분 다 빼놓은 테이블
(
	orderid NUMBER(4) primary key, -- 주문번호
	userid VARCHAR2(20) not null,        -- 회원 id ----FK
  username VARCHAR2(20) NOT NULL, -- 수신자이름
	selldate DATE not null, -- 주문일자
	tel VARCHAR2(20) not null,   -- 휴대폰
	zipcode CHAR(10) not null, -- 우편번호
	address1 VARCHAR2(200) not null, -- 주소1
	address2 VARCHAR2(200) not null,  -- 주소2
	payid  VARCHAR2(5) not null,      -- 결제수단
	message VARCHAR2(300),  -- 메시지
	o_state VARCHAR2(5) not null,   -- 주문상태(주문처리중,주문완료)
	d_state VARCHAR2(5) not null,   -- 배송상태(배송전,배송중,배송완료)
  idx Number(3), --- 쿠폰번호(Null허용 안쓸수도있기때문) -- FK
  delivery number(5), ---배송비(3000 or 0)
  price number(8) not null,  -- 할인가를 적용안한 총가격
  totalprice number(8) not null --- 최종합계가격(배송비,쿠폰할인가 적용)
)
DROP TABLE orderbasic;
SELECT *FROM ORDERBASIC;

-- orderbasicVO 입력 프로시저
CREATE OR REPLACE PROCEDURE orderBasic_insert
(
  userid       			 IN    orderBasic.userid%TYPE,
  username        IN    orderBasic.username%TYPE,
  tel        					IN    orderBasic.tel%TYPE,
  zipcode      	   IN    orderBasic.zipcode%TYPE,
  address1        IN    orderBasic.address1%TYPE,
  address2        IN    orderBasic.address2%TYPE,
  message        IN    orderBasic.message%TYPE,
  payid            IN    orderBasic.payid%TYPE,
  idx               IN    orderBasic.idx%TYPE,
  delivery        IN    orderBasic.delivery%TYPE,
  price            IN    orderBasic.price%TYPE,
  totalprice      IN    orderBasic.totalprice%TYPE
)
IS
BEGIN
	INSERT INTO orderBasic(orderid,userid,username,selldate,tel,zipcode,
  address1,address2,payid,message,o_state,d_state,idx,delivery,price,totalprice)
	VALUES(orderid_seq.NEXTVAL, userid,username,SYSDATE,tel,zipcode,
  address1,address2,payid,message,1,1,idx,delivery,price,totalprice);
	COMMIT;
END;

-- 가장최근 index값 뽑아내는 프로시저
CREATE OR REPLACE procedure selectOrderid
(
	orderid_recored  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN orderid_recored FOR
	SELECT MAX(orderid)
	FROM orderbasic;
END;
ALTER TABLE orderBasic
ADD CONSTRAINTS fk_userid1 FOREIGN KEY (userid)
REFERENCES Member(userid) ON DELETE CASCADE;

-- 주문id 시퀀스
  CREATE SEQUENCE orderid_seq
	MAXVALUE 9999
	NOCYCLE
--주문idx 시퀀스
  CREATE SEQUENCE orderidx_seq
	MAXVALUE 9999
	NOCYCLE

--- 주문상세(주문내역) 테이블
CREATE TABLE orderDetail -- 다른부분
(
	orderidx NUMBER(4) PRIMARY key,  --주문 일련번호
	orderid NUMBER(4),      -- 주문번호
	productid NUMBER(3),   --상품번호
	pcount NUMBER(4),    -- 상품수량
	price NUMBER(10)      -- 금액(상품가격x상품수량)
)
DROP TABLE orderDetail

ALTER TABLE orderDetail
ADD CONSTRAINTS fk_orderid FOREIGN KEY (orderid)
REFERENCES orderBasic(orderid) ON DELETE CASCADE;
--외래키 선언 식

ALTER TABLE orderDetail
ADD CONSTRAINTS fk_productid1 FOREIGN KEY (productid)
REFERENCES Product(productid) ON DELETE CASCADE;

CREATE OR REPLACE PROCEDURE orderDetail_insert
(
  orderid       			 IN    orderDetail.orderid%TYPE,
  productid       	 IN    orderDetail.productid%TYPE,
  pcount        			IN    orderDetail.pcount%TYPE,
  price      	  			 IN    orderDetail.price%TYPE
)
IS
BEGIN
	INSERT INTO orderDetail(orderidx,orderid,productid,pcount,price)
	VALUES(orderidx_seq.NEXTVAL, orderid,productid,pcount,price);
	COMMIT;
END;

--- 카트id로 cartDetail정보 전부가져오기
CREATE OR REPLACE procedure select_cartDetail
(
	p_cartid 			IN 		CARTDETAIL.cartid%TYPE,
	cart_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN cart_record FOR
	SELECT *
	FROM CARTDETAIL
	WHERE cartid = p_cartid and validation=1;
END; 

--카트일련번호로 cartDetail정보 전부 가져오기
CREATE OR REPLACE procedure select_cartDetailOne
(
	p_cartidx 			IN 		CARTDETAIL.cartidx%TYPE,
	cart_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN cart_record FOR
	SELECT *
	FROM CARTDETAIL
	WHERE cartidx = p_cartidx;
END; 

-- cartDetail 유효성을 1에서 2로 수정해주는 프로시저
CREATE OR REPLACE procedure update_cartDetailValidation
(
		p_cartidx			IN 		CARTDETAIL.cartidx%TYPE
)
AS
BEGIN
UPDATE CARTDETAIL SET validation = 2
WHERE cartidx = p_cartidx;
COMMIT;
END;


CREATE OR REPLACE procedure select_productid
(
	p_cartid 			IN 		CARTDETAIL.cartidx%TYPE,
	p_productid 			IN 		product.productid%TYPE,
	product_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN product_record FOR
	SELECT productid
	FROM CARTDETAIL
	WHERE cartid = p_cartid AND productid = p_productid AND validation=1;
END; 


--쿠폰테이블 페이지에서 관리하는 쿠폰테이블
CREATE TABLE Coupon
(
	idx NUMBER(3) PRIMARY KEY, --쿠폰 번호
  c_name VARCHAR2(30) NOT null, --쿠폰 이름
  c_content VARCHAR2(200) NOT NULL,  --쿠폰 내용
  c_discount NUMBER(6),-- 쿠폰 할인 금액
  c_discount1 NUMBER(3),-- 할인율(ex.20% 할인)
  c_dead    DATE, -- 쿠폰 마감 일자
  c_condition NUMBER(6) -- 쿠폰 사용 조건
)

INSERT INTO coupon(idx,c_name,c_content,c_discount,c_dead,c_condition) VALUES(coupon_seq.nextval, '1000원 할인쿠폰','12월기념 1000원할인쿠폰(10000원이상 구매시 사용가능)','1000',sysdate+30,'10000');
INSERT INTO coupon(idx,c_name,c_content,c_discount,c_dead,c_condition) VALUES(coupon_seq.nextval, '3000원 할인쿠폰','크리스마스 할인행사(20000원이상 구매시 사용가능)','3000',sysdate+30,'20000');
INSERT INTO coupon(idx,c_name,c_content,c_discount,c_dead,c_condition) VALUES(coupon_seq.nextval, '5000원 할인쿠폰','연말 할인 행사(25000원이상 구매시 사용가능)','5000',sysdate+30,'25000');
INSERT INTO coupon(idx,c_name,c_content,c_discount1,c_dead,c_condition) VALUES(coupon_seq.nextval, '30% 할인쿠폰','신규회원 30%할인 쿠폰(15000원이상 구매시 사용가능)','30',sysdate+30,'15000');

SELECT *FROM coupon;
-- 쿠폰가지고있는 유저의 쿠폰테이블
CREATE TABLE userCoupon(
	c_idx NUMBER(2) PRIMARY key,
	userid VARCHAR2(20) NOT NULL, --사용자 id
  idx NUMBER(3) NOT NULL, -- 쿠폰번호
  receive_date DATE NULL, --받은 날자
	validity number(2)-- 쿠폰상태(1:있는 상태(기본), 2:쿠폰사용시)
)
DROP TABLE usercoupon;
SELECT *FROM usercoupon;
INSERT INTO usercoupon(c_idx,userid,idx,receive_date,validity) VALUES(coupon_seq1.nextval, 'alrha486',12, sysdate, 1);


CREATE SEQUENCE coupon_seq
	MAXVALUE 9999
	NOCYCLE

CREATE SEQUENCE coupon_seq1
	MAXVALUE 9999
	NOCYCLE

SELECT *FROM member;


ALTER TABLE userCoupon
ADD CONSTRAINTS fk_userid2 FOREIGN KEY (userid)
REFERENCES Member(userid) ON DELETE CASCADE;
--외래키 선언 식

ALTER TABLE userCoupon
ADD CONSTRAINTS fk_idx FOREIGN KEY (idx)
REFERENCES coupon(idx) ON DELETE CASCADE;

-- userid로 가지고있는 쿠폰조회
CREATE OR REPLACE procedure select_userCoupon
(
	p_userid			IN 		userCoupon.userid%TYPE,
	coupon_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN coupon_record FOR
	SELECT *
	FROM userCoupon
	WHERE userid = p_userid and validity = 1;
END;


-- userid로 가지고있는 쿠폰조회
CREATE OR REPLACE procedure select_userCoupon1
(
	p_idx			IN 		Coupon.idx%TYPE,
	coupon_record1  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN coupon_record1 FOR
	SELECT *
	FROM coupon
	WHERE idx = p_idx;
END;


--userCoupon테이블의 validity값을 1에서 2로 업데이트
CREATE OR REPLACE procedure update_UserCouponValidation
(
		p_userid			IN 		USERCOUPON.userid%TYPE,
    p_couponIdx			IN 		USERCOUPON.c_idx%TYPE
)
AS
BEGIN
UPDATE USERCOUPON SET VALIDITY = 2
WHERE userid=p_userid AND idx=p_couponIdx;
COMMIT;
END;


ALTER TABLE product ADD(s_count NUMBER(5) default 0 NOT NULL);
--- 상품테이블에 판매량(s_count) 컬럼 추가 : 기본값 0

--- 상품테이블에 판매량을 장바구니테이블의 count 값 만큼 증가
CREATE OR REPLACE procedure updateProductS_count
(
		p_productid			IN 		product.productid%TYPE,
    p_count			IN 		CARTDETAIL.p_count%TYPE
)
AS
BEGIN
UPDATE product SET s_count = s_count + p_count
WHERE productid = p_productid;
COMMIT;
END;

--- 회원가입시 신규회원 쿠폰 발급
CREATE OR REPLACE PROCEDURE insertNewMemberCoupon
(
	p_userid		IN		usercoupon.userid%TYPE
)
IS
BEGIN
INSERT INTO usercoupon(c_idx,userid,idx,receive_date,validity)
VALUES(coupon_seq1.nextval, p_userid, 25 , sysdate, 1);
COMMIT;
END;

--- 상품 주문 조회 프로시저
CREATE OR REPLACE procedure selectOrderList
(
	p_userid 			IN 		orderBasic.userid%TYPE,
	order_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN order_record FOR
	SELECT b.ORDERID, b.SELLDATE, d.PRODUCTID, d.PCOUNT, b.PAYID, d.PRICE, b.O_STATE
	FROM ORDERBASIC b INNER JOIN orderDetail d
	ON b.ORDERID = d.ORDERID
	WHERE b.userid = p_userid;
END;

CREATE OR REPLACE procedure cartdetail_delete
(
	p_cartidx 			IN 		cartdetail.cartidx%TYPE
)
IS
BEGIN
	DELETE FROM cartdetail
	WHERE cartidx = p_cartidx;
	COMMIT;
END; 

--- id중복체크를 위한 프로시저
CREATE OR REPLACE procedure userid_select
(
	p_userid	 			IN 		member.userid%TYPE,
	member_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN member_record FOR
	SELECT userid FROM Member
	WHERE userid = p_userid;
END;

--닉네임 중복체크를 위한 프로시저
CREATE OR REPLACE procedure usernick_select
(
	p_usernickname	 			IN 		member.usernickname%TYPE,
	member_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN member_record FOR
	SELECT usernickname FROM Member
	WHERE usernickname = p_usernickname;
END;

-- 전체 주문 조회 프로시저(관리자)
CREATE OR REPLACE procedure select_OrderListAll
(
	orderList_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
OPEN orderList_record FOR
SELECT d.orderid, b.SELLDATE, p.PRODUCTNAME, p.PRODUCTIMG, d.pcount,
d.price, b.PAYID, m.USERNAME, m.tel, b.username AS username1, b.tel AS tel1,
b.ZIPCODE, b.ADDRESS1, b.ADDRESS2,  b.O_STATE,b.D_STATE
FROM orderDetail d
INNER JOIN orderBasic b
ON b.ORDERID = d.orderid
INNER JOIN member m
ON b.userid = m.userid
INNER JOIN product p
ON d.productid = p.productid;
END;

-- 조건검색 
CREATE OR REPLACE procedure select_OrderList
(	
  p_date1               IN        VARCHAR2,
  p_date2               IN        VARCHAR2,
  p_productname     IN        VARCHAR2,
  p_pay 		             IN        VARCHAR2,
  p_sort                 IN        VARCHAR2,
  p_state              IN       VARCHAR2,
	orderList_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
OPEN orderList_record FOR

SELECT d.orderid, b.SELLDATE, p.PRODUCTNAME, p.PRODUCTIMG, d.pcount,
d.price, b.PAYID, m.USERNAME, m.tel, b.username AS username1, b.tel AS tel1,
b.ZIPCODE, b.ADDRESS1, b.ADDRESS2,  b.O_STATE,b.D_STATE
FROM orderDetail d
INNER JOIN orderBasic b
ON b.ORDERID = d.orderid
INNER JOIN member m
ON b.userid = m.userid
INNER JOIN product p
ON d.productid = p.productid
WHERE p.PRODUCTNAME like p_productname and b.payid LIKE p_pay and b.O_STATE LIKE p_state
ORDER BY p_sort asc;

END;

--- 회원 전체 조회 프로시저 
CREATE OR REPLACE procedure select_memberListAll
(
	memberList_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
OPEN memberList_record FOR
SELECT *
FROM member;
END;

-- 회원 조건검색(case문 사용해서 다르게 나옴)
CREATE OR REPLACE procedure select_memberList
(	
	p_select               IN        VARCHAR2,
  p_text         		      IN        VARCHAR2,
	memberList_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
OPEN memberList_record FOR
SELECT  *FROM member
WHERE (
case when p_select = '1' then username
	     when p_select = '2' then tel
  	   when p_select = '3' then userid
     	else userid
 			end) LIKE p_text;
END;

--- 상품 전체 조회 프로시저 
CREATE OR REPLACE procedure select_productListAll
(
	productList_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
OPEN productList_record FOR
SELECT *
FROM product;
END;

-- 상품 조건검색(case문 사용해서 다르게 나옴)
CREATE OR REPLACE procedure select_productList
(	
	p_productname               IN        VARCHAR2,
  p_producttype         		      IN        NUMBER,
  p_select         		      IN        NUMBER,
	productList_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
OPEN productList_record FOR
SELECT  *FROM product
WHERE productname like p_productname AND producttype = p_producttype;
END;

-- 상품등록 프로시저 (관리자페이지)
CREATE OR REPLACE PROCEDURE product_insert
(
	p_producttype		IN		product.producttype%TYPE,
	p_productname   	IN		product.productname%TYPE,
	p_productimg	IN		product.productimg%TYPE,
	p_productex IN product.productex%TYPE,
	p_price			IN		product.price%TYPE,
	p_s_count        IN    product.s_count%TYPE
)
IS 
BEGIN
	INSERT INTO product(productid, producttype, productname, productimg, productex, price, s_count)
	VALUES(product_seq.NEXTVAL,p_producttype,p_productname,p_productimg,p_productex,p_price,p_s_count);
	COMMIT;
END; 

--오늘의 매출액 구하기
CREATE OR REPLACE procedure select_todayRevenue
(
	revenue_cursor  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN revenue_cursor FOR
	SELECT SUM(totalprice) AS revenue
	FROM orderbasic
	WHERE o_state = 1 AND TO_CHAR(SELLDATE,'YYYY-MM-DD') <= (SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD') FROM dual);
END; 
 
--총 매출액구하기
CREATE OR REPLACE procedure select_totalRevenue
(
	revenue_cursor  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN revenue_cursor FOR
	SELECT SUM(totalprice) AS revenue
	FROM orderbasic
	WHERE o_state = 1;
END; 

-- 전체 상품 판매 랭킹 구하는 프로시저
CREATE OR REPLACE procedure select_productRanking
(
	ranking_cursor  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN ranking_cursor FOR
SELECT p.PRODUCTNAME AS productname, p.PRODUCTIMG AS productimg,
p.S_COUNT AS s_count, (p.S_COUNT * p.PRICE) AS price
FROM product p
ORDER BY p.S_COUNT DESC; 
END; 