<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ include file="../includes/header.jsp" %>	<%--헤더 파일 넣기 --%>
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
                    	게시글 쓰기
                    	<a href="recom?bno=${board.bno}&pageNum=${cri.pageNum}&amount=${cri.amount}" style="color:blue" id="like">
                        	추천 : ${board.recommand}개
                        </a>
                        <a href="unrecom?bno=${board.bno}&pageNum=${cri.pageNum}&amount=${cri.amount}" style="color:red" id="hate">
                        	비추천 : ${board.unrecommand}개
                        </a>
                    </div>
                    <div class="panel-body">
                    	<div class="row">
                         	<div class="col-lg-6">
                             	<div class="form-group">
                                	<label>제목</label>
                                	<input class="form-control" placeholder="제목 입력" name="title" value="${board.title}" readonly>
                                </div>
                                <div class="form-group">
                                	<label>작성자</label>
                                	<input class="form-control" placeholder="작성자 입력" name="writer" value="${board.writer}" readonly>
                                </div>                                        
                                <div class="form-group">
                                	<label>Text area</label>
                                	<textarea class="form-control" rows="5" placeholder="내용 입력" name="content" readonly >${board.content}</textarea>
                                </div>
                                <a href="/board/modify?bno=${board.bno}&pageNum=${cri.pageNum}&amount=${cri.amount}">
                                	<button type="button" class="btn btn-outline btn-primary">수정</button>
                                </a>
                                <a href="/board/list?pageNum=${cri.pageNum}&amount=${cri.amount}">
                                	<button type="button" class="btn btn-outline btn-primary">목록</button>
                                </a>
                                
                            </div><!-- /.col-lg-6 (nested) -->
                    	</div><!-- /.row (nested) -->
                	</div><!-- /.panel-body -->
            	</div><!-- /.panel -->
        	</div><!-- /.col-lg-12 -->
    	</div><!-- /.row -->
	</div>
	<!-- /#page-wrapper -->
	<%@ include file="../includes/footer.jsp" %>
	<!-- 댓글처리 JavaScript -->
	<script src="/resources/js/reply.js"></script>
	<script>
		console.log(replyService);
		replyService.getList(${board.bno}, function(a){
			console.log(a)
		});
		replyService.read(8, function(a){
			console.log(a)
		});
		
		/*
		reply={reply:"JavaScript로 Test",replyer:"관리자박",bno:285};
		replyService.add(reply, function(a){	// 댓글 작성
			console.log(a)
		});
		replyService.del(20, function(a){		// 댓글 삭제
			console.log(a)
		});

		rep={reply:"(수정 완료)",replyer:"관리자 박"};
		replyService.update(45, rep, function(a){	// 댓글 수정
			console.log(a)
		});
		*/
	</script>
</body>
</html>