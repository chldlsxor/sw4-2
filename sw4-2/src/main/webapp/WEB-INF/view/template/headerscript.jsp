<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
<link rel="stylesheet" type="text/css" href="${root}/res/css/common.css">
<link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<style>
		.receive-mail{
			color : yellow !important;
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
	var uri = "ws://localhost:8080/sw4-2/send_message";
	"${messageTo = null}";
	window.websocket = new WebSocket(uri);	
	//메세지 오면 알람
	websocket.onmessage = function(e){
		$(".message-icon").addClass('receive-mail');
		var count = Number($("#message-count").text());
		console.log(count);
		$("#message-count").text(count+1);
		console.log($("#messageCntNick").text())
		if(e.data==messageNick){
			
		}
		console.log(e.data);
		//$("#messageCntNick").text(count+1);
		//디비에
		//해당 아이디에도
	};
}
function disconnect(){
	if(!websocket) return;
	websocket.close();
	websocket = null;
}
</script>