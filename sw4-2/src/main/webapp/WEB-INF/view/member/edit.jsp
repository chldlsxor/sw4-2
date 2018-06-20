<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
    <head>
        <title>회원정보 변경</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="${root}/res/css/common.css">
        <style>
            *{
                box-sizing: border-box;
                font-size: 18px;
            }
            main, aside, section{
                border:1px solid black;
                min-height: 600px;
            }
            main{
                display: flex;
                /*다음 줄로 넘어가는 것을 허용하겠다*/
                flex-wrap: wrap;
                width: 900px;
            }
            aside{
                width: 230px;
            }
            section{
                flex-grow: 1;
            }
            
            table{
                width: 100%;
                border-collapse: collapse;
            }
            th{
                text-align: right;
                padding: 10px;
                width: 160px;
                margin : 10px;
            }
            td{
                flex-grow: 1;
            }
            .form-control{
            	margin : 10px;
            }
            .form-btn {
            	width:200px;
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
            
            #f {  
				opacity: 0;
				font-size:17px;
				position: relative;
                width: 120px;
			}
 			.look {
				position: absolute;
				width: 120px;
				background-color: white;
				font-size:10px;
				height: 30px;
				padding:0px;
				color:#00A2E8;
			} 
			
			@media screen and (max-width:900px){
                main{
                	width:100%;
                }
            }
            
            @media screen and (max-width:768px){
                aside{
                    display: none;
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
                
                $("#f").on("change", function(){
                    readURL(this);
                });
                
                $("#member_edit").on("submit",function(event){
                	event.preventDefault();
                	
                	var name_regex = /^[가-힣]{2,10}$/;
                	var nick_regex = /^[a-zA-Z0-9]{2,60}$/;
                	
                	if(!name_regex.test($("#name").val())){
                		alert("이름은 한글 2~10자리 입니다.");
                		return;
                	}else if(!nick_regex.test($("#nick").val())){
                		alert("닉네임은 영문숫자 2~60자리 입니다.");
                		return;
                	}else{
                		document.querySelector("#member_edit").submit();
                	}
                });
            });
            
            function readURL(input) {
                if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                        $('#profile').attr('src', e.target.result);
                    }

                  reader.readAsDataURL(input.files[0]);
                }
            }
            
        </script>
    </head>
    <body>
    	<div class="empty-row"></div>
       	<div class="empty-row"></div>
        <main>
            <aside>
                <table>
                    <tbody>
                        <tr><button id="edit" class="now">프로필 편집</button></tr>
                        <tr><button id="edit_pw">비밀번호 변경</button></tr>
                        <tr><button id="exit">회원 탈퇴</button></tr>
                    </tbody>
                </table>
            </aside>
            <section>
                <form action="edit" method="post" id="member_edit" enctype="multipart/form-data">
                    <table>
                        <tbody>
                            <tr height=100>
                                <th>
                                	<c:if test="${memberDto.profile=='pic.jpg'}">
										<img class="img-circle" src="${root}/res/img/${memberDto.profile}" width="70" height="70" id="profile">
									</c:if>
									<c:if test="${memberDto.profile!='pic.jpg'}">
										<img class="img-circle" src="${root}/res/img/${memberDto.id}_${memberDto.profile}" width="70" height="70" id="profile">
									</c:if>
                                </th>
                                
                                <td>
                                	<button class="look">프로필 사진 변경</button>
                                	<input type="file" name="f" id="f" onchange="LoadImg(this)">
                                </td>
                            </tr>
                            <tr>
                                <th>아이디(이메일)</th>
                                <td><input class="form-control" type="text" name="id" required value="${memberDto.id}" readonly></td>
                            </tr>
                            <tr>
                                <th>이름</th>
                                <td><input class="form-control" type="text" name="name" id="name" required value="${memberDto.name}"></td>
                            </tr>
                            <tr>
                                <th>닉네임</th>
                                <td><input class="form-control" type="text" name="nick" id="nick" required value="${memberDto.nick}"></td>
                            </tr>
                            <tr>
                            	<th>공개범위</th>
                            	<td>
                            		<select name="open" class="form-control">
                            			<option <c:if test="${memberDto.open == 0}">selected</c:if> value="0">전체공개</option>
                            			<option <c:if test="${memberDto.open == 1}">selected</c:if> value="1">팔로워만 공개</option>
                            			<option <c:if test="${memberDto.open == 2}">selected</c:if> value="2">비공개</option>
                            		</select>
                            	</td>
                            </tr>
                            <tr>
                            	<td colspan="2" class="center"><input class="form-btn" type="submit" value="수정"></td>
                            </tr>
                        </tbody>
                    </table>
                </form>
            </section>
        </main>
    </body>
</html>