 <-------------------------------------멤버관련 테이블------------------------------------------>
 -- 멤버 테이블
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

--- 회원정보 수정
CREATE OR REPLACE procedure member_update
(
	p_userid      IN member.USERID%TYPE,
  p_passwd			IN		member.passwd%TYPE,
  p_usernickname			IN		member.usernickname%TYPE,
	p_email			IN		member.email%TYPE,
  p_tel			IN		member.tel%TYPE,
	p_zipcode		IN		member.zipcode%TYPE,
	p_address1		IN		member.address1%TYPE,
	p_address2		IN		member.address2%TYPE
)
IS 
BEGIN
	UPDATE Member
	SET passwd = p_passwd, usernickname = p_usernickname,
         email = p_email, tel = p_tel, zipcode = p_zipcode,
         address1=p_address1, address2=p_address2
	WHERE userid = p_userid;
	COMMIT;
END; 

--- 회원 삭제
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

--이름과 ID로 비밀번호 찾기
CREATE OR REPLACE procedure selectUserInfo
(
	p_username	 			IN 		member.username%TYPE,
	p_userid	 			IN 		member.userid%TYPE,
	member_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN member_record FOR
	SELECT * 
	FROM Member
	WHERE username = p_username AND userid = p_userid;
END; 

-- 유저 비밀번호 난수로 변경
CREATE OR REPLACE procedure updateUserInfo
(
	p_userid      IN member.USERID%TYPE,
  p_passwd			IN		member.passwd%TYPE
)
IS 
BEGIN
	UPDATE Member
	SET passwd = p_passwd         
	WHERE userid = p_userid;
	COMMIT;
END; 


-- 회원 ID찾기
CREATE OR REPLACE procedure selectUserInfo1
(
	p_username	 			IN 		member.username%TYPE,
  p_tel	 			IN 		member.tel%TYPE,
	member_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN member_record FOR
	SELECT * 
	FROM Member
	WHERE tel = p_tel AND username = p_username;
END; 
  <---------------------------------------------------------------------------------------------->
 <-------------------------------------상품관련 테이블------------------------------------------>
 -- 상품종류 테이블
CREATE TABLE ProductKind
(
	kind_idx NUMBER(3) PRIMARY KEY NOT NULL,
  p_type VARCHAR2(20) NOT NULL,
  p_productkind VARCHAR2(20) NOT NULL
)
 
  -- 상품테이블
  CREATE TABLE Product
(
  productid	NUMBER(3) PRIMARY KEY NOT NULL, -- 상품id
  kind_idx NUMBER(3) NOT NULL, -- 상품 종류
  productname VARCHAR2(50) NOT NULL, -- 상품이름
  productimg   VARCHAR2(50), -- 상품이미지
  productex VARCHAR2(150), -- 상품설명
  price    NUMBER(8) NOT NULL, -- 상품 가격
  sell_count NUMBER(5), -- 판매수량
  CONSTRAINTS fk_Product_kind_idx FOREIGN KEY (kind_idx) 
	REFERENCES productkind(kind_idx) ON DELETE CASCADE
	-- productKind테이블의 kind_idx참조
)
ALTER TABLE product ADD(stock number(5));
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

-- 하나의 상품종류 검색(소뷴류)
CREATE OR REPLACE procedure select_productListOne
(
	kind_idx1 							IN        product.kind_idx%type,
	productList_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
OPEN productList_record FOR
SELECT *
FROM product
WHERE kind_idx = kind_idx1
ORDER BY KIND_IDX asc;
END;

-- 하나의 상품종류 검색(대분류)
CREATE OR REPLACE procedure select_productListOnes
(
	p_type1 							IN        productkind.p_type%type,
	productList_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
OPEN productList_record FOR
SELECT p.productid,p.kind_idx,p.productname,p.productimg,p.productex,p.price,p.sell_count
FROM product p INNER JOIN PRODUCTKIND k 
ON p.KIND_IDX = k.KIND_IDX
WHERE k.p_type = p_type1
ORDER BY p.KIND_IDX asc;
END;

--- 상품id로 하나의 상품 조회
CREATE OR REPLACE procedure selectProductOne
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

-- 오늘의 상품별 판매량 구하는 프로시저 
CREATE OR REPLACE procedure selectProductGrape1
(
	selectProductGrape1_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN selectProductGrape1_record FOR
		SELECT k.KIND_IDX, d.PCOUNT, k.P_TYPE,k.P_PRODUCTKIND FROM
		PRODUCT p 
		INNER JOIN orderdetail d
		ON p.productid = d.productid
		INNER JOIN orderbasic b
		ON b.orderid = d.orderid
    INNER JOIN productkind k
    ON p.KIND_IDX = k.kind_idx
    WHERE TO_CHAR(SELLDATE,'yyyy-mm-dd') = TO_CHAR(sysdate,'yyyy-mm-dd')
		ORDER BY d.ORDERIDX asc;
END; 

sELECT *FROM coupon;
--- 이번 주 그래프
CREATE OR REPLACE procedure selectProductGrape2
(
	p_selldate 								IN          VARCHAR2,
	selectProductGrape2_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN selectProductGrape2_record FOR
		SELECT k.KIND_IDX, d.PCOUNT, k.P_TYPE,k.P_PRODUCTKIND,
    TO_CHAR(SELLDATE,'yyyy-mm-dd') AS selldate FROM
		PRODUCT p 
		INNER JOIN orderdetail d
		ON p.productid = d.productid
		INNER JOIN orderbasic b
		ON b.orderid = d.orderid
    INNER JOIN productkind k
    ON p.KIND_IDX = k.kind_idx
    WHERE TO_CHAR(SELLDATE,'yyyy-mm-dd') = p_selldate; 
		ORDER BY d.ORDERIDX asc;
END; 
 <---------------------------------------------------------------------------------------------->
 <-------------------------------------카트관련 테이블-------------------------------------------->

-- 세션에 담긴 유저id로 장바구니에 담긴 상품들 전체 가져오는 프로시저
CREATE OR REPLACE procedure select_cartDetail
(
	p_userid 			IN 		member.userid%TYPE,
	cart_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN cart_record FOR
	SELECT d.cartidx, d.cartid, d.productid, d.P_COUNT,
  D.VALIDATION, d.PRICE, p.PRODUCTNAME, p.PRODUCTIMG, p.price AS price1
	FROM CARTDETAIL d 
  INNER JOIN cartbasic b 
  ON d.cartid = b.CARTID
  INNER JOIN member m 
  ON m.USERID = b.USERID 
  INNER JOIN product p 
  ON p.productid = d.productid
  WHERE b.userid = 'alrha486' AND D.VALIDATION = 1;
END; 

-- 카트 기본 테이블
CREATE TABLE cartBasic
(
cartid NUMBER(3) NOT NULL PRIMARY KEY, -- 장바구니 번호
userid VARCHAR2(20) NOT NULL, -- 회원 id
cartstate NUMBER(3) NOT NULL, -- 카트상태 (1:카트에담겨있는,2:주문했을시)
CONSTRAINTS fk_cartBasic_userid FOREIGN KEY (userid) 
REFERENCES member(userid) ON DELETE CASCADE -- member테이블의 userid참조
)

-- 카트 상세 테이블
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


-- 선택상품 장바구니 삭제
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

--cartBasic 입력
CREATE OR REPLACE PROCEDURE cartBasic_insert
(
	userid        IN    member.userid%TYPE
)
IS 
BEGIN
	INSERT INTO cartBasic(cartid,userid,cartstate)
	VALUES(cart_id_seq.NEXTVAL, userid,1);
	COMMIT;
END; 


--시퀀스

 CREATE SEQUENCE cart_id_seq
	MAXVALUE 9999
	NOCYCLE
	
	
--userid로 cartid가져오기
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
	
--cartidx 시퀀스
CREATE SEQUENCE cart_idx_seq
	MAXVALUE 9999
	NOCYCLE
	
--cartDetail 입력 프로시저
CREATE OR REPLACE PROCEDURE cartDetail_insert
(
	d_cartid        IN    cartDetail.cartid%TYPE,
	d_productid        IN    cartDetail.productid%TYPE,
	d_p_count        IN    cartDetail.p_count%TYPE,
	d_price             IN   cartDetail.price%TYPE
)
IS 
BEGIN
	INSERT INTO cartDetail(cartidx,cartid,productid,p_count,validation,price)
	VALUES(cart_idx_seq.NEXTVAL, d_cartid, d_productid, d_p_count, 1,d_price);
	COMMIT;
END; 

-- cartid랑 상품id로 해당상품이 장바구니에 존재 여부
CREATE OR REPLACE procedure select_productid
(
	p_cartid 			IN 		CARTDETAIL.cartidx%TYPE,
	p_productid 			IN 		product.productid%TYPE,
	product_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN product_record FOR
	SELECT *
	FROM CARTDETAIL
	WHERE cartid = p_cartid AND productid = p_productid AND validation=1;
END; 

--- 장바구니 수량변경
CREATE OR REPLACE procedure updateCartDetail
(
	p_cartidx      IN cartdetail.cartidx%TYPE,
  p_p_count			IN		cartdetail.p_count%TYPE,
  p_price          IN  cartdetail.price%type
)
IS 
BEGIN
	UPDATE cartdetail
	SET p_count = p_p_count, price = p_price
	WHERE cartidx = p_cartidx;
	COMMIT;
END; 
 <---------------------------------------------------------------------------------------------->
 <-------------------------------------쿠폰테이블 시작------------------------------------------->
 
 --- 쿠폰테이블 시퀀스
CREATE SEQUENCE coupon_seq
	MAXVALUE 9999
	NOCYCLE
  
--- 쿠폰테이블 
CREATE TABLE Coupon
(
	couponNum NUMBER(3) PRIMARY KEY, --쿠폰 번호
  c_name VARCHAR2(30) NOT null, --쿠폰 이름
  c_content VARCHAR2(200) NOT NULL,  --쿠폰 내용
  c_discount NUMBER(6),-- 쿠폰 할인 금액
  c_dead    DATE, -- 쿠폰 마감 일자
  c_condition NUMBER(6) -- 쿠폰 사용 조건
)

--- 유저쿠폰 테이블 시퀀스
CREATE SEQUENCE coupon_seq1
	MAXVALUE 9999
	NOCYCLE
  
--- 유저의 쿠폰 테이블
CREATE TABLE userCoupon(
	c_idx NUMBER(2) PRIMARY key,
	userid VARCHAR2(20) NOT NULL, --사용자 id
  couponNum NUMBER(3) NOT NULL, -- 쿠폰번호
  receive_date DATE NULL, --받은 날자
	validity number(2),-- 쿠폰상태(1:있는 상태(기본), 2:쿠폰사용시)
  CONSTRAINTS fk_userCoupon_userid FOREIGN KEY (userid) 
	REFERENCES member(userid) ON DELETE CASCADE,
  CONSTRAINTS fk_userCoupon_couponNum FOREIGN KEY (couponNum) 
	REFERENCES Coupon(couponNum) ON DELETE CASCADE
)

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

-- userid로 쿠폰조회
CREATE OR REPLACE procedure select_userCoupon
(
	p_userid			IN 		userCoupon.userid%TYPE,
	coupon_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN coupon_record FOR
	SELECT u.c_idx, u.userid, u.couponNum, TO_CHAR(u.receive_date,'yyyy-mm-dd') AS receive_date,
  u.validity, c.c_name, c.c_content, c.c_discount, TO_CHAR(c.c_dead,'yyyy-mm-dd') AS c_dead, c.c_condition
	FROM userCoupon u INNER JOIN coupon c
  ON u.COUPONNUM = c.COUPONNUM
	WHERE userid = p_userid and validity = 1;
END;

-- 주문완료시 사용한 쿠폰의 유효성 1>> 0으로 변경
CREATE OR REPLACE procedure updateUserCoupon
(
	p_userid	 			IN 		USERCOUPON.userid%TYPE,
	p_couponNum	 			IN 		USERCOUPON.couponNum%TYPE
)
AS
BEGIN
	UPDATE usercoupon
  SET validity = 0
	WHERE userid = p_userid AND couponnum = p_couponNum;           
  COMMIT;
END;
-------------------------------------------쿠폰테이블 끝------------------------------------------------------------
-------------------------------------------주문테이블 시작-------------------------------------------------------
----orderBasic 테이블
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
  couponNum Number(3), --- 쿠폰번호(Null허용 안쓸수도있기때문) -- FK
  delivery number(5), ---배송비(3000 or 0)
  totalprice number(8) not NULL, --- 최종합계가격(배송비,쿠폰할인가 적용)
  CONSTRAINTS fk_orderBasic_userid FOREIGN KEY (userid) 
	REFERENCES Member(userid) ON DELETE CASCADE
)
ALTER TABLE orderbasic ADD(coupon_discount number(7));
ALTER TABLE orderbasic ADD(saving_discount number(7));
ALTER TABLE orderbasic ADD(RealTotalPrice number(7));
--- 할인금액 컬럼 추가

---- orderBasic 시퀀스
  CREATE SEQUENCE orderid_seq
	MAXVALUE 9999
	NOCYCLE
	
	
---- orderBasic 테이블
CREATE TABLE orderDetail -- 다른부분
(
	orderidx NUMBER(4) PRIMARY key,  --주문 일련번호
	orderid NUMBER(4),      -- 주문번호
	productid NUMBER(3),   --상품번호
	pcount NUMBER(4),    -- 상품수량
	price NUMBER(10),      -- 금액(상품가격x상품수량)
  CONSTRAINTS fk_orderDetail_orderid FOREIGN KEY (orderid) 
	REFERENCES orderBasic(orderid) ON DELETE CASCADE,
  CONSTRAINTS fk_productid1 FOREIGN KEY (productid)
 REFERENCES Product(productid) ON DELETE CASCADE
)

---- orderBasic 시퀀스
  CREATE SEQUENCE orderidx_seq
	MAXVALUE 9999
	NOCYCLE
	
---- orderbasic 입력 프로시저
CREATE OR REPLACE PROCEDURE orderBasic_insert
(
  p_userid       			 IN    orderBasic.userid%TYPE,
  p_username        IN    orderBasic.username%TYPE,
  p_tel        					IN    orderBasic.tel%TYPE,
  p_zipcode      	   IN    orderBasic.zipcode%TYPE,
  p_address1        IN    orderBasic.address1%TYPE,
  p_address2        IN    orderBasic.address2%TYPE,
  p_message        IN    orderBasic.message%TYPE,
  p_payid            IN    orderBasic.payid%TYPE,
  p_couponNum    IN    orderBasic.couponNum%TYPE,
  p_delivery        IN    orderBasic.delivery%TYPE,
  p_totalprice      IN    orderBasic.totalprice%TYPE,
  p_coupon_discount  IN orderbasic.coupon_discount%TYPE,
  p_saving_discount  IN orderbasic.saving_discount%TYPE,
  p_RealTotalPrice  IN orderbasic.RealTotalPrice%TYPE  
  
)
IS
BEGIN
	INSERT INTO orderBasic(orderid,userid,username,selldate,tel,zipcode,
  address1,address2,payid,message,o_state,couponNum,delivery,totalprice,coupon_discount,saving_discount,RealTotalPrice)
	VALUES(orderid_seq.NEXTVAL, p_userid,p_username,SYSDATE,p_tel,p_zipcode,
  p_address1,p_address2,p_payid,p_message,1,p_couponNum,p_delivery,p_totalprice,p_coupon_discount,p_saving_discount,p_RealTotalPrice);
	COMMIT;
END;

-- 가장 최근 idx 뽑아오기
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

-- 한 유저의 주문정보 가져오기 
CREATE OR REPLACE procedure ORDERINFOSELECT
(
	p_userid			IN 		orderbasic.userid%TYPE,
	orderInfo_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN orderInfo_record FOR
SELECT TO_CHAR(b.selldate,'yyyy-mm-dd') AS selldate, d.orderid,
           p.productimg, p.productname, d.price, b.o_state, b.COUPON_discount, b.saving_discount, totalprice
FROM orderbasic b INNER JOIN orderdetail d
ON b.ORDERID = d.ORDERID
INNER JOIN product p
ON p.productid = d.productid
WHERE userid = p_userid;
END;

--- userid로 orderbasic 조회
CREATE OR REPLACE procedure orderInfoSelect
(
	p_userid			IN 		orderbasic.userid%TYPE,
	orderInfo_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN orderInfo_record FOR
SELECT *FROM orderbasic
WHERE userid = p_userid;
END;

--하나의 orderid에 몇개의 상품이 존재하는지 
CREATE OR REPLACE procedure orderIdsSize
(
	p_orderid			IN 		orderdetail.orderid%TYPE,
	orderIdsSize_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN orderIdsSize_record FOR
SELECT d.orderidx, d.orderid, d.productid, d.pcount, d.price, p.productimg, p.productname
FROM ORDERDETAIL d INNER JOIN product p
ON d.productid = p.productid
WHERE orderid = p_orderid;
END;

---orderid로 orderDetail 조회
CREATE OR REPLACE procedure orderDetailSelect
(
	p_orderid			IN 		orderdetail.orderid%TYPE,
	orderDetailSelect_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN orderDetailSelect_record FOR
SELECT
d.orderidx, d.orderid, d.productid, d.pcount, d.price, p.productname, p.productimg,
b.username, TO_CHAR(b.selldate,'yyyy-mm-dd') AS selldate, b.tel, b.zipcode,
b.ADDRESS1, b.ADDRESS2,b.MESSAGE, b.PAYID, b.O_STATE, b.COUPONNUM, b.DELIVERY,
 b.TOTALPRICE,RealTotalPrice, COUPON_DISCOUNT, SAVING_DISCOUNT
FROM ORDERDETAIL d
INNER JOIN product p ON d.productid = p.productid 
INNER JOIN orderbasic b ON b.orderid = d.orderid
WHERE d.orderid = p_orderid;
END;

--- 주문완료하면 해당상품 재고는 --, 판매량은 ++
CREATE OR REPLACE procedure updateProductNum
(
	p_productid	 			IN 		product.productid%TYPE,
	p_pcount	 			IN 		cartdetail.p_count%TYPE
)
AS
BEGIN
	UPDATE product
  SET sell_count = sell_count + p_pcount, stock = stock - p_pcount
	WHERE productid = p_productid;           
           COMMIT;
END;

---- 주문 매출 표 출력 
	CREATE OR REPLACE procedure SearchOrderCount
(
	p_date1 								IN          VARCHAR2,
  p_date2 								IN          VARCHAR2,
	SearchOrderCount_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN SearchOrderCount_record FOR
		SELECT * FROM orderbasic
    WHERE selldate BETWEEN TO_DATE(p_date1,'yyyy-mm-dd')
 AND TO_DATE(p_date2,'yyyy-mm-dd');
END; 

SELECT TO_DATE('2019-01-17','yyyy-mm-dd')
FROM orderbasic;

-- 이번 주 주문 수량 그래프
	CREATE OR REPLACE procedure SearchOrderCount1
(
	p_date 								IN          VARCHAR2,
	SearchOrderCount_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN SearchOrderCount_record FOR
		SELECT * FROM orderbasic b
    INNER JOIN orderdetail d
    ON b.orderid = d.orderid
    WHERE selldate = TO_DATE(p_date,'yyyy-mm-dd');
END; 
-------------------------------------------------------------------------------------------------------------------
----------------------------------------메시지 테이블--------------------------------------------------------------
--메시지 테이블 생성
CREATE TABLE Message
(
	m_idx NUMBER(6) NOT NULL PRIMARY KEY, -- 일련번호
  m_sender VARCHAR2(20) NOT NULL,  -- 송신자ID
  m_receiver VARCHAR2(20) NOT NULL, -- 수신자ID
  m_contents VARCHAR2(300), -- 메시지내용
  m_date VARCHAR2(40)       -- 메시지 보낸 일자
);

-- 메시지테이블 pk 시퀀스
CREATE SEQUENCE message_seq
	MAXVALUE 9999
	NOCYCLE

-- 신규회원가입 시 메시지 보내는 프로시저
CREATE OR REPLACE PROCEDURE insertCouponMessage
(
	p_m_receiver		IN		message.m_receiver%TYPE,
	p_m_contents   	IN		message.m_contents%TYPE
)
IS 
BEGIN
	INSERT INTO message(m_idx, m_sender, m_receiver, m_contents, m_date,m_read)
	VALUES(message_seq.nextval, 'wlsdnd123', p_m_receiver, p_m_contents, SYSDATE,1);
	COMMIT;
END; 

-- 전체 메시지 조회(유저용) 
CREATE OR REPLACE procedure selectMessageAll
(
	p_m_receiver	 			IN 		message.m_receiver%TYPE,
	selectMessageAll_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN selectMessageAll_record FOR
	SELECT m_idx, m_sender, M_RECEIVER, M_CONTENTS, TO_CHAR(M_DATE, 'yymmdd-HH24:MI') AS m_date, m_read 
	FROM message
	WHERE (m_receiver = p_m_receiver and m_sender = 'wlsdnd123') 
  				OR  (m_receiver = 'wlsdnd123' and m_sender = p_m_receiver) 
  ORDER BY m_date asc;
END; 

-- 주문성공 시 메시지 보내는 프로시저
CREATE OR REPLACE PROCEDURE insertOrderMessage
(
	p_m_receiver		IN		message.m_receiver%TYPE,
	p_m_contents   	IN		message.m_contents%TYPE
)
IS 
BEGIN
	INSERT INTO message(m_idx, m_sender, m_receiver, m_contents, m_date,m_read)
	VALUES(message_seq.nextval, 'wlsdnd123', p_m_receiver, p_m_contents, SYSDATE,1);
	COMMIT;
END; 

--- 발신자 id로 메시지 전체조회(관리자용)
CREATE OR REPLACE procedure selectMessageAllAdmin
(
	p_m_sender	 			IN 		message.m_sender%TYPE,
	selectMessageAllAdmin_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN selectMessageAllAdmin_record FOR
	SELECT * 
	FROM message
	WHERE (m_receiver = 'wlsdnd123' and m_sender = p_m_sender)
  				 OR (m_receiver = p_m_sender and m_sender = 'wlsdnd123')
  ORDER BY m_date asc;
END; 

---관리자입장에서 누구누구한테 메시지가 왔는지 
CREATE OR REPLACE procedure selectReceiverList
(
	p_m_receiver	 			IN 		message.m_receiver%TYPE,
	selectReceiverList_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN selectReceiverList_record FOR
	SELECT * 
	FROM message
	WHERE m_receiver = 'wlsdnd123'
  ORDER BY m_date asc;
END; 


--  회원이 관리자에게 보내는 메시지 insert
CREATE OR REPLACE PROCEDURE insertUserMessage
(
	p_m_sender		IN		message.m_sender%TYPE,
	p_m_contents   	IN		message.m_contents%TYPE
)
IS 
BEGIN
	INSERT INTO message(m_idx, m_sender, m_receiver, m_contents, m_date,m_read)
	VALUES(message_seq.nextval, p_m_sender, 'wlsdnd123', p_m_contents, SYSDATE,1);
	COMMIT;
END; 

-- 관리자가 회원에게 보내는 메시지 insert
CREATE OR REPLACE PROCEDURE insertAdminMessage
(
	p_m_receiver		IN		message.m_receiver%TYPE,
	p_m_contents   	IN		message.m_contents%TYPE
)
IS 
BEGIN
	INSERT INTO message(m_idx, m_sender, m_receiver, m_contents, m_date,m_read)
	VALUES(message_seq.nextval, 'wlsdnd123', p_m_receiver, p_m_contents, SYSDATE,1);
	COMMIT;
END; 

-- 챗봇 대답 DB에 저장
CREATE OR REPLACE PROCEDURE AuToinsertAdminMessage
(
	p_m_receiver		IN		message.m_receiver%TYPE,
	p_m_contents   	IN		message.m_contents%TYPE
)
IS 
BEGIN
	INSERT INTO message(m_idx, m_sender, m_receiver, m_contents, m_date,m_read)
	VALUES(message_seq.nextval, 'wlsdnd123', p_m_receiver, p_m_contents, SYSDATE,0);
	COMMIT;
END; 

-- 안읽은 메시지 개수 조회 프로시저
CREATE OR REPLACE procedure selectUserUnReadMessage
(
	p_m_receiver	 			IN 		message.m_receiver%TYPE,
	selectUserUnReadMessage_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN selectUserUnReadMessage_record FOR
	SELECT * 
	FROM message
	WHERE (m_sender = 'wlsdnd123' and m_receiver = p_m_receiver)
           AND m_read = 1;
END; 


--- m_read 업데이트 (유저용)
CREATE OR REPLACE procedure MessageReadUpdate
(
	p_m_receiver	 			IN 		message.m_receiver%TYPE
)
AS
BEGIN
	UPDATE message
  SET m_read = 0
	WHERE (m_receiver = 'alrha486' and m_sender = 'wlsdnd123')
           AND m_read = 1;
           COMMIT;
END; 

--- m_read 업데이트 (관리자용)
CREATE OR REPLACE procedure MessageReadUpdateAdmin
(
	p_m_sender	 			IN 		message.m_sender%TYPE,
	p_m_receiver	 			IN 		message.m_receiver%TYPE
)
AS
BEGIN
	UPDATE message
  SET m_read = 0
	WHERE (m_receiver = p_m_receiver and m_sender = p_m_sender)	
           AND m_read = 1;
           COMMIT;
END; 

-- 가장 많이 팔린 상품 찾기 프로시저
CREATE OR REPLACE procedure SearchManyPopularityProduct
(
	ManyPopularityProduct_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN ManyPopularityProduct_record FOR
	SELECT * 
	FROM product
	ORDER BY  sell_count desc;
END; 

-- 추천상품 찾는 프로시저(가장최근에 올린 상품)
CREATE OR REPLACE procedure SearchRecentlyProduct
(
	SearchRecentlyProduct_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN SearchRecentlyProduct_record FOR
	SELECT * 
	FROM product
	ORDER BY registerdate desc;
END; 

---------------------------------------적립금 테이블------------------------------------
-- 적립금 테이블 생성 
CREATE TABLE savings
(
	s_idx NUMBER(3) PRIMARY KEY NOT null, -- 일련번호
	userid VARCHAR2(20) NOT null, -- 유저아이디
  saving NUMBER(7) NOT null, -- 적립금 
  CONSTRAINTS fk_savings_userid FOREIGN KEY (userid) 
	REFERENCES member(userid) ON DELETE CASCADE
)

-- 적립금 시퀀스
 CREATE SEQUENCE savings_seq
	MAXVALUE 9999
	NOCYCLE
	
	
	
-- 내 적립금 조회
CREATE OR REPLACE procedure selectMySaving
(
	p_userid 			IN savings.userid%TYPE,
	selectMySaving_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN selectMySaving_record FOR
	SELECT * 
	FROM savings
	WHERE userid = p_userid;
END;  


-- 주문 완료 시 적립금 업데이트(사용)
CREATE OR REPLACE procedure updateUserSaving
(
	p_userid	 			IN 		savings.userid%TYPE,
	p_saving	 			IN 		savings.saving%TYPE
)
AS
BEGIN
	UPDATE savings
  SET saving = saving - p_saving
	WHERE userid = p_userid;        
  COMMIT;
END; 

-- 회원 가입 시 기본 적립금 insert(0원으로)
CREATE OR REPLACE PROCEDURE insertBasicSaving
(
  p_userid       			 IN    savings.userid%TYPE  
)
IS
BEGIN
	INSERT INTO savings(s_idx, userid, saving)
	VALUES(savings_seq.nextval,p_userid,0);
	COMMIT;
END;

-- 주문완료시 적립금 적립
CREATE OR REPLACE procedure afterPurchaseUpdate
(
	p_userid	 			IN 		savings.userid%TYPE,
	p_saving	 			IN 		savings.saving%TYPE
)
AS
BEGIN
	UPDATE savings
  SET saving = saving + p_saving
	WHERE userid = p_userid;        
  COMMIT;
END; 

-- 쿠폰id로 쿠폰조회
CREATE OR REPLACE procedure selectCouponOne
(
	p_couponNum 			IN coupon.couponNum%TYPE,
	selectCouponOne_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
	OPEN selectCouponOne_record FOR
	SELECT * 
	FROM coupon
	WHERE couponNum = p_couponNum;
END;  

---- 주문 상태 변경
CREATE OR REPLACE PROCEDURE orderStateModify
(
	p_orderid		IN		orderbasic.orderid%type
)
AS
BEGIN
UPDATE  orderbasic
SET o_state = 2
WHERE orderid = p_orderid;
COMMIT;
END;

-- 주문상태 변경 시 메시지 전송
CREATE OR REPLACE PROCEDURE insertOrderStateChange
(
	p_m_receiver		IN		message.m_receiver%TYPE,
	p_m_contents   	IN		message.m_contents%TYPE
)
IS
BEGIN
	INSERT INTO message(m_idx, m_sender, m_receiver, m_contents, m_date,m_read)
	VALUES(message_seq.nextval, 'wlsdnd123', p_m_receiver, p_m_contents, SYSDATE,0);
	COMMIT;
END;

-- 주문상태 변경 시 메시지 전송2
CREATE OR REPLACE PROCEDURE insertOrderStateChange1
(
	p_m_receiver		IN		message.m_receiver%TYPE,
	p_m_contents   	IN		message.m_contents%TYPE
)
IS
BEGIN
	INSERT INTO message(m_idx, m_sender, m_receiver, m_contents, m_date,m_read)
	VALUES(message_seq.nextval, 'wlsdnd123', p_m_receiver, p_m_contents, SYSDATE,0);
	COMMIT;
END;




----------------------------------------------------- 주문관리 테이블 및 프로시저
create or replace PROCEDURE sq_admin_order_select
(
    sq_order_product_result     OUT     SYS_REFCURSOR
)
AS
BEGIN
    OPEN sq_order_product_result FOR
    SELECT DISTINCT productid, productname
    FROM product;
END;

create or replace procedure sq_admin_order_select_all
(
    order_select_all    OUT     SYS_REFCURSOR
)
AS
BEGIN
OPEN order_select_all FOR
SELECT
d.orderidx, d.orderid, d.productid, d.pcount, d.price, p.productname,
b.username, TO_CHAR(b.selldate,'yyyy-mm-dd') AS selldate,
b.PAYID, b.O_STATE, b.DELIVERY, b.TOTALPRICE
FROM ORDERDETAIL d
INNER JOIN product p ON d.productid = p.productid 
INNER JOIN orderbasic b ON b.orderid = d.orderid;
END;


create or replace procedure sq_admin_order_select_any
(
    sq_any_open     OUT     SYS_REFCURSOR,
    v_productname   IN      product.productname%TYPE,
    v_datepicker1   IN      DATE,
    v_datepicker2   IN      DATE,
    v_deliveryStep  IN      orderbasic.o_state%TYPE,
    v_orderlist     IN      VARCHAR
)
AS
BEGIN
    OPEN sq_any_open FOR
    SELECT
    d.orderidx, d.orderid, d.productid, d.pcount, d.price, p.productname,
    b.username, TO_CHAR(b.selldate,'yyyy-mm-dd') AS selldate,
    b.PAYID, b.O_STATE, b.DELIVERY, b.TOTALPRICE
    FROM ORDERDETAIL d
    INNER JOIN product p ON d.productid = p.productid AND p.productname = v_productname
    INNER JOIN orderbasic b ON b.orderid = d.orderid AND selldate between v_datepicker1 and v_datepicker2 AND b.o_state = v_deliveryStep
    ORDER BY v_orderlist ASC;
END;

//  가격정렬

create or replace procedure sq_admin_order_select_price
(
    sq_any_open_price     OUT     SYS_REFCURSOR,
    v_productname   IN      product.productname%TYPE,
    v_datepicker1   IN      DATE,
    v_datepicker2   IN      DATE,
    v_deliveryStep  IN      orderbasic.o_state%TYPE,
    v_payid         IN      orderbasic.payid%TYPE
)
AS
BEGIN
    OPEN sq_any_open_price FOR       
        SELECT    
        d.orderidx, d.orderid, d.productid, d.pcount, d.price, b.payid, p.productname,
        b.username, TO_CHAR(b.selldate,'yyyy-mm-dd') AS selldate,
        b.PAYID, b.O_STATE, b.DELIVERY, b.TOTALPRICE
        FROM ORDERDETAIL d
        INNER JOIN product p ON d.productid = p.productid 
        INNER JOIN orderbasic b ON b.orderid = d.orderid WHERE selldate between v_datepicker1 and v_datepicker2 AND b.o_state like '%' || v_deliveryStep || '%' AND b.payid like '%' || v_payid || '%'
        AND p.productname like '%' || v_productname || '%'
        ORDER BY price ASC;
END;


/// ////////////////////////////////////////////////////////////주문일
create or replace procedure sq_admin_order_select_selldate
(
    sq_any_open_selldate     OUT     SYS_REFCURSOR,
    v_productname   IN      product.productname%TYPE,
    v_datepicker1   IN      DATE,
    v_datepicker2   IN      DATE,
    v_deliveryStep  IN      orderbasic.o_state%TYPE,
    v_payid         IN      orderbasic.payid%TYPE
)
AS
BEGIN
    OPEN sq_any_open_selldate FOR       
        SELECT    
        d.orderidx, d.orderid, d.productid, d.pcount, d.price, b.payid, p.productname,
        b.username, TO_CHAR(b.selldate,'yyyy-mm-dd') AS selldate,
        b.PAYID, b.O_STATE, b.DELIVERY, b.TOTALPRICE
        FROM ORDERDETAIL d
        INNER JOIN product p ON d.productid = p.productid 
        INNER JOIN orderbasic b ON b.orderid = d.orderid WHERE selldate between v_datepicker1 and v_datepicker2 AND b.o_state like '%' || v_deliveryStep || '%' AND b.payid like '%' || v_payid || '%'
        AND p.productname like '%' || v_productname || '%'
        ORDER BY selldate ASC;
END;


///////////////////////////////////////////////////////////// 주문번호
create or replace procedure sq_admin_order_select_orderid
(
    sq_any_open_orderid     OUT     SYS_REFCURSOR,
    v_productname   IN      product.productname%TYPE,
    v_datepicker1   IN      DATE,
    v_datepicker2   IN      DATE,
    v_deliveryStep  IN      orderbasic.o_state%TYPE,
    v_payid         IN      orderbasic.payid%TYPE
)
AS
BEGIN
    OPEN sq_any_open_orderid FOR       
        SELECT    
        d.orderidx, d.orderid, d.productid, d.pcount, d.price, p.productname,
        b.username, TO_CHAR(b.selldate,'yyyy-mm-dd') AS selldate,
        b.PAYID, b.O_STATE, b.DELIVERY, b.TOTALPRICE
        FROM ORDERDETAIL d
        INNER JOIN product p ON d.productid = p.productid 
        INNER JOIN orderbasic b ON b.orderid = d.orderid WHERE selldate between v_datepicker1 and v_datepicker2 AND b.o_state like '%' || v_deliveryStep || '%' AND b.payid like '%' || v_payid || '%'
        AND p.productname like '%' || v_productname || '%'
        ORDER BY orderid ASC;
END;

------------------------------------------------------------------ 매장 테이블 및 프로시저

CREATE OR REPLACE PROCEDURE select_city_list_gugun
(
    rec_city       OUT      SYS_REFCURSOR,
    v_sido         IN       zipcode.sido%TYPE
)
AS
BEGIN
    OPEN rec_city FOR
    SELECT DISTINCT gugun
    FROM zipcode
    WHERE sido = v_sido;
END;


CREATE TABLE store
(
    shopid      NUMBER(2),
    shopname    VARCHAR2(50),
    address     VARCHAR2(200),
    telenumber  VARCHAR2(20),
    latitude    NUMBER,
    longitude   NUMBER,
    CONSTRAINT store_shopid_pk PRIMARY KEY(shopid)
);

INSERT INTO store VALUES(1, '카페인홍대입구점', '서울특별시 마포구 동교동', '02-1234-5678', 37.557527, 126.924467);
INSERT INTO store VALUES(2, '카페인서교점', '서울특별시 마포구 서교동', '02-1111-1111', 37.553489, 126.917730);
INSERT INTO store VALUES(3, '카페인홍익대점', '서울특별시 마포구 상수동 와우산로 94', '02-2782-6782', 37.551464, 126.925011);
INSERT INTO store VALUES(4, '카페인합정점', '서울특별시 마포구 합정동 양화로 45', '02-3213-1333', 37.551336, 126.913299);
INSERT INTO store VALUES(5, '카페인성산점', '서울특별시 마포구 성산2동 월드컵로 240', '02-6581-1111', 37.568259, 126.897277);
INSERT INTO store VALUES(6, '카페인송도점', '인천광역시 연수구 해송로 12', '032-7852-7777', 37.383107, 126.644591);
INSERT INTO store VALUES(7, '카페인킨텍스점', '경기도 고양시 일산서구 대화동 2234', '031-5475-1547', 37.672440, 126.746956);


create or replace PROCEDURE store_any_search
(
    v_address   IN	store.address%TYPE,
    rec_store   OUT SYS_REFCURSOR       
)
AS
BEGIN
    OPEN rec_store FOR
    SELECT *
    FROM store
    WHERE address LIKE '%' || v_address || '%';
END;


create or replace PROCEDURE store_all_search
(
    rec_store_all   OUT     SYS_REFCURSOR
)
AS
BEGIN
    OPEN rec_store_all FOR
    SELECT * FROM store;
END;


CREATE OR REPLACE PROCEDURE shopname_search
(
    v_shopname  IN      store.shopname%TYPE,
    sps_shop    OUT     SYS_REFCURSOR
)
AS
BEGIN
    OPEN sps_shop FOR
    SELECT *
    FROM store
    WHERE shopname LIKE '%' || v_shopname || '%';
END;


------------------------------------------------------------ 마이페이지 테이블 및 프로시저

CREATE OR REPLACE PROCEDURE my_select
(
    v_userid    IN  member.userid%TYPE,
    s_my_select OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN s_my_select FOR
    SELECT *
    FROM Member
    WHERE userid = v_userid;
END;


create or replace procedure my_update
(
	p_userid        IN      member.USERID%TYPE,
    p_passwd	    IN		member.passwd%TYPE,
    p_username      IN      member.username%TYPE,
    p_usernickname	IN		member.usernickname%TYPE,
	p_email			IN		member.email%TYPE,
    p_tel			IN		member.tel%TYPE,
	p_zipcode		IN		member.zipcode%TYPE,
	p_address1		IN		member.address1%TYPE,
	p_address2		IN		member.address2%TYPE
)
IS 
BEGIN
	UPDATE Member
	SET  usernickname = p_usernickname, email = p_email, tel = p_tel, zipcode = p_zipcode, address1 = p_address1, address2 = p_address2
	WHERE userid = p_userid;
	COMMIT;
END;


CREATE OR REPLACE PROCEDURE my_delete
(
    v_userid    IN      member.userid%TYPE
)
IS
BEGIN
    DELETE FROM member WHERE userid = v_userid;
END;

----------------------------------------------------------------- 배송지 관련 테이블 및 프로시저

CREATE TABLE subaddress(
seq	NUMBER	PRIMARY KEY,
userid varchar2(20) NOT NULL,
qaddressname    varchar2(50),
qzipcode CHAR(10),
qaddress1 varchar2(200),
qaddress2 varchar2(100),

CONSTRAINT FK_subaddress FOREIGN KEY(userid) REFERENCES member(userid)
);

CREATE OR REPLACE PROCEDURE sq_address_insert
(
    v_userid        IN      subaddress.userid%TYPE,
    v_qaddressname  IN      subaddress.qaddressname%TYPE,
    v_qzipcode      IN      subaddress.qzipcode%TYPE,
    v_qaddress1     IN      subaddress.qaddress1%TYPE,
    v_qaddress2     IN      subaddress.qaddress2%TYPE
)
IS
BEGIN
    INSERT INTO subaddress VALUES(v_userid, v_qaddressname, v_qzipcode, v_qaddress1, v_qaddress2);
END;

CREATE OR REPLACE PROCEDURE sq_address_select
(
    v_userid    IN  subaddress.userid%TYPE,
    sq_multi_address    OUT     SYS_REFCURSOR
)
AS
BEGIN
    OPEN sq_multi_address FOR
    SELECT *
    FROM subaddress
    WHERE userid = v_userid;
END;


CREATE OR REPLACE PROCEDURE sq_address_delete
(
    v_qaddressname  IN      subaddress.qaddressname%TYPE
)
IS
BEGIN
    DELETE FROM subaddress WHERE qaddressname = v_qaddressname;
    commit;
END;

CREATE SEQUENCE SEQ_address
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOMINVALUE;

INSERT INTO subaddress VALUES(seq_address.NEXTVAL, 'qw123', '일산', '10448', '경기 고양시 일산동구 일산로 9 (백석동)', '청솔아파트');
INSERT INTO subaddress VALUES(seq_address.NEXTVAL, 'qw123', '분당', '13591', '경기 성남시 분당구 분당로 43 (서현동)', '나우아파트');
INSERT INTO subaddress VALUES(seq_address.NEXTVAL, 'qw123', '홍대', '04050', '서울 마포구 양화로 지하 160 (동교동)', '쌍용교육센터');
INSERT INTO subaddress VALUES(seq_address.NEXTVAL, 'qw123', '강남', '06232', '서울 강남구 강남대로 지하 396 (역삼동)', '로빌아파트');



//상품 등록
create or replace PROCEDURE insertProduct
(
  p_kind_idx IN Product.kind_idx%TYPE,  
  p_productname IN Product.productname%TYPE, 
  p_productimg IN Product.productimg%Type,
  p_productex IN Product.productex%TYPE,
  p_price IN Product.price%TYPE,
  p_stock IN Product.stock%TYPE
)
IS
BEGIN
  INSERT INTO Product
  VALUES(product_seq.NEXTVAL, p_kind_idx, p_productname, p_productimg, p_productex, p_price, 0, to_char(SYSDATE,'YYYY-MM-DD HH:MI:SS'), p_stock);
  COMMIT;
END;


//상품 수정
create or replace PROCEDURE modifyProduct
( 
  m_productid       IN      Product.productid%TYPE,
  m_kind_idx        IN      Product.kind_idx%TYPE,
  m_productname     IN      Product.productname%TYPE,
  m_productimg      IN      Product.productimg%TYPE,
  m_productex       IN      Product.productex%TYPE,
  m_price           IN      Product.price%TYPE,
  m_stock           IN      Product.stock%TYPE
)
IS
BEGIN
  UPDATE Product 
  SET kind_idx = m_kind_idx, productname = m_productname, productimg = m_productimg,
  productex = m_productex, price=m_price, stock=m_stock
  WHERE productid = m_productid;
  COMMIT;
END;


//상품 삭제
create or replace procedure deleteProduct
(
    m_productid    in      Product.productid%TYPE
)
is
begin
    delete from Product
    where productid = m_productid;
    commit;
end;


//상품 정보 불러오기
create or replace PROCEDURE infoProduct
(
  m_productid		IN		Product.productid%TYPE,
  modify_info		OUT		SYS_REFCURSOR
)
AS
BEGIN
	OPEN modify_info FOR
	SELECT * FROM Product
	WHERE productid = m_productid;
END; 


//상품 조건 검색
create or replace PROCEDURE productInfo_select
(
   v_start             IN          NUMBER,
   v_end               IN          NUMBER,
   p_type      IN       varchar2,
   p_name      IN       varchar2,
   product_record OUT SYS_REFCURSOR
)
AS
    t_type  VARCHAR2(30);
BEGIN
    IF p_type = '1' THEN
        t_type := 'Beans';
    ELSIF p_type = '2' THEN
        t_type := 'Bottle Coffee';
    ELSIF p_type = '3' THEN
        t_type := 'Drip Bags';
    ELSIF p_type = '4' THEN
        t_type := 'Cake';
    ELSIF p_type = '5' THEN
        t_type := 'Bakery';
    ELSIF p_type = '6' THEN
        t_type := 'Sandwich';
    ELSIF p_type = '7' THEN
        t_type := 'Mug';
    ELSIF p_type = '8' THEN
        t_type := 'Tumbler';
    ELSIF p_type = '9' THEN
        t_type := 'Accessory';
    END IF;

    OPEN product_record FOR
    SELECT B.* FROM
        (SELECT rownum AS rnum, A.* FROM
            (SELECT * FROM product p
                INNER JOIN productkind k
                ON p.kind_idx = k.kind_idx
            WHERE k.p_productkind = t_type AND p.productname LIKE concat(concat('%',p_name),'%') order by productid desc) A
        WHERE rownum <= v_end) B
    WHERE B.rnum >= v_start;
END;


//상품 검색 카운트
create or replace PROCEDURE sp_product_search_count
(
   p_type      IN       varchar2,
   p_name      IN       varchar2,
   p_count     OUT      NUMBER
)
AS
    t_type  VARCHAR2(30);
BEGIN
    IF p_type = '1' THEN
        t_type := 'Beans';
    ELSIF p_type = '2' THEN
        t_type := 'Bottle Coffee';
    ELSIF p_type = '3' THEN
        t_type := 'Drip Bags';
    ELSIF p_type = '4' THEN
        t_type := 'Cake';
    ELSIF p_type = '5' THEN
        t_type := 'Bakery';
    ELSIF p_type = '6' THEN
        t_type := 'Sandwich';
    ELSIF p_type = '7' THEN
        t_type := 'Mug';
    ELSIF p_type = '8' THEN
        t_type := 'Tumbler';
    ELSIF p_type = '9' THEN
        t_type := 'Accessory';
    END IF;

    SELECT COUNT(*) INTO p_count FROM product p
    INNER JOIN productkind k
    ON p.kind_idx = k.kind_idx
    WHERE k.p_productkind = t_type AND p.productname LIKE concat(concat('%',p_name),'%');
END;


//상품 전체 카운트
create or replace PROCEDURE sp_coupon_total_count
(
    v_count     OUT     Number
)
IS
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Coupon;
END;


//상품 대분류 카운트
create or replace PROCEDURE sp_product_type_count
(
    p_type1 	IN      productkind.p_type%type,
    v_count     OUT     Number
)
IS
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM product p INNER JOIN PRODUCTKIND k ON p.KIND_IDX = k.KIND_IDX
    WHERE k.p_type = p_type1;
END;


//상품 소분류 카운트
create or replace PROCEDURE sp_product_kind_count
(
    kind_idx1 	IN      Number,
    v_count     OUT     Number
)
IS
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM product 
    WHERE kind_idx = kind_idx1;
END;


//상품 전체 목록
create or replace procedure select_productListAll
(
    v_start             IN          NUMBER,
	v_end               IN          NUMBER,
	productList_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
OPEN productList_record FOR
SELECT B.*
FROM
    (SELECT rownum AS rnum, A.*
    FROM
        (SELECT * FROM product order by productid desc) A
        WHERE rownum <= v_end) B
    WHERE B.rnum >= v_start;
END;


//상품 정보 불러오기
create or replace procedure selectProductOne
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


//상품 소분류 목록
create or replace procedure select_productListOne
(
	kind_idx1 			IN          product.kind_idx%type,
    v_start             IN          NUMBER,
	v_end               IN          NUMBER,
	productList_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
OPEN productList_record FOR
SELECT B.*
FROM
    (SELECT rownum AS rnum, A.*
    FROM
        (SELECT * FROM product WHERE kind_idx = kind_idx1 ORDER BY registerdate desc) A
        WHERE rownum <= v_end) B
    WHERE B.rnum >= v_start;
END;


//상품 대분류 목록
create or replace procedure select_productListOnes
(
	p_type1 			IN          productkind.p_type%type,
    v_start             IN          NUMBER,
	v_end               IN          NUMBER,
	productList_record  OUT 		SYS_REFCURSOR
)
AS
BEGIN
OPEN productList_record FOR
SELECT B.*
FROM
    (SELECT rownum AS rnum, A.*
    FROM
        (SELECT p.*
        FROM product p INNER JOIN PRODUCTKIND k ON p.KIND_IDX = k.KIND_IDX WHERE k.p_type = p_type1 ORDER BY p.registerdate desc) A
    WHERE rownum <= v_end) B
WHERE B.rnum >= v_start;
END;

//쿠폰 발급 페이지 회원 전체 검색
create or replace procedure select_memberListAll
(
	memberList_record   OUT 		SYS_REFCURSOR
)
AS
BEGIN
OPEN memberList_record FOR
SELECT * FROM member
order by regdate desc;
END;


//쿠폰 발급 페이지 회원 조건 검색
create or replace PROCEDURE memberInfo_select
(
   m_userid         IN       Member.userid%TYPE,
   member_record    OUT      SYS_REFCURSOR
)
AS
BEGIN
    OPEN member_record FOR
    SELECT * FROM Member
    WHERE userid LIKE concat(concat('%',m_userid),'%') order by regdate desc;
END;


//리뷰 시퀀스
CREATE SEQUENCE board_rev_idx_seq
  START WITH 1
  MAXVALUE 999999
  NOCYCLE;


//리뷰 테이블
CREATE TABLE RevList
(
  rev_idx NUMBER(6) NOT NULL ,
  product_id NUMBER(6),
  userid varchar2(6),
  rev_title	VARCHAR2(100)	NOT NULL,
  rev_file VARCHAR2(100),
  rev_score NUMBER(6)	NOT NULL,
  rev_contents	VARCHAR2(4000) 	NOT NULL,
  rev_writedate DATE 	NOT NULL,
  CONSTRAINT revlist_rev_idx_pk PRIMARY KEY(rev_idx)
);


//상품별 리뷰 전체 목록
create or replace PROCEDURE rev_select
(
	p_productid     IN      NUMBER,
    v_start         IN      NUMBER,
	v_end           IN      NUMBER,
    all_reviews		OUT		SYS_REFCURSOR
)
AS
BEGIN 
  OPEN all_reviews FOR
  SELECT B.*
  FROM
    (SELECT rownum AS rnum, A.*
    FROM
        (SELECT * FROM REVLIST WHERE product_id=p_productid order by rev_idx desc) A
        WHERE rownum <= v_end) B
    WHERE B.rnum >= v_start;
  COMMIT;
END;


//리뷰 등록
create or replace PROCEDURE rev_insert
(
  v_product_id IN RevList.product_id%TYPE,
  v_userid IN RevList.userid%TYPE,  
  v_rev_title IN RevList.rev_title%TYPE, 
  v_rev_file IN RevList.rev_file%Type,
  v_rev_score IN RevList.rev_score%TYPE,
  v_rev_contents IN RevList.rev_contents%TYPE  
)
IS
BEGIN
  INSERT INTO RevList
  VALUES(board_rev_idx_seq.NEXTVAL, v_product_id, v_userid, v_rev_title, v_rev_file, v_rev_score, 
v_rev_contents, SYSDATE);
  COMMIT;
END;


//리뷰 수정
create or replace PROCEDURE rev_update
( 
  v_rev_title IN RevList.rev_title%TYPE,
  v_rev_file IN RevList.rev_file%TYPE,
  v_rev_score IN RevList.rev_score%TYPE,
  v_rev_contents IN RevList.rev_contents%TYPE,
  v_rev_idx IN RevList.rev_idx%TYPE
)
IS
BEGIN
  UPDATE REVLIST 
  SET rev_title = v_rev_title, rev_file = v_rev_file, 
  rev_score = v_rev_score, rev_contents = v_rev_contents
  WHERE rev_idx = v_rev_idx;
  COMMIT;
END;


//리뷰 삭제
create or replace procedure rev_delete
(
    v_rev_idx    in      RevList.rev_idx%TYPE
)
is
begin
    delete from RevList
    where rev_idx = v_rev_idx;
    commit;
end;


//리뷰 정보 불러오기
create or replace PROCEDURE rev_select_one
(
  v_rev_idx		IN		RevList.rev_idx%TYPE,
  rev_board_record		OUT		SYS_REFCURSOR
)
AS
BEGIN
	OPEN rev_board_record FOR
	SELECT rev_idx, rev_title, rev_file, rev_score, rev_contents FROM RevList 
	WHERE rev_idx = v_rev_idx;
END;  


//상품별 리뷰 카운트
create or replace PROCEDURE sp_product_review_count
(
    p_product_id 	IN      revlist.product_id%type,
    v_count         OUT     Number
)
IS
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM revlist
    WHERE product_id = p_product_id;
END;


--문의 게시판--

CREATE SEQUENCE board_qna_idx_seq
	START WITH 1
  MAXVALUE 999999
  NOCYCLE;

CREATE TABLE QnAlist
(
	qna_idx		NUMBER(6)	NOT NULL 	,
  userid		varchar2(20)		,
  title		VARCHAR2(100)		NOT NULL,
  contents		LONG		NOT NULL,
  writedate		DATE ,
  readnum		 NUMBER(4)		NOT NULL,
  c_lock	NUMBER(1) 	NOT NULL,
  grp		NUMBER(5)		NOT NULL,
	lev		NUMBER(1)		NOT NULL,
	step		NUMBER(4)		NOT NULL,
  CONSTRAINT QnAlist_idx_pk		PRIMARY KEY(qna_idx)
)

DROP TABLE QNALIST

--리스트에 내용을 표시--

CREATE OR REPLACE PROCEDURE board_selectAll
(
	board_record OUT SYS_REFCURSOR
)
AS
BEGIN
	OPEN board_record FOR
	SELECT qna_idx, userid, title, writedate, readnum, c_lock, grp, lev, step
	FROM QNALIST  ORDER BY grp DESC, step ASC;
END; 

--리스트에 내용 표시 페이징 버전--
CREATE OR REPLACE PROCEDURE board_selectAll
(
	board_record OUT SYS_REFCURSOR,
  p_start	IN 		NUMBER,
  p_end	IN		NUMBER
)
AS
BEGIN
		OPEN	board_record FOR
    	SELECT B.qna_idx, userid, title, writedate, readnum, c_lock, grp, lev, step 
      FROM 
      	(SELECT ROWNUM AS rnum, A.qna_idx, A.userid, A.title, A.writedate, A.readnum, A.c_lock, A.grp, A.lev, A.step
         FROM 
         	(SELECT qna_idx, userid, title, writedate, readnum, c_lock, grp, lev, step
					 FROM QnAlist ORDER BY grp desc, STEP asc) A
         WHERE ROWNUM <= p_end) B
      WHERE B.rnum >= v_start;
END;

--페이징 카운트용--
CREATE OR REPLACE PROCEDURE board_page_count
(
	p_count		OUT		NUMBER 
)
IS
BEGIN 
	SELECT COUNT(*) INTO p_count
  FROM QnAList;
END;


--뷰에 내용 표시--
CREATE OR REPLACE PROCEDURE board_select
(
	p_qna_idx		IN		QnAlist.QNA_IDX%type,
  board_record		OUT		SYS_REFCURSOR
)
AS
BEGIN
	OPEN board_record FOR
	SELECT * FROM QNALIST 
	WHERE qna_idx = p_qna_idx;
END; 

--삽입입니다...
CREATE OR REPLACE PROCEDURE SCOTT.BOARD_INSERT
(
	p_title		IN		QnAlist.title%TYPE,
  p_c_lock		IN		QnAlist.C_LOCK%TYPE,
  p_contents		IN		QnAlist.contents%TYPE,
  p_userid		IN		QnAlist.userid%TYPE
)
IS
BEGIN
	INSERT INTO  QNALIST(qna_idx, userid, title, contents, writedate, readnum, c_lock, grp, step, lev)
  VALUES (board_qna_idx_seq.NEXTVAL,p_userid, p_title,  p_contents,
  				SYSDATE, 0, p_c_lock, BOARD_QNA_IDX_SEQ.CURRVAL, 0, 0);
	COMMIT;
END;

--조회수 업뎃
CREATE OR REPLACE PROCEDURE board_readnum_update
(
	p_qna_idx		IN		QnAlist.QNA_IDX%TYPE 
)
IS
	p_readnum		QnAlist.readnum%TYPE;
BEGIN 
	SELECT readnum INTO p_readnum
  FROM QNALIST WHERE qna_idx = p_qna_idx;
  
  UPDATE QNALIST SET readnum = p_readnum +1
  WHERE qna_idx = p_qna_idx;
  COMMIT;
END;

--답글용 스텝 그룹 업뎃
CREATE OR REPLACE PROCEDURE board_update_step
(
	p_grp		IN		QnAlist.grp%TYPE ,
  p_step		IN 		QnAlist.step%TYPE 
)
IS
BEGIN
UPDATE QNALIST
	SET step = step + 1
	WHERE grp = p_grp AND step > p_step;
	COMMIT;
END; 

--삭제
CREATE OR REPLACE PROCEDURE board_delete
(
	p_qna_idx       IN     QnAlist.qna_idx%TYPE
)
IS
BEGIN
	DELETE FROM QnAlist
	WHERE qna_idx = p_qna_idx;
	COMMIT;
END; 

--수정
CREATE OR REPLACE PROCEDURE board_update
(
	p_title             IN        QnAlist.title%TYPE,
	p_contents      IN         QnAlist.contents%TYPE,
  p_c_lock		IN			QnAlist.c_lock%TYPE ,
	p_qna_idx              IN        QnAlist.qna_idx%TYPE
)
IS
BEGIN
	UPDATE QnAlist
	SET title = p_title, contents = p_contents, C_LOCK = p_c_lock
	WHERE qna_idx = p_qna_idx;
	COMMIT;
END; 

--답글 입력--
CREATE OR REPLACE PROCEDURE board_reply_insert
(
	v_title                IN             QnAlist.title%TYPE,
	v_contents       IN            QnAlist.contents%TYPE,
  v_c_lock					IN							QnAlist.c_lock%TYPE,
  v_userid					IN							QnAlist.userid%TYPE,
	v_grp                 IN            QnAlist.grp%TYPE,
	v_lev                 IN            QnAlist.lev%TYPE,
	v_step               IN           QnAlist.step%TYPE
)
IS
BEGIN
	INSERT INTO QnAList
	VALUES(board_qna_idx_seq.NEXTVAL, v_userid, v_title, v_contents,  sysdate, 0, v_c_lock, v_grp, v_lev, v_step);
	COMMIT;
END;

--여기서부터 리뷰 테이블--

CREATE SEQUENCE board_rev_idx_seq
	START WITH 1
  MAXVALUE 999999
  NOCYCLE;

CREATE TABLE RevList
(
	rev_idx NUMBER(6) NOT NULL ,
  product_id NUMBER(6),
  userid varchar2(6),
  rev_title	VARCHAR2(100)	NOT NULL,
  rev_file VARCHAR2(100),
  rev_score NUMBER(6)	NOT NULL,
  rev_contents	VARCHAR2(4000) 	NOT NULL,
  rev_writedate DATE 	NOT NULL,
  CONSTRAINT revlist_rev_idx_pk PRIMARY KEY(rev_idx)
);

DROP TABLE REVLIST;

--읽어오는 셀렉트 프로시저
CREATE OR REPLACE PROCEDURE rev_select
(
	all_reviews		OUT		SYS_REFCURSOR
)
AS
BEGIN 
	OPEN all_reviews FOR
  SELECT *
  FROM REVLIST 
  ORDER BY rev_idx DESC;
END;

--삽입하는 인서트 프로시저
CREATE OR REPLACE PROCEDURE rev_insert
(
	v_rev_title IN RevList.rev_title%TYPE, 
  v_rev_file IN RevList.rev_file%Type,
  v_rev_score IN RevList.rev_score%TYPE,
  v_rev_contents IN RevList.rev_contents%TYPE,
  v_userid IN RevList.userid%TYPE
)
IS
BEGIN
	INSERT INTO RevList
  VALUES(board_rev_idx_seq.NEXTVAL,NULL, v_userid, v_rev_title, v_rev_file, v_rev_score, v_rev_contents, SYSDATE);
  COMMIT;
END;

--삭제 프로시저
CREATE OR REPLACE PROCEDURE rev_delete
(
	v_rev_idx	IN  RevList.rev_idx%TYPE
)
IS
BEGIN
	DELETE FROM REVLIST
	WHERE rev_idx = v_rev_idx;
  COMMIT;
END;

--수정 프로시저
CREATE OR REPLACE PROCEDURE rev_update
(
	v_rev_title IN RevList.rev_title%TYPE,
  v_rev_file IN RevList.rev_file%TYPE,
  v_rev_score IN RevList.rev_score%TYPE,
  v_rev_contents IN RevList.rev_contents%TYPE,
  v_rev_idx IN RevList.rev_idx%TYPE
)
IS
BEGIN
	UPDATE REVLIST 
  SET rev_title = v_rev_title, rev_file = v_rev_file, 
  rev_score = v_rev_score, rev_contents = v_rev_contents
  WHERE rev_idx = v_rev_idx;
  COMMIT;
END;

--하나만 셀렉트
CREATE OR REPLACE PROCEDURE rev_select_one
(
	v_rev_idx		IN		RevList.rev_idx%TYPE,
  rev_board_record		OUT		SYS_REFCURSOR
)
AS
BEGIN
	OPEN rev_board_record FOR
	SELECT rev_idx, rev_title, rev_file, rev_score, rev_contents FROM RevList 
	WHERE rev_idx = v_rev_idx;
END; 

--삭제
create or replace procedure rev_delete
(
    v_rev_idx    in      RevList.rev_idx%TYPE
)
is
begin
    delete from RevList
    where rev_idx = v_rev_idx;
    commit;
end;

DESC qnaList;