<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>new reply</title>
</head>
<body>
	오늘의 리플 갯수 : <strong id="rcnt">${todayCnt}</strong><br>
	<button id="btn">확인</button><br>
	<div id="rlist">
	</div>
	<script src="../resources/vendor/jquery/jquery.min.js"></script>    <!-- jQuery -->
	<script>
	$(function(){
		$("#btn").click(function(){
			/*
			$.ajax({
				type:"get",
				url:"http://localhost:8080/replies/todayCount.json",
				success:function(res){
					console.log(res);
					$("#rcnt").html(res);
				}
			});
			*/
			$.ajax({
				type:"post",
				url:"http://localhost:8080/replies/newReplylist",
				success:function(res){
					console.log("결과 : ",res);
					var htmlStr = "";
					for(var i=0; i < res.length; i++){
						htmlStr += (i + 1) + ". " + res[i].reply + "(" + res[i].replyer + ")<br>"
					}
					$("#rlist").html(htmlStr);
				}
			});
		});
	});
	</script>
</body>
</html>