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
                    					<input id="replyData" class="form-control" type="text" placeholder="댓글내용">
                             			<input id="replyWriter" type="text" placeholder="작성자">
                    					<button id="replyBtn" class="btn btn-primary btn-xs pull-right">댓글쓰기</button>
                    				</div>
                    				<div class="panel-body">
                    					<ul class="chat">
                    					</ul>
                    				</div>
                    			</div>
                    		</div>
                    	</div><!-- /.row (댓글) -->
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
		// console.log(replyService);
		function replyList(){
			//1.해당하는 게시글의 댓글가져오고
			replyService.getList(${board.bno} , function(reply){
			//2.댓글 잘 가공해서 화면에 넣을 내용을 만들고 (html)	
			console.log(reply)
			replyStr="";
			for(var i=0; i<reply.length; i++){
				replyStr += "<li> <span hidden>"+reply[i].rno+"</span>" +'<span class="replyModify">'+reply[i].reply+"</span>("+reply[i].replyer+") - " + replyService.time(reply[i].replyDate) +' [<span class="btnDel"><a href="#">X</a></span>] </li>';
			}
			console.log("넣어야할 리플화면",replyStr);
			//3.해당하는 위치에 넣어준다.
			$("#chat").html(replyStr);
		
			} );	
		}
		
		$(document).ready(function(){ 
			replyList();
		});
		
		/* 동적 생성된 dom이므로 eventListener 등록 불가
		#(".btnDel").click(function(){
			replyService.del(rno, function(a){		// 댓글 삭제
				console.log(a + "삭제됨.")
			});
		});*/

		$("#replyBtn").click(function(e){
			var reply = {bno:"${board.bno}",reply:$("#replyData").val(),replyer:$("#replyWriter").val())};
			replyService.add(reply,replyList);
			$("#replyData").val("");
			$("#replyWriter").val("");
		});
		
		$("#chat").on("click",".btnDel",function(e){  
			e.preventDefault();//걸려있는 이벤트 무시
			console.log("삭제버튼 클릭");
			var pw=prompt("패스워드를 입력하세요");
			if(pw==1234){
				//1.해당하는 댓글번호 일기
				var rno=$(this).prev().text();
				console.log("댓글번호",rno);
				//2.삭제 js 호출     //3.댓글 목록갱신
				replyService.del(rno,replyList );
			}else{
				alert("패스워드가 다릅니다.");
			}
		} );

		//수정
		//1.댓글내용이 클릭되면 수정이 가능하도록 입력창으로 변경
		$("#chat").on("click",".replyModify",function(e){  
			console.log("댓글내용클릭");
			$(this).removeClass(); //다시 클릭이 안되도록  class 속성삭제
			var replyData=$(this).text(); //클릭한 댓글 내용
			console.log("댓글내용",replyData);
			var rno=$(this).prev().text(); // 클릭한 댓글 번호
			console.log("댓글번호",rno);
			var str='<input type="text" value="'+replyData+'">';
			$(this).html(str).children().focus(); //바로 수정이 가능하도록 포커스 이동
			//2.포커스가 사라지면 수정이 되도록 js 호출
			//$("#chat").on("blur","input",function(e){  //누적문제 발생함으로
			//(why? 엘리먼트 삭제시 포커스를 잃었다는 이벤트를 발생함으로)
			$(':focus').on("blur",function(e){ //현재포커스 기준으로 수정
				console.log("댓글수정작업");
				var modifyData=$(this).val(); //변경한 댓글내용읽기
				console.log("수정할내용:",modifyData);
				reply={reply:modifyData};     
				replyService.modify(rno,reply,replyList);  //3.댓글 목록 재갱신 
			}); 
		});
	</script>
</body>
</html>