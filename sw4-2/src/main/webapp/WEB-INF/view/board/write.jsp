<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
<title>InStory</title>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="${root}/res/css/common.css">
<!-- 스크립트 작성 공간-->
<script>
	var rgx = /#[\w가-힣]+\s/g;
	$(document).ready(function() {
		$("textarea").on("blur",function(){
			var text = $(".textarea").val();
			console.log(text);
			var hashTag = text.match(rgx);
			console.log(hashTag);
			$(".hashtag").val(hashTag);
			console.log($(".hashtag").val());
		});	
	});
</script>
</head>
<body>
	<header>
		<div id="menu" class="container-60">
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
	<div id="main-view" class="container-70">
                <div class="row">
                    <h2>글 쓰기</h2>
                </div>
                <form action="write" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="writer" value="${userid }">
                    <div class="row">
                        <input type="file" name="file" multiple="multiple">
                    </div>
                    <div class="row">
			             <textarea name="content" class="textarea" rows="10" cols="100"></textarea>
			             <input type="hidden" class="hashtag" name="hashtag" value="">
		            </div>
                    <div class="row">
                        <button type="submit" class="profile-btn btn btn-info btn-lg">글 쓰기</button>
                    </div>
                </form>
            </div>
	</main>
	<footer> 제작사 등등 </footer>
</body>
</html>