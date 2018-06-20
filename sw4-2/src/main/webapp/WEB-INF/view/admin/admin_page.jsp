<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/view/admin/admin_header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
        
        <!--스크립트 작성 공간-->
<script>            
      $(document).ready(function(){
 		
    	  var ctx = document.getElementById("myChart").getContext("2d");
    	  var myPieChart = new Chart(ctx,{
    		    type: 'pie',
    		    data:{
    			    datasets: [{
    			        data: [10, 20, 30]
    			    }],

    			    // These labels appear in the legend and in the tooltips when hovering different arcs
    			    labels: [
    			        'Red',
    			        'Yellow',
    			        'Blue'
    			    ]
    			},
    		    options: options
    		});
    	  
          });
      
         
  </script>

<h1>관리자 페이지 입니다</h1>
<table>
	<thead>
		<tr>
			<th>해시태그</th>
			<th>사용수</th>
		</tr>	
	</thead>
	<tbody>
		<c:forEach var = "hashtag" items="${hashtag_list }">
			<tr>
				<td> ${hashtag.get("TAG")}</td>
				<td> ${hashtag.get("COUNT")}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<canvas id="myChart" width="400" height="400"></canvas>
<jsp:include page="/WEB-INF/view/admin/admin_footer.jsp"></jsp:include>