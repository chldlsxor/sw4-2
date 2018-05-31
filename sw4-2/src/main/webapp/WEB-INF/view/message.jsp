<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h1>현재 로그인 아이디 : ${success}</h1>

<h1>message</h1>

<h2>친구 리스트</h2>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>

<table>
	<thead>
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>닉네임 </th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var = "member" items="${memberList }">
			<tr>
				<td><a href = "send_message">${member.id }</td>
				<td>${member.name }</td>
				<td> ${member.nick}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>