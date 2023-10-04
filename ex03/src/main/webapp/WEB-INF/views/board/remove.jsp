<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../includes/header.jsp" %><%--헤더 파일 넣기 --%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>삭제 화면</title>
</head>
<body>
	<div id="page-wrapper">
		<div class="row">
        	<div class="col-lg-12">
        		<div class="panel panel-default">
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-6">
								<form action="remove" method="post">
									<input type="hidden" name="bno" value="${bno}">
									삭제 비밀번호 : <input type="password" name="pw"><br>
									<input type="submit" value="전송">
								</form>
							</div>
						</div>
					</div>
				</div>
        	</div>
        </div>
	</div>
<%@ include file="../includes/footer.jsp" %>
<script>
	var flag = "{flag}"		// "":삭제요청 or "실패": 비밀번호 오류
	if(flag == "실패"){
		alert("잘못된 비밀번호");
	}
</script>
</body>
</html>