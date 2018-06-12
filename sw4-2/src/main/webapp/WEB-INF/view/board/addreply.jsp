<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<c:set var="flag" value="${false}"></c:set>
			<c:forEach var="replyDto" items="${replyList}">
				<p class="reply-text">${replyDto.id} | ${replyDto.content}</p><img class="reply-love" src="${root}/res/image/outLineHeart.png"width="17px" height="17px">
				<br>
				<p>${replyDto.reg }&nbsp;&nbsp;&nbsp;좋아요<i> 0</i>&nbsp;&nbsp;&nbsp;<a class="re-reply">답글 달기</a><input type="hidden" value="${replyDto.no }"></p>
				<a class="re-reply-view">답글 보기</a>
				<br><br>
			</c:forEach>