<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.net.InetAddress" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<link rel="stylesheet" type="text/css" href="${root}/res/css/common.css">
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	 <script src = "${root}/res/js/swiper.min.js"></script>
	 <link rel="stylesheet" type="text/css" href="${root}/res/css/swiper.min.css">
	
	<style>
		.messageCnt{
			color : red;
		}
		
		.mask {
	position: absolute;
	left: 0;
	top: 0;
	z-index: 9999;
	background-color: #000;
	display: none;
}

.content-view {
	background-color: #ffffff;
	z-index: 99999;
}
		
	</style>
<script>
$(document).ready(function(){
	//웹소켓 연결
	connect();
	$("#top-chaser").hide();
	$(".fa-bars").on("click",function(){
		$("#top-chaser").slideToggle();
	});
	
	$("#search").hide();
	$("#search-result").hide();
	$(".user-alert").hide();
	$(".top-user-alert").hide();
    //상단 알림창
    $(".top-user-alert-div").on("click",function(){
        $(".top-user-alert").empty();
        $.ajax({
        	url : "${root}/member/notice",
        	success : function(result){
				var origin = result;
				result = $.parseHTML(result);
        		$(".top-user-alert").append(result);
        		$(".top-user-alert").slideToggle();
        	}
        });
        
    });
	
	//검색 기능 
	$(".fa-hashtag").on("click",function(){
		$("#search").slideToggle();
		$("#search-result").slideToggle();
	});

	$(".top-search").on("keyup",function(){
		var key = $(this).val();
		if(key != ""){
			$.ajax({
				url:"${root}/board/search-tag",
				data:{"key":key},
				success : function(result){
					var text = "";
					for(var i in result){
						text += "<button class='search-ret btn btn-info' type='submit'>"+result[i]+"</button>&nbsp;&nbsp;&nbsp;&nbsp;";
					}
					$("#search-result").html(text);					
					$(".search-ret").on("click",keyClick);
				}
			});
		}else{
			$("#search-result").empty();
		}
	});
	
	function keyClick(){
		$(".top-search").val($(this).text());
	};
});
$(document).on("unload", function(){
	disconnect();
});  
function connect(){	
	if(window.websocket) return;	
	var uri = "ws://61.75.27.204:11000/sw4-2/send_message";
	//var uri = "ws://${InetAddress.getLocalHost().getHostAddress()}:8080/sw4-2/send_message"
	//var uri = "ws://localhost:8080/sw4-2/send_message";

	
	"${messageTo = null}";
	window.websocket = new WebSocket(uri);	
	//메세지 오면 알람
	websocket.onmessage = function(e){
		var count = Number($("#message-count").text());
		$("#message-count").text(count+1);
		
		var count_nick = Number($("#"+e.data).text());
		$("#"+e.data).text(count_nick+1);
	};
}
function disconnect(){
	if(!websocket) return;
	websocket.close();
	websocket = null;
}
</script>