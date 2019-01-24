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
