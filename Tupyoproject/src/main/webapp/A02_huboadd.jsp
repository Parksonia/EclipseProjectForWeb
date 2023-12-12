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
<title>A02_huboadd</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f7f7f7;
}
.container {
	width: 600px;
	margin: 20px auto;
	margin-top :80px;
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
		String name = request.getParameter("name");
		int newkiho = Integer.parseInt(request.getParameter("kiho"));  
		
		TupyoDao tupyodao1 = new TupyoDaoImpl();
		boolean success=tupyodao1.newHubolist(newkiho, name);   // 생성한 함수에 매개변수로 받아온 데이터
		
		// 등록 성공시 다시 처음 화면으로 돌아감
		if (success) {
		    out.println("<script>alert('등록이 성공적으로 이루어졌습니다.'); window.location.href='./A01_hubo.jsp';</script>"); 
		} else {
		    out.println("<script>alert('등록에 실패했습니다.'); window.location.href='./A01_hubo.jsp';</script>");  
		}
		%>
	
</body>
</html>
