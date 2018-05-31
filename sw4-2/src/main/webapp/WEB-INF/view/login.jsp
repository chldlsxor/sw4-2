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
            .swiper-container, .login-container{
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
            .login-wrapper, .btn-wrapper{
                margin: 10px;
            }
            @media screen and (max-width:768px){
                .swiper-container{
                    display: none;
                }
                .container{
                    width: 320px;
                }
                .login-container{
                    width: 95%;
                }
            }
            @media screen and (max-width:320px){
                .container{
                    width: 100%;
                }
                .login-container{
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
            <div class="login-container">
                <div class="login-wrapper">
                    <h1>Instory</h1>
                    <form action="login" method="post">
                        <input class="form-input" type="text" placeholder="이메일">
                        <input class="form-input" type="password" placeholder="비밀번호">
                        <input class="form-btn" type="submit" value="로그인">
                    </form>
                    <hr>
                    <a href="#">비밀번호를 잊으셨나요?</a>
                </div>
                <div class="btn-wrapper">
                    계정이 없으신가요?<a href="register">가입하기</a>
                </div>
            </div>
        </div>
    </body>
</html>