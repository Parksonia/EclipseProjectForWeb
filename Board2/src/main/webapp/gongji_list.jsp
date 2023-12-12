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

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>gonji_list</title>
<style>
.container {
	width: 800px;
	height: 100px;    
	margin: auto;	
    padding: 20px;


}
.container table {
	border-collapse: collapse;
	width: 100%;
	table-layout:fixed;
}
table thead td{
text-align : center;
	
}
.container td {
	border: 1px solid;
	padding: 8px;
	text-overflow:ellipsis; overflow:hidden; white-space:nowrap;"

}

.button table {
	border-collapse: collapse;
}

.button td {
	border: 0px;
	padding: 8px;
	height: 50px;
}

.button input[type="button"] {
	padding: 8px 16px;
	background-color: #4CAF50;
	color: white;
	border: none;
	cursor: pointer;
	font-size: 14px;
}
.button input[type="button"]:hover {
	background-color: #45a049;
}

.current-page {
	color: red;
	font-weight: bold;
}
</style>


</head>
<body>

<div class="container">
<table>
<thead>
<tr>
<td>번호</td>
<td>제목</td>
<td>등록일</td>
</tr>
</thead>
<tbody>
<%
GongjiItemDao gongiitemdao = new GongjiItemImpl();
//gongiitemdao.insertgongjilist(); // insert 까지 

List<GongjiItem> list= gongiitemdao.GonjiListAll();

for(GongjiItem a : list){
	%>
	<tr>
	<td width="100"><p><%=a.getId() %></p></td>
	<td width="600"><p><a href="gongji_view.jsp?key=<%=a.getId()%>"><%=a.getTitle()%></a></p></td>
	<td width ="100"><p><%=a.getDate()%></p></td>
	</tr>
<% 	
}
%>
</tbody>
</table>


</div>
</table>

</body>
</html>