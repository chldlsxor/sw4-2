<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>
    <head>
        <title>flex 배우기</title>
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
        <script>
            $(document).ready(function(){
                $("#edit").on("click",function(){
                    location.href="edit";
                });
                $("#edit_pw").on("click",function(){
                    location.href="edit_pw";
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
                <form action="edit_pw" method="post" id="member_edit">
                	<input type="hidden" name="id" value="${memberDto.id}">
                    <table>
                        <tbody>
                            <tr height=100>
                                <th>사진</th>
                                <td><a>프로필 사진 수정</a></td>
                            </tr>
                            <tr>
                                <th>이전 비밀번호</th>
                                <td><input class="form-input" type="password" name="pw" id="pw" required></td>
                            </tr>
                            <tr>
                                <th>새 비밀번호</th>
                                <td><input class="form-input" type="password" name="new_pw" id="new_pw" required></td>
                            </tr>
                            <tr>
                                <th>새 비밀번호 확인</th>
                                <td><input class="form-input" type="password" id="new_pw_check"required></td>
                            </tr>
                            <tr>
                            	<td colspan="2"><input class="form-btn" type="submit" value="비밀번호 변경"></td>
                            </tr>
                        </tbody>
                    </table>
                </form>
            </section>
        </main>
    </body>
</html>