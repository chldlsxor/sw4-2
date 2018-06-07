<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
    <head>
        <title>Javascript 배우기</title>    
<!--        디자인 코드 작성 공간-->
        <style>
        
        </style>
<!--        jQuery를 사용하기 위해 라이브러리를 불러오도록 설정-->
        <script src = "https://code.jquery.com/jquery-latest.js"></script>
<!--        스크립트 작성 공간-->
        <script>
            $(document).ready(function(){
            	alert($("#msg").val());
            	location.href = $("#go").val();
            });
        </script>
    </head>
    <body>
        <input type="hidden" id="msg" value="${msg}">
        <input type="hidden" id="go" value="${go}">
    </body>
</html>