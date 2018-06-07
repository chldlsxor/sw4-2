<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
    <head>
        <title>flex 배우기</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="${root}/res/css/common.css">
        <style>
            *{
                box-sizing: border-box;
                font-size: 18px;
            }
            main, aside, section{
                border:1px dotted black;
                min-height: 800px;
            }
            main{
                display: flex;
                /*다음 줄로 넘어가는 것을 허용하겠다*/
                flex-wrap: wrap;
                width:100%;
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
                width: 200px;
                margin : 10px;
            }
            td{
                flex-grow: 1;
            }
            .form-input{
            	margin : 10px;
            }
            button{
                width: 100%;
                text-align: left;
                padding: 10px;
                background-color: white;
                border: none;
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
        <main>
            <aside>
                <table>
                    <tbody>
                        <tr><button id="edit">프로필 편집</button></tr>
                        <tr><button id="edit_pw">비밀번호 변경</button></tr>
                    </tbody>
                </table>
            </aside>
            <section>
                <form action="edit" method="post" id="member_edit" enctype="multipart/form-data">
                    <table>
                        <tbody>
                            <tr height=100>
                                <th><img class="img-circle" src="${root}/res/img/${memberDto.id}_${memberDto.profile}" width="50" height="50" id="profile"></th>
                                <td><input type="file" name="f" id="f" onchange="LoadImg(this)"></td>
                            </tr>
                            <tr>
                                <th>아이디(이메일)</th>
                                <td><input class="form-input" type="text" name="id" required value="${memberDto.id}" readonly></td>
                            </tr>
                            <tr>
                                <th>이름</th>
                                <td><input class="form-input" type="text" name="name" id="name" required value="${memberDto.name}"></td>
                            </tr>
                            <tr>
                                <th>닉네임</th>
                                <td><input class="form-input" type="text" name="nick" id="nick" required value="${memberDto.nick}"></td>
                            </tr>
                            <tr>
                            	<th>공개범위</th>
                            	<td>
                            		<select name="open" class="form-input">
                            			<option <c:if test="${memberDto.open == 0}">selected</c:if> value="0">전체공개</option>
                            			<option <c:if test="${memberDto.open == 1}">selected</c:if> value="1">팔로워만 공개</option>
                            			<option <c:if test="${memberDto.open == 2}">selected</c:if> value="2">비공개</option>
                            		</select>
                            	</td>
                            </tr>
                            <tr>
                            	<td colspan="2"><input class="form-btn" type="submit" value="수정"></td>
                            </tr>
                        </tbody>
                    </table>
                </form>
            </section>
        </main>
    </body>
</html>