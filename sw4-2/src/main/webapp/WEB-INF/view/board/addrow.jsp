<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<c:set var="flag" value="${false}"></c:set>
		<c:forEach var="boardDto" items="${list}" varStatus="status">
				<div class="row my-align">
				<div>
				<c:if test="${boardDto.profile=='pic.jpg'}">
						<img class="img-profile img-circle" src="${root}/member/image?name=${boardDto.profile}" width="50px" height="50px">
					</c:if>
					<c:if test="${boardDto.profile!='pic.jpg'}">
						<img class="img-profile img-circle" src="${root}/member/image?name=${boardDto.id}_${boardDto.profile}"width="50px" height="50px">
					</c:if> 
					${boardDto.nick }
					</div>
				<div class="swiper-container main-view-photo">
					<div class="swiper-wrapper">
					<input id="boardNo" type="hidden" value="${boardDto.no }">
						<c:forEach var="photoDto" items="${photoList[status.index]}">
								<img class="imgs swiper-slide" src="${root }/board/image?name=${photoDto.name}">
						</c:forEach>
				</div>
			           
			        <!-- 스크롤바 -->
            		<div class="swiper-scrollbar"></div>
	            </div>
				<div>
					<input class="loveList" type="hidden" value="${boardDto.good}">
					<input class="bno" type="hidden" value="${boardDto.no }">
					<c:forEach var="l" items="${loveList[status.index] }">
						<c:if test="${l == userno }">
							<c:set var="flag" value="${true}"></c:set>
						</c:if>
					</c:forEach>
					<c:choose>
						<c:when test="${flag }">
							<img class="love" src="${root}/res/image/innerHeart.png"
								width="30px" height="30px">
						</c:when>
						<c:otherwise>
							<img class="love" src="${root}/res/image/outLineHeart.png"
								width="30px" height="30px">
						</c:otherwise>
					</c:choose>
					<c:set var="flag" value="${false}"></c:set>
					<c:set var="markflag" value="${false}"></c:set>
						<c:forEach var="s" items="${scrapList.split(',') }">
							<c:if test="${boardDto.no == s }">
								<c:set var="markflag" value="${true}"></c:set>
							</c:if>
						</c:forEach>
						<c:choose>
							<c:when test="${markflag }">
								<a><img class="mark"
									src="${root}/res/image/innerBookmark.png" width="35px"
									height="35px"></a>
							</c:when>
							<c:otherwise>
								<a><img class="mark"
									src="${root}/res/image/outLineBookmark.png" width="35px"
									height="35px"></a>
							</c:otherwise>
						</c:choose>
						<c:set var="markflag" value="${false}"></c:set>
					<c:choose>
							<c:when test="${boardDto.nick == usernick }">
								<a href="delete?no=${boardDto.no }"><i class="fa fa-trash" style="font-size: 20px;"></i></a>
							</c:when>
							<c:otherwise>
								<a class="reportTag"><i class="fa fa-ban" style="font-size: 20px;"></i></a>
							</c:otherwise>
						</c:choose>
				</div>
				<div>
					<p class="inline">좋아요&nbsp;&nbsp;</p>
					<p class="inline loveCnt">${loveCnt[status.index]}</p>
					
				</div>
				<div>${boardDto.content }</div>
			</div>
		</c:forEach>