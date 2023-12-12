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
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>C01_voteresult</title>
<%
	TupyoDao tupyodao = new TupyoDaoImpl();
	List<TupyoItem> votesall =  tupyodao.voteResultAll();  // 개표결과 갖고 오기
	%>

<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f7f7f7;
}
.container {
	width: 600px;
	margin: 20px auto;

}

table {
	border-collapse: collapse;
	width: 100%;
}

table th, table td {
	padding: 10px;
	border: 1px solid #ccc;
}

.icons {
	display: flex;
	margin-bottom: 20px;
	justify-content: center;
}

.icons a {
	display: flex;
	align-items: center;
	margin-right: 30px;
	color: #fff;
	text-decoration: none;
}

/* 버튼 스타일 */
.button {
	padding: 10px;
	border: none;
	background-color: #e7b7d2;
	color: #fff;
	cursor: pointer;
	text-decoration: none;
	display: inline-block;
	border-radius: 5px;
}

.button:hover {
	background-color: #e75d80;
}

.bar{
	   width: 500px;
	display: flex;
	flex-direction: row;
	justify-content: flex-start;
    align-items: center
   
}
	
.barstyle{
background-color:#e75d80;
height:30px
}
h3{
    text-align: center;
    margin-top: 50px;
}
</style>

</head>
<body>

	<div class="icons">
		<a href="./A01_hubo.jsp" class="button">후보등록</a> <a
			href="./B01_tupyo.jsp" class="button">투표</a> 
			<a href="./C01_voteresult.jsp"class="button"style="background-color: #e75d80;">개표결과</a>
	</div>
	
	<h3>후보 별 득표율</h3>
	<div class="container">
	<table>
	<% for(TupyoItem i : votesall){
		double votesrate = i.getVotesrate();
		String formattedrate= String.format("%.2f", votesrate); //소수점 잘라주기
		
		out.println("<tr><td width =\"75\"><a href=./C02_voteresult.jsp?votekiho="+i.getVotekiho()+"&candidate="+i.getName()+">"+i.getVotekiho()+"번"+i.getName()+"</a></td>");
		out.println("<td width=500 style=padding-left:0px><div class='bar'><div class='barstyle' style='width:"+formattedrate+"%'></div><div>"+i.getVotescount()+"("+formattedrate+"%)</div></div></td>");
		// 모든 후보자의 투표 득표수 득표율 출력함 
	}	
	%> 
	</table>
	</div>
</body>
</html>
	