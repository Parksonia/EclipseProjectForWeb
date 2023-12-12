<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*, javax.sql.*, java.io.*"%>
<%@ page import="kr.ac.kopo.ctc.kopo15.dao.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>테이블 삭제</title>
</head>
<body>
<h2>테이블 삭제</h2>

<% 
	//droptable
	StudentItemDao studentItemDao = new StudentItemDaoImpl();
	
		boolean drop=studentItemDao.dropTable();
		
		if(drop == true){
			out.println("테이블 삭제 성공!");
		}else{
			out.println("테이블 삭제 실패!");
		}
	
%>

</body>
</html>