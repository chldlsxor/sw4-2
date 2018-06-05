<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<c:set var="flag" value="${false}"></c:set>
<html>
<head>
<style>
</style>
<title>InStory</title>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="${root}/res/css/common.css">
<link rel="stylesheet" type="text/css" href="${root}/res/css/swiper.min.css">
<script src = "${root}/res/js/swiper.min.js"></script>

<script>
	var flag = true;
	var start = 1;
	var isRun = false;
	$(document).ready(function() {
	    var userNo = $("#userNo").val();
	    var listCnt = $("#listCnt").val();
	    console.log("userNo = ", userNo);
	    var root = document.location.hostname;
	    $(document).scroll(function() {
								var scrollT = $(this).scrollTop(); //스크롤바의 상단위치
								var scrollH = $(this).height(); //스크롤바를 갖는 div의 높이
								if (scrollT >= scrollH * 0.5&& flag) { // 스크롤바가 맨 아래에 위치할 때
									flag = false;
									start = start + 2;
									    if(isRun == true) {
									        return;
									    }
									    
									    isRun = true;
									$.ajax({
										url : "addlist",
										data : {
											"start" : start
										},
										success : function(result,status,information) {
											isRun = false;
	                                        result = $.parseHTML(result);
				                            var div = $("<div/>").html(result);
											$("#main-view").append(div);
											listCnt--;
											listCnt--;
									if(listCnt > 0){
										flag = true;
									}
									
									new Swiper(".swiper-container",{
							        	  mode:'horizontal',
								    	  loop: false,
								    	//스크롤바 등록
						                    scrollbar:{
						                        el:".swiper-scrollbar",//대상
						                        
						                        //스크롤바 드래그 설정
						                        draggable:true,
						                    }
							        });
									
											
								}
	    });
	}
});

	    //이벤트 바인딩
	    $("body").on("click","img.love",loveClick);
	    function loveClick(){
			var now = $(this);
			var bno = $(this).prevAll(".bno").val();
			var list = $(this).prevAll(".loveList").val().split(',');
			var mylove = now.parents("div.row").find(".loveCnt").text();
			var userNo = $("#userNo").val();
			$.ajax({
						url : "good",
						data : {
							"bno" : bno,
							"id" : userNo
						},
						contentType: "application/x-www-form-urlencoded; charset=UTF-8",
						success : function(result) {
							if (result > mylove) {
								now.context.src = "/sw4-2/res/image/innerHeart.png";
							} else {
								now.context.src = "/sw4-2/res/image/outLineHeart.png";
							}
							now.parents("div.row").find(".loveCnt").text(result);
						}
					});
	    };
	    
        new Swiper(".swiper-container",{
        	  mode:'horizontal',
	    	  loop: false,
	    		//스크롤바 등록
              scrollbar:{
                  el:".swiper-scrollbar",//대상
                  
                  //스크롤바 드래그 설정
                  draggable:true,
              }
        });
        
});
</script>
</head>
<body>
	<header>
		<input id="listCnt" type="hidden" value="${listCnt }">
		<input id="userNo" type="hidden" value="${userno}">
		<div id="menu" class="container-70">
			<a><i class="fa fa-camera">&nbsp;</i></a>
			<p>|</p>
			<a href="${root }/board/list" class="left"> InStory</a>

			<form action="#">
				<input class="top-search" type="text" placeholder="검색">
			</form>

			<a href="#" class="right"><i class="fa fa-history"></i></a> &nbsp;
			&nbsp; <a href="#" class="inner-right"><i class="fa fa-heart"></i></a>
			&nbsp; &nbsp; <a href="#" class="inner-right"><i class="fa fa-user"></i></a>
		</div>
	</header>
	<div class="empty-row"></div>
	<div class="empty-row"></div>
	<div class="empty-row"></div>
	<main>
	<div id="chaser">
		<div class="row">
			<div class="user-profile">
				<img class="img-circle" src="http://via.placeholder.com/100x100">
			</div>
			<div class="user-profile">
				<p class="user-name">사용자 이름</p>
			</div>
			<hr>
			<div>
				<a class="pleft" href="#">스토리</a> <a class="pright" href="#">모두
					보기</a>
			</div>
			<div>
				<button type="button" class="profile-btn btn btn-info btn-lg"
					onclick="location='write'">글 쓰기</button>
			</div>
		</div>
	</div>
	<div id="main-view" class="container-70">
		<div>session = ${userno }</div>
		<div>session = ${userid }</div>
		<c:forEach var="boardDto" items="${list}" varStatus="status">
			<div class="row">
				<div>${boardDto.writer }</div>
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<c:forEach var="photoDto" items="${photoList[status.index]}">
								<img class="img swiper-slide" src="${root }/board/image?name=${photoDto.name}" width="400px" height="400px;">
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
	</div>
	</main>
	<footer> 제작사 등등 </footer>
</body>
</html>