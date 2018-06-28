<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
    <head>
    <meta name="viewport" content="width=device-width, init-scale=1.0">
        <title>팔로워 리스트</title>    
<!--        디자인 코드 작성 공간-->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="${root}/res/css/common.css">
        <style>
        	th{
        		width:100px;
        	}
        	img{
        		margin:10px;
        	}
        	.nick, .name{
        		padding:20px 20px;
        		display: inline-block;
        		border:none;
        	}
        	.name{
        		color:gray;
        	}
        	.result{
            	width:100%;
            	border:1px solid lightgray;
            }
        	h3{
        		padding:10px;
        	}
        	.empty{
        		display: none;
        	}

        	@media screen and (max-width:600px){
                .nick, .name{
                	padding:10px 20px;
                    display: block;
                }
            }
            @media screen and (max-width:350px){
				.empty{
	        		display: block;
	        	}
	        	th{
	        		display:none;
	        	}
            }
        </style>
<!--        jQuery를 사용하기 위해 라이브러리를 불러오도록 설정-->
        <script src = "https://code.jquery.com/jquery-latest.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!--        스크립트 작성 공간-->
        <script>
            $(document).ready(function(){
                
            });
        </script>
        <jsp:include page="/WEB-INF/view/template/headerscript.jsp"></jsp:include>
        <jsp:include page="/WEB-INF/view/template/content_view_script.jsp"></jsp:include>
    </head>
    <body>
    	<jsp:include page="/WEB-INF/view/template/header.jsp"></jsp:include>
    	<div class="page-container">
    		<form action="follower_list" method="get">
	        	<div class="row">
	        		<input type="hidden" name="nick" value="${nick}">
	        		<select name="type" class="form-input inline">
						<option value="name">이름</option>
						<option value="nick" <c:if test="${type == 'nick'}">selected</c:if>>닉네임</option>
					</select>
					<div class="empty"></div>
	        		<input class="form-input inline" value="${keyword}" type="text" name="keyword" placeholder="팔로워 검색" required>
	        		<input class="form-btn inline" type="submit" value="검색">
	        	</div>
	        </form>
			<div>
				<h3>팔로워 : ${follower_cnt-1} 명</h3>
			</div>
			<div class="row result">
				<table>
					<tbody>
						<c:forEach var="memberDto" items="${list}">
							<c:if test="${memberDto.nick!=nick}">
								<tr>
									<th>
										<c:if test="${memberDto.profile=='pic.jpg'}">
											<img class="img-circle" src="${root}/member/image?name=${memberDto.profile}" width="70" height="70">
										</c:if>
										<c:if test="${memberDto.profile!='pic.jpg'}">
											<img class="img-circle" src="${root}/member/image?name=${memberDto.id}_${memberDto.profile}" width="70" height="70">
										</c:if>
									</th>
									<td align="left">
										<div class="nick">
										<!-- 제목 : 누르면 detail 페이지로 이동 -->
										<a href="detail?nick=${memberDto.nick}">
											${memberDto.nick}
										</a>
										</div>
										<div class="name">
											${memberDto.name}
										</div>
									</td>
								</tr> 
							</c:if>
						</c:forEach>
					</tbody>
				</table>
			</div>
        </div>
    </body>
</html>