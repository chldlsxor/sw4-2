<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:forward page="register"></jsp:forward>
<%-- <%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<h1><a href = "/sw4-2/board/list">board_list</a></h1>
<h1><a href = "/sw4-2/member/message">message</a></h1>
<h1><a href = "/sw4-2/login">login</a></h1>
<h1><a href = "/sw4-2/member/logout">logout</a></h1>
<h1><a href = "/sw4-2/email?type=register">회원가입</a></h1>
<h1><a href = "/sw4-2/email?type=reset_pw">비밀번호 재설정</a></h1>
<h1><a href = "/sw4-2/member/edit">회원정보 수정</a></h1>
<h1><a href = "/sw4-2/member/name_search">사용자 검색</a></h1>
<c:if test="${userpwr=='관리자'}">
	<h1><a href = "/sw4-2/admin/admin">admin_page</a></h1>
</c:if>
<h1><a href = "/sw4-2/member/detail?nick=${usernick}">내정보</a></h1>
<h1>userid : ${userid}</h1>
<h1>session-id : ${pageContext.session.id}</h1>
<h1>userweb: ${userweb}</h1>
<h1><a href = "/sw4-2/member/notice">알림 메세지</a></h1> --%>