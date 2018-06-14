<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/view/admin/admin_header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
        
        <!--스크립트 작성 공간-->
        <script>            
            $(document).ready(function(){
                $("button").on("click", function(){
                        var ctx = document.getElementById("myChart");
                        var myChart = new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
                                datasets: [{
                                    label: '# of Votes',
                                    data: [12, 19, 3, 5, 2, 3],
                                    backgroundColor: [
                                        'rgba(255, 99, 132, 0.2)',
                                        'rgba(54, 162, 235, 0.2)',
                                        'rgba(255, 206, 86, 0.2)',
                                        'rgba(75, 192, 192, 0.2)',
                                        'rgba(153, 102, 255, 0.2)',
                                        'rgba(255, 159, 64, 0.2)'
                                    ],
                                    borderColor: [
                                        'rgba(255,99,132,1)',
                                        'rgba(54, 162, 235, 1)',
                                        'rgba(255, 206, 86, 1)',
                                        'rgba(75, 192, 192, 1)',
                                        'rgba(153, 102, 255, 1)',
                                        'rgba(255, 159, 64, 1)'
                                    ],
                                    borderWidth: 1
                                }]
                            },
                            options: {
                                scales: {
                                    yAxes: [{
                                        ticks: {
                                            beginAtZero:true
                                        }
                                    }]
                                }
                            }
                        });
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
            <button> 그래프 보기</button>
            <canvas id = "myChart"></canvas>
        </div>
    </body>

<div class="empty-row"></div>
<jsp:include page="/WEB-INF/view/admin/admin_footer.jsp"></jsp:include>