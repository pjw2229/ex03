<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../includes/header.jsp" %><%--헤더 파일 넣기 --%>
	<div id="page-wrapper">
    	<div class="row">
        	<div class="col-lg-12">
            	<h1 class="page-header">게시판</h1>
        	</div><!-- /.col-lg-12 -->
        </div><!-- /.row -->
        <div class="row">
        	<div class="col-lg-12">
            	<div class="panel panel-default">
                	<table>
                    	<tr>
                    		<td>
                    			<div class="panel-heading">
                        			<div>게시글 목록(<a href="register">쓰기</a>)</div>
                        		</div>
                        	</td>
                    		<td>
                    			<div class="panel-heading">
                        			<div>전체 글 갯수 : ${cnt}개</div>
                        		</div>
                        	</td>
                        	<td>
                    			<div class="panel-heading">
                        			<div>오늘 쓴 글 갯수 : ${todayCnt}개</div>
                        		</div>
                        	</td>
                        	<td>
                        		<div>현재 시간 : ${serverTime}</div>
                        	</td>
                    	</tr>
                    </table><!-- /.panel-heading -->
                    <div class="panel-body">
                    	<table width="100%" class="table table-striped table-bordered table-hover">
                        	<thead>
                            	<tr>
                                	<th>번호</th>
                                	<th>제목</th>
                                	<th>작성자</th>
                                	<th>등록일</th>
                                	<th>수정일</th>
                                	<th>추천/비추천</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach items="${list}" var="board">
	                        	<tr>
	                            	<td>${board.bno}</td>
	                            	<td>
	                                	<a href="/board/get?bno=${board.bno}&pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}">
	                                    	<c:out value="${board.title}"/>
	                                	</a>
	                                </td>
	                                <td><c:out value="${board.writer}"/></td>
	                                <td class="center"><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate}" /></td>
	                                <td class="center"><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}" /></td>
	                                <td class="center"><strong style="color:blue">${board.recommand}</strong> / <strong style="color:red">${board.unrecommand}</strong></td>
	                            </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <form action="/board/list" method="get"><%-- 검색바 시작 --%>
                        	<select name="type">
                        		<option value="T" <c:if test="${pageMaker.cri.type=='T'}">selected</c:if>>제목</option>
                        		<option value="C" <c:if test="${pageMaker.cri.type=='C'}">selected</c:if>>내용</option>
                        		<option value="W" <c:if test="${pageMaker.cri.type=='W'}">selected</c:if>>작성자</option>
                        		<option value="TC" <c:if test="${pageMaker.cri.type=='TC'}">selected</c:if>>제목 or 내용</option>
                        		<option value="TW" <c:if test="${pageMaker.cri.type=='TW'}">selected</c:if>>제목 or 작성자</option>
                        		<option value="CW" <c:if test="${pageMaker.cri.type=='CW'}">selected</c:if>>내용 or 작성자</option>
                        		<option value="TCW" <c:if test="${pageMaker.cri.type=='TCW'}">selected</c:if>>제목 or 내용 or 작성자</option>
                        	</select>
                        	<input type="text" name="keyword" id="keyword" placeholder="search.." value="${pageMaker.cri.keyword}">
                        	<input type="submit" value="검색" id="search">
                        </form><%-- 검색바 끝 --%>
                        <div><%-- pagebar 시작 --%>
	                        <c:if test="${pageMaker.prev}">
	                        	<a href="list?pageNum=${pageMaker.startPage - 1}&amount=${pageMaker.cri.amount}" class="btn btn-default">이전</a>
	                        </c:if>
	                        <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="num">
		                        <c:if test="${num==pageMaker.cri.pageNum}"><b></c:if>
		                        <a href="list?pageNum=${num}&amount=${pageMaker.cri.amount}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}">
		                        	${num}
		                        </a>
		                        <c:if test="${num==pageMaker.cri.pageNum}"></b></c:if>
	                        </c:forEach>
	                        <c:if test="${pageMaker.next}">
	                            <a href="list?pageNum=${pageMaker.endPage + 1}&amount=${pageMaker.cri.amount}" class="btn btn-default">다음</a>
	                        </c:if>
                        </div><%-- pagebar 끝 --%>
                    </div> <!-- /.panel-body -->
                </div><!-- /.panel -->
            </div><!-- /.col-lg-12 -->
        </div><!-- /.row -->
    </div><!-- /#page-wrapper -->
        <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    	<div class="modal-dialog">
        	<div class="modal-content">
            	<div class="modal-header">
                	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                	<h4 class="modal-title" id="myModalLabel">알림</h4>
                </div>
                <div class="modal-body">
                	게시글 등록 완료
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                </div>
            </div><!-- /.modal-content -->
        </div> <!-- /.modal-dialog -->
    </div><!-- /.modal -->
<%@ include file="../includes/footer.jsp" %>
<script>
	$(function(){
		$("#search").click(function(){
			if(!$("#keyword").val())
				alert("검색어 입력 후 버튼을 누르십시오.");
		});
	});	// 검색 button 눌리면 사용자 입력 error 처리
</script>
<script>
	var oper = "${oper}";
	var bno = "${result}";
	console.log("보내온 결과 : ", bno);
    	
	if(oper !== ""){
    	if(oper === "remove") {		// 삭제
        	$("div.modal-body").text(bno + "번 글 삭제 완료");
    	}else if(oper === "modify") {	// 수정
        	$("div.modal-body").text(bno + "번 글 수정 완료");
    	}
    	$("#myModal").modal("show");
	}
</script>
</body>
</html>