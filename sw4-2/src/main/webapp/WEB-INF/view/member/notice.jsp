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
			<div class="row">
				<table class="table table-stripe">
					<thead>
						<tr>
							<th>reg</th>
							<th>type</th>
							<th>read</th>
							<th>프사</th>
							<th>msg</th>
							<th>게시물</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="mNDto" items="${list}">
						<tr>
							<td>${mNDto.reg}</td>
							<td>${mNDto.type}</td>
							<td>${mNDto.read}</td>
							<td>
								<c:if test="${mNDto.profile=='pic.jpg'}">
									<img class="img-circle" src="${root}/res/img/${mNDto.profile}" width="50" height="50">
								</c:if>
								<c:if test="${mNDto.profile!='pic.jpg'}">
									<img class="img-circle" src="${root}/res/img/${mNDto.id}_${mNDto.profile}" width="50" height="50">
								</c:if>
							</td>
							<td align="left">
								<c:if test="${mNDto.type==0}">
									<!-- 제목 : 누르면 detail 페이지로 이동 -->
									<a href="detail?nick=${mNDto.nick}">
										${mNDto.nick}님이 회원님을 팔로우하기 시작했습니다.
									</a>
								</c:if>
								<c:if test="${mNDto.type==1}">
									<a href="#">
										${mNDto.nick}님이 회원님이 나온 사진을 업로드했습니다.
									</a>
								</c:if>
								<c:if test="${mNDto.type==2}">
									<a href="#">
										${mNDto.nick}님이 회원님의 게시물을 좋아합니다.
									</a>
								</c:if>
								<c:if test="${mNDto.type==3}">
									<a href="#">
										${mNDto.nick}님이 댓글을 남겼습니다 : 댓글내용
									</a>
								</c:if>
								<c:if test="${mNDto.type==4}">
									<a href="#">
										${mNDto.nick}님이 댓글에서 회원님을 태그했습니다 : 댓글내용
									</a>
								</c:if>
								<c:if test="${mNDto.type==5}">
									<a href="#">
										신고
									</a>
								</c:if>
							</td>
							<td>
								<c:if test="${mNDto.type==0}">
									<!-- 제목 : 누르면 detail 페이지로 이동 -->
									<a href="detail?nick=${mNDto.nick}">
										정보보기
									</a>
								</c:if>
								<c:if test="${mNDto.type!=0}">
									<!-- 제목 : 누르면 detail 페이지로 이동 -->
									${mNDto.bno}
								</c:if>
							</td>
						</tr> 
						</c:forEach>
					</tbody>
				</table>
			</div>
        </div>
    </body>
</html>