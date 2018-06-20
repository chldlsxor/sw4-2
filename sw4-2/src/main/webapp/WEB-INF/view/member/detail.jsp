<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
    <head>
        <title>상세보기</title>
        <link rel="stylesheet" type="text/css" href="${root}/res/css/swiper.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="${root}/res/css/common.css">
        <style>
        	.container{
        		width:900px;
        	}
            *{
                box-sizing: border-box;
                border:1px dotted black;
                font-size: 18px;
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
                width: 300;
                display: inline-block;
                vertical-align: top;
            }
            
            table{
                width: 100%;
                border-collapse: collapse;
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
            
            input[type=submit], input[type=button]{
            	background-color: #00A2E8;
				color:white;
            }
            
            .now{
            	font-weight: bold;
                border-top: 3px solid black;
            }
            #scrap{
            	color: gray;
            }
            
            @media screen and (max-width:900px){
                .container{
                    width:100%;
                }
            }
            
            @media screen and (max-width:768px){
                .main-container{
                    height: 210px;
                }
                .profile{
                    height: 200px;
                    width: 200px;
                    padding: 20px;
                }
                td{
                    display: block;
                }
                .content{
                    width: 150px;
                }
                .empty-row{
                	display:none;
                }
            }
            @media screen and (max-width:460px){
                .profile{
                    height: 70px;
                    width: 70px;
                    padding:0px;
                    margin-top:50px;
                }
                table{
                	font-size:14px;
                }
            }
        </style>
        <script src = "https://code.jquery.com/jquery-latest.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src = "${root}/res/js/swiper.min.js"></script>
        <script>
            $(window).resize(function(){
                var w = $(".img").width();
                $(".img").height(w);
            });
            $(document).ready(function() {
                var w = $(".img").width();
                $(".img").height(w);
                
                var swiper = new Swiper(".swiper-container",{
                    spaceBetween:10,
                    effect:'slide',
                    pagination:{
                        el:".swiper-pagination",    //버튼 영역
                        
                        //모양
                        type:"bullets",     //동그라미
                    },
                    
                    //스크롤바 등록
                    scrollbar:{
                        el:".swiper-scrollbar",
                        
                        //스크롤바 드래그 설정
                        draggable:true,
                    },
                });
            });
        </script>
    </head>
    <body>
        <div class="container">
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
                                <td>${memberDto.nick}</td>
                                <td>
                                	<c:if test="${userid == memberDto.id}">
                                		<input type="button" value="프로필 편집" onclick="location.href='edit';">
									</c:if>
									<c:if test="${userid != memberDto.id}">
										<c:if test="${follow_check}">
											<form action="unfollow" method="post">
												<input type="hidden" name="follower" value="${userid}">
												<input type="hidden" name="follow" value="${memberDto.id}">
												<input type="submit" value="언팔로우">
											</form>
										</c:if>
										<c:if test="${!follow_check}">
											<form action="follow" method="post">
												<input type="hidden" name="follower" value="${userid}">
												<input type="hidden" name="follow" value="${memberDto.id}">
												<input type="submit" value="팔로우">
											</form>
										</c:if>
									</c:if>
                                </td>
                            </tr>
                            <tr>
                                <td>${memberDto.name}</td>
                                <td>게시물 ${board_cnt}</td>
                            </tr>
                            <tr>
                                <td><a href="follower_list?nick=${memberDto.nick}">팔로워 ${follower_cnt}</a></td>
                                <td><a href="follow_list?nick=${memberDto.nick}">팔로우 ${follow_cnt}</a></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <c:if test="${userid == memberDto.id}">
	            <div class="select-container">
	                <table>
	                    <tbody>
	                        <tr><button id="myboard" class="now" onclick="location.href='detail?nick=${memberDto.nick}';">게시물</button></tr>
                        	<tr><button id="scrap" onclick="location.href='scrap';">저장됨</button></tr>
	                    </tbody>
	                </table>
	            </div>
			</c:if>
            <div class="img-container">
            	<c:forEach var="boardDto" items="${my_list}" varStatus="status">
            		<div class="swiper-container img">
						<div class="swiper-wrapper">
		            		<c:forEach var="photoDto" items="${photo_list[status.index]}">
								<img class="swiper-slide" src="${root}/board/image?name=${photoDto.name}">
		            		</c:forEach>
	            		</div>
	            		
	            		<!-- 페이징 버튼 -->
	                    <div class="swiper-pagination"></div>
	
	                    <!-- 스크롤바 -->
	                    <div class="swiper-scrollbar"></div>
	            	</div>
            	</c:forEach>
            </div>
        </div>
    </body>
</html>