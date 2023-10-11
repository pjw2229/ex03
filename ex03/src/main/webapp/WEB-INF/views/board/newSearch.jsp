<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Page</title>
</head>
<body>
	페이지 번호 : <input type="text" id="pageNum"><br>
	보여줄 개수 : <input type="text" id="amount"><br>
	검색 타입 : <select id="type">
                  	<option value="T" <c:if test="${pageMaker.cri.type=='T'}">
                  		selected</c:if>>제목
                  	</option>
                  	<option value="C">내용</option>
                  	<option value="W">작성자</option>
                  	<option value="TC">제목 or 내용</option>
                  	<option value="TW">제목 or 작성자</option>
                  	<option value="CW">내용 or 작성자</option>
                  	<option value="TCW">제목 or 내용 or 작성자</option>
              </select><br>
	검색 내용 : <input type="text" id="keyword"><br>
	<button id="crit">확인</button>
	<script src="/resources/js/newSearch.js"></script>
	<script>
		$("#crit").click(function(){
			var pageNum = $("#pageNum").val();
			var amount = $("#amount").val();
			var type = $("#type").val();
			var keyword = $("#keyword").val();
			
			var criteria = {pageNum:pageNum,amount:amount,type:type,keyword:keyword};
			newService.cri(criteria,cri);
			
			$("#pageNum").val("");
			$("#amount").val("");
			$("#type").val("");
			$("#keyword").val("");
		});
	</script>
</body>
</html>