<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>

<table>
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
				<td> ${board.writer }</button></td>
				<td> ${board.content }</td>
				<td> ${board.reg}</td>
				<td> ${board.report }</td>
				<td>
					<button>알림 보내기</button>
					<button>삭제하기</button>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>