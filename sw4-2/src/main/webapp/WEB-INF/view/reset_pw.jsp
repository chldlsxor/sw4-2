<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
    <head>
        <title>Javascript 배우기</title>    
<!--        디자인 코드 작성 공간-->
        <link rel="stylesheet" type="text/css" href="${root}/res/css/swiper.min.css">
        <link rel="stylesheet" type="text/css" href="${root}/res/css/common.css">
        <style>
            div{
                border : 1px dotted black;
            }
            .container{
                width: 768px;
                margin: auto;
/*                display: inline-block;*/
            }
            .swiper-container, .register-container{
                width: 46%;
                height: 550px;
                margin: 10;
                display: inline-block;
                vertical-align: top;
            }
            .swiper-slide > img{
                width: 100%;
                height: 100%;
            }
            .register-wrapper, .btn-wrapper{
                margin: 10px;
            }
            @media screen and (max-width:768px){
                .swiper-container{
                    display: none;
                }
                .container{
                    width: 320px;
                }
                .register-container{
                    width: 95%;
                }
            }
            @media screen and (max-width:320px){
                .container{
                    width: 100%;
                }
                .register-container{
                    width: 95%;
                }
            }
        </style>
<!--        jQuery를 사용하기 위해 라이브러리를 불러오도록 설정-->
        <script src = "https://code.jquery.com/jquery-latest.js"></script>
<!--        스크립트 작성 공간-->
        <script src = "${root}/res/js/swiper.min.js"></script>
        <script>
            $(document).ready(function(){
                //Swiper 생성
//                var swiper = new Swiper("영역", {옵션});
                var swiper = new Swiper(".swiper-container",{
                    //끝과 끝을 연결(반복)
                    loop:true,

                    //이미지 전환 효과를 변경
                    effect:"fade",
                    
                    //자동재생
                    autoplay:{
                        delay:1000,//전환 간격(밀리초)
                    },
                });
                
                $("#reset").on("submit",function(event){
                	event.preventDefault();
                	
                	var regex = /^[a-zA-Z0-9]{6,15}$/;
                	
                	if(regex.test($("#pw").val())){
                		document.querySelector("#reset").submit();
                	}
                	else{
                		alert("비밀번호는 영문숫자 6~15자리 입니다.");
                		return;
                	}
                });
                
            });
        </script>
    </head>
    <body>
    	
        <div class="empty-row"></div>
        <div class="container">
            <!-- 이미지 슬라이더 전체 공간 -->
            <div class="swiper-container">
                <!-- 이미지 영역 -->
                <div class="swiper-wrapper">
                    <div class="swiper-slide"><img src="${root}/res/img/bg001.jpg"></div>
                    <div class="swiper-slide"><img src="${root}/res/img/bg002.jpg"></div>
                    <div class="swiper-slide"><img src="${root}/res/img/bg003.jpg"></div>
                    <div class="swiper-slide"><img src="${root}/res/img/bg004.jpg"></div>
                    <div class="swiper-slide"><img src="${root}/res/img/bg005.jpg"></div>
                </div>
            </div>
			<div class="register-container">
                <div class="register-wrapper">
                	<div class="row">
                    	<h1>Instory 비밀번호 재설정</h1>
                    </div>
                    <form action="reset_pw" method="post" id="reset">
                    	<div class="row">
                        	<input class="form-input" type="text" name="id" required readonly value="${id}">
                        </div>
                        <div class="row">
                        	<input class="form-input" type="password" name="pw" id="pw" required placeholder="비밀번호">
                        </div>
                        <div class="row">
                        	<input class="form-btn" type="submit" value="재설정">
                        </div>
                    </form>
                    <hr>
                    재설정할 비밀번호를 입력하세용
                </div>
                <div class="btn-wrapper">
                    비밀번호가 기억나셨나요?<a href="login">로그인</a>
                </div>
            </div>
        </div>
    </body>
</html>