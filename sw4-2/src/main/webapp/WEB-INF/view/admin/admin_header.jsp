<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
    <head>
        <title>관리자 페이지</title>
        <!--디자인 코드 작성 공간-->
        <style>
            
            body{
            	display: flex;
                flex-wrap: wrap; 
            } 
            
            .admin_header, .admin_footer{
                min-height: 70px;
                width: 100%;
            }            
            .admin_header{
                background-color : #D9ECFF;
                color: white;
                padding-left: 25px;
            }
            .admin_footer{
                background-color: azure;
            }
            .admin_nav{
                background-color: lightyellow;
                width: 150px;
                min-height: 500px;                
            }
            .admin_nav > a{
            	color : indianred;
            	text-decoration: none;
            	display : block;
            	padding : 5px;
            }
            
            
            .admin_section{
               background-color : aliceblue;
                flex-grow: 1;
                min-height: 500px;
            }
        
            @media screen and (max-width:1000px){
                .admin_header{
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
                .admin_footer{
                    order:4;
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
                
                #hamburger ~ a{
                    display:none;
                }

                #hamburger:checked ~ a{
                    display:inline-block;
                }
            }     
      
        </style>
        
        <!--Jquery를 사용하기 위해 라이브러리를 불러오도록 설정-->
        <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src = "https://code.jquery.com/jquery-latest.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<%--         <link rel="stylesheet" type="text/css" href="${root}/res/css/common.css"> --%>
        
        <!--스크립트 작성 공간-->
        <script>            
            $(document).ready(function(){
               
            });
        </script>
    </head>
    <body>
	    <header class = "admin_header">
	    	<h2><a href = "admin">InStory</a></h2>
	    </header>
	    <nav class = "admin_nav">
	   		<input type="checkbox" id="hamburger">
            <label for="hamburger">&#8801;</label>
	    	<a href = "member_list">회원 리스트</a>
	    	<a href = "report_list">신고 글 리스트</a>
	    	<a href = "admin_count">통계 확인하기</a>
	    	<a href = "#">내용 검색하기</a>
	    </nav>
	    <section class = "admin_section">