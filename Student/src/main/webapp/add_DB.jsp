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
//get 방식 (post 방식으로 부터 데이터 받기), 받을 떼 한글처리 주의하기!
//int studentid = 학번 자동 부여...? 
		
request.setCharacterEncoding("UTF-8"); //한글처리
String name = request.getParameter("name"); //request 객체를 통해 name 이름으로 설정 데이터를 받음 
int kor = Integer.parseInt(request.getParameter("kor"));
int eng = Integer.parseInt(request.getParameter("eng"));
int mat = Integer.parseInt(request.getParameter("mat"));

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DB insert 추가</title>
<style>
 table td p{text-align: center;}
</style>
</head>
<body>

	<%	
	try{		
	StudentItemDao studentItemDao = new StudentItemDaoImpl();
	int newStudentid= studentItemDao.newstudentid(name, kor, eng, mat);
	%>
	<h2>성적입력추가완료</h2>
	<form method='post' action='./inputForm1.jsp'>
		<table cellspacing=1 width=400 border=0>
			<tr>
				<td width=300></td>
				<td width=100><input type='submit' value="뒤로가기"></td>
			</tr>
		</table>

		<table cellspacing=1 width=400 border=1>
			<tr>
				<td width=100><p>이름</p></td>
				<td width=300><p>
						<input type='text' name='name' value='<%=name%>' readonly>
					</p></td>
			</tr>

			<tr>
				<td width=100><p>학번</p></td>
				<td width=300><p>
						<input type='text' name='studentid'
							value='<%=newStudentid%>' readonly>
					</p></td>
			</tr>
			<tr>
				<td width=100><p>국어</p></td>
				<td width=300><p>
						<input  type='text'  name='kor' value='<%=kor%>'readonly>
					</p></td>
			</tr>

			<tr>
				<td width=100><p>영어</p></td>
				<td width=300><p>
						<input  type='text' "name='eng' value='<%=eng%>' readonly>
					</p></td>
			</tr>

			<tr>
				<td width=100><p>수학</p></td>
				<td width=300><p>
						<input  type='text'   name='mat' value='<%=mat%>' readonly>
					</p></td>
			</tr>
		</table>
	</form>
 <%
	}catch(Exception e){
		out.println("<h2>입력 실패!<h2>");
	}

 %>

</body>
</html>
<%

/*한글처리 겟방식
	-뽀냬는꽀
	String han="지연";
     String ckey= URLEncoder.encode(han, "euc-kr"); 
     String cURL="http://iamhpd8.cafe24.com/lec17/tview.jsp?key='"+ckey+"'";
  	- 받는 곳
     String ckey = request.getParameter( "key" );
     String ckey2= URLDecoder.decode(ckey); 
     String name=new String(ckey2.getBytes("8859_1"),”utf-8");*/
%>