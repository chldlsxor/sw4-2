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
        			$("#result").append("<h4>"+e.data+"</h4>");
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
    		<div class="jumbotron text-center">
    			<h1>메세지</h1>
    			
    			<p>
    				로그인 ID : ${userid }
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
    			<div class="col-md-offset-1 col-md-8">		
    				<input id="chat" type="text" placeholder="입력.." class="form-control">
    			</div>
    			<div class="col-md-2">
    				<input id="send" type="button" value="전송" class="btn btn-default btn-block">
    			</div>
    		</div>
    		
    		<div class="row">
    			<div id="result" class="col-md-offset-1 col-md-10">
    				<c:forEach var = "message" items="${message_list}">
						<h4>[${message.send }] ${message.content }</h4>
					</c:forEach>
    			</div>
    		</div>
    	</div>
    </body>
</html>