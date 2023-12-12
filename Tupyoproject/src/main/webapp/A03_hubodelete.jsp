<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- JDBC 사용시 필요한 임포트 -->
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@page import="kr.ac.kopo.ctc.kopo15.dao.*"%>
<%@page import="kr.ac.kopo.ctc.kopo15.domain.*"%>
<%@page import="kr.ac.kopo.ctc.kopo15.dto.*"%>
<%@page import="kr.ac.kopo.ctc.kopo15.service.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>A03_hubodelete</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
}
.container {
	width: 600px;
	margin: 20px auto;
}

table {
	border-collapse: collapse;
	width: 100%;
}

table th,
table td {
	padding: 10px;
	border: 1px solid #ccc;
}
table th {
	background-color: #f0f0f0;
}

.icons {
	display: flex;
	margin-bottom: 20px;
	justify-content: center;
}

.icons a {
	display: flex;
	align-items: center;
	margin-right:30px;
	color: #fff;
	text-decoration: none;
}

.button {
	padding: 10px;
	border: none;
	background-color: #e7b7d2;
	color: #fff;
	cursor: pointer;
	text-decoration: none;
	display: inline-block;
	border-radius: 5px;
}

.button:hover {
	background-color: #e75d80;
}
</style>
</head>
<body>
	<% 
		//get 으로 받아오기
		request.setCharacterEncoding("UTF-8"); //한글처리
		int delkiho = Integer.parseInt(request.getParameter("kiho")); //a01 삭제버튼 누르면 해당 value 넘겨줌,그걸 받아옴
		
		TupyoDao tupyodao1 = new TupyoDaoImpl();
		boolean success= tupyodao1.delHuboData(delkiho);   //함수 호출하여 del실행
		
		if (success) {
	%>
	    <script>
	        alert('삭제 완료 되었습니다.'); window.location.href='./A01_hubo.jsp';
	    </script>
	<%
	} else {
	%>
	    <script>
	        alert('삭제 실패'); window.location.href='./A01_hubo.jsp';
	    </script>
	<%
	}
	%>
	<% 
	TupyoDao tupyodao2 = new TupyoDaoImpl();
	List<TupyoItem> hubolist = tupyodao2.selectAll();  // 전체 불러오기%>
	
	<!--  원래는 전체 결과 출력하려고 함
	<div class="icons">
		<a href="./A01_hubo.jsp" class="button">후보등록</a> <a
			href="./B01_tupyo.jsp" class="button">투표</a> 
			<a href="./C01_voteresult.jsp"class="button">개표결과</a>
	</div>

	<div class="container">
		<table>
			<thead>
				<tr>
					<th width="100">기호</th>
					<th width="300">후보명</th>
				</tr>
			</thead>
			<tbody>
					<%
	
					//for (int i = 0; i < hubolist.size(); i++) {
					//	out.println("<tr><td width=\"100\">" + hubolist.get(i).getKiho() + "</td>");
						//out.println("<td width=\"300\">" + hubolist.get(i).getName() + "</td><tr>");
					//}
					%>
			</tbody>	
		</table>
	</div> 
	-->
</body>
</html>
