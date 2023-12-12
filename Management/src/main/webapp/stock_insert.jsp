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
<%@ page
	import="java.sql.*, javax.sql.*,java.io.*,java.util.*, 
java.text.*, com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%><!--multipart import해줘야함-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert newItem</title>
</head>
<body>
	<%
	String path = "\\image";
	String savePath = request.getServletContext().getRealPath(path);
	int sizeLimit = 100 * 1024 * 1024; //100MB 제한

	MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "UTF-8", new DefaultFileRenamePolicy());

	String title = multi.getParameter("file");
	String img = multi.getFilesystemName("file");

	request.setCharacterEncoding("UTF-8"); //한글처리

	String id = multi.getParameter("productid");
	String name = multi.getParameter("name");
	int cnt = Integer.parseInt(multi.getParameter("cnt"));
	//String img = request.getParameter("img"); 이미지 업로드 방법 1
	String description = multi.getParameter("description"); // 주의 다 multi로 받아줘야함!!!!

	StockItemDao stockitemdao = new StockItemDaoImpl();

	try {

		boolean success = stockitemdao.insertProduct(id, name, cnt, description, img); // title 이 null이 아니면 새로운 글 게시 후 업데이트 하기

		if (success == true) {
	%>

	<script>
		alert("등록성공!");
		window.location.href = './stock_itemlist.jsp'; // 성공 시 다시 리스트로 돌아가기
	</script>
	<%
	} else {
	%>
	<script>
		alert("등록실패!");
		window.location.href = './stock_itemlist.jsp'; // 실패 시 돌아갈 화면 링크 걸기 window 어쩌구
	</script>


	<%
	}

	} catch (Exception e) {

	}
	%>

</body>
</html>