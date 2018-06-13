<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/view/admin/admin_header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<!-- 세션 통계 -->
<div class="container-60">
	<div class="row f2">일자별 세션 요청 통계</div>
	<div class="row">
		<table class="table table-stripe">
			<thead>
				<tr>
					<th width="50%">일자</th> 
					<th>요청량</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="day" items="${application.scMap.keySet()}">
					<tr>
						<td>${day}</td>
						<td>${scMap.get(day)}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>

<div class="empty-row"></div>
<jsp:include page="/WEB-INF/view/admin/admin_footer.jsp"></jsp:include>