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


<%
request.setCharacterEncoding("UTF-8");   //한글처리

String productid=request.getParameter("productid");

int cnt= Integer.parseInt(request.getParameter("cnt"));
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>delete_Stockitem</title>
</head>
<body>
<%

	StockItemDao stockitemdao = new StockItemDaoImpl();
	//GongjiItem gongjiitem = new GongjiItem (); // setter로 저장 하고 get방식으로 데려온 값 null인지 아닌지 확인

	boolean success = stockitemdao.updateStock(productid, cnt);
	
	try {
		if (success = true) {
	%>
	<script>
		alert("수정되었습니다");  window.location.href='./stock_oneview.jsp?id=<%=productid%>'; 
	</script>
	<%
	} else {
	%>
	<script>
		alert("error!");  window.location.href='./stock_oneview.jsp?id=<%=productid%>'; 
	</script>
	<%
	}
	} catch (Exception e) {
	}
	%>
</body>
</html>