<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>실시간 인기글</title>
</head>
<body>
	<div id="blist"></div>
	<script src="../resources/vendor/jquery/jquery.min.js"></script>    <!-- jQuery -->
	<script>
	var preResult;		// 이전 결과값
	
	/*
	function bestboard(){
		$.ajax({
			type:"get",
			url:"/myapi/bestboard.json",
			success:function(res){
				var htmlStr = "";
				for(var i=0; i < res.length; i++){
					htmlStr += (i + 1) + "등 : " + res[i].title + " [" + res[i].replyCount + "]<br>"
				}
				$("#blist").html(htmlStr);
			}
		});
	}
	*/
	function bestboard(){
		$.ajax({
			url:"/myapi/bestboard.json",
			success:function(res){
				var htmlStr = "";
				//preResult = res[0];
				if(preResult){		// preResult 존재 시 이전 데이터와 현재 데이터를 비교해 순위변경 표시
					for(var rank = 0; rank < res.length; rank++){	// 현재 데이터로 이전 데이터 비교
						for(var i = 0; i < preResult.length; i++){			// 각각 현재값이 이전에 어디에 있는지 확인
							if(res[rank].title == preResult[i].title){
								var diffRank = "-";		// 동일 순위로 시작
								if(rank > i){	// 순위 감소
									diffRank = i - rank;
								}
								else if(rank < i){	// 순위 상승
									diffRank = "+" + (i - rank);
								}
								htmlStr += (rank + 1) + "등 : " + res[rank].title + " [" + diffRank + "]<br>"
								break;	// 찾았으니
							}
						}
						if(i == preResult.length){		// 새로 순위에 올라온 글
							htmlStr += (rank + 1) + "등 : " + res[rank].title + " [new]<br>"
						}
					}
				}else{	// 맨 처음 로딩 시
					for(var i = 0; i < res.length; i++){
						htmlStr += (i + 1) + "등 : " + res[i].title + " [-]<br>"
					}
				}

				$("#blist").html(htmlStr);	// 화면출력
				preResult = res;	// 이전 데이터 보관
			}
		});
	}
	
	setInterval(bestboard, 1000 * 60 * 60);
	</script>
</body>
</html>