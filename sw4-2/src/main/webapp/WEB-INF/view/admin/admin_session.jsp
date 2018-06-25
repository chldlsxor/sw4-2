<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/view/admin/admin_header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>          
        <!--스크립트 작성 공간-->
        <script>            
            $(document).ready(function(){
            	//이번달 그래프
            	var todayLabels = [];
                var todayData=[];
                var todayctx = document.getElementById("todayChart").getContext("2d");
                $.getJSON("./getTodaySession", function(data){
                	 $.each(data, function(key, value){
                		 console.log(data);
                		 todayLabels.push(value.month);
                		 todayData.push(value.count);
        			 });
       			
	       			lineChartData = {
						labels : todayLabels,
	                    datasets : [ {
							label : "일 별 방문자 수",
	                        backgroundColor:"#bfdaf9",
	                        borderColor: "#80b6f4",
	                        pointBorderColor: "#80b6f4",
	                        pointBackgroundColor: "#80b6f4",
	                        pointHoverBackgroundColor: "#80b6f4",
	                        pointHoverBorderColor: "#80b6f4",
	                        fill: false,
	                        borderWidth: 4,
	                        data : todayData
						} ]
					}
	       			
	       			LineChartDemo = Chart.Line(todayctx, {
	                    data : lineChartData
					});
                });
            	
            	//차트 함수
            	var month;
            	function createChart(){
            		var monthctx = document.getElementById("monthChart").getContext("2d");
            		LineChartDemo = Chart.Line(monthctx, {
                        data : lineChartData
                    });
            	}
            	
            	$("#selectMonth").on("change", function(){
            		var changeMonth = $("#selectMonth").val();
            		month = changeMonth;
            		console.log("month : "+month);
            	});
            	
            	$("#btn-chart").on("click", function(){
                	chartLabels = [];
                    chartData=[];
            	
	           		$.ajax({
	   					url:"getDailyVisitor",
	   					data:{
	   						month : month
	                       },
	   					type :"get",//또는 "post"외 4개
	   					dataType:"json",//결과물의 형태]
	   					success:function(data){
	   						var chartLabels = []; //받아올 이름
	   		            	var chartData = [];	//받아올 데이터
	      						$.each(data, function(key, value){
	      							chartData.push(value.count);
	      							chartLabels.push(value.month);   
	      						});
	      						
      							lineChartData = {
                                       labels : chartLabels,
                                       datasets : [ {
                                           label : "일 별 방문자 수",
                                           backgroundColor:"#bfdaf9",
                                           borderColor: "#80b6f4",
                                           data : chartData
                                       } ]
                                   }
                               createChart();
	   					}
	   				});
	           	
            	});
            	
            	
			});
               
        </script>
<div class = "container-70 main-section-container">
	<table class = "table">
		<tr>
			<td class= "center">이번달 방문자 그래프<td>
		</tr>
	</table>
	<div class="chart-container">
		<canvas id = "todayChart"></canvas>
	</div>
	<div class = "empty-row"> </div>
	<div class = "empty-row"> </div>

	<table class = "table">
		<tr>
			<td colspan="2" class = "center">월별 방문자 그래프 검색<td>
		</tr>
		<tr>
			<td><input type = "month" name = "selectMonth" id="selectMonth" class = "form-input"></td>
		    <td><button id="btn-chart" class = "form-btn">월 별 그래프 보기</button></td>
	    </tr>
	</table>      
	<div class="chart-container">
		<canvas id = "monthChart"></canvas>
	</div>
</div> 
<jsp:include page="/WEB-INF/view/admin/admin_footer.jsp"></jsp:include>
