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
<title>gongji_update</title>
<style>
.container {
  width: 800px;
	height: 100px;
    margin: auto;
    padding: 20px;

}

table {
  border-collapse: collapse;
  width: 100%;
}

.container td {
  border: 1px solid;
  padding: 8px;
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
//int rootid=Integer.parseInt(request.getParameter("rootid"));  //원글번호 글번호와 같다 (그룹번호) 
//int relevel=Integer.parseInt(request.getParameter("relevel")); 
//int recnt=Integer.parseInt(request.getParameter("recnt"));
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
					<td width="100"><b>번호</b></td>
					<td width="700"><input type=text name=key  size=70 value=<%=g.getId()%> readonly></td>  <!-- name을 update의 경우와 같게 하여 if문으로 처리  -->
				</tr>

				<tr>
					<td width="100"><b>제목</b></td>
					<td width="700"><input type='text' name=title size=70 maxlength=70 value="<%=g.getTitle()%>"></td>
				</tr>				
				<tr>
					<td width="100"><b>일자</b></td>							
					<td width="700"><%=g.getDate()%></td> <!-- 오늘 날짜  -->				
				</tr>
				 <tr>
                    <td width="100"><b>조회수</b></td>
                    <td width="700"><%=g.getViewcnt()%></td>
                                                            
                </tr>				
				<tr>
					<td width="100"><b>내용</b></td>
					<td width="700"><textarea style="width:700px; height:250px;" name=content rows="600" cols="70"><%=g.getContent()%></textarea></td>
				</tr>
				 <tr>
                    <td width="100"><b>원글</b></td>
                    <td width="700"><%=g.getRootid()%></td>
                                                            
                </tr>
                   <tr>
                    <td width="100"><b>댓글수준</b></td>
                    <td width="700"><%=g.getRelevel()%></td>
                                                            
                </tr>
                   <tr>
                    <td width="100"><b>댓글내순서</b></td>
                    <td width="700"><%=g.getRecnt()%></td>
                                                            
                </tr>				
			</table>
			<%
			}
			%>						
			<div class="button">
			<table>
			<tr>                                       
				<td width="600"></td> 
				<td><input type="button" value ="취소" onclick="location.href='gongji_list.jsp'"></td> <!-- 뒤로가기  -->
				<td><input type="button" value="쓰기" onclick="submitForm('write')"></td>
		
			</tr>
			</table>
			</div>
	</form>
</div>
</body>
</html>