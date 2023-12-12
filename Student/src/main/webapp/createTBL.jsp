<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*, javax.sql.*, java.io.*"%>
<%@ page import="kr.ac.kopo.ctc.kopo15.dao.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>테이블 생성</title>
<style>
p {font-size:15px;}
</style>

</head>
<body>

<h2>테이블 생성</h2>

<%
// 순서대로 처리됨 주의!

StudentItemDao studentItemDao = new StudentItemDaoImpl();

	boolean create = studentItemDao.createTable();

	if(create ==true){     // boolean형으로 객체 생성하여 true false가 리턴됨 
		out.println("테이블 생성 성공!");
	}else{
		out.println("테이블 생성 실패!");
	}
	
%>
</body>
</html>