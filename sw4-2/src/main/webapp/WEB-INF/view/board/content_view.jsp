<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<c:set var="flag" value="${false}"></c:set>
<!-- 	마스크 div -->
<div class="mask"></div>
<div class="content-view">
	<div class="content-header"><img class="img-circle" src="http://via.placeholder.com/50x50"> ${boardDto.writer }</div>
	<div class="swiper-container content-photo">
		<div class="swiper-wrapper">
			<c:forEach var="photoDto" items="${photoList}">
				<img class="viewPhoto swiper-slide"
					src="${root }/board/image?name=${photoDto.name}">
			</c:forEach>
		</div>

		<!-- 스크롤바 -->
		<div class="swiper-scrollbar"></div>
	</div>
	<div class="content-text">
		<div class="content-post">
			${boardDto.content}
		</div>
		<div class="content-reply">
			<c:forEach var="replyDto" items="${replyList}">
				
				<p class="reply-text">${replyDto.id} | ${replyDto.content}</p><img class="reply-love" src="${root}/res/image/outLineHeart.png"width="17px" height="17px">
				<br>
				<p>
				${replyDto.reg }&nbsp;&nbsp;&nbsp;좋아요<i> 0</i>&nbsp;&nbsp;&nbsp;
				<c:if test="${replyDto.gno == 0 }">
					<a class="re-reply">답글 달기</a>
					<input type="hidden" value="${replyDto.no }">
					<input type="hidden" value="${replyDto.id }">
					</p>
					<c:if test="${replyDto.recnt != 0 }">
						<a class="re-reply-view">답글 보기(${replyDto.recnt})</a>
					</c:if>
					<a class="re-reply-hide" style="display: none">답글 접기</a>
				</c:if>
				<br><br>
			</c:forEach>
		</div>
		<div>
			<input class="content-view-bno" type="hidden" value="${boardDto.no }">
			<input class="content-view-content reply-input" type="text" placeholder="댓글 쓰기...">
			<button class="reply-btn btn btn-info">작성</button>
		</div>
	</div>


</div>