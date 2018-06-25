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
		var etcData = 0;
		
		var ctx = document.getElementById("hashTagChart");
		$.ajax({
			url:"getHashtagCount",
			type :"get",//또는 "post"외 4개
			dataType:"json",//결과물의 형태]
			success:function(data){
				etcData = 0;
				$.each(data, function(key, value){
		 			var tag = value.TAG;
		   			var count = value.COUNT;
		   			if(key<10){
						chartLabels.push(tag);
						chartData.push(count);
					}
					else{
						etcData +=count;
					}
				});
				chartLabels.push('기타');
	        	chartData.push(etcData);
	        	var PieChart = new Chart(ctx,{
	        		  type: 'pie',
	        		  data:{
	        			  datasets: [{
	        			    	label:'해시태그',
	        			        data: chartData,
	        			        backgroundColor:[
	        			        	'rgba(255, 0, 0, 0.2)',
	        			        	'rgba(255, 228, 0, 0.2)',
	        			        	'rgba(29, 219, 22, 0.2)',
	        			        	'rgba(0, 84, 255, 0.2)',
	        			        	'rgba(102, 0, 88, 0.2)',
	        			        	'rgba(255, 94, 0, 0.2)',
	        			        	'rgba(171, 242, 0, 0.2)',
	        			        	'rgba(0, 216,255, 0.2)',
	        			        	'rgba(255, 255, 108, 0.2)',
	        			        	'rgba(102, 37, 0, 0.2)',
	        			        	'rgba(140, 140, 140, 0.2)'
	        			        ],
	                            borderWidth: 1
							}],
						labels: chartLabels
					}
				});
			}
		});
         
	});      
</script>
<div class = "container-70 main-section-container">
	<table class = "table">
		<tr>
			<td class= "center">Instory 인기 해시태그<td>
		</tr>
	</table>
	<div class="chart-container">
	 	<canvas id = "hashTagChart"></canvas>
	</div>	
</div>
<jsp:include page="/WEB-INF/view/admin/admin_footer.jsp"></jsp:include>
