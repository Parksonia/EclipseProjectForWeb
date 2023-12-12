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
request.setCharacterEncoding("UTF-8"); //한글처리
int id = Integer.parseInt(request.getParameter("key")); //글번호 
int rootid = Integer.parseInt(request.getParameter("rootid")); //원글번호 글번호와 같다 (그룹번호) 
int relevel = Integer.parseInt(request.getParameter("relevel"));
int recnt = Integer.parseInt(request.getParameter("recnt"));
%>
<%
GongjiItemDao gonjiitemdao = new GongjiItemImpl();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>gonji_oneview</title>
<style>
.container {
	width: 800px;
	 height: 100px;
    margin: auto;
    padding: 20px;
	
}

table {
	border-collapse: collapse;
	width: 100%;
}

.container td {
	border: 1px solid;
	padding: 8px;
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
	function submitForm(mode) {
		fm.action = "./gongji_write.jsp?key=REINSERT";
		fm.submit();

		//전체 value 보낼 수 있음 
	}
</script>

</head>
<body>
	<!-- 댓글달기 -->
	<div class="container">
		<form method="post" name="fm">
			<table>
				<tr>
					<td width="100"><b>번호</b></td>
					<td width="700">댓글(insert)<input type=hidden name=key value='REINSERT'></td>
					<!-- 댓글인서트 -->
				</tr>

				<tr>
					<td width="100"><b>제목</b></td>
					<td width="700"><input type='text' name=title size=70 maxlength=70
						required></td>
				</tr>
				<tr>
					<td width="100"><b>일자</b></td>
					<td width="700"><%=gonjiitemdao.getDate()%></td>
					<!-- 오늘 날짜  -->

				</tr>
				<tr>
					<td width="100"><b>내용</b></td>
					<td width="700"><textarea style="width: 700px; height: 250px;"
							name=content rows="600" cols="70" required></textarea></td>
				</tr>
				<tr>
					<td width="100"><b>원글</b></td>
					<!-- rootid 가져오기 -->
					<td width="700"><input type='number' name=rootid value='<%=rootid%>'
						readonly>
				</tr>
				<tr>
					<td width="100"><b>댓글수준</b></td>
					<td width="700" ><input type='hidden' name=relevel value='<%=relevel%>'>
						<input type='number' value='<%=relevel + 1%>' readonly></td>
				</tr>
				<tr>
					<td width="100"><b>댓글 내 순서</b></td>
					<td width="700"><input type='hidden' name=recnt value='<%=recnt%>'>
						<input type='number' value='<%=recnt + 1%>' readonly></td>
				</tr>
			</table>

			<div class="button">
				<table>
					<tr>
						<td width="600"></td>

						<td><input type="button" value="취소"
							onclick="location.href='gongji_list.jsp'"></td>
						<!-- 뒤로가기  -->
						<td><input type="button" value="쓰기"
							onclick="submitForm('write')"></td>
					</tr>
				</table>
			</div>
		</form>
	</div>
</body>
</html>