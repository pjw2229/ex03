console.log("댓글 처리하는 JavaScript 작동");
var replyService = (function(){
	function add(reply,callback,error){
		console.log("댓글 등록");
		$.ajax({
			type: "post",
			url: "/replies/new",
			data: JSON.stringify(reply),
			contentType:"application/json;charset=UTF-8",
			success:function(result,status,xhr){
				console.log("댓글 등록 정상 처리");
				if(callback)
					callback(result);
			},
			error:function(xhr,status,er){
				if(error)
					error(er);
			}
		})
	}
	
	// 댓글 목록
	function getList(bno,callback,error){
		console.log("댓글 목록");
		/*
		$.ajax({
			type: "get",
			url: "/replies/pages/" + bno + ".json",
			success:function(result,status,xhr){
				console.log("댓글 목록 정상 처리");
				if(callback)
					callback(result);
			},
			error:function(xhr,status,er){
				if(error)
					error(er);
			}
		})*/

		// $.getJSON(요청주소, 성공 시 처리함수).fail(실패 시 처리함수)
		$.getJSON("/replies/pages/" + bno, function(result){
			console.log("댓글 목록 정상 처리");
			if(callback)
				callback(result);
		}).fail(function(xhr,status,er){
			if(error)
				error(er);
		});
	};
	
	// 댓글 수정
	function modify(rno,reply,callback,error){
		console.log("댓글 수정");
		$.ajax({
			type: "put",
			url: "/replies/" + rno,
			data: JSON.stringify(reply),
			contentType:"application/json;charset=UTF-8",
			success:function(result,status,xhr){
				console.log("댓글 수정 완료");
				if(callback)
					callback(result);
			},
			error:function(xhr,status,er){
				if(error)
					error(er);
			}
		})
	}
	
	// 댓글 1개 가져오기
	function get(rno,callback,error){
		console.log("댓글 1개 가져오기");
		$.getJSON("/replies/read/" + rno, function(result){
			console.log("댓글 " + rno + "번 정상적으로 가져왔습니다.");
			if(callback)
				callback(result);
		}).fail(function(xhr,status,er){
			if(error)
				error(er);
		});
	};
	
	function remove(rno,callback,error){
		console.log("댓글 삭제");
		$.ajax({
			type: "delete",
			url: "/replies/" + rno,
			success:function(result,status,xhr){
				console.log("댓글 정상적으로 삭제됨");
				if(callback)
					callback(result);
			},
			error:function(xhr,status,er){
				if(error)
					error(er);
			}
		})
	}
	return {add:add, getList:getList, update:modify, read:get, del:remove};	// 이름 : 값(함수)
})();