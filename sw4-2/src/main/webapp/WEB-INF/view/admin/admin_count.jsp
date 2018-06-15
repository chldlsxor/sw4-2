<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/view/admin/admin_header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
        
        <!--스크립트 작성 공간-->
        <script>            
            $(document).ready(function(){
            	
            	//변수 만들기
            	var chartLabels = []; //받아올 이름
            	var chartData = [];	//받아올 데이터
            	var month = "";
            	
            	//var cooContractNo = '<c:out value="${no}"/>';
            	var cooContractNo = 11;
            	//차트 함수
            	function createChart(){
            		var ctx = document.getElementById("myChart").getContext("2d");
            		LineChartDemo = Chart.Line(ctx, {
                        data : lineChartData,
                        options : {
                            scales : {
                                yAxes : [ {
                                    ticks : {
                                        beginAtZero : true
                                    }
                                } ]
                            }
                        }
                    });
            	}
            	
            	//selectlist로 월을 생성해서 ajax로 받아옴
            	$("#selectMonth").on("change", function(){
            		var changeMonth = $("#selectMonth option:selected").val();
            		month = changeMonth;
            		console.log("month : "+month);
            	});
            	
            	//버튼 누르면 차트 생성
                $("#btn-chart").on("click", function(){
                	chartLabels = [];
                    chartData=[];
                    
                    //getJson으로 데이터 
                    $.getJSON("./getDailyVisitor", {
                        cooContractNo : cooContractNo,
                        month : month
                    }, function(data) {
                    	console.log("data"+data);
                        $.each(data, function(key, value) {
                        	console.log("key"+key);
                        	console.log("value"+value);
                            console.log("value.month"+value.month);
                            console.log("value.count"+value.count);
                            chartLabels.push(value.month);
                            chartData.push(value.count);
                        });
                        
                        lineChartData = {
                                labels : chartLabels,
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
                                    data : chartData
                                } ]
         
                            }
                        createChart();
                        
                    });
//                         var ctx = document.getElementById("myChart");
//                         var myChart = new Chart(ctx, {
//                             type: 'bar',
//                             data: {
//                                 labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
//                                 datasets: [{
//                                     label: '월 별 요청량',
//                                     data: [12, 19, 3, 5, 2, 3],
//                                     backgroundColor: [
//                                         'rgba(255, 99, 132, 0.2)',
//                                         'rgba(54, 162, 235, 0.2)',
//                                         'rgba(255, 206, 86, 0.2)',
//                                         'rgba(75, 192, 192, 0.2)',
//                                         'rgba(153, 102, 255, 0.2)',
//                                         'rgba(255, 159, 64, 0.2)'
//                                     ],
//                                     borderColor: [
//                                         'rgba(255,99,132,1)',
//                                         'rgba(54, 162, 235, 1)',
//                                         'rgba(255, 206, 86, 1)',
//                                         'rgba(75, 192, 192, 1)',
//                                         'rgba(153, 102, 255, 1)',
//                                         'rgba(255, 159, 64, 1)'
//                                     ],
//                                     borderWidth: 1
//                                 }]
//                             },
//                             options: {
//                                 scales: {
//                                     yAxes: [{
//                                         ticks: {
//                                             beginAtZero:true
//                                         }
//                                     }]
//                                 }
//                             }
//                         });
                    });
                });
               
        </script>
    </head>
    <body>
        <div>
	        <!-- 세션 통계 -->
			<div class="container-60">
				<div class="row f2">일자별 세션 요청 통계</div>
				<div class="row">
					<table class="table table-stripe">
						<thead>
							<tr>
								<th width="50%">달 별</th> 
								<th>요청량</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="day" items="${scMap.keySet()}">
								<tr>
									<td>${day}</td>
									<td>${scMap.get(day)}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>   
			<div style="margin-top:20px; margin-left:80px">
                    <select name="selectMonth" id="selectMonth">
 
                        <option value="01">JAN</option>
                        <option value="02">FEB</option>
                        <option value="03">MAR</option>
                        <option value="04">APR</option>
                        <option value="05">MAY</option>
                        <option value="06">JUN</option>
                        <option value="07">JUL</option>
                        <option value="08">AUG</option>
                        <option value="09">SEP</option>
                        <option value="10">OCT</option>
                        <option value="11">NOV</option>
                        <option value="12">DEC</option>
                    </select>
                    <button id="btn-chart">월 별 그래프 보기</button>
                </div>      
            <div class="chart-container" style="position: relative; height:40vh; width:80vw">
           		<canvas id = "myChart"></canvas>
            </div>
            
        </div>
    </body>

<div class="empty-row"></div>
<jsp:include page="/WEB-INF/view/admin/admin_footer.jsp"></jsp:include>