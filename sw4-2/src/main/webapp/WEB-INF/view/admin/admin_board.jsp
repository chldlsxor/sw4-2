<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/view/admin/admin_header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
        
        <!--스크립트 작성 공간-->
        <style>
        	.hashtag-chart{
        		display : inline-block;
        	}
        </style>
<script> 
	$(document).ready(function(){
		var chartLabels = [];
		var chartData = [];
		var chartLabels5 = [];
		var chartData5 = [];
		var etcData = 0;
		
		var ctx = document.getElementById("hashTagChart");
		var ctx2 = document.getElementById("5hashTagChart");  
    	  //데이터 받아오기
          $.getJSON("./getHashtagCount", function(data){
        	  $.each(data, function(key, value){
        		  //받아온 데이터 저장
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
        	  
        	  chartLabels5 = chartLabels.slice(0,5);
        	  chartData5 = chartData.slice(0,5);
        	    
        	//데이터 받아오면 그래프 그리기
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
        			    // These labels appear in the legend and in the tooltips when hovering different arcs
        			    labels: chartLabels
        			}
        		});
        	
        	  var myPieChart = new Chart(ctx2,{
        		  type: 'pie',
        		  data:{
        			  datasets: [{
        			    	label:'해시태그',
        			        data: chartData5,
        			        backgroundColor:[
        			        	'rgba(255, 99, 132, 0.2)',
        			        	'rgba(54, 162, 235, 0.2)',
        			        	'rgba(255, 206, 86, 0.2)',
        			        	'rgba(75, 192, 192, 0.2)',
        			        	'rgba(153, 102, 255, 0.2)',
        			        ],
                            borderWidth: 1
        			    }],
        			    // These labels appear in the legend and in the tooltips when hovering different arcs
        			    labels: chartLabels5
        			}
        		});
        	  
 
        	  
          });

	});
      
         
  </script>
 <div class = "hashtag-chart" style="width: 40%;">
 	전체 해시태그
 	<canvas id = "hashTagChart" height = "350" width = "400"></canvas>
</div>
<div class = "hashtag-chart" style="width: 40%;">
 	인기 해시태그
 	<canvas id = "5hashTagChart" height = "350" width = "400"></canvas>
</div>

<jsp:include page="/WEB-INF/view/admin/admin_footer.jsp"></jsp:include>