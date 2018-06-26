<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<header>
		<div class="row">
			<input id="listCnt" type="hidden" value="${listCnt }"> <input
				id="userNo" type="hidden" value="${userno}">
			<div id="menu" class="container-70">
				<a href="${root }/board/list"><i class="fa fa-camera">&nbsp;</i></a>
				<p>|</p>
				<a href="${root }/board/list" class="left"> InStory</a>
	
				<a class="right"><i class="fa fa-hashtag"></i></a>&nbsp;&nbsp;<a href="${root }/member/name_search" class="inner-right"><i class="fa fa-search"></i></a> &nbsp;
				&nbsp; <a class="inner-right message-icon"  href="${root }/member/follow_list?nick=${usernick}"><i class="fa fa-envelope"></i></a>
				<label id = "message-count" class = "messageCnt">
					<c:if test="${messageCnt!=0}">
					${messageCnt}
					</c:if>
				</label>
				&nbsp; &nbsp; <a href="${root }/member/detail?nick=${usernick }" class="inner-right"><i class="fa fa-user"></i></a>&nbsp;&nbsp;<a class="inner-right"><i class="fa fa-bars"></i></a>
				&nbsp;&nbsp;<a class="inner-right" href="${root}/member/logout"><i class="fa fa-external-link"></i></a>
			</div>
		</div>
				<br><br><br>
		<div class="row">
			<div id="top-chaser">
				<div class="user-profile">
					<c:if test="${memberDto.profile=='pic.jpg'}">
						<img class="img-circle" src="${root}/res/img/${memberDto.profile}" width="50px" height="50px">
					</c:if>
					<c:if test="${memberDto.profile!='pic.jpg'}">
						<img class="img-circle" src="${root}/res/img/${memberDto.id}_${memberDto.profile}" width="50px" height="50px">
					</c:if>
					<p class="user-name">${usernick }</p>
				</div>
				<div class="top-user-alert-div">
					<a class="pleft">스토리</a>
				</div>
				<div>
					<button type="button" class="profile-btn btn btn-info btn-lg"
						onclick="location='write'">글 쓰기</button>
				</div>
			</div>
				<div class="top-user-alert">       
	            </div>
			<form action="${root }/board/list">
				<div id="search">
						<input class="top-search" type="text" name="key" placeholder="검색">
				</div>
				<div id="search-result"></div>
			</form>
	</div>
	</header>
	<div class="empty-row"></div>
	<div class="empty-row"></div>
	<div class="empty-row"></div>