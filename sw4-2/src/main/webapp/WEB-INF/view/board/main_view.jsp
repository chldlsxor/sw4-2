<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
<style>
</style>
<title>InStory</title>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="${root}/res/css/common.css">

<script>
	var contentdiv = "";
	var photodiv = "";
	var flag = true;
	var start = 1;
	var boardList;
	var photoList;
	var replyList;
	var listSize = 0;
	$(document).ready(function() {
		$(document).scroll(function() {
			//                    console.log("스크롤 이동")
			var scrollT = $(this).scrollTop(); //스크롤바의 상단위치
			//                    console.log("scrollT = "+scrollT);
			var scrollH = $(this).height(); //스크롤바를 갖는 div의 높이
			//                    console.log("scrollH = "+scrollH);
			if (scrollT >= scrollH * 0.5 && flag) { // 스크롤바가 맨 아래에 위치할 때
				console.log("스크롤 이벤트3")
				
				flag = false;
				console.log("스크롤 이벤트4")
				start = start + 2;
				console.log("스크롤 이벤트5")
				console.log(start);
				$.ajax({
                    dataType : 'json',
                    url : "addlist",      
                    data : {"start":JSON.stringify(start)},
                    success:function(result, status, information){
// 	                    console.log(result);
	                    console.log(status);
// 	                    console.log(information);
// 	                    console.log(result.listBoardDto[0]);
// 	                    console.log(result.listPhotoDto[0]);
	                    boardList = result.listBoardDto;
	                    photoList = result.listPhotoDto;
	                    listSize = boardList.length;
	                    for(var b in boardList){
	                    	for(var p in photoList[b]){
	                    		photodiv = photodiv+"</div><div><img class='img' src='${root }/board/image?name="+photoList[b][p].name+"'></div><div>";
	                    	}
	                    	 contentdiv = "<div class='row'><div>"+boardList[b].writer+""+photodiv+""+boardList[b].content+"</div><div>댓글</div><input class='form-input'type='text' placeholder='댓글 달기...'></div>";
	                    	 $("#main-view").append(contentdiv);
	                    	 photodiv = "";
	                    	 listSize++;
	                    }
                    }
          		  });
				//조건문 걸어서 배열 크기가 0이아니면 실행하게 해야함
						flag = true;

			}
		});
		
		$(".love")
		
	});
</script>
</head>
<body>
	<header>
		<div id="menu" class="container-70">
			<a><i class="fa fa-camera">&nbsp;</i></a>
			<p>|</p>
			<a href="${root }/board/list" class="left"> InStory</a>

			<form action="#">
				<input class="top-search" type="text" placeholder="검색">
			</form>

			<a href="#" class="right"><i class="fa fa-history"></i></a> &nbsp;
			&nbsp; <a href="#" class="inner-right"><i class="fa fa-heart"></i></a>
			&nbsp; &nbsp; <a href="#" class="inner-right"><i
				class="fa fa-user"></i></a>
		</div>
	</header>
	<div class="empty-row"></div>
	<div class="empty-row"></div>
	<div class="empty-row"></div>
	<main>
	<div id="chaser">
		<div class="row">
			<div class="user-profile">
				<img src="http://via.placeholder.com/100x100">
			</div>
			<div class="user-profile">
				<p class="user-name">사용자 이름</p>
			</div>
			<hr>
			<div>
				<a class="pleft" href="#">스토리</a> <a class="pright" href="#">모두 보기</a>
			</div>
			<div><button type="button" class="profile-btn btn btn-info btn-lg" onclick="location='write'">글 쓰기</button></div>
		</div>
	</div>
	<div id="main-view" class="container-70">
		<c:forEach var="boardDto" items="${list}" varStatus="status">
			<div class="row">
				<div>${boardDto.writer }</div>
				<c:forEach var="photoDto" items="${photoList[status.index]}">
					<div>
						<img class="img"src="${root }/board/image?name=${photoDto.name}">
					</div>
				</c:forEach>
				<div>
					<a href="#"><img class="love" src="${root}/res/image/outLineHeart.png" width="30px" height="30px"></a>
					<a href=""><img class="mark" src="${root}/res/image/outLineBookmark.png" width="30px" height="30px"></a>
				</div>
				<div>
					<p>좋아요 ${boardDto.good}</p>
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