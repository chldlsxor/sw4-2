<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<jsp:include page="/WEB-INF/view/admin/admin_header.jsp"></jsp:include>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<div class = "container-70 main-section-container">
	<table class = "table">
		<thead>
			<tr>
				<th>작성자</th>
				<th>내용</th>
				<th>등록일 </th>
				<th>신고 수</th>
				<th>관리</th>
		</thead>
		<tbody>
		<!-- 나중에 회원하고 관리자하고 분리(리스트에 회원만 들어가게) -->
			<c:forEach var = "board" items="${reportList }">
				<tr>
				
					<td> ${board.writer }</td>
					<td> ${board.content }</td>
					<td> ${board.reg}</td>
					<td> ${board.report }</td>
					<td>
						<form action="report_list" method="post">
							<input type = "hidden" name = "id" value = "${board.writer}">
							<input type = "hidden" name = "bno" value = "${board.no }">
							<input type = "submit" value = "게시물 삭제하기">
						</form>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<jsp:include page="/WEB-INF/view/admin/admin_footer.jsp"></jsp:include>
