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
<title>gongji_view</title>
<style>
.container {
  width: 800px;
}

table {
  border-collapse: collapse;
  width: 100%;
}

.container td {
  border: 1px solid;
  padding: 8px;
}

.container th {
  border: 1px solid;
  padding: 8px;
  background-color: #f2f2f2;
}

.p {
  text-align: center;
}

.button table {
  border-collapse: collapse;
}

.button td {
  border: 0px;
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
</style>
<%
int id = Integer.parseInt(request.getParameter("key"));  //게시글 번호가 value임
%>
<script>
function submitForm(mode){
	
	if(mode == "write"){
		fm.action = "./gongji_write.jsp";		
	}else if(mode =="delete"){
		fm.action = "./gongji_delete.jsp";		
	}
	fm.submit();
}
</script>

</head>
<body>
<div class="container">
<form method="post" name="fm">
		
			<table>
			<%
			GongjiItemDao gongjiitemdao = new GongjiItemImpl();			
			List<GongjiItem> gongji = gongjiitemdao.GongjiOneView(id);
			
			for(GongjiItem g: gongji){		
			%>
			
				<tr>
					<td><b>번호</b></td>
					<td><input type=text name=key  size=70 value=<%=g.getId()%> readonly></td>  <!-- name을 update의 경우와 같게 하여 if문으로 처리  -->
				</tr>

				<tr>
					<td><b>제목</b></td>
					<td><input type='text' name=title size=70 maxlength=70 value="<%=g.getTitle()%>"></td>
				</tr>				
				<tr>
					<td><b>일자</b></td>							
					<td><%=g.getDate()%></td> <!-- 오늘 날짜  -->				
				</tr>
				
				<tr>
					<td><b>내용</b></td>
					<td><textarea style="width:500px; height:250px;" name=content rows="600" cols="70"><%=g.getContent()%></textarea></td>
				</tr>				
			</table>
			<%
			}
			%>			
			
			<div>
			<table width=650>
			<tr>                                       
				<td width="600"></td> 
				<td><input type="button" value ="취소" onclick="location.href='gongji_list.jsp'"></td> <!-- 뒤로가기  -->
				<td><input type="button" value="쓰기" onclick="submitForm('write')"></td>
				<td><input type="button" value="삭제" onclick="submitForm('delete')"></td>
			</tr>
			</table>
			</div>
	</form>
</div>


</body>
</html>