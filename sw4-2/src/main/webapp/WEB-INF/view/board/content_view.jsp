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
			<p>댓글 자리</p>
			<p>댓글 자리</p>
			<p>댓글 자리</p>
			<p>댓글 자리</p>
		</div>
		<div>
			<input class="reply-input" type="text" placeholder="댓글 쓰기...">
			<button class="reply-btn btn btn-info">작성</button>
		</div>
	</div>


</div>