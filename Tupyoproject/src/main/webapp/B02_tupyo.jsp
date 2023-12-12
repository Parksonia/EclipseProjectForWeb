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
<title>B02_tupyo</title>
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
    margin-top :80px;
}

table {
    border-collapse: collapse;
    width: 100%;
}

table th,
table td {
    padding: 10px;
    border: 1px solid #ccc;
}

table th {
    background-color: #f0f0f0;
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
</style>
</head>
<body>
    <% 
        //get 으로 받아오기
        int votekiho = Integer.parseInt(request.getParameter("hubo")); // 후보의 value 인기호번호를 데이터로 갖고옴
        int ageGroup = Integer.parseInt(request.getParameter("agegroup")); // 연령대의 value값들을 받아옴 (10~90)
        
        TupyoDao tupyodao1 = new TupyoDaoImpl();
        boolean success = tupyodao1.insertVoteData(votekiho, ageGroup); // 함수 호출하여 데이터 보냄 -> 테이블에 투표가 insert
        
        if (success) {
    %>
    <script>
        alert('투표 완료.');
    </script>
    <% } else { %>
    <script>
        alert('투표에 실패했습니다.');
    </script>
    <% } %>
    
    
	<div class="icons">
		<a href="./A01_hubo.jsp" class="button">후보등록</a> <a
			href="./B01_tupyo.jsp" class="button">투표</a> 
			<a href="./C01_voteresult.jsp"class="button">개표결과</a>
	</div>

    <div class="container">
        <table>
            <tbody>
                <tr>
                    <td>
                        <p>
                            <%
                                TupyoDao tupyodao2 = new TupyoDaoImpl();
                                int totalVoter = tupyodao2.totalVoteCount();
                                out.println("총 투표 수는 [ " + totalVoter + " ] 입니다.");
                            %>
                        </p>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</body>
</html>
