<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src = "https://code.jquery.com/jquery-latest.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<link rel="stylesheet" type="text/css" href="${root}/res/css/common.css">
<html>
    <head>
        <title>Instory 관리자</title>
        <!--디자인 코드 작성 공간-->
        <style>  
	        *{
	        	background-color: 
	        }         
            .admin-body{
            	display: flex;
                flex-wrap: wrap;  
            } 
      
            #admin-header, #admin-footer{ 
                width : 100%;
                display:flex;
                flex-wrap: nowrap;
                padding: 20px;            
            }
            #admin-header{
            	height : 100px;
            	padding-left: 20px; 
            	white-space: nowrap;
            }
            #admin-header > a{
				color: white;
				text-decoration: none;
				font-size:3em;
				width: auto;
            }
        	#admin-header > a.left{
               	margin-left: 1em;
            }
            #admin-header > a.right-start{
               	margin-left: auto;
            }
            #admin-header > a.right{
            	font-size: 4em;
               	margin-left: 1em;
            }
           /* #admin-container{
            	width: 100%;
            	margin: auto;
            	display: flex;
            	flex-wrap: wrap;
            }  */
            #admin-nav{
           		background-color: white;
                width: 230px;
                min-height: 500px; 
                border-right: 3px double lightgray; 
            }
            
            #admin-nav > .sub-menu:hover{
            	cursor: pointer;
            }
            #admin-nav .menu:hover{
            	border-left: 1px solid  #00A2E8;	
            }             
            #admin-nav > div > a{
           		color:black;
                text-decoration: none;
                padding: 10px;
            }
            .sub-menu-item > div > a{
           		color:black;
                text-decoration: none;
                margin-left: 15px;
                padding: 5px;
            }
            
            #admin-section{;
                flex-grow: 1;
                min-height: 500px;
            }
            #hamburger, #admin-nav > .sub-menu-item{
            	display: none;
            }
            
            .table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {
				vertical-align: middle;
			}
        
            @media screen and (max-width:1000px){
                #admin-header{
                    order:1;
                }
                #admin-nav{
                	position : fixed;
                	top:100px;
                	background-color: #00A2E8;
                    width: 100%;
                    min-height: 70px;
                    order: 2;
                    display : none;
                }
                #admin-nav > div > a{
	           		color:white;
	            }
	            .sub-menu-item > div > a{
	           		color:white; 
	            }
                #admin-section{
                    width: 100%;
                    order:3;
                }  
                #admin-footer{
                    order:4;
                }  
                #admin-container{
	            	width: 100%;
	            }
                #hamburger{
            		display: block !important;
            	}   
            } 
            
            @media screen and (max-width:900px){
		       .main-section-container{
		       		min-width: 700px;
	       		}
       		} 
        </style>

<script>            
	$(document).ready(function(){
		$("#admin-header").find("#hamburger").on("click", function(){
		          $("#admin-nav").slideToggle();
		      });
		$(window).on("resize", function(){
			if($(this).width() > 1000){
				$("#admin-nav").show();
				$("#admin-header").find("#hamburger").hide();
			}else{
				$("#admin-nav").hide();
				$("#admin-header").find("#hamburger").show();
			}
		});
      	//최초에는 메뉴를 숨긴다
      	
      	
      	$("#admin-nav").find(".sub-menu").on("click", function(){
      		$(this).next().fadeToggle();
	   	});
      	var header_height= $("#admin-header").height();
      	var footer_height= $("#admin-footer").height();
      	var nav_height= $("#admin-nav").height();
      	var section_height= $("#admin-section").height();
      	var content_height= $(window).height()-header_height-footer_height-nav_height;
      	if(section_height<content_height){
      		$("#admin-section").css('height', content_height+'px');
      	}	
	});
</script>
    </head>   	
    <body class  = "admin-body">
    	<div style="width: 100% ;height: 100px; background-color: yellow"></div>
	  	<header id = "admin-header"  style="width: 100% ;height: 100px">
		    	<a class = "left" href = "admin">
		    		<i class="fa fa-camera"></i>
		    		&nbsp;|&nbsp;InStory
				</a>			
				<a class = "right-start"></a>
				<a class = "right"><i id = "hamburger" class="fa fa-bars">&nbsp;</i></a>
	    </header>
	    <nav id = "admin-nav">
	    	<div class = "menu"><a href = "member_list">회원 관리</a></div>
	    	<div class = "menu sub-menu"><a>게시글 관리</a></div>
	    		<div class = "sub-menu-item">
		    		<div class = "menu"><a href = "admin_board">내용 검색하기</a></div>
		    		<div class = "menu"><a href = "report_list">신고 글 관리</a></div>
	    		</div>
	    	<div class = "menu sub-menu"><a>통계 확인하기</a></div>
		    	<div class = "sub-menu-item">
			    	<div class = "menu"><a href = "admin_hashtag">인기 해시태그</a></div>
			    	<div class = "menu"><a href = "admin_star">인기 유저</a></div>
		    	</div>
	    	<div class = "menu"><a href = "/sw4-2/member/logout">로그아웃</a></div>
	    </nav>
	    <section id = "admin-section">
