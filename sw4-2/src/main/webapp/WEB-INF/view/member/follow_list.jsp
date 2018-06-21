<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
    <head>
        <title>팔로우 리스트</title>    
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
        	h7{
        		display:none;
        	}
        	.messenger_btn{
        		margin-left: 20px;
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
            	$(".messenger_btn").on("click", function(){
    		        window.open("send_message?messageTo="+$(this).find("h7").text(),
    		        		$(this).text(),//팝업창 이름
    		        		'toolbar=no, menubar=no, location=no, directories=no, status=no, resizable=yes, scrollbars=yes, width=350,height=700,left=0,top=0' );
    		    });
            });
        </script>
        <jsp:include page="/WEB-INF/view/template/headerscript.jsp"></jsp:include>
    </head>
    <body>
    	<jsp:include page="/WEB-INF/view/template/header.jsp"></jsp:include>
    	<div class="container">
    		<form action="follow_list" method="get">
	        	<div class="row">
	        		<input type="hidden" name="nick" value="${nick}">
	        		<select name="type" class="form-input inline">
						<option value="name">이름</option>
						<option value="nick" <c:if test="${type == 'nick'}">selected</c:if>>닉네임</option>
					</select>
	        		<input class="form-input inline" value="${keyword}" type="text" name="keyword" placeholder="팔로우 검색" required>
	        		<input class="form-btn inline" type="submit" value="검색">
	        	</div>
	        </form>
			<div class="empty-row"></div>
			<div>
				<h3>팔로우 : ${follow_cnt} 명</h3>
			</div>
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
							<c:if test="${usernick == nick}">
								<td>
									<button class = "messenger_btn form-btn inline"><h7>${memberDto.id}</h7><i class="fa fa-envelope"></i></button>
								</td>
							</c:if>
						</tr> 
						</c:forEach>
					</tbody>
				</table>
			</div>
        </div>
    </body>
</html>