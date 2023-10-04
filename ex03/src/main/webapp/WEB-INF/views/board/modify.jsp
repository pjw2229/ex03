<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                	<div class="panel-heading">
                    	게시글 수정하기
                    </div>
                    <div class="panel-body">
                    	<div class="row">
                        	<div class="col-lg-6">
                            	<form role="form" action="modify" method="post">
                                	<input type="hidden" name="bno" value="${board.bno}">
                                	<input type="hidden" name="pageNum" value="${cri.pageNum}">
                                	<input type="hidden" name="amount" value="${cri.amount}">
                                    <div class="form-group">
                                    	<label>제목</label>
                                    	<input class="form-control" placeholder="제목 입력" name="title" value="${board.title}" id="title">
                                    </div>
                                    <div class="form-group">
                                    	<label>작성자</label>
                                    	<input class="form-control" placeholder="작성자 입력" name="writer" value="${board.writer}" readonly>
                                    </div>                                        
                                    <div class="form-group">
                                    	<label>내용</label>
                                    	<textarea class="form-control" rows="5" placeholder="내용 입력" name="content" id="content">${board.content}</textarea>
                                    </div>
                                    <button type="button" class="btn btn-default" data-oper="modify">수정</button>
                                    <button type="button" class="btn btn-default" data-oper="remove">삭제</button>
                                    <button type="button" class="btn btn-default" data-oper="list">목록</button>
                            	</form>
                        	</div><!-- /.col-lg-6 (nested) -->
                    	</div><!-- /.row (nested) -->
                	</div><!-- /.panel-body -->
            	</div><!-- /.panel -->
        	</div><!-- /.col-lg-12 -->
    	</div><!-- /.row -->
	</div><!-- /#page-wrapper -->
</div><!-- /#wrapper -->
<%--footer 파일 넣기 --%>    
<%@ include file="../includes/footer.jsp" %>
<script>	//p262
	$(function(){  
		var formObj = $("form");

		$("button").on("click",function(e){
			console.log("버튼 누름");
			e.preventDefault(); //버튼에 걸린 이벤트 없애고
			var operation = $(this).data("oper") // data-oper속성의 값읽기 즉,어떤 버튼인지 확인

			if(operation === "modify"){ //수정 버튼이 눌리면
				var title = "${board.title}";				// 원본 제목 읽기
				var content = `${board.content}`;			// 원본 내용 읽기
				var user_title = $("#title").val();			// 수정 제목 읽기
				var user_content = $("#content").val();		// 수정 내용 읽기
				if(title == user_title && content == user_content){ //수정안됨
					alert("수정 필요");
					return;
				}
			}
			else if(operation === "remove"){
				formObj.attr("action","/board/remove");
				formObj.attr("method","get");
			}
			else if(operation === "list"){ // 목록 버튼이 눌리면
				self.location="/board/list";  //board/list 요청
				return; //리턴없으면 아래문장이 실행됨으로
			}

			console.log("submit 동작합니다.");
			formObj.submit(); //submit 전송
		}); //e는 버튼 이벤트
	});
</script>
</body>
</html>