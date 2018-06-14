<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
    <head>
        <title>flex 배우기</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="${root}/res/css/common.css">
        <style>
            *{
                box-sizing: border-box;
                border:1px dotted black;
                font-size: 18px;
            }
            .main-container, .select-container, .img-container, .profile, .content{
                
            }
            
            .main-container{
                width: 100%;
                height: 250px;
            }

            .select-container{
                width: 100%;
                height: 60px;
                text-align: center;
            }
            .img-container{
                width:100%;
                min-height: 60px;
            }
            
            .img-container::after{
                display: table;
                content: "";
                clear: both;
            }
            
            .img{
                float:left;
                width: 33.333333%;
                padding: 5px;
            }
            
            img{
                width:100%;
                height: 100%;
            }
            
            .profile{
                height: 100%;
                width: 250;
                display: inline-block;
                padding : 30px;
            }
            .content{
                width: 350;
                display: inline-block;
                vertical-align: top;
            }
            
            table{
                width: 100%;
                border-collapse: collapse;
            }
            
             .img-container > table{
             	height: 100%;
             }
            
            td{
            	padding:5px;
            }
            
            button{
                padding: 10px;
                background-color: white;
                border: none;
                height: 100%;
            }
            
            .now{
            	font-weight: bold;
                border-top: 3px solid black;
            }
            #myboard{
            	color: gray;
            }
        </style>
        <script src = "https://code.jquery.com/jquery-latest.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script>
            $(window).resize(function(){
                var w = $(".img").width();
                $(".img").height(w);
            });
            $(document).ready(function() {
                var w = $(".img").width();
                $(".img").height(w);
            });
        </script>
    </head>
    <body>
        <div class="container-80">
            <div class="main-container">
                <div class="profile">
                	<c:if test="${memberDto.profile=='pic.jpg'}">
						<img class="img-circle" src="${root}/res/img/${memberDto.profile}">
					</c:if>
					<c:if test="${memberDto.profile!='pic.jpg'}">
						<img class="img-circle" src="${root}/res/img/${memberDto.id}_${memberDto.profile}">
					</c:if>
                </div>
                <div class="content">
                	<div class="empty-row"></div>
                    <table>
                        <tbody>
                            <tr>
                                <td>${memberDto.nick}(닉네임)</td>
                                <td>
                                	<input type="button" value="프로필 편집" onclick="location.href='edit';">
                                </td>
                            </tr>
                            <tr>
                                <td>${memberDto.name}(이름)</td>
                                <td>게시물 0</td>
                            </tr>
                            <tr>
                                <td><a href="follower_list?nick=${memberDto.nick}">팔로워 ${follower_cnt} (링크)</a></td>
                                <td><a href="follow_list?nick=${memberDto.nick}">팔로우 ${follow_cnt} (링크)</a></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="select-container">
                <table>
                    <tbody>
                        <tr><button id="myboard" onclick="location.href='detail?nick=${memberDto.nick}';">게시물</button></tr>
                        <tr><button id="scrap" class="now" onclick="location.href='scrap';">저장됨</button></tr>
                    </tbody>
                </table>
            </div>
            <div class="img-container">
                <div class="img"><img src="img/bg001.jpg"></div>
                <div class="img"><img src="img/bg002.jpg"></div>
                <div class="img"><img src="img/bg002.jpg"></div>
                <div class="img"><img src="img/bg004.jpg"></div>
                <div class="img"><img src="img/bg005.jpg"></div>
                <div class="img"><img src="img/bg003.jpg"></div>
                <div class="img"><img src="img/bg003.jpg"></div>
                <div class="img"><img src="img/bg003.jpg"></div>
                <div class="img"><img src="img/bg003.jpg"></div>
            </div>
        </div>
    </body>
</html>