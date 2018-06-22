<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/view/admin/admin_header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
        
<!--스크립트 작성 공간-->
<style>
	
</style>
<script> 
	$(document).ready(function(){
		var chartLabels = [];
		var chartData = [];
		
		var ctx = document.getElementById("starChart");
		
		//데이터 받아오기
		$.getJSON("./getFollowTopList", function(data){
			 $.each(data, function(key, value){
				 chartLabels.push(value.FOLLOW);
				 chartData.push(value.COUNT);
			 });
			 
			//데이터 받아오면 그래프 그리기
			var myBarChart = new Chart(ctx, {
			    type: 'horizontalBar',
			    data: {
			    	datasets:[{
			    		label: 'follow 수',
			    		data: chartData
			    	}],
			    	labels: chartLabels
			    }
			});
		});
	});        
</script>
<div style = "text-align : center; ">
	<div style="width: 70%; margin : auto;">
	 	<div>instory star 상위 20</div>
	 	<canvas id = "starChart" height = "500" width = "400"></canvas>
	</div>	
</div>
<jsp:include page="/WEB-INF/view/admin/admin_footer.jsp"></jsp:include>