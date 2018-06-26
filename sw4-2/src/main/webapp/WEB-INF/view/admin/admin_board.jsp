<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/view/admin/admin_header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
       
        <!--스크립트 작성 공간-->
        <style>
        	
        </style>
<script> 
	$(document).ready(function(){
		
	});     
</script>
<div class = "container-70 main-section-container">
	<form action = "admin_board" method ="post">
	 	<table class = "table">
			<tbody>
			 	<tr>
			 		<td width="20%">검색</td>
					<td>
						<input class="form-input" type = "text" name = "keyword" placeholder="검색할 내용 입력" value = ${keyword}>
					</td>
					<td width="20%">
						<input class="form-btn" type ="submit" value = "검색">	
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	 <table class ="table">
		<thead>
			<tr>
				<th>아이디</th>
				<th>내용</th>
				<th>등록일 </th>
				<th>좋아요 수</th>
				<th>신고 수</th>
			</tr>
		</thead>
		<tbody>
		<!-- 나중에 회원하고 관리자하고 분리(리스트에 회원만 들어가게) -->
			<c:forEach var = "board" items="${boardList }">
				<tr class = "center">
					<td> ${board.writer }</td>
					<td> ${board.content }</td>
					<td> ${board.reg}</td>
					<td> ${board.good}</td>
					<td> ${board.report }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<jsp:include page="/WEB-INF/view/admin/admin_footer.jsp"></jsp:include>
