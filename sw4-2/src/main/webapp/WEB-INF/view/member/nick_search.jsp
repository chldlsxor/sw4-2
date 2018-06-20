<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
    <head>
        <title>친구 찾기</title>    
<!--        디자인 코드 작성 공간-->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="${root}/res/css/common.css">
        <style>
        	.container{
        		width:900px;
        	}
        	th{
        		width:100px;
        	}
        	img{
        		margin:10px;
        	}
        	.nick, .name{
        		padding:5px 20px;
        		display: inline-block;
        		border:none;
        	}
        	.name{
        		color:gray;
        	}
        	
        	.select-container{
                width: 100%;
                height: 60px;
                text-align: center;
            }
            
        	button{
                padding: 10px;
                background-color: white;
                border: none;
                height: 100%;
                color: gray;
            }
            .now{
            	font-weight: bold;
                border-top: 3px solid black;
                color: black;
            }
            
        	@media screen and (max-width:900px){
                .container{
                    width:100%;
                }
            }
        	
        	@media screen and (max-width:600px){
                .nick, .name{
                    display: block;
                }
            }
        	
        </style>
<!--        jQuery를 사용하기 위해 라이브러리를 불러오도록 설정-->
        <script src = "https://code.jquery.com/jquery-latest.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!--        스크립트 작성 공간-->
        <script>
            $(document).ready(function(){
                
            });
        </script>
    </head>
    <body>
    	<div class="empty-row"></div>
    	<div class="empty-row"></div>
    	<div class="container">
    		<div class="select-container">
                <table>
                    <tbody>
                        <tr><button onclick="location.href='name_search';">이름으로 검색</button></tr>
                       	<tr><button class="now" onclick="location.href='nick_search';">닉네임 검색</button></tr>
                    </tbody>
                </table>
            </div>
    	
    		<form action=nick_search method="get">
	        	<div class="row center">
	        		<input value="${nick}" class="form-input inline" type="text" name="nick" placeholder="친구 찾기(닉네임 검색)" required>
	        		<input type="submit" class="form-btn inline" value="검색">
	        	</div>
	        </form>
			<div class="row">
				<table>
					<tbody>
						<c:forEach var="memberDto" items="${list}">
						<tr>
							<th>
								<c:if test="${memberDto.profile=='pic.jpg'}">
									<img class="img-circle" src="${root}/res/img/${memberDto.profile}" width="70" height="70">
								</c:if>
								<c:if test="${memberDto.profile!='pic.jpg'}">
									<img class="img-circle" src="${root}/res/img/${memberDto.id}_${memberDto.profile}" width="70" height="70">
								</c:if>
							</th>
							<td align="left">
								<div class="nick">
								<!-- 제목 : 누르면 detail 페이지로 이동 -->
								<a href="detail?nick=${memberDto.nick}">
									${memberDto.nick}
								</a>
								</div>
								<div class="name">
									${memberDto.name}
								</div>
							</td>
						</tr> 
						</c:forEach>
					</tbody>
				</table>
			</div>
        </div>
    </body>
</html>