<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- JDBC 사용시 필요한 임포트 -->
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@page import="kr.ac.kopo.ctc.kopo15.dao.*"%>
<%@page import="kr.ac.kopo.ctc.kopo15.domain.*"%>
<%@page import="kr.ac.kopo.ctc.kopo15.dto.*"%>
<%@page import="kr.ac.kopo.ctc.kopo15.service.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%
request.setCharacterEncoding("UTF-8");   //한글처리
%>


<%
GongjiItemDao gonjiitemdao = new GongjiItemImpl();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>gonji_list</title>
<style>
.container {
	width: 800px;
}

table {
	border-collapse: collapse;
	width: 100%;
}

.container td {
	border: 1px solid;
	padding: 8px;
}

.container th {
	border: 1px solid;
	padding: 8px;
	background-color: #f2f2f2;
}

.p {
	text-align: center;
}

.button table {
	border-collapse: collapse;
}

.button td {
	border: 0px;
}

.button input[type="button"] {
	padding: 8px 16px;
	background-color: #4CAF50;
	color: white;
	border: none;
	cursor: pointer;
	font-size: 14px;
}

.button input[type="button"]:hover {
	background-color: #45a049;
}
</style>
<script>
function submitForm(mode){
	fm.action = "./gongji_write.jsp?key=INSERT";
	fm.submit();	
}
</script>
</head>
<body>

	<div class="container">
		<form method="post" name="fm">
			<table>
				<tr>
					<td><b>번호</b></td>
					<td>신규(insert)<input type=hidden name=key value='INSERT'></td>  <!-- name을 update의 경우와 같게 하여 if문으로 처리  -->
				</tr>

				<tr>
					<td><b>제목</b></td>
					<td><input type='text' name=title size=70 maxlength=70></td>
				</tr>				
				<tr>
					<td><b>일자</b></td>							
					<td><%=gonjiitemdao.getDate() %></td> <!-- 오늘 날짜  -->
				
				</tr>
				
				<tr>
					<td><b>내용</b></td>
					<td><textarea style="width:500px; height:250px;" name=content rows="600" cols="70" maxlength="100000" required></textarea></td>
				</tr>				
			</table>
			
			<tr>
				<td width="600"></td>
				<!-- 새글작성 -->
				<!-- hidden처리된 value들 insert로 보내기 -->
				<input type ="hidden" name="rootid" value="-1"> <!--새글처리를 위해 이라는 표시로 -1로 줌 -->
				<input type ="hidden" name ="relevel" value="0"> <!--원글이므로 0 -->
				<input type ="hidden" name="recnt" value="0"> <!-- 원글이므로 들여쓰기 없음 0 -->
				<input type ="hidden" name ="viewcnt" value="0">  <!-- 새글 조회수 0 -->
				
				<td><input type="button" value ="취소" onclick="location.href='gongji_list.jsp'"></td> <!-- 뒤로가기  -->
				<td><input type="button" value ="쓰기" onclick="submitForm('write')"></td>
	
			</tr>
	</form>
	</div>
</body>
</html>