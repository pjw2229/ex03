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
                    	<div id="chat" class="panel panel-default">
                    	</div>
                        <!-- 댓글끝 -->
                        <input id="replyData" type="text" placeholder="댓글내용" style="width:50%;">
                        <input id="replyWriter" type="text" placeholder="작성자" style="width:100px;">
                        <button id="btnReplyWrite">작성</button>
                	</div><!-- /.panel-body -->
            	</div><!-- /.panel -->
        	</div><!-- /.col-lg-12 -->
    	</div><!-- /.row -->
	</div>
	<!-- /#page-wrapper -->
	<%@ include file="../includes/footer.jsp" %>
	<!-- 댓글처리 JavaScript -->
	<script src="/resources/js/reply.js?ver=3"></script>
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
				
			});
		}
		
		$(document).ready(function(){ 
			replyList();
		});
		
		
		$("#btnReplyWrite").click(function(e){
			//1.작성한 리플내용과 작성자와 글번호를 읽어서
			var replyData=$("#replyData").val();
			var replyWriter=$("#replyWriter").val();
			var bno="${board.bno}";
			console.log("작성할 리플내용:",replyData,replyWriter,bno);
			//2.리플객체를 만들어서
			var reply={bno:bno,reply:replyData,replyer:replyWriter};
			//3.리플등록처리      //4.리플목록 갱신(콜백으로 넣어줘야함why?ajax는 비동기 처리 되기 때문)
			replyService.add(reply,replyList);
			//5.리플 작성내용 지우기
			$("#replyData").val("");
			$("#replyWriter").val("");
		});
		
		//리플 삭제 처리
		/* 동적으로 만들어진  dom 임으로 이벤트 리스너가 등록이 불가함으로
		 * 위임을 통해서 이벤트 등록시키자!
		$(".btnDel").on("click",function(e){  
			console.log("삭제버튼 클릭");
		});
		*/
		// #chat 존재dom       .btnDel 실제대상(동작요소)
		$("#chat").click(".btnDel",function(e){  
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
		});
		
		//수정
		//1.댓글내용이 클릭되면 수정이 가능하도록 입력창으로 변경
		$("#chat").click(".replyModify",function(e){
			$(this).removeClass(); //다시 클릭이 안되도록  class 속성삭제
			var replyData=$(this).text(); //클릭한 댓글 내용
			var rno=$(this).prev().text(); // 클릭한 댓글 번호
			var str='<input type="text" value="'+replyData+'">';
			$(this).html(str).children().focus(); //바로 수정이 가능하도록 포커스 이동
			//2.포커스가 사라지면 수정이 되도록 js 호출
			//$("#chat").on("blur","input",function(e){  //누적문제 발생함으로
			//(why? 엘리먼트 삭제시 포커스를 잃었다는 이벤트를 발생함으로)
			$(':focus').blur(function(e){ //현재포커스 기준으로 수정
				var modifyData=$(this).val(); //변경한 댓글내용읽기
				reply={reply:modifyData};     
				replyService.modify(rno,reply,replyList);  //3.댓글 목록 재갱신 
			}); 
		});
	</script>
</body>
</html>