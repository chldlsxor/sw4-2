<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
    <head>
    <meta name="viewport" content="width=device-width, init-scale=1.0">
        <title>비밀번호 변경</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="${root}/res/css/common.css">
        <style>
            *{
                box-sizing: border-box;
                font-size: 18px;
            }
            .select-container, .content-container{
                border:1px solid black;
                min-height: 600px;
            }
            .page-container{
                display: flex;
                /*다음 줄로 넘어가는 것을 허용하겠다*/
                flex-wrap: wrap;
                width: 900px;
            }
            .select-container{
                width: 180px;
            }
            .content-container{
            	padding:20px;
                flex-grow: 1;
            }
            
            table{
                width: 100%;
                border-collapse: collapse;
            }
            .th{
                text-align: right;
                padding: 10px;
                width: 160px;
                margin : 10px;
            }
            .td{
                flex-grow: 1;
                margin-left: 10px;
            }
            .form-control{
            	margin : 10px;
            }
            input[type=submit]{
            	margin-top:20px;
            }
            button{
                width: 100%;
                text-align: left;
                padding: 10px;
                background-color: white;
                border: none;
            }
            .now{
            	font-weight: bold;
                border-left: 3px solid black;
            }
            #edit, #exit{
				color:gray;
			}
            .profile{
                height: 100px;
                width:100px;
                display: inline-block;
                padding : 10px;
            }
            .content{
                flex-grow:1;
                display: inline-block;
                vertical-align: top;
                margin-left: 10px;
            }
            .empty{
            	height:30px;
            }
            
            @media screen and (max-width:768px){
                .select-container{
                    display: none;
	            }
	            .th, .td{
	            	display: block;
	            }
	            .th{
	            	text-align: left;
	            }
            }

        </style>
        <script src = "https://code.jquery.com/jquery-latest.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script>
            $(document).ready(function(){
                $("#edit").on("click",function(){
                    location.href="edit";
                });
                $("#edit_pw").on("click",function(){
                    location.href="edit_pw";
                });
                $("#exit").on("click",function(){
                    location.href="exit";
                });
                
				$("#member_edit").on("submit",function(event){
                	event.preventDefault();
                	
					var regex = /^[a-zA-Z0-9]{6,15}$/;
                	
                	if(!regex.test($("#new_pw").val())){
                		alert("비밀번호는 영문숫자 6~15자리 입니다.");
                		return;
                	}else if($("#new_pw").val()!=$("#new_pw_check").val()){
                		alert("비밀번호와 비밀번호확인이 다릅니다.");
                		return;
                	}else{
                		document.querySelector("#member_edit").submit();
                	}
                });
            });
        </script>
        <jsp:include page="/WEB-INF/view/template/headerscript.jsp"></jsp:include>
    </head>
    <body>
    	<jsp:include page="/WEB-INF/view/template/header.jsp"></jsp:include>
		<div class="page-container">
            <div class="select-container">
                <table>
                    <tbody>
                        <tr><button id="edit">프로필 편집</button></tr>
                        <tr><button id="edit_pw" class="now">비밀번호 변경</button></tr>
                        <tr><button id="exit">회원 탈퇴</button></tr>
                    </tbody>
                </table>
            </div>
            <div class="content-container">
            	<div class="row">
            		<div class="profile">
	                    <c:if test="${memberDto.profile=='pic.jpg'}">
							<img class="img-circle" src="${root}/res/img/${memberDto.profile}" width="70" height="70" id="profile">
						</c:if>
						<c:if test="${memberDto.profile!='pic.jpg'}">
							<img class="img-circle" src="${root}/res/img/${memberDto.id}_${memberDto.profile}" width="70" height="70" id="profile">
						</c:if>
					</div>
					<div class="content">
						<div class="empty"></div>
                    	${memberDto.nick}
                    </div>
            	</div>
            	<hr>
                <form action="edit_pw" method="post" id="member_edit">
                    <table>
                        <tbody>
                            <tr>
                                <td class="th">이전 비밀번호</td>
                                <td class="td"><input class="form-control" type="password" name="pw" id="pw" required></td>
                            </tr>
                            <tr>
                                <td class="th">새 비밀번호</td>
                                <td class="td"><input class="form-control" type="password" name="new_pw" id="new_pw" required></td>
                            </tr>
                            <tr>
                                <td class="th">새 비밀번호 확인</td>
                                <td class="td"><input class="form-control" type="password" id="new_pw_check"required></td>
                            </tr>
                            <tr>
                            	<td colspan="2" class="center"><input class="form-btn inline" type="submit" value="비밀번호 변경"></td>
                            </tr>
                        </tbody>
                    </table>
                    <input type="hidden" name="id" value="${memberDto.id}">
                </form>
            </div>
        </div>
    </body>
</html>