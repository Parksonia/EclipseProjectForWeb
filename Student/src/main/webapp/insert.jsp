<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*, javax.sql.*, java.io.*"%>
<%@ page import="kr.ac.kopo.ctc.kopo15.dao.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>테이블 데이터 넣기</title>
</head>
<body>
<h2>데이터 입력</h2>

<% 
	//droptable
	StudentItemDao studentItemDao = new StudentItemDaoImpl();  //impl클래스 사용위한 객체 생성
	
		boolean insert = studentItemDao.insertTable();  // impl객체 메서드 호출 
		
		if(insert ==true){
			out.println("데이터 입력 성공!"); 
		}else{
			out.println("데이터 입력 실패!");
		}
%>
</body>
</html>