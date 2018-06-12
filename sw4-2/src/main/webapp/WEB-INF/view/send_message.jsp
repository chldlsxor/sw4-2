<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<html>

    <head>
        <title>웹소켓 문제</title>
        <link rel="stylesheet" type="text/css" href="${root}/res/css/common.css">
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <style>
        	#result{
        		/* max-height:100%;  */
        	}
        	.not-read{
    			color: fuchsia;
    		}
    		.message-header{
    			position: fixed; 
    			width:100%;
    			min-width : 350px;
    			padding: 10px;
    			background-color: lightpink;
    		}
    		.userimg-container{
    			width = 40%;
    			display: inline-block;
    		}
    		.userinfo-container{
    			width = 60%;
    			display: inline-block;
    		}
    		.input-message{
    			position: fixed;
    			left: 0;
    			right: 0;
    			bottom: 0;
    		}
    		.message-container > .message-header{
    			 width: 350px;
    			 height : 700px;
    		}
    		.result-message{
    			height: 100%;   		
    		}
    		.my-message{
    			background-color: lightpink;
    		}
    		.your-message{
    			background-color: lightyellow;
    		}
        </style>
        
        <script src="http://code.jquery.com/jquery-latest.js"></script>
   	    <script>
         	
        	
        	
        	$(document).ready(function(){
        		connect();               	
        		
        		$("#send").on("click",function(){
                     
        			if(!websocket) return;
        			var text = $("#chat").val();
        			if(!text) return;
        			
       				websocket.send(text);
        			 $("#chat").val(""); 
        		});
        		
        	});
        	
        	$(document).on("unload", function(){
        		disconnect();
        	});
        	
        	function connect(){
        		if(window.websocket) return;
				
        		var uri = "ws://localhost:8080/sw4-2/send_message";
        		
        		window.websocket = new WebSocket(uri);
        		
        		var ismassage= false;
        		var send = null;
        		
        		websocket.onopen = function(e){
        			$("#result").append("<h4>서버에 접속하였습니다</h4>");
        			//스크롤바 맨 아래로
        			$("body").scrollTop($("body")[0].scrollHeight);

        		};
        		websocket.onclose = function(e){
        			$("#result").append("<h4>서버와의 연결이 종료되었습니다</h4>");
        		};
        		websocket.onerror = function(e){
        			$("#result").append("<h4>서버에 접속할 수 없습니다</h4>");
        		};
        		websocket.onmessage = function(e){
        			console.log("넘어온 메세지 : "+e.data);
        			console.log("ismessage 값 : "+ ismassage);
        			console.log("메세지 보낸 사람 아이디 : "+send);
        			console.log("userid 값(현재 로그인 유저 ) : "+$("#userid").val().trim());
        		
        			if(e.data=="e9dc924f-238f-36cc-a946-5942875fe8f0"){
        				//class not read를 remove
        				$(".message").removeClass("not-read");
        				console.log("--> 멤버 정원참");
        			}else if(!ismassage){
        				console.log("--> 보내는 이 저장")
        				ismassage = true;
        				send = e.data;
        			}
        			else{
        				console.log("--> 메세지 표시")
        				ismassage = false;
        				console.log(send==$("#userid").val().trim());
        				if(send==$("#userid").val().trim()){
        					$("#result").append("<div align= 'right' class = 'message not-read'><span class = 'my-message'>"+e.data+"</span></div>")
        				}
        				else{
        					$("#result").append("<div align= 'left' class = 'message not-read'><span class = 'my-message'>"+e.data+"</span></div>")
        				}
        				console.log($("#result"));
        				console.log($("#result")[0]);
        				$("#result").scrollTop($("#result")[0].scrollHeight);

        				
        			}
        			
        			
        			
        		};
        		
        	}
        	function disconnect(){
        		if(!websocket) return;

        		websocket.close();
        		websocket = null;
        	}
        </script>
    </head>
    <%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
    <body class = "message-container">
    	<input type="hidden" id  = "userid" value = "${userid }">
    	<div class="container-fluid">
    		<header class = "message-header">
    			<div class = "container-100">  
    				<div class = "userimg-container">
    					<img class = "img-circle" alt="profile" src="http://via.placeholder.com/100x100">
    				</div>
    				<div class = "userinfo-container">	
    					<div>ID : ${receive_info.id }</div>
			   			<div>name : ${receive_info.name }</div>
			   			<div>nick : ${receive_info.nick }</div>
    				</div>
    				
    			</div>
    			
    		</header>
    		<div class="empty-row"></div>	
    		<div class="empty-row"></div>
    		<div class="empty-row"></div>
    		<section class = "">
    		<div class="row" >
    			<div id="result" class="col-md-offset-1 col-md-10">
    				<!-- DB리스트에 있는 메세지 리스트는 이 창이 열린 순간 다 읽음 처리 되므로 read 표시 안함 -->
    				<c:forEach var = "message" items="${message_list}">
    					<!-- 내가 보낸 메세지 리스트 -->
    					<c:if test="${userid == message.send }">
    						<c:if test="${message.read==0 }">
    							<div align= "right" class = "message not-read"><span class = "my-message">${message.content }</span></div>
    						</c:if>
    						<c:if test="${message.read==1 }">
    							<div align="right" class = "message"> <span class = "right my-message">${message.content }</span></div>
    						</c:if>					
						</c:if>
						<!-- 내가 받은 메세지 리스트 (창여는 순간 무조건 읽음 처리)-->
						<c:if test="${messageto == message.send }">
							<div  align= "left" class= "message"><span class = "your-message">${message.content }</span></div>
						</c:if>
					</c:forEach>
    			</div>
    		</div>
    		<div class="empty-row"></div>
    		<div class="empty-row"></div>
    		</section>
	    		<div class="row input-message">
	    			<div class="col-md-offset-1 col-md-8">		
	    				<input id="chat" type="text" placeholder="입력.." class="form-control">
	    			</div>
	    			<div class="col-md-2">
	    				<input id="send" type="button" value="전송" class="btn btn-default btn-block">
	    			</div>
	    		</div>
    	</div>
    </body>
</html>