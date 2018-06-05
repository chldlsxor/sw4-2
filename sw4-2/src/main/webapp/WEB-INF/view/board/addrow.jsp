<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<c:set var="flag" value="${false}"></c:set>

		<c:forEach var="boardDto" items="${list}" varStatus="status">
			<div class="row">
				<div>${boardDto.writer }</div>
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<c:forEach var="photoDto" items="${photoList[status.index]}">
								<img class="img swiper-slide" src="${root }/board/image?name=${photoDto.name}">
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
					<!-- 					<button class="test">클릭</button> -->
					<a><img class="mark"
						src="${root}/res/image/outLineBookmark.png" width="30px"
						height="30px"></a>
				</div>
				<div>
					<p class="inline">좋아요&nbsp;&nbsp;</p>
					<p class="inline loveCnt">${loveCnt[status.index]}</p>
				</div>
				<div>${boardDto.content }</div>
				<%--             		<c:forEach var="replyDto" items="${ }"> --%>
				<!--             			<div>댓글판</div> -->
				<%--             		</c:forEach> --%>
				<input class="form-input" type="text" placeholder="댓글 달기...">
			</div>
		</c:forEach>