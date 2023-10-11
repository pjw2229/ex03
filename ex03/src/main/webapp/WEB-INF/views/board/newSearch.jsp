<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AJAX TEST</title>
</head>
<body>
	페이지 번호 : <input type="number" id="pageNum"><br>
	보여줄 개수 : <input type="number" id="amount"><br>
	검색 종류 : <select id="type">
              	<option value="T">제목</option>
             	<option value="C">내용</option>
             	<option value="W">작성자</option>
              	<option value="TC">제목 or 내용</option>
              	<option value="TW">제목 or 작성자</option>
              	<option value="CW">내용 or 작성자</option>
              	<option value="TCW">제목 or 내용 or 작성자</option>
              </select><br>
	검색 내용 : <input type="text" id="keyword"><br>
	<button id="searchBtn">확인</button>
	<div id="result">
	</div>
	<script src="../resources/vendor/jquery/jquery.min.js"></script>    <!-- jQuery -->
	<script>
	$(function(){		// 문서 로딩 시 해당 함수 실행
		$("#searchBtn").click(function(e){
			e.preventDefault();			// 기존 이벤트 무시
			$.ajax({
				type: "post",
				url:"http://localhost:8080/myapi/board/" + $("#pageNum").val() + "/" + $("#amount").val(),
				data: JSON.stringify({keyword:$("#keyword").val(),type:$("#type").val()}),	// =  data:"{'keyword':'" + keyword + "','type':'" + type + "'}",
				contentType:"application/json;charset=UTF-8",
				success:function(res){
					console.log("결과 : ",res);
					var htmlStr = "";
					for(var i=0; i < res.length; i++){
						htmlStr += (i + 1) + ". " + res[i].title + "<br>";
					}
					$("#result").html(htmlStr);
				}
			});

			$("#pageNum").val("");
			$("#amount").val("");
			$("#type").val("");
			$("#keyword").val("");
		});
	});
	</script>
</body>
</html>