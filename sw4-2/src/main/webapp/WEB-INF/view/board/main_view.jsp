<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<c:set var="flag" value="${false}"></c:set>
<html>
<head>
<style>
#main-view{
	display: flex;
	flex-wrap: wrap;
}
/* 이미지 슬라이더 적용 */
	.swiper-container {
		width: 500px;
		height: 500px;
/* 		margin: auto; */
		border: 1px solid black;
	}
	.swiper-container .swiper-slide>img {
		height: 500px;
		width: 500px;
	}
	
/* 	레이어 프레임 적용 */
        .mask {
            position:absolute;
            left:0;
            top:0;
            z-index:9999;
            background-color:#000;
            display:none;
        }
        .content-view {
            display: none;
            background-color: #ffffff;
            height: 200px;
            z-index:99999;
        }

/* 반응형 웹 */
@media screen and (min-width:891px) {
	
	#main-view{
		margin: auto;
	}

	.swiper-container {
		width: 500px;
		height: 500px;
/* 		margin: auto; */
		border: 1px solid black;
	}
	.swiper-container .swiper-slide>img {
		height: 400px;
		width: 400px;
	}
	.container-70 {
		width: 70%;
	}
	label {
		display: block;
		font-size: 3em;
		color: white;
	}
	#menu {
		width: 100%;
		margin-left: 0px;
	}
	#menu>a.right, #menu>a.inner-right {
		margin-right: 10px;
	}
}

@media screen and (max-width:890px) {

		#main-view{
		margin: 0;
		}
	
		.swiper-container {
		width: 400px;
		height: 400px;
/* 		margin: auto; */
		border: 1px solid black;
	}
	.swiper-container .swiper-slide>img {
		height: 300px;
		width: 300px;
	}

	.inner-div {
		width: 50%;
		padding: 2px;
		max-width: 50%;
	}
	#menu {
		margin-left: 0px;
		font-size: 1em;
	}
	.container-70 {
		width: 100%;
	}
	.top-search {
		width: auto;
		margin-left: 0px;
	}
	.imgs {
		width: 40%;
	}
}

@media screen and (max-width:565px) {
		#main-view{
		margin: 0;
		}
		.swiper-container {
		width: 300px;
		height: 300px;
		border: 1px solid black;
	}
	.swiper-container .swiper-slide>img {
		height: 100px;
		width: 200px;
	}
	#menu {
		font-size: 0.5em;
	}
		#main-view {
		width: 45%;
	}
	.inner-div {
		width: 100%;
		padding: 2px;
	}
	.top-search {
		width: 50px;
		margin-left: 0px;
	}
	.imgs {
		width: 30%;
	}
}
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
	//반응형 flex로 변경해야함
	var flag = true;
	var start = 1;
	var isRun = false;
	
    function wrapWindowByMask(){
    	
        $(document).on("mousewheel.disableScroll DOMMouseScroll.disableScroll touchmove.disableScroll", function(e) {
            e.preventDefault();
            return;
        });
        $(document).on("keydown.disableScroll", function(e) {
            var eventKeyArray = [32, 33, 34, 35, 36, 37, 38, 39, 40];
            for (var i = 0; i < eventKeyArray.length; i++) {
                if (e.keyCode === eventKeyArray [i]) {
                    e.preventDefault();
                    return;
                }
            }
        });
    	
        // 화면의 높이와 너비를 변수로 만듭니다.
        var maskHeight = $(document).height();
        var maskWidth = $(window).width();
 
        // 마스크의 높이와 너비를 화면의 높이와 너비 변수로 설정합니다.
        $('.mask').css({'width':maskWidth,'height':maskHeight});
 
        // fade 애니메이션 : 1초 동안 검게 됐다가 80%의 불투명으로 변합니다.
        $('.mask').fadeIn(1000);
        $('.mask').fadeTo("slow",0.8);
 
        // 레이어 팝업을 가운데로 띄우기 위해 화면의 높이와 너비의 가운데 값과 스크롤 값을 더하여 변수로 만듭니다.
        var left = ($(window).scrollLeft() + ( $(window).width() - $('.content-view').width()) / 2 );
        var top = ( $(window).scrollTop() +  50);
 
        // css 스타일을 변경합니다.
        $('.content-view').css({'left':left,'top':top, 'position':'absolute'});
        
        // 레이어 팝업을 띄웁니다.
        $('.content-view').show();
    }
	
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
										url : "${root}/board/addlist",
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
						url : "${root}/board/good",
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
	    
	    $("body").on("click","img.imgs",contentView);
        // 뒤 검은 마스크를 클릭시 모두 제거하도록 처리합니다.
 		$("body").on("click",".mask",maskOff);
        function maskOff(){
 			console.log("mask");
            $(".mask").remove();
            $('.content-view').remove();
            $(document).off(".disableScroll");
        };

	    function contentView(){
	    	var now = $(this);
	    	var boardNo = $(this).prev().val();
	    	$.ajax({
	    		url:"${root}/board/content_view",
	    		data: {"no":boardNo},
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				success : function(result){
					console.log(result);
                    result = $.parseHTML(result);
                    var div = $("<div/>").html(result);
					$("body").before(div);
					// imgs를 클릭시 작동하며 검은 마스크 배경과 레이어 팝업을 띄웁니다.
					wrapWindowByMask();
					$(".mask").on("click",maskOff);
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
				<img class="img-circle" src="http://via.placeholder.com/50x50">
			</div>
			<div class="user-profile">
				<p class="user-name">${userid }</p>
			</div>
			<hr>
			<div>
				<a class="pleft" href="#">스토리</a> <a class="pright" href="#">모두 보기</a>
			</div>
			<div>
				<button type="button" class="profile-btn btn btn-info btn-lg"
					onclick="location='write'">글 쓰기</button>
			</div>
		</div>
	</div>
	<div id="main-view" class="container-70">
<%-- 		<div>session = ${userno }</div> --%>
<%-- 		<div>session = ${userid }</div> --%>
		<c:forEach var="boardDto" items="${list}" varStatus="status">
			<div class="row my-align">
				<div><img class="img-circle" src="http://via.placeholder.com/50x50"> ${boardDto.writer }</div>
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<input id="boardNo" type="hidden" value="${boardDto.no }">
						<c:forEach var="photoDto" items="${photoList[status.index]}">
<!-- 								크기 변경안됨 -->
								<img class="imgs swiper-slide" src="${root }/board/image?name=${photoDto.name}" width="10px" height="10px;">
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