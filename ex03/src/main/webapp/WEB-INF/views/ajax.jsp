<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>AJAX TEST</title>
</head>
<body>
    ajax test
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script>
        $.ajax({
            url:"/ajax.test",	// 필수요소
            type:"put",
            data:JSON.stringify({num1:3, num2:4}),	// data : 요청 시 보내는 데이터(언제나 Parameter 형태로 보낸다. ex:a=3&b=4)
            contentType:"JSON",	// contentType : 보내는 데이터형식(보내는 데이터와 형식이 맞아떨어져야 한다.)
        	// 기본값 : application/x-www-form-rulencoded; charset-UTF-8 즉 parameter date
        	
        	// spring에서는 parameter 전송 메소드의 parameter로 선언해 수집가능
        	// spring에서는 json 데이터 전송은 parameter에 @RequestBody annotation 사용
            success:function(result){
                console.log("ajax 요청 성공");
            },
            error:function(){
                console.log("ajax 요청 실패");
            }
        })
    </script>
</body>
</html>