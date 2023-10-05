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
	
	function add2(){
		console.log("댓글들이다?");
	}
	return {add:add, aaa:add2};
})();