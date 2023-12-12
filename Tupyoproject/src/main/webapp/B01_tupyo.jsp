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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>B01_tupyo</title>
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
	background-color: #fff;
	border: 1px solid #ccc;
	border-radius: 5px;
	padding: 20px;
}

.icons {
	display: flex;
	justify-content: center;
	margin-bottom: 20px;
}

.icons a {
	display: flex;
	align-items: center;
	margin-right: 10px;
	color: #fff;
	text-decoration: none;
	padding: 10px;
	background-color: #e7b7d2;
	border-radius: 5px;
}

.icons a:hover {
	background-color: #e75d80;
}

.container table {
	border-collapse: collapse;
	width: 100%;
	margin-top: 20px;
}

.container table th,
.container table td {
	padding: 10px;
	
	text-align: center;
}

.container table th {
	background-color: #f0f0f0;
}

.container input[type="submit"] {
	padding: 8px;
	border: none;
	background-color: #e7b7d2;
	color: #fff;
	cursor: pointer;
	border-radius: 5px;
}

.container input[type="submit"]:hover {
	background-color: #e75d80;
}

.container select { /*select 박스 크기 조절*/
	height: 40px; 
	width: 100%; 
}

</style>
</head>
<body>

	<div class="icons">
		<a href="./A01_hubo.jsp" class="button">후보등록</a>
		<a href="./B01_tupyo.jsp" class="button" style="background-color: #e75d80;">투표</a>
		<a href="./C01_voteresult.jsp" class="button">개표결과</a>
	</div>
	<div class="container">
		<% 
			TupyoDao tupyodao = new TupyoDaoImpl();
			List<TupyoItem> hubolist = tupyodao.selectAll();  // 전체 후보 갖고 오기 
		%>
		<table>
			<form method="post" action="./B02_tupyo.jsp"> <!-- 투표버튼으로 데이터 보내기 -->
				<tr>
					<td width="250">
						<label for="hubo">후보</label>
						<select name="hubo" width="150" required> <!--"hubo" 데이터를 전송하게됨  -->
							<option value="" selected>기호를 선택하세요</option>
							<% 
								for(TupyoItem hubo :hubolist) {
									out.println("<option value="+hubo.getKiho()+">"+hubo.getKiho()+"번   "+hubo.getName()+"</option>");  //post hubo으로 value인 기호번호를 보내게 됨
								}
							%>
						</select>
					</td>
					<td width="250">
						<label for="agegroup">연령</label>
						<select name="agegroup" required>
							<option value="" selected>연령을 선택해주세요</option>							
							<option value="10">10대</option>
							<option value="20">20대</option>
							<option value="30">30대</option>
							<option value="40">40대</option>
							<option value="50">50대</option>
							<option value="60">60대</option>
							<option value="70">70대</option>
							<option value="80">80대</option>
							<option value="90">90대</option>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="투표" required>
					</td>
				</tr>
			</form>
		</table>
	</div>
    
    <script>
        const form = document.querySelector('#myForm');
        const selectElement = document.querySelector('#votekiho');

        form.addEventListener('submit', (event) => {
            event.preventDefault(); // 폼 전송 막기

            const selectedOption = selectElement.value; // 선택된 옵션의 값 가져오기
            if (selectedOption === '') {
                alert('기호를 선택하세요.'); // 선택되지 않은 경우 경고창 표시
            } else {
                // 선택된 옵션의 값을 전송하고자 하는 URL로 설정하여 폼 전송
                form.action = './B02_tupyo.jsp'; // 결과페이지 URL을 적절한 값으로 변경
                form.submit();
            }
        });
    </script>
</body>
</html>
