<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
				<td> ${member.id }</button></td>
				<td> ${member.name }</td>
				<td> ${member.nick}</td>
				<td> ${member.power }</td>
				<td> ${member.open }</td>
				<td>
					<button onclick="move:">상세보기</button>
					<button>수정하기</button>
					<button>삭제하기</button>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<h1><a href = "report_list">신고 글 리스트</a></h1>
<h1><a href = "">통계 확인하기</a></h1>
<h1><a href = "">내용 해시태그 아이디 검색하기</a></h1>
