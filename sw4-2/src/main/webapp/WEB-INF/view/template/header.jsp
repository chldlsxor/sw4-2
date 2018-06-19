<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
		<div class="row">
			<input id="listCnt" type="hidden" value="${listCnt }"> <input
				id="userNo" type="hidden" value="${userno}">
			<div id="menu" class="container-70">
				<a href="${root }/board/list"><i class="fa fa-camera">&nbsp;</i></a>
				<p>|</p>
				<a href="${root }/board/list" class="left"> InStory</a>
	
				<a class="right"><i class="fa fa-search"></i></a>&nbsp;&nbsp;<a href="${root }/member/list" class="inner-right"><i class="fa fa-history"></i></a> &nbsp;
				&nbsp; <a class="inner-right" href="${root }/member/message"><i class="fa fa-envelope"></i></a>
				&nbsp; &nbsp; <a href="${root }/member/detail?nick=${usernick }" class="inner-right"><i class="fa fa-user"></i></a>
				&nbsp;&nbsp;<a class="inner-right"><i class="fa fa-bars"></i></a>
			</div>
		</div>