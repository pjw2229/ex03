<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>new reply</title>
</head>
<body>
	오늘의 리플 갯수 : <div id="rcnt"></div><br>
	<button id="btn">확인</button><br>
	<div id="rlist">
	</div>
	<script src="../resources/vendor/jquery/jquery.min.js"></script>    <!-- jQuery -->
	<script>
	$(function(){
		$("#btn").click(function(){
			$.ajax({
				type:"post",
				url:"http://localhost:8080/replies/newReply",
				success:function(res){
					$("#rcnt").html(res);
				}
			});
		});
	});
	</script>
</body>
</html>