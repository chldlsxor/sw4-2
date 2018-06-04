<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<script src = "https://code.jquery.com/jquery-latest.js"></script>
<script>
$(document).ready(function(){
    $(".messenger_btn").on("click", function(){
        window.open("send_message?messageto="+$(this).text(),
        		$(this).text(),//팝업창 이름
        		'toolbar=no, menubar=no, location=no, directories=no, status=no, resizable=yes, scrollbars=yes, width=350,height=700,left=0,top=0' );
   
    });
 });
</script>
<h1>현재 로그인 아이디 : ${userid}</h1>

<h1>message</h1>

<h2>친구 리스트</h2>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>

<table>
	<thead>
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>닉네임 </th>
			<th> follow</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var = "member" items="${memberList }">
			<tr>
				<td><button class = "messenger_btn">${member.id }</button></td>
				<td>${member.name }</td>
				<td> ${member.nick}</td>
				<td> <button>follow</button></td>
			</tr>
		</c:forEach>
	</tbody>
</table>