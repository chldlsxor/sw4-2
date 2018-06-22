<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
    <head>
        <title>관리자 페이지</title>
        <!--디자인 코드 작성 공간-->
        <style>
            
            .admin_body{
            	display: flex;
                flex-wrap: wrap; 
            } 
            
                   
            #admin_header{
                background-color : #00A2E8;
                padding-left: 25px;
                width : 100%;
                padding: 1em;
                display:flex;
                flex-wrap: nowrap;
            }
            #admin_header> a{
				color: white;
				text-decoration: none;
				margin-right: 0px;
				margin-left:0px; 
				font-size:2em;
				width: auto;
            }
            #admin_header> a.left{
                margin-right: 3em;
            }
            #admin_header> a.right{
               text-align: right;
            }
            .admin_nav{
                background-color: lightyellow;
                width: 150px;
                min-height: 500px;                
            }
            .admin_nav > a{
            	color : black;
            	display : block;
            	padding : 5px;
            }
            #sub-btn{
            	padding:5px;
            }
            #sub-menu > a{
            	color : black;
            	display : block;
            	padding : 5px;
            	margin-left: 7px;
            	
            }
            
            
            .admin_section{;
                flex-grow: 1;
                min-height: 500px;
            }
        
            @media screen and (max-width:1000px){
                #admin_header{
                    order:1;
                }
                .admin_nav{
                    width: 100%;
                    min-height: 70px;
                    order: 2;
                }
                .admin_section{
                    width: 100%;
                    order:3;
                }        
            } 
      
            #hamburger, #hamburger + label{
                display:none;
                color:indianred;
                font-size:2em;
            }
            
            @media screen and (max-width:1000px){
                #hamburger + label{
                    display:block;
                    padding: 5px;
                }
                
                #hamburger ~ a, #hamburger ~ #sub-btn{
                    display:none;
                }

                #hamburger:checked ~ a{
                    display:inline-block;
                }
            }     
            
            @media screen and (max-width:1000px){
                #ck + #sub-btn{
                    display:block;
                    padding: 5px;
                }
                
                #ck ~ a{
                    display:none;
                }

                #ck ~ a{
                    display:inline-block;
                }
            }     
      
        </style>
        
        <!--Jquery를 사용하기 위해 라이브러리를 불러오도록 설정-->
        <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src = "https://code.jquery.com/jquery-latest.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<%-- <link rel="stylesheet" type="text/css" href="${root}/res/css/common.css">  --%>
        
        <!--스크립트 작성 공간-->
        <script>            
            $(document).ready(function(){
               	//최초에는 메뉴를 숨긴다
               	$(".admin_nav").children("#submenu").hide();
               	
               	$(".admin_nav").children("#sub-btn").on("click", function(){
               		$(this).next().fadeToggle();
               	});
            });
        </script>
    </head>
    <body class  = "admin_body">
	    <header id = "admin_header">
	    	<a class = "left" href = "admin">InStory</a>
	    	<a class = "right" href = "/sw4-2/member/logout">Logout</a>
	    </header>
	    <nav class = "admin_nav">
	   		<input type="checkbox" id="hamburger">
            <label for="hamburger">&#8801;</label>
	    	<a href = "member_list">회원 리스트</a>
	    	<a href = "report_list">신고 글 리스트</a>
	    	<label id="sub-btn" for = "ck">통계 확인하기</label>
	    	<div id = "sub-menu">
		    	<a href = "admin_session">월별 세션 확인하기</a>
		    	<a href = "admin_upload">월별 업로드 확인하기</a>
		    	<a href = "admin_hashtag">인기 해시태그</a>
		    	<a href = "admin_board">인기 게시글</a>
		    	<a href = "admin_star">instory star</a>
	    	</div>
	    	
	    	<a href = "#">내용 검색하기</a>
	    </nav>
	    <section class = "admin_section">