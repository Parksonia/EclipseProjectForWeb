
<%@ page errorPage="./inputForm_1.jsp"%>
<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<style>

 table td p{text-align: center;}
.container input[type="number"] {
	width: 150px;
}

</style>
</head>
<body>


<h2>성적 조회 후 정정/삭제</h2>

<!-- post방식으로 데이터 보냄 -->
<form method='post' action ='showRec.jsp'> 
	<div class="container">
	<table cellspacing =1 width =400 border=0>
	<tr>
		<td width =100><p>조회 학번</p></td>
		<td width =200><p><input type="number" min="209901" max="300000" name ="searchid" maxlength="6" placeholder="ex)209901~300000"  value='' required></p></td>
		<td width =100><input type="submit" value="조회" required></td>
	</tr>
	</table>
</form>
<form>	


	<table cellspacing =1 width=400 border=1>
	<tr>
		<td width =100><p>이름</p></td>
		<td width =300><p><input type='text' name='name' value=''readonly></p></td> <!-- 조회만 입력 가능하도록 하기위해 readonly처리  -->
	</tr>
	
	<tr>
		<td width =100><p>학번</p></td>
		<td width =300><p></p></td> <!--학번 자동부여됨-->
	</tr>
	
	<tr>
		<td width =100><p>국어</p></td>
		<td width =300><p><input type='text' name='kor' value=''readonly></p></td>
	</tr>
	
	<tr>
		<td width =100><p>영어</p></td>
		<td width =300><p><input type='text' name='eng' value=''readonly></p></td>
	</tr>
	
	<tr>
		<td width =100><p>수학</p></td>
		<td width =300><p><input type='text' name='mat' value=''readonly></p></td>
	</tr>
	</table>
	</div>
</form>
</body>
</html>