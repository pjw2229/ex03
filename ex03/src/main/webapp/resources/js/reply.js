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

	// 시간 처리
	function displayTime(timeValue){
		var dataObj = new Date(timeValue);
		var gap = new Date().getTime() - timeValue;

		if(gap < (1000 * 60 * 60 * 24)){
			var hh = dataObj.getHours();
			var mi = dataObj.getHours();
			var ss = dataObj.getHours();
			return [(hh > 9 ? '' : '0') + hh, '시 ', (mi > 9 ? '' : '0') + mi, '분 ', (ss > 9 ? '' : '0') + ss, '초'].join('');
		} else
			return [dataObj.getFullYear(), '년 ', dataObj.getMonth() + 1, '월 ', dataObj.getDate(), '일'].join('');
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
	
	// 댓글 갯수
	function cnt(bno,callback,error){
		console.log("댓글 갯수");
		$.getJSON("/replies/count/" + bno, function(result){
			console.log("댓글 " + bno + "번의 댓글 수 가져옴.");
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
	
	return {add:add, getList:getList, time:displayTime, update:modify, read:get, cnt:cnt, del:remove};	// 이름 : 값(함수)
})();