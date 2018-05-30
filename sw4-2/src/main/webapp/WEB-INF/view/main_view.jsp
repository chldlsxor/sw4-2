<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>    
<html>
<head>
<title>InStory</title>
        <script src="https://code.jquery.com/jquery-latest.js"></script>
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="${root}/res/css/common.css">
        
                <script>
            var testdiv = "<div class='row'><div>test1</div><div><img class='img' src='${pageContext.request.contextPath}/res/image/bg001.jpg'></div><div>이쁜 노을</div><div>댓글</div><input class='form-input'type='text' placeholder='댓글 달기...'></div>";
            var flag = true;
            
            $(document).ready(function(){
                $(document).scroll(function(){
//                    console.log("스크롤 이동")
                    var scrollT = $(this).scrollTop(); //스크롤바의 상단위치
//                    console.log("scrollT = "+scrollT);
                    var scrollH = $(this).height(); //스크롤바를 갖는 div의 높이
//                    console.log("scrollH = "+scrollH);
                    if(scrollT >= scrollH*0.6 && flag) { // 스크롤바가 맨 아래에 위치할 때
                        flag = false;
                        console.log("이미지 불러오는 중");
                        $("#main-view").append(testdiv);
                        flag = true;
                    }  
                });
            });
            
            
        </script>
</head>
    <body>
        <header>
            <div id = "menu" class="container-70">
                <a><i class="fa fa-camera">&nbsp;</i></a>
                <p>|</p>
                <a href="#" class="left"> InStory</a>
                
                <form action="#">
                    <input class="top-search" type="text" placeholder="검색">
                </form>
                
                <a href="#" class="right"><i class="fa fa-history"></i></a>
                &nbsp;
                &nbsp;
                <a href="#" class="inner-right"><i class="fa fa-heart"></i></a>
                &nbsp;
                &nbsp;
                <a href="#" class="inner-right"><i class="fa fa-user"></i></a>
            </div>
        </header>
        <div class="empty-row"></div>
        <div class="empty-row"></div>
        <div class="empty-row"></div>
        <main>
            <div id="main-view" class="container-90">
            <c:forEach var="boardDto" items="${list}" varStatus="status">
            	<div class="row">
            		<div>${boardDto.writer }</div>
            		<c:forEach var="photoDto" items="${photoList[status.index]}">
            			<div><img class="img" src="${pageContext.request.contextPath}/res/image/bg001.jpg"></div>
            		</c:forEach>
            		<div>${boardDto.content }</div>
<%--             		<c:forEach var="replyDto" items="${ }"> --%>
<!--             			<div>댓글판</div> -->
<%--             		</c:forEach> --%>
            		<input class="form-input"type="text" placeholder="댓글 달기...">
            	</div>
            </c:forEach>
  
            </div>
        </main>
        <footer>
            제작사 등등
        </footer>
    </body>
</html>