<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!-- JDBC 사용시 필요한 임포트 -->
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@page import="kr.ac.kopo.ctc.kopo15.dao.*" %>
<%@page import="kr.ac.kopo.ctc.kopo15.domain.*" %>
<%@page import="kr.ac.kopo.ctc.kopo15.dto.*" %>
<%@page import="kr.ac.kopo.ctc.kopo15.service.*" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%
request.setCharacterEncoding("UTF-8"); // 한글을 받을 때의 경우 선언해줘야한다 (get방식에)
//get 방식 (post 방식으로 부터 데이터 받기)
int studentid = Integer.parseInt(request.getParameter("student_id")); //request 객체를 통해 데이터를 받음 
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
table {
	border-collapse: collapse;
	width: 70%;
}

th {
	border-bottom: 1px #444444;
	border: 1px solid #444444;
	text-align: center;
	background-color: #1e90ff;
	color: #f0f8ff;
}

td, tr {
	border: 1px solid;
	padding: 2px;
}
</style>

</head>
<body>
	<h2>조회</h2>
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>국어</th>
				<th>영어</th>
				<th>수학</th>
			</tr>
		</thead>
		<tbody>

			<% 
			StudentItemDao studentItemDao = new StudentItemDaoImpl();

			StudentItem onestudent = studentItemDao.selectOne(studentid);
			
			out.println("<tr><td>"+onestudent.getId()+"</td>");
			out.println("<td>"+onestudent.getName()+"</td>");
			out.println("<td>"+onestudent.getKor()+"</td>");
			out.println("<td>"+onestudent.getEng()+"</td>");
			out.println("<td>"+onestudent.getMat()+"</td></tr>");			
			%>
		</tbody>
	</table>
	<div><a href="./selectAll.jsp"target="right">돌아가기</a></div>
</body>
</html>