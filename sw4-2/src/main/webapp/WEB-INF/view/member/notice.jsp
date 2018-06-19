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
									<img class="img-circle" src="${root}/res/img/${noticeDto.profile}" width="50" height="50">
									</c:if>
									<c:if test="${noticeDto.profile!='pic.jpg'}">
										<img class="img-circle" src="${root}/res/img/${noticeDto.id}_${noticeDto.profile}" width="50" height="50">
									</c:if>
								</span>
								<span class="alert-content">
									<c:if test="${noticeDto.type==0}">
										<!-- 제목 : 누르면 detail 페이지로 이동 -->
										<a href="detail?nick=${noticeDto.nick}">
											${noticeDto.nick}님이 회원님을 팔로우하기 시작했습니다.
										</a>
									</c:if>
									<c:if test="${noticeDto.type==1}">
										<a href="#">
											${noticeDto.nick}님이 회원님이 나온 사진을 업로드했습니다.
										</a>
									</c:if>
									<c:if test="${noticeDto.type==2}">
										<a href="#">
											${noticeDto.nick}님이 회원님의 게시물을 좋아합니다.
										</a>
									</c:if>
									<c:if test="${noticeDto.type==3}">
										<a href="#">
											${noticeDto.nick}님이 댓글을 남겼습니다 : 댓글내용
										</a>
									</c:if>
									<c:if test="${noticeDto.type==4}">
										<a href="#">
											${noticeDto.nick}님이 댓글에서 회원님을 태그했습니다 : 댓글내용
										</a>
									</c:if>
									<c:if test="${noticeDto.type==5}">
										<a href="detail?nick=${usernick}">
											회원님의 게시물이 신고로 인해 삭제되었습니다.
										</a>
									</c:if>
								</span>
								<span class="alert-date">${noticeDto.auto}</span>
								<span class="alert-move">
									<c:if test="${noticeDto.type==0}">
									<!-- 제목 : 누르면 detail 페이지로 이동 -->
									<button class="btn btn-info btn-xs" onclick="location.href='${root }/member/detail?nick=${noticeDto.nick}'">정보보기</button>
<%-- 									<a href="detail?nick=${noticeDto.nick}"> --%>
<!-- 										정보보기 -->
<!-- 									</a> -->
									</c:if>
									<c:if test="${noticeDto.type!=0}">
										<!-- 제목 : 누르면 detail 페이지로 이동 -->
										${noticeDto.bno}
									</c:if>
								</span>
								
						</div>
						</c:forEach>
			</div>
        </div>