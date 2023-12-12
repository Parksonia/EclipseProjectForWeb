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
<title>C02_voteresult</title>
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

.bar {
	width: 500px;
	display: flex;
	flex-direction: row;
	justify-content: flex-start;
	align-items: center
}

.barstyle {
	background-color: #e75d80;
	height: 30px
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
			href="./B01_tupyo.jsp" class="button">투표</a> <a
			href="./C01_voteresult.jsp" class="button">개표결과</a>
	</div>
	<% 
	request.setCharacterEncoding("UTF-8"); // 한글처리
	String candidate= request.getParameter("candidate");  // 투표된 후보자 이름 불러오기
	%>
	<h3><%=candidate%>후보 득표 성향
	</h3>
	<div class="container">
	<table>


<% 
int votekiho = Integer.parseInt(request.getParameter("votekiho"));  // 투표 결과로부터 특정 기호번호 받아오기

TupyoDao tupyodao = new TupyoDaoImpl();

List<TupyoItem> eachresult = tupyodao.voteResultOne(votekiho);

int agegroupIndex = 0; // 연령대 인덱스 변수, 메서드로 불러온 리스트의 인덱스  
int listSize = eachresult.size(); // 리스트 크기 저장

for (int agegroup = 10; agegroup <= 90; agegroup += 10) {  //연령대 출력 위하여 10씩 증가하는 루프
    
	if (agegroupIndex < listSize) { // 리스트 저장된 값이 있고,저장된 크기보다 작다면 
        TupyoItem currentItem = eachresult.get(agegroupIndex); //0번째 리스트의 값들을 가져옴(인덱스도 증가 시킬거임)
        
        if (currentItem.getAgegroup() == agegroup) { 
        	double votesRate = currentItem.getVotesrate();
			String formattedRate = String.format("%.2f", votesRate);// 소수점 두자리까지 자르기 
			
        	out.println("<tr><td>" + agegroup + "대</td><td width=500px style=padding-left:0px><div class='bar'>"+
            "<div class='barstyle' style='width:"+ formattedRate+ "%'></div>"+
           "<div>"+currentItem.getVotescount()+ "("+ formattedRate+ "%)</div></div></td></tr>");
            
			agegroupIndex++;  // 인덱스 증가 시켜서 그 다음 리스트값 살펴보기
        
        } else {
            out.println("<tr><td>" + agegroup + "대</td><td width=500px style=padding-left:0px><div class='bar'>"+
                    							"<div class='barstyle' style='width:0.0%'></div>"+
                    							"<div>0(0.0%)</div></div></td></tr>");
        }
    } else {
        out.println("<tr><td>" + agegroup+ "대</td><td width=500px style=padding-left:0px><div class='bar'>"+
												"<div class='barstyle' style='width:0.0%'></div>"+
												"<div>0(0.0%)</div></div></td></tr>"); //데이터가 없다면 0으로 처리 
    }
}

	%>
		</table>
	</div>
</body>
</html>
