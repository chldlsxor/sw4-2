<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<c:set var="flag" value="${false}"></c:set>
			<c:forEach var="replyDto" items="${replyList}">
				<p class="reply-text"><c:if test="${replyDto.gno != 0 }">&nbsp;&nbsp;&nbsp;&nbsp;</c:if>${replyDto.nick} | ${replyDto.content}</p><img class="reply-love" src="${root}/res/image/outLineHeart.png"width="17px" height="17px">
				<br>
				<p>
				<c:if test="${replyDto.gno != 0 }">&nbsp;&nbsp;&nbsp;&nbsp;</c:if>${replyDto.reg }&nbsp;&nbsp;&nbsp;좋아요<i> 0</i>&nbsp;&nbsp;&nbsp;
				<c:if test="${replyDto.gno == 0 }">
					<a class="re-reply">답글 달기</a>
					<input type="hidden" value="${replyDto.no }">
					<input type="hidden" value="${replyDto.nick }">
					</p>
					<c:if test="${replyDto.recnt != 0 }">
						<a class="re-reply-view">답글 보기(${replyDto.recnt})</a>
					</c:if>
					<a class="re-reply-hide" style="display: none">답글 접기</a>
				</c:if>
				<br><br>
			</c:forEach>