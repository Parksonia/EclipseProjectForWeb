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


<%
// showRec.jsp 데이터 받아옴 
request.setCharacterEncoding("UTF-8"); //한글처리
String name = request.getParameter("u.name");
int studentid = Integer.parseInt(request.getParameter("u.studentid"));
int kor =Integer.parseInt(request.getParameter("u.kor"));
int eng =Integer.parseInt(request.getParameter("u.eng"));
int mat =Integer.parseInt(request.getParameter("u.mat"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
<style>
table {
	border-collapse: collapse;
	width: 70%;
}

th {
	border-bottom: 1px #444444;
	border: 1px solid #444444;
	text-align: center;
	background-color: #1e90ff;
	color: #f0f8ff;
}

td, tr {
	border: 1px solid;
	padding: 2px;
}
</style>
</head>
<body>
	
	<h2>레코드수정</h2>
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>국어</th>
				<th>영어</th>
				<th>수학</th>
				<th>총점</th>
				<th>평균</th>
				<th>등수</th>
			</tr>
		</thead>
		<tbody>
			
			<% 
			StudentItemDao studentItemDao = new StudentItemDaoImpl();  //메서드 사용하기 위함
 			List<StudentItem>up_studentlist = studentItemDao.updateData(studentid, name, kor, eng, mat);
			
 			// 전체 조회 후 업데이트 된 경우 테이블에 색 변경을 위하여 조건을 줌! 
 			for(int i=0; i<up_studentlist.size();i++){
 				int sum = (up_studentlist.get(i).getKor()+up_studentlist.get(i).getEng()+up_studentlist.get(i).getMat());  //국영수 총합 리스트에 저장된 값 불러오기 
				double avg = ((int) ((sum / 3.0) * 100)) / 100.0;
				int rank = studentItemDao.scoreRank(up_studentlist.get(i).getId());
 				
	 				
 			if(up_studentlist.get(i).getId()== studentid){
	 			out.println("<tr bgcolor='#fffacd'>");
	 			//selectOne에 데이터(studentid) 넘겨주기 ,링크는 이름 
	 			out.println("<td>" + up_studentlist.get(i).getId() +"</td>");
	 			out.println("<td>" + up_studentlist.get(i).getName()+"</td>");
	 			out.println("<td>" + up_studentlist.get(i).getKor() +"</td>"); 		
	 			out.println("<td>" + up_studentlist.get(i).getEng() +"</td>");
	 			out.println("<td>" + up_studentlist.get(i).getMat() +"</td>");
	 			out.println("<td>" + sum +"</td>");
	 			out.println("<td>" + avg +"</td>");
	 			out.println("<td>" + rank +"</td></tr>");
	 		}else{
				out.println("<tr><td>"+up_studentlist.get(i).getId() +"</td>");
				out.println("<td>" + up_studentlist.get(i).getName()+"</td>");
	 			out.println("<td>" + up_studentlist.get(i).getKor() +"</td>"); 		
	 			out.println("<td>" + up_studentlist.get(i).getEng() +"</td>");
	 			out.println("<td>" + up_studentlist.get(i).getMat() +"</td>");
	 			out.println("<td>" + sum +"</td>");
	 			out.println("<td>" + avg +"</td>");
	 			out.println("<td>" + rank +"</td></tr>");	 					
	 		}
	 
 			}
 
			%>
</tbody>
</table>		
</body>
</html>