<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

.container {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}

.count {
  text-align: center;
  margin-bottom: 30px;
}

.img {
  display: flex;
  justify-content: center;
  align-items: center;
  margin: 50px;
}


</style>
</head>
<body>

	<% 
    StudentItemDao studentItemDao = new StudentItemDaoImpl();  //dao 클래스 객체 사용
    int cnt = studentItemDao.countOfVisitor();  // 메서드 호출 변수에 호출값 저장 
    
    out.println("<div class='count'><p>현재 홈페이지 방문 조회수는 ["+cnt+"]입니다.<p></div>");
%>

	<div class="img">
		<img src="./pooh.jpg" alt="이미지" />     <!-- 이미지 파일 불러옴  -->
	</div>

</body>
</html>