근데 만약 지금 급한거면 우선 보내줄게!

cartList.jsp


<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <link rel="stylesheet" href="./css/common.css">
</head>
<style>
* {
  margin: 0;
  padding: 0;
}
body {
  font-size: 11px;
}
.chat_list_wrap {
  list-style: none;
}
.chat_list_wrap .header {
  font-size: 14px;
  padding: 15px 0;
  background: #420100;
  color: white;
  text-align: center;
  font-family: "Josefin Sans", sans-serif;
}
.chat_list_wrap .search {
  background: #eee;
  padding: 5px;
}
.chat_list_wrap .search input[type="text"] {
  width: 100%;
  border-radius: 4px;
  padding: 5px 0;
  border: 0;
  text-align: center;
}
.chat_list_wrap .list {
  padding: 0 16px;
}
.chat_list_wrap .list ul {
  width: 100%;
  list-style: none;
  margin-top: 3px;
}
.chat_list_wrap .list ul li {
  padding-top: 10px;
  padding-bottom: 10px;
  border-bottom: 1px solid #e5e5e5;
}
.chat_list_wrap .list ul li table {
  width: 100%;
}
.chat_list_wrap .list ul li table td.profile_td {
  width: 50px;
  padding-right: 11px;
}
.chat_list_wrap .list ul li table td.profile_td img {
  width: 50px;
  height: auto;
}
.chat_list_wrap .list ul li table td.chat_td .name {
  font-size: 12px;
  font-weight: bold;
}
.chat_list_wrap .list ul li table td.time_td {
  width: 90px;
  text-align: center;
}
.chat_list_wrap .list ul li table td.time_td .time {
  padding-bottom: 4px;
}
.chat_list_wrap .list ul li table td.time_td .check p {
  width: 5px;
  height: 5px;
  margin: 0 auto;
  -webkit-border-radius: 50%;
  -moz-border-radius: 50%;
  border-radius: 50%;
  background: #e51c23;
}
</style>
<body>
<div class="chat_list_wrap">
    <div class="header">
        CAFEIN | 채팅
    </div>
    <div class="search">
        <input type="text" placeholder="채팅방 이름, 참여자 검색" />
    </div>
    <div class="list">
        <ul>
            <li>
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="profile_td">
                            <!--Img-->
                            <img src="./images/profile_preview.png" />
                        </td>
                        <td class="chat_td">
                            <!--name & Preview-->
                            <div class="name">
                                김수연
                            </div>
                            <div class="chat_preview">
                                여기에 문의해도 되나요?
                            </div>
                        </td>
                        <td class="time_td">
                            <!--Time & Check-->
                            <div class="time">
                                오후 4:00
                            </div>
                            <div class="check">
                                <p> </p>
                            </div>
                        </td>
                    </tr>
                </table>
            </li>
            <li>
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="profile_td">
                            <!--Img-->
                            <img src="./images/profile_preview.png" />
                        </td>
                        <td class="chat_td">
                            <!--name & Preview-->
                            <div class="name">
                                카페인 관리자
                            </div>
                            <div class="chat_preview">
                                안내드립니다
                            </div>
                        </td>
                        <td class="time_td">
                            <!--Time & Check-->
                            <div class="time">
                                어제
                            </div>
                            <div class="check">
                                
                            </div>
                        </td>
                    </tr>
                </table>
            </li>
            <li>
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="profile_td">
                            <!--Img-->
                            <img src="./images/profile_preview.png" />
                        </td>
                        <td class="chat_td">
                            <!--name & Preview-->
                            <div class="name">
                                복종순
                            </div>
                            <div class="chat_preview">
                                물건 안왔는데요
                            </div>
                        </td>
                        <td class="time_td">
                            <!--Time & Check-->
                            <div class="time">
                               2019-01-14
                            </div>
                        </td>
                    </tr>
                </table>
            </li>
        </ul>
    </div>
</div>
</body>
</html>