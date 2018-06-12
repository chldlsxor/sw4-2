<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
    <head>
        <title>Javascript 배우기</title>    
<!--        디자인 코드 작성 공간-->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="${root}/res/css/common.css">
        <style>
        
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
    	<div class="container-80">
    		<form action="list" method="get">
	        	<div class="row">
	        		<input value="${p.keyword}" type="text" name="name" placeholder="검색어" required>
	        		<input type="submit" value="검색">
	        	</div>
	        </form>
			<div class="empty-row"></div>
			<div class="row">
				<table class="table table-stripe">
					<thead>
						<tr>
							<th>프사</th>
							<th>닉네임</th>
							<th>이름</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="memberDto" items="${list}">
						<tr>
							<td><img class="img-circle" src="${root}/res/img/${memberDto.id}_${memberDto.profile}" width="50" height="50" id="profile"></td>
							<td align="left">
								
								<!-- 제목 : 누르면 detail 페이지로 이동 -->
								<a href="detail?no=${memberDto.no}">
									${memberDto.nick}
								</a>

							</td>
							<td>${memberDto.name}</td>
						</tr> 
						</c:forEach>
					</tbody>
				</table>
			</div>
        </div>
    </body>
</html>