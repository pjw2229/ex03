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
                    	<div class='row'>
                    		<div class="col-lg-12">
                    			<div class="panel panel-default">
                    				<div class="panel=heading">
                    					<i class="fa fa-comments fa-fw"></i> 댓글
                    					<button id="replyBtn" class="btn btn-primary btn-xs pull-right">댓글쓰기</button>
                    				</div>
                    				<div class="panel-body">
                    					<ul class="chat">
                    					</ul>
                    				</div>
                    			</div>
                    		</div>
                    	</div>
                	</div><!-- /.panel-body -->
            	</div><!-- /.panel -->
        	</div><!-- /.col-lg-12 -->
    	</div><!-- /.row -->
	</div>
	<!-- /#page-wrapper -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    	<div class="modal-dialog">
        	<div class="modal-content">
            	<div class="modal-header">
                	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                	<h4 class="modal-title" id="myModalLabel">댓글 작성</h4>
                </div>
                <div class="modal-body">
                	<div class="form-group">
                		<label>댓글</label>
                		<input class="form-control" name='reply'>
                	</div>
                	<div class="form-group">
                		<label>작성자</label>
                		<input class="form-control" name='replyer'>
                	</div>
                </div>
                <div class="modal-footer">
                	<button id="registerBtn" type="button" class="btn btn-default" data-dismiss="modal">작성</button>
                    <button id="modalCloseBtn" type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                </div>
            </div><!-- /.modal-content -->
        </div> <!-- /.modal-dialog -->
    </div><!-- /.modal -->
	<%@ include file="../includes/footer.jsp" %>
	<!-- 댓글처리 JavaScript -->
	<script src="/resources/js/reply.js"></script>
	<script>
		// console.log(replyService);
		replyService.getList(${board.bno}, function(list){	// 1. 해당 게시글 가져오기
			var str = "";
			if(list == null || list.length == 0){
				$(".chat").html("");
				return;
			}
			for(var i = 0; i < list.length; i++){		// 2. 화면에 넣을 댓글 가공
				str += "<li class='left clearfix' data-rno='";
				str += list[i].rno;
				str += "'>	<div><div class='header'><strong class='primary-font'>";
				str += list[i].replyer;
				str += "</strong>		<small class='pull-right text-muted'>";
				str += replyService.displayTime(list[i].replyDate);
				str += "</small></div>		<p>";
				str += list[i].reply;
				str += "</p></div></li>";
			}
			$(".chat").html(str);		// 3. 해당 위치에 삽입
		});
		
		var modal = $(".modal");
		
		$("#replyBtn").click(function(){
			modal.find("input").val("");
			
			$(".modal").modal("show");
		});
		
		$("#registerBtn").click(function(){
			var reply = {
				reply: modal.find("input[name='reply']").val(),
				replyer: modal.find("input[name='replyer']").val(),
				bno:${board.bno}
			};
			
			replyService.add(reply, function(res){	// 댓글 작성
				alert(res);
				modal.find("input").val("");
				modal.modal("hide");
			});
		});
		
		/*
		replyService.read(8, function(a){
			console.log(a)
		});
		
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