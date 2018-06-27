<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
  	<div class="container-80">
	<div class="row">
		<c:forEach var="noticeDto" items="${list}">
			<div class="alert-row">
				<span class="alert-profile">
					<c:if test="${noticeDto.profile=='pic.jpg'}">
						<img class="img-circle" src="${root}/member/image?name=${noticeDto.profile}" width="50" height="50">
					</c:if>
					<c:if test="${noticeDto.profile!='pic.jpg'}">
						<img class="img-circle" src="${root}/member/image?name=${noticeDto.id}_${noticeDto.profile}" width="50" height="50">
					</c:if>
				</span>
				<span class="alert-content">
					<c:if test="${noticeDto.type==0}">
						<!-- 제목 : 누르면 detail 페이지로 이동 -->
						<a href="${root}/member/detail?nick=${noticeDto.nick}">
							${noticeDto.nick}님이 회원님을 팔로우하기 시작했습니다.
						</a>
					</c:if>
					<c:if test="${noticeDto.type==1}">
						<a href="${root}/member/detail?nick=${usernick}">
							회원님의 게시물이 신고로 인해 삭제되었습니다.
						</a>
					</c:if>
					<c:if test="${noticeDto.type==2}">
						<input type="hidden" value="${noticeDto.bno}">
						<a class="board_notice" style="color:black;">
							${noticeDto.nick}님이 회원님의 게시물을 좋아합니다.
						</a>
					</c:if>
					<c:if test="${noticeDto.type==3}">
						<input type="hidden" value="${noticeDto.bno}">
						<a class="board_notice" style="color:black;">
							${noticeDto.nick}님이 댓글을 남겼습니다.
						</a>
					</c:if>
					<c:if test="${noticeDto.type==4}">
						<a href="${root}/member/detail?nick=${noticeDto.nick}">
							${noticeDto.nick}님이 메세지를 보냈습니다. 읽으시려면 팔로우를 해주세요.
						</a>
					</c:if>
				</span>
			</div>
		</c:forEach>
	</div>
</div>