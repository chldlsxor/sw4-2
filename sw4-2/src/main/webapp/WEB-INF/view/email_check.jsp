<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
    <head>
        <title>이메일 인증</title>    
<!--        디자인 코드 작성 공간-->
        <link rel="stylesheet" type="text/css" href="${root}/res/css/swiper.min.css">
        <link rel="stylesheet" type="text/css" href="${root}/res/css/common.css">
        <style>
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
                text-align: center;
            }
            .swiper-slide > img{
                width: 100%;
                height: 100%;
            }
            .register-wrapper, .btn-wrapper{
                margin: 10px;
                border : 1px solid black;
                padding:10px;
            }
            a:visited, a:link {
            	color:#00A2E8;
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
                
                var handle;
                var time=300;
                function start(){
                    handle = setInterval(decrease,1000);
                }
                
                function decrease(){
                    var min = document.querySelector("#min");
                    var sec = document.querySelector("#sec");
                    time--;
                    min.innerText = parseInt(time/60)+"분";
                    sec.innerText = parseInt(time%60)+"초";
                    if(time==0){
                    	clearInterval(handle);
                    	min.innerText = "시간이 초과되었습니다.";
                    	sec.innerText = "";
                    }
                }
                
                start();
                
                $("#check").on("submit",function(event){
                   if(time==0){
						event.preventDefault();
						alert("시간초과됨")
                   }
				})
            });
        </script>
    </head>
    <body>
    	<div class="empty-row"></div>
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
				<div class="empty-row"></div>
                <div class="register-wrapper">
                	<div class="row">
                    	<h1>Instory</h1>
                    </div>
                    <form action="email_check" method="post" id="check">
                    	<input type="hidden" name="type" value="${type}">
                    	<div class="row">
                    		<input type="text" name="id" value="${id}" class="form-input" required readonly>
                    	</div>
                    	<div class="row">
                        	<input type='text' class="form-input" placeholder='인증번호' name="num" required>
                        </div>
                        <div class="row">
                        	<input type="submit" class="form-btn" value="인증번호 확인">
                        </div>
                    </form>
                    <span id="min"></span>
                    <span id="sec"></span>

                    <hr>
					인증번호를 입력하세요
                </div>
                <div class="btn-wrapper">
                    <a href="login">로그인</a>
                </div>
            </div>
        </div>
    </body>
</html>