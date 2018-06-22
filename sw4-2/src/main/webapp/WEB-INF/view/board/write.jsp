<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
<head>
<meta name="viewport" content="width=device-width, init-scale=1.0">
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
<jsp:include page="/WEB-INF/view/template/headerscript.jsp"></jsp:include>
<style>
.textarea{
	width: 97%;
}


</style>
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
	<jsp:include page="/WEB-INF/view/template/header.jsp"></jsp:include>
	<section>
	<div id="main-view" class="container-60">
                <div class="row">
                    <h2>글 쓰기</h2>
                </div>
                <form action="write" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="writer" value="${userid }">
                    <div class="row">
                        <input type="file" name="file" multiple="multiple" required>
                    </div>
                    <div class="row">
			             <textarea name="content" class="textarea" rows="10"></textarea>
			             <input type="hidden" class="hashtag" name="hashtag" value="">
		            </div>
		            <div class="alert alert-info" role="alert"><strong>알림!</strong>해시태그는 <strong>#내용 </strong> 으로 사용 가능하며 내용 뒤에 <strong>띄어쓰기</strong>를 써야 적용됩니다.<br>ex) #먹방 #먹스타그램&nbsp;</div>
                    <div class="row">
                        <button type="submit" class="profile-btn btn btn-info btn-lg">글 쓰기</button>
                    </div>
                </form>
            </div>
	</section>
	<footer> 제작사 등등 </footer>
</body>
</html>