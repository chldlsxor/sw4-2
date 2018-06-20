<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/view/admin/admin_header.jsp"></jsp:include>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<form action = "member_list" method="get">
	<div>
	 	검색
		<select name ="keyword_type">
			<option value = "id||name||nick">전체</option>
			<option value = "id" <c:if test="${p.keyword_type == 'id'}">selected</c:if>>아이디</option>
			<option value = "name" <c:if test="${p.keyword_type == 'name'}">selected</c:if>>이름</option>
			<option value = "nick"<c:if test="${p.keyword_type == 'nick'}">selected</c:if>>닉네임</option>
		</select>
		<input type = "text" name = "keyword" placeholder="검색할 내용 입력" value = "${p.keyword }">
	</div>
	<div>
		정렬
		<select name ="order_type">		
			<option value = "id" >아이디</option>
			<option value = "name" <c:if test="${p.order_type == 'name'}">selected</c:if>>이름</option>
			<option value = "nick" <c:if test="${p.order_type == 'nick'}">selected</c:if>>닉네임</option>
			<option value = "reg" <c:if test="${p.order_type == 'reg'}">selected</c:if>>등록일</option>
		</select>
		<select name ="order">
			<option value = "asc">오름차순</option>
			<option value = "desc" <c:if test="${p.order == 'desc'}">selected</c:if>>내림차순</option>
		</select>
	</div>
	<div>
		리스트
		<select name ="list_num">
			<option value = "5" <c:if test="${p.list_num == 5}">selected</c:if>>5개</option>
			<option value = "10" <c:if test="${p.list_num == null||p.list_num==10}">selected</c:if>>10개</option>
			<option value = "15" <c:if test="${p.list_num == 15}">selected</c:if>>15개</option>
			<option value = "20" <c:if test="${p.list_num == 20}">selected</c:if>>20개</option>
		</select>
	</div>
	<div>
		권한
		<select name ="power">
			<option value = "회원">회원</option>
			<option value = "관리자" <c:if test="${p.power == '관리자'}">selected</c:if>>관리자</option>
		</select>
	</div>
	<div>
		<input type ="submit" value = "검색">	
	</div>
</form>
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
		<c:if test="${p.isNotFirst()}">
			<li><a href="member_list?page=1${p.url}">&lt;&lt;</a></li>
		</c:if>
		<c:if test="${p.isNotFirstBlock()}">
			<li><a href="member_list?page=${p.blockstart-1}${p.url}">&lt;</a></li>
		</c:if>
		<c:forEach var="i" begin="${p.blockstart}" end="${p.blockfinish}" step="1">
			<c:choose>
				<c:when test="${i == p.pageNo}">
					<li class="active"><a>${i}</a></li>			
				</c:when>
				<c:otherwise>
					<li><a href="member_list?page=${i}${p.url}">${i}</a></li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${p.isNotLastBlock()}">
			<li><a href="member_list?page=${p.blockfinish+1}${p.url}">&gt;</a></li>
		</c:if>
		<c:if test="${p.isNotLast()}">
			<li><a href="member_list?page=${p.blockmax}${p.url}">&gt;&gt;</a></li>
		</c:if>
	</ul>
</div>
<jsp:include page="/WEB-INF/view/admin/admin_footer.jsp"></jsp:include>

