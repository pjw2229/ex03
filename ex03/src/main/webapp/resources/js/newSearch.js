var newService = (function(){
	function cri(criteria,callback,error){
		$.ajax({
			type: "post",
			url: "/board/newSearch",
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
	
	return {cri:cri};	// 이름 : 값(함수)
})();