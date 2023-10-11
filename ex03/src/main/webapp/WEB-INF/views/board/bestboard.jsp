<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>실시간 인기글</title>
</head>
<body>
	<c:forEach items="${best}" var="board">
		<div>${board.title} [${board.replyCount}]</div>
	</c:forEach>
</body>
</html>