<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
    <head>
        <title>관리자 페이지</title>
        <!--디자인 코드 작성 공간-->
        <style>
            
            body{
            	display: flex;
                flex-wrap: wrap; 
            } 
            
            header, footer{
                min-height: 70px;
                width: 100%;
            }            
            header{
                background-color : lightpink;
            }
            footer{
                background-color: azure;
            }
            nav{
                background-color: lightyellow;
                width: 150px;
                min-height: 500px;
                
            }
            nav > a{
            	color : indianred;
            	text-decoration: none;
            	display : block;
            }
            
            
            section{
               background-color : aliceblue;
                flex-grow: 1;
                min-height: 500px;
            }
            
            
            /*미디어 스크린 중간 사이즈 하나더 만들기  */
            @media screen and (max-width:1000px){
                header{
                    order:1;
                }
                nav{
                    width: 100%;
                    min-height: 70px;
                    order: 2;
                }
                nav > a{
            		display : inline-block;
           		}
                nav > a.left{
            		margin-right: 1.5em;
            	}
                section{
                    width: 100%;
                    order:3;
                }
                footer{
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
                }
                
                #hamburger ~ a{
                    display:none;
                }

                #hamburger:checked ~ a{
                    display:block;
                }
            }     
             
            
              
        </style>
        
        <!--Jquery를 사용하기 위해 라이브러리를 불러오도록 설정-->
        <script src = "https://code.jquery.com/jquery-latest.js"></script>
        
        <!--스크립트 작성 공간-->
        <script>            
            $(document).ready(function(){
               
            });
        </script>
    </head>
    <body>
	    <header>
	    	<h2>InStory</h2>
	    </header>
	    <nav>
	   		<input type="checkbox" id="hamburger">
            <label for="hamburger">&#8801;</label>
	    	<a href = "member_list" class = "left">회원 리스트</a>
	    	<a href = "report_list" class = "left">신고 글 리스트</a>
	    	<a href = "#" class = "left">통계 확인하기</a>
	    	<a href = "#" class = "left">내용 검색하기</a>
	    </nav>
	    <section>