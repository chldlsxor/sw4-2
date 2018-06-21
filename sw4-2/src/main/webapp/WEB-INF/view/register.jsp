<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
    <head>
        <title>회원가입</title>    
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
            .head > a{
            	font-size:30px;
            	color:white;
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
                
                $("#register").on("submit",function(event){
                	event.preventDefault();
                	
                	var name_regex = /^[가-힣]{2,10}$/;
                	var nick_regex = /^[a-zA-Z0-9]{2,60}$/;
                	var pw_regex = /^[a-zA-Z0-9]{6,15}$/;
                	
                	if(!name_regex.test($("#name").val())){
                		alert("이름은 한글 2~10자리 입니다.");
                		return;
                	}else if(!nick_regex.test($("#nick").val())){
                		alert("닉네임은 영문숫자 2~60자리 입니다.");
                		return;
                	}else if(!pw_regex.test($("#pw").val())){
                		alert("비밀번호는 영문숫자 6~15자리 입니다.");
                		return;
                	}
                	else{
                		document.querySelector("#register").submit();
                	}
                });
            });
        </script>
    </head>
    <body>
    	<header>
			<div class="row left head">
				<a href="login">InStory</a>
			</div>
		</header>
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
                <div class="register-wrapper">
                	<div class="row">
                    	<h1>Instory</h1>
                    </div>
                    <form action="register" method="post" id="register">
                    	<div class="row">
                        	<input class="form-input" type="text" name="id" required value="${id}" readonly>
                        </div>
                        <div class="row">
                        	<input class="form-input" type="text" name="name" id="name" required placeholder="이름">
                        </div>
                        <div class="row">
                        	<input class="form-input" type="text" name="nick" id="nick" required placeholder="닉네임(영문숫자 2~60자리)">
                        </div>
                        <div class="row">
                        	<input class="form-input" type="password" name="pw" id="pw" required placeholder="비밀번호(영문숫자  6~15자리)">
                        </div>
                        <div class="row">
                        	<input class="form-btn" type="submit" value="가입">
                        </div>
                    </form>
                    <hr>
                    가입하면 Instory의 약관, 데이터 정책 및 쿠키 정책에 동의하게 됩니다.
                </div>
                <div class="btn-wrapper">
                    계정이 있으신가요? <a href="login">로그인</a>
                </div>
            </div>
        </div>
    </body>
</html>