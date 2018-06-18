<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/view/admin/admin_header.jsp"></jsp:include>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<table>
	<thead>
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>닉네임 </th>
			<th>권한</th>
			<th>공개 여부</th>		
			<th>관리</th>
		</tr>
	</thead>
	<tbody>
	<!-- 나중에 회원하고 관리자하고 분리(리스트에 회원만 들어가게) -->
		<c:forEach var = "member" items="${memberList }">
			<tr>
				<td> ${member.id }</td>
				<td> ${member.name }</td>
				<td> ${member.nick}</td>
				<td> ${member.power }</td>
				<td> ${member.open }</td>
				<td>
					<form action = "detail_user" >
						<input type = "hidden" name = "nick" value="${member.nick}">
						<input type = "submit" value="상세 보기">
					</form>
					<form action = "" >
						<input type = "submit" value="수정하기">
					</form>
					<form action = "delete_user" method="get">
						<input type = "hidden" name = "id" value="${member.id }">
						<input type = "submit" value="삭제 하기">
					</form>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<div>
	<ul class = "pagination pagination=lg">
		<c:if test="첫페이지가 아니면">
			<li><a href="#">&lt;&lt;</a></li>
		</c:if>
		<c:if test="첫 블록이 아니면">
			<li><a href="#">&lt;</a></li>
		</c:if>
		<c:forEach var="i" begin="${p.blockstart}" end="${p.blockfinish}" step="1">
			<c:choose>
				<c:when test="${i == p.pageNo}">
					<li class="active">${i}</li>			
				</c:when>
				<c:otherwise>
					<li><a href="list?page=${i}${p.url}">${i}</a></li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="마지막 블록이 아니면">
			<li><a href="#">&gt;</a></li>
		</c:if>
		<c:if test="마지막페이지가 아니면">
			<li><a href="#">&gt;&gt;</a></li>
		</c:if>
	</ul>
</div>
<jsp:include page="/WEB-INF/view/admin/admin_footer.jsp"></jsp:include>

