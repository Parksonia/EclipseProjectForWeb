
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
int id = Integer.parseInt(request.getParameter("key"));
//int rootid = Integer.parseInt(request.getParameter("rootid"));
int relevel= Integer.parseInt(request.getParameter("relevel")); //원글삭제, 댓글삭제 나누어 처리 할 예정 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>gongji_delete</title>
</head>
<body>
	<%
	GongjiItemDao gongjiitemdao = new GongjiItemImpl();
	//GongjiItem gongjiitem = new GongjiItem (); // setter로 저장 하고 get방식으로 데려온 값 null인지 아닌지 확인

	boolean success = gongjiitemdao.deleteGonji(id,relevel);

	try {

		if (success = true) {
	%>
	<script>
		alert("삭제되었습니다");  window.location.href='./gongji_list.jsp'; // 성공 시 화면 링크 걸기
	</script>
	<%
	} else {
	%>
	<script>
		alert("error!");  window.location.href='./gongji_list.jsp'; // 실패 시 돌아갈 화면 링크 걸기 window 어쩌구
	</script>
	<%
	}
	} catch (Exception e) {

	}
	%>
</body>
</html>