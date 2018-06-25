<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<c:set var="flag" value="${false}"></c:set>
<html>
<head>
<meta name="viewport" content="width=device-width, init-scale=1.0">
<style>
#main-view {
	display: flex;
	flex-wrap: wrap;
}
/* 이미지 슬라이더 적용 */
.swiper-container {
	width: 60%;
	height: 70%;
}

.imgs {
	width: 100%;
	height: 100%;
}

/* 	레이어 프레임 적용 */
.mask {
	position: absolute;
	left: 0;
	top: 0;
	z-index: 9999;
	background-color: #000;
	display: none;
}

.content-view {
	background-color: #ffffff;
	z-index: 99999;
}

.text-red {
	color: red;
}
section {
	text-align: left;
}

#chaser > .row{
	padding-left: 15%;
}

.imgs, .love, .mark{
	cursor: pointer;
}

/* 반응형 웹 */
@MEDIA SCREEN AND (MIN-WIDTH:1113PX) {
	.content-photo {
		flex-grow: 0.48;
		order: 1;
	}
	.content-text {
		flex-grow: 0.48;
		order: 1;
	}
}

@MEDIA SCREEN AND (MAX-WIDTH:1112PX) {
	.content-photo {
		flex-grow: 1;
		oder: 1;
	}
	.content-text {
		flex-grow: 1;
		order: 2;
	}
}


@MEDIA SCREEN AND (MAX-WIDTH:750PX) {
	.swiper-container{
		width: 100%;
	}
	.content-view {
		font-size: 0.7em;
	}
}

@MEDIA SCREEN AND (MAX-WIDTH:565PX) {
	.content-view {
		font-size: 0.2em;
	}
}
</style>
<title>InStory</title>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" type="text/css"
	href="${root}/res/css/swiper.min.css">
<script src="${root}/res/js/swiper.min.js"></script>
<jsp:include page="/WEB-INF/view/template/headerscript.jsp"></jsp:include>
<style>
#top-chaser>.top-user-alert>a{
	color:black;
}
a:visited, a:link {
	color: black;
	text-decoration: none;
}
a:hover{
	cursor: pointer;
	color: black;
	text-decoration: none;
}
</style>
<script>
	//반응형 flex로 변경해야함
	var flag = true;
	var start = 6;
	var isRun = false;
	var gno = 0;

	function wrapWindowByMask() {
		$(document)
				.on(
						"mousewheel.disableScroll DOMMouseScroll.disableScroll touchmove.disableScroll",
						function(e) {
							e.preventDefault();
							return;
						});
		$(document).on("keydown.disableScroll", function(e) {
			var eventKeyArray = [ 32, 33, 34, 35, 36, 37, 38, 39, 40 ];
			for (var i = 0; i < eventKeyArray.length; i++) {
				if (e.keyCode === eventKeyArray[i]) {
					e.preventDefault();
					return;
				}
			}
		});

		// 화면의 높이와 너비를 변수로 만듭니다.
		var maskHeight = $(document).height();
		var maskWidth = $(window).width();

		// 마스크의 높이와 너비를 화면의 높이와 너비 변수로 설정합니다.
		$('.mask').css({
			'width' : maskWidth,
			'height' : maskHeight
		});

		// fade 애니메이션 : 1초 동안 검게 됐다가 80%의 불투명으로 변합니다.
		$('.mask').fadeIn(500);
		$('.mask').fadeTo("slow", 0.8);

		// 레이어 팝업을 가운데로 띄우기 위해 화면의 높이와 너비의 가운데 값과 스크롤 값을 더하여 변수로 만듭니다.
		var left = ($(window).scrollLeft() + ($(window).width() - $(
				'.content-view').width()) / 2);
		var top = ($(window).scrollTop() + 50);

		// css 스타일을 변경합니다.
		$('.content-view').css({
			'left' : left,
			'top' : top,
			'position' : 'absolute'
		});

		// 레이어 팝업을 띄웁니다.
		$('.content-view').show();
	}

	$(window).resize(function() {
				//리스트 사진 크기 정렬
				var w = $(".main-view-photo").width();
				$(".main-view-photo").height(w);
				//글 상세보기 사진 크기 정렬
				var w = $(".content-photo").width();
				$(".content-photo").height(w);

				var contentViewWidth = $('.content-view').width();

				if ($(document).width() > 1112) {
					$(".fa-bars").hide();
					$("#chaser").show();
					$("#top-chaser").hide();
				} else {
					$(".fa-bars").show();
					$("#chaser").hide();

				}
				if ($(document).width() > 750) {
					var contentviewHeight = contentViewWidth * 0.55;
				} else {
					var contentviewHeight = w * 0.7;
				}

				// 화면의 높이와 너비를 변수로 만듭니다.
				var maskHeight = $(document).height();
				var maskWidth = $(window).width();

				var contentText = $(".content-text").width();
				$(".content-text").height(contentText);

				//게시글 상세보기 크기 변경
				$(".content-view").height(contentviewHeight);

				// 마스크의 높이와 너비를 화면의 높이와 너비 변수로 설정합니다.
				$('.mask').css({
					'width' : maskWidth,
					'height' : maskHeight
				});

				// fade 애니메이션 : 1초 동안 검게 됐다가 80%의 불투명으로 변합니다.
				$('.mask').fadeIn(500);
				$('.mask').fadeTo("slow", 0.8);

				// 레이어 팝업을 가운데로 띄우기 위해 화면의 높이와 너비의 가운데 값과 스크롤 값을 더하여 변수로 만듭니다.
				var left = ($(window).scrollLeft() + ($(window).width() - $(
						'.content-view').width()) / 2);
				var top = ($(window).scrollTop() + 50);

				// css 스타일을 변경합니다.
				$('.content-view').css({
					'left' : left,
					'top' : top,
					'position' : 'absolute'
				});

			});

	//해쉬태그 색칠

	$(document).ready(function() {
						if ($(document).width() > 1250) {
							$(".fa-bars").hide();
							$("#chaser").show();
							$("#top-chaser").hide();
						} else {
							$(".fa-bars").show();
							$("#chaser").hide();
							$("#top-chaser").hide();
						}

						console.log("key = ${param.key}");
						var w = $(".main-view-photo").width();
						$(".main-view-photo").height(w);
						var userNo = $("#userNo").val();
						var listCnt = $("#listCnt").val();
						console.log("userNo = ", userNo);
						var root = document.location.hostname;
						$(document)
								.scroll(
										function() {
											var scrollT = $(this).scrollTop(); //스크롤바의 상단위치
											var scrollH = $(this).height(); //스크롤바를 갖는 div의 높이
											if (scrollT >= scrollH * 0.2
													&& flag) { // 스크롤바가 맨 아래에 위치할 때
												flag = false;

												if (isRun == true) {
													return;
												}

												isRun = true;

												$
														.ajax({
															url : "${root}/board/addlist",
															data : {
																"start" : start,
																"key" : "${param.key}"
															},
															success : function(
																	result,
																	status,
																	information) {
																start = start + 3;
																isRun = false;
																result = $
																		.parseHTML(result);
																var div = $(
																		"<div class='add-aglin'/>")
																		.html(
																				result);
																$("#main-view")
																		.append(
																				div);
																listCnt--;
																listCnt--;
																var w = $(".main-view-photo").width();
																$(".main-view-photo").height(w);
																if (listCnt > 0) {
																	flag = true;
																}

																new Swiper(".swiper-container",{
																			mode : 'horizontal',
																			loop : false,
																			//스크롤바 등록
																			scrollbar : {
																				el : ".swiper-scrollbar",//대상

																				//스크롤바 드래그 설정
																				draggable : true,
																			}
																		});

															}
														});
											}
										});

						//이벤트 바인딩
						$("body").on("click", "img.love", loveClick);
						function loveClick() {
							var now = $(this);
							var bno = $(this).prevAll(".bno").val();
							var list = $(this).prevAll(".loveList").val().split(',');
							var mylove = now.parents("div.row").find(".loveCnt").text();
							var userNo = $("#userNo").val();
							$
									.ajax({
										url : "${root}/board/good",
										data : {
											"bno" : bno,
											"id" : userNo
										},
										contentType : "application/x-www-form-urlencoded; charset=UTF-8",
										success : function(result) {
											if (result > mylove) {
												now.context.src = "/sw4-2/res/image/innerHeart.png";
											} else {
												now.context.src = "/sw4-2/res/image/outLineHeart.png";
											}
											now.parents("div.row").find(
													".loveCnt").text(result);
										}
									});
						}
						;

						$("body").on("click", "img.imgs", contentView);
						$("body").on("click","a.board_notice", contentView);
						// 뒤 검은 마스크를 클릭시 모두 제거하도록 처리합니다.
						$("body").on("click", ".mask", maskOff);
						function maskOff() {
							console.log("mask");
							$(".mask").remove();
							$('.content-view').remove();
							$(document).off(".disableScroll");
						}
						;

						//글 상세보기
						function contentView() {
							var now = $(this);
							var boardNo = $(this).prev().val();
							$
									.ajax({
										url : "${root}/board/content_view",
										data : {"no" : boardNo},
										contentType : "application/x-www-form-urlencoded; charset=UTF-8",
										success : function(result) {

											result = $.parseHTML(result);
											var div = $("<div/>").html(result);
											$("body").before(div);
											//댓글 버튼 이벤트 바인딩
											$(".reply-btn").on("click",
													replyWrite);
											$(".re-reply-view").on("click",
													reReplyView);
											$(".re-reply").on("click", reReply);
											$(".re-reply-hide").on("click",
													reReplyHide);
											$(".reply-love").on("click",
													ReplyLove);
											$(".reply-input").on("keyup",function(e) {
																var keyCode = e.which ? e.which
																		: e.keyCode;
																var text = $(
																		".reply-input")
																		.val();
																if (keyCode == 32) {
																	$(".reply-input").val(text+" ");
																}
															});

											//사진크기
											var w = $(".content-photo").width();
											$(".content-photo").height(w);

											//자세히보기 사이즈
											var contentViewWidth = $('.content-view').width();
											var contentviewHeight = contentViewWidth * 0.55;

											//글 내용 사이즈
											var contentText = $(".content-text").width();
											$(".content-text").height(contentText);

											// imgs를 클릭시 작동하며 검은 마스크 배경과 레이어 팝업을 띄웁니다.
											wrapWindowByMask();
											$(".mask").on("click", maskOff);
											new Swiper(".swiper-container", {
												mode : 'horizontal',
												loop : false,
												//스크롤바 등록
												scrollbar : {
													el : ".swiper-scrollbar",//대상

													//스크롤바 드래그 설정
													draggable : true,
												}
											});
										}
									});
						}
						;

						//댓글 등록
						function replyWrite() {
							var userId = "${userid}";
							var bno = $(".content-view-bno").val();
							console.log("bno = ", bno);
							var content = $(".content-view-content").val();
							if (content.charAt(0) != "@") {
								gno = 0;
							}
							$.ajax({
								url : "${root}/reply/write",
								data : {
									"bno" : bno,
									"content" : content,
									"gno" : gno,
									"id" : userId
								},
								success : function(result) {
									$(".content-reply").empty();
									var replyList = result;
									result = $.parseHTML(result);
									var addP = $("<p/>").html(result);
									$(".content-reply").append(addP);
									$(".content-view-content").val("");
									$(".re-reply-view")
											.on("click", reReplyView);
									$(".re-reply").on("click", reReply);
									$(".re-reply-hide")
											.on("click", reReplyHide);
									$(".reply-love").on("click", ReplyLove);
									gno = 0;

								}
							});
						}
						;

						//대댓보기
						function reReplyView() {
							console.log("답글 보기")
							var now = $(this);
							var reNo = $(this).prev().find("input").val();
							$.ajax({
								url : "${root}/reply/re-reply-view",
								data : {
									"gno" : reNo
								},
								success : function(result) {
									var replyView = result;
									result = $.parseHTML(result);
									var addP = $("<p/>").html(result);
									now.next().show();
									now.after(addP);
									now.hide();
								}
							});
						}
						;

						//대댓 닫기
						function reReplyHide() {
							$(this).prev().remove();
							$(this).prev().show();
							$(this).hide();
						}

						//대댓 쓰기
						function reReply() {
							console.log("답글 쓰기");
							gno = $(this).next().val();
							var id = $(this).next().next().val();
							$(".reply-input").val("@" + id + " - ");
							console.log(gno);
						}

						new Swiper(".swiper-container", {
							mode : 'horizontal',
							loop : false,
							//스크롤바 등록
							scrollbar : {
								el : ".swiper-scrollbar",//대상

								//스크롤바 드래그 설정
								draggable : true,
							}
						});

						//알림창 보기

						//우측 알림창
						$(".user-alert-div").on("click", function() {
							$(".user-alert").empty();
							$.ajax({
								url : "${root}/member/notice",
								success : function(result) {
									var origin = result;
									result = $.parseHTML(result);
									$(".user-alert").append(result);
									$(".user-alert").slideToggle();
								}
							});
						});

						//댓글 좋아요
						function ReplyLove() {
							var reno = $(this).nextAll().next().find(
									".reply-no").val();
							var reuserno = "${userno}";
							console.log("no = " + reno);
							console.log("buserno = " + reuserno);
							$.ajax({
								url : "${root}/reply/replylove",
								data : {
									"no" : reno,
									"userno" : reuserno
								},
								success : function(result) {
									var bno = result.bno;
									$(".content-reply").empty();
									var replyList = result;
									result = $.parseHTML(result);
									var addP = $("<p/>").html(result);
									$(".content-reply").append(addP);
									$(".content-view-content").val("");
									$(".re-reply-view")
											.on("click", reReplyView);
									$(".re-reply").on("click", reReply);
									$(".re-reply-hide")
											.on("click", reReplyHide);
									$(".reply-love").on("click", ReplyLove);
									gno = 0;

								}
							});
						}
						;

						$("body").on("click", "img.mark", scrap);
						function scrap() {
							var markflag = false;
							var now = $(this);
							var bno = $(this).parent().prevAll()[1].value;
							$
									.ajax({
										url : "${root}/member/scrapUp",
										data : {
											"bno" : bno
										},
										success : function(result) {
											result = result.split(",");
											for ( var s in result) {
												if (bno == result[s]) {
													markflag = true;
												}
											}
											if (markflag) {
												now.context.src = "${root}/res/image/innerBookmark.png";
											} else {
												now.context.src = "${root}/res/image/outLineBookmark.png";
											}
										}
									});
						}
						;

					});
</script>

</head>
<body>
	<jsp:include page="/WEB-INF/view/template/header.jsp"></jsp:include>


	<section>
	<div id="chaser" class="left">
		<div class="row" style="width: 95%">
			<div class="user-profile">
				<c:if test="${memberDto.profile=='pic.jpg'}">
						<img class="img-profile img-circle" src="${root}/res/img/${memberDto.profile}" width="50px" height="50px">
					</c:if>
					<c:if test="${memberDto.profile!='pic.jpg'}">
						<img class="img-profile img-circle" src="${root}/res/img/${memberDto.id}_${memberDto.profile}" width="50px" height="50px">
					</c:if>
			</div>
			<div class="user-profile">
				<p class="user-name">${usernick }</p>
			</div>
			<hr>
			<div class="user-alert-div">
				<a class="pleft">스토리</a>
			</div>
			<div class="user-alert"></div>
			<div>
				<button type="button" class="profile-btn btn btn-info btn-lg"
					onclick="location='write'">글 쓰기</button>
			</div>
		</div>
	</div>
	<div id="main-view" class="container-60">
		<%-- 		<div>session = ${userno }</div> --%>
		<%-- 		<div>session = ${userid }</div> --%>
		<c:if test="${list == null }">
			<div>
				<h1>팔로우를 추가해 보세요!</h1>
			</div>
		</c:if>
		<c:forEach var="boardDto" items="${list}" varStatus="status">
			<div class="row my-align left">
				<div>
					<a href="${root }/member/detail?nick=${boardDto.nick}" style="text-decoration:none">
					<c:if test="${boardDto.profile=='pic.jpg'}">
						<img class="img-profile img-circle" src="${root}/res/img/${boardDto.profile}" width="50px" height="50px">
					</c:if>
					<c:if test="${boardDto.profile!='pic.jpg'}">
						<img class="img-profile img-circle" src="${root}/res/img/${boardDto.id}_${boardDto.profile}"width="50px" height="50px">
					</c:if>
					${boardDto.nick }
					</a>
				</div>
				<div class="main-view-cover">
					<div class="swiper-container main-view-photo">
						<div class="swiper-wrapper">
							<input class="boardNo" type="hidden" value="${boardDto.no }">
							<c:forEach var="photoDto" items="${photoList[status.index]}">
								<img class="imgs swiper-slide"
									src="${root }/board/image?name=${photoDto.name}" width="10px"
									height="10px;">
							</c:forEach>
						</div>

						<!-- 스크롤바 -->
						<div class="swiper-scrollbar"></div>
					</div>
				</div>
					<div></div>
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
									src="${root}/res/image/innerBookmark.png" width="30px"
									height="30px"></a>
							</c:when>
							<c:otherwise>
								<a><img class="mark"
									src="${root}/res/image/outLineBookmark.png" width="30px"
									height="30px"></a>
							</c:otherwise>
						</c:choose>
						<c:set var="markflag" value="${false}"></c:set>
					</div>
					<div>
						<p class="inline">좋아요&nbsp;&nbsp;</p>
						<p class="inline loveCnt">${loveCnt[status.index]}</p>
					</div>
					<div>${boardDto.content }</div>
			</div>
		</c:forEach>
	</div>
	</section>
	<hr color="lightblue">
	<footer>KGITBANK 자바 SW 개발자 양성반 2팀 </footer>
</body>
</html>