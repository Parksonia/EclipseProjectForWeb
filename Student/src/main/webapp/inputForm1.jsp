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
<title>Document</title>

<style>
.container input[type="number"] {
	width: 150px;
}
</style>
<title>Insert title here</title>
</head>
<body>
	<%try{ %>
	<h2>성적입력추가</h2>
	<form method='post' action='add_DB.jsp'>
		<!-- 아래 폼을 다 채우고 실행은 insertDB.jsp로 간다 -->
		<table cellspacing=1 width=400 border=0>
			<tr>
				<td width=300></td>
				<td width=100><input type="submit" value="추가"></input></td>
			</tr>
		</table>

		<div class="container">
			<table cellspacing=1 width=400 border=1>
				<tr>
					
					<td width=100><p align=center>이름</p></td>
					<td width=300><p align=center>
							<input type="text" name="name" pattern="^[ㄱ-ㅎ가-힣a-zA-Z0-9]*$" title="이름을 입력하세요."  value=""required  maxlength="15"> </input> <!-- onkeypress 주의 이벤트 발생 방식이 달라서 스페이스 한칸은 입력됨 -->
						</p></td>
				</tr>
				<tr>
					<td width=100><p align=center>학번</p></td>
					<td width=300><p align=center>자동부여</p></td>
					<!-- 학번은 자동으로 맨 뒷번호등으로 부여된다 -->
				</tr>
				<tr>
					<td width=100><p align=center>국어</p></td>
					<td width=300><p align=center>
							<input type='number' min='0' max='100' name='kor'
								placeholder="ex)0-100 숫자만입력" value='' required></input
						</p></td>
				</tr>
				<tr>
					<td width=100><p align=center>영어</p></td>
					<td width=300><p align=center>
							<input type='number' min='0' max='100' name='eng'
								placeholder="ex)0-100 숫자만입력" value='' required></input
						</p></td>
				</tr>
				<tr>
					<td width=100><p align=center>수학</p></td>
					<td width=300><p align=center>
							<input type='number' min='0' max='100' name='mat'
								placeholder="ex)0-100 숫자만입력" value='' required></input
						</p></td>
				</tr>
			</table>
		</div>
	</form>

	<% 
	}catch(Exception e){
	 %>
	<h2>생성된 테이블이 없습니다<h2>	
	<%
   }
   %>

</body>
</html>