<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/view/admin/admin_header.jsp"></jsp:include>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
        <link rel="stylesheet" type="text/css" href="${root}/res/css/swiper.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="${root}/res/css/common.css">
        <script src = "${root}/res/js/swiper.min.js"></script>
        <style>
        /* 	레이어 프레임 적용 */
		.mask {
			position: absolute;
			left: 0;
			top: 0;
			z-index: 9999;
			background-color: #000;
			display: none;
		}
		
		
		.content-view {
			display: none;
			background-color: #ffffff;
			z-index: 99999;
		}
        	.page-container{
        		font-size: 18px;
        	}
            *{
                box-sizing: border-box;
            }
            
            .main-container{
                width: 100%;
                height: 250px;
                border:1px solid lightgray;
            }

            .select-container{
                width: 100%;
                height: 60px;
                text-align: center;
            }
            .img-container{
                width:100%;
                min-height: 60px;
                border:1px solid lightgray;
                margin-top:5px;
            }
            
            .img-container::after{
                display: table;
                content: "";
                clear: both;
            }
            
/*             .imgs{ */
/*             	width: 100%; */
/*             	height: 100%; */
/*             } */
            
            .img{
                float:left;
                width: 33.333333%;
                padding: 5px;
            }
            
            .profile > .img-profile{
                width:100%;
                height: 100%;
            }
            
            .profile{
                height: 100%;
                width: 250;
                display: inline-block;
                padding : 30px;
            }
            .content{
                width: 300;
                display: inline-block;
                vertical-align: top;
            }
            
            table{
                width: 100%;
                border-collapse: collapse;
                font-size: 18px;
            }
            
            #myboard, #scrap{
                padding: 10px;
                background-color: white;
                border-bottom : none;
                border-right : none;
                border-left : none;
                height: 100%;
            }
            
            input[type=submit], input[type=button]{
            	background-color: #00A2E8;
				color:white;
            }
            
            .now{
            	font-weight: bold;
                border-top: 3px solid black;
            }
            #scrap{
            	color: gray;
            	border-top:none;
            }
            
            @media screen and (max-width:768px){
                .profile{
                    height: 200px;
                    width: 200px;
                    padding: 20px;
                }
                td{
                    display: block;
                }
                .content{
                    width: 150px;
                }
                .content > .empty-row{
                	display:none;
                }
                table{
                	font-size:14px;
                }
            }
            @media screen and (max-width:460px){
                .profile{
                    height: 100px;
                    width: 100px;
                    padding:10px;
                    margin-top:20px;
                }
                table{
                	font-size:12px;
                }
                .content{
                    width: 120px;
                }
                
            }
        </style>
        <%--  --%>
        <jsp:include page="/WEB-INF/view/template/headerscript.jsp"></jsp:include>
        <script>
        $(window).resize(function(){
            var w = $(".img").width();
            $(".img").height(w);
        });
        $(document).ready(function() {
        	
            var w = $(".img").width();
            $(".img").height(w);
            
            $("#admin-section").css('width', 500+'px');
            
            var swiper = new Swiper(".swiper-container",{
                spaceBetween:10,
                effect:'slide',
                pagination:{
                    el:".swiper-pagination",    //버튼 영역
                    
                    //모양
                    type:"bullets",     //동그라미
                },
                
                //스크롤바 등록
                scrollbar:{
                    el:".swiper-scrollbar",
                    
                    //스크롤바 드래그 설정
                    draggable:true,
                },
            });
        });
        </script>
        <jsp:include page="/WEB-INF/view/template/content_view_script.jsp"></jsp:include>

        <div class = "container-70 main-section-container">
            <div class="main-container">
                <div class="profile">
                	<c:if test="${memberDto.profile=='pic.jpg'}">
						<img class="img-profile img-circle" src="${root}/res/img/${memberDto.profile}">
					</c:if>
					<c:if test="${memberDto.profile!='pic.jpg'}">
						<img class="img-profile img-circle" src="${root}/res/img/${memberDto.id}_${memberDto.profile}">
					</c:if>
                </div>
                <div class="content">
                	<div class="empty-row"></div>
                    <table class="table">
                        <tbody>
                            <tr>
                                <td>${memberDto.nick}</td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>${memberDto.name}</td>
                                <td>게시물 ${board_cnt}</td>
                            </tr>
                            <tr>
                                <td><a>팔로워 ${follower_cnt}</a></td>
                                <td><a>팔로우 ${follow_cnt}</a></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="img-container">
            	<c:forEach var="boardDto" items="${my_list}" varStatus="status">
            		<div class="swiper-container img main-view-photo">
						<div class="swiper-wrapper">
							<input class="boardNo" type="hidden" value="${boardDto.no }">
		            		<c:forEach var="photoDto" items="${photo_list[status.index]}">
								<img class="swiper-slide imgs" src="${root}/board/image?name=${photoDto.name}">
		            		</c:forEach>
	            		</div>
	            		
	            		<!-- 페이징 버튼 -->
	                    <div class="swiper-pagination"></div>
	
	                    <!-- 스크롤바 -->
	                    <div class="swiper-scrollbar"></div>
	            	</div>
            	</c:forEach>
            </div>
        </div>

<jsp:include page="/WEB-INF/view/admin/admin_footer.jsp"></jsp:include>