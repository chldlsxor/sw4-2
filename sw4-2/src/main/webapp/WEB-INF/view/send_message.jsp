<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>

    <head>
        <title>웹소켓 문제</title>
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <style>
        	#result{
        		max-height:50%;
        		overflow-y:scroll;
        	}
        	.not-read{
    			color: purple;
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
        			console.log("userid 값(현재 로그인 유저 ) : "+$("#userid").text().trim());
        		
        			if(e.date=="e9dc924f-238f-36cc-a946-5942875fe8f0"){
        				//class not read를 remove
        				console.log("정원참..");
        				$( '#message' ).removeClass("not-read");
        			}else if(!ismassage){
        				ismassage = true;
        				send = e.data;
        			}
        			else{
        				ismassage = false;
        				console.log(send==$("#userid").text().trim());
        				if(send==$("#userid").text().trim()){
        					$("#result").append("<div id='message' class = 'not-read' align = 'right'>"+e.data+"</div>")
        				}
        				else{
        					$("#result").append("<div id='message' class = 'not-read' align = 'left'>"+e.data+"</div>")
        				}
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
    <body>
    	<div class="container-fluid">
    		<div class="jumbotron text-center" >
    			<h1>메세지</h1>
    			
    			<p id = "userid">
    				${userid }
    			</p>
    			<p>
    				messageFrom : ${userid }
    			</p>
    			<p>
    				messageTo : ${messageto }
    			</p>
    		</div>
    		<div class="row">
    			
    		</div>	
    		<div class="row">
    			<div id="result" class="col-md-offset-1 col-md-10">
    				<!-- DB리스트에 있는 메세지 리스트는 이 창이 열린 순간 다 읽음 처리 되므로 read 표시 안함 -->
    				<c:forEach var = "message" items="${message_list}">
    					<c:if test="${userid == message.send }">
							<div align="right">[${message.send }] ${message.content }</div>
						</c:if>
						<c:if test="${messageto == message.send }">
							<div align="left">[${message.send }] ${message.content }</div>
						</c:if>
					</c:forEach>
    			</div>
    		</div>
    		<div class="row bottom">
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