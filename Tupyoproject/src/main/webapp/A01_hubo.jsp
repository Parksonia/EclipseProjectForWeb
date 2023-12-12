<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="kr.ac.kopo.ctc.kopo15.dao.TupyoDao"%>
<%@ page import="kr.ac.kopo.ctc.kopo15.dao.TupyoDaoImpl"%>
<%@ page import="kr.ac.kopo.ctc.kopo15.domain.TupyoItem"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>A01_hubo</title>
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
	margin-top: 80px;
}

table {
	border-collapse: collapse;
	width: 100%;
}

table th, table td {
	padding: 10px;
	border: 1px solid #ccc;
}

table th {
	background-color: #f0f0f0;
}

form {
	margin-bottom: 10px;
}

input[type="number"], input[type="text"] {
	width: 100%;
	padding: 0;
	border: 1px solid #ccc;
	border-radius: 3px;
}

input[type="submit"], input[type="button"], a.button {
	padding: 10px;
	border: none;
	background-color: #e7b7d2;
	color: #fff;
	cursor: pointer;
	text-decoration: none;
	display: inline-block;
	border-radius: 5px;
}

input[type="submit"]:hover, input[type="button"]:hover, a.button:hover {
	background-color: #e75d80;
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

</style>

</head>
<body>

	<div class="icons">
		<a href="./A01_hubo.jsp" class="button" style="background-color: #e75d80;">후보등록</a> <a
			href="./B01_tupyo.jsp" class="button">투표</a> <a
			href="./C01_voteresult.jsp" class="button">개표결과</a>
	</div>

	<div class="container">
		<table>
			<thead>
				<tr>
					<th width="100">기호</th>
					<th width="300">후보명</th>
					<th width="100"></th>
				</tr>
			</thead>
			<tbody>
				<form method="post" action="A03_hubodelete.jsp">
					<%
					TupyoDao tupyodao = new TupyoDaoImpl();
					List<TupyoItem> hubolist = tupyodao.selectAll();  // 함수 호출하여 전체 후보 리스트 가져옴 

					for (TupyoItem hubo : hubolist) {
					%>
					<tr>
						<td width="100"><%=hubo.getKiho()%></td>
						<td width="300"><%=hubo.getName()%></td>
						<td width="100">
							<button type="submit" name="kiho" value="<%=hubo.getKiho()%>"
								class="button">삭제</button>  <!-- 기존 등록된 후보 삭제 , value로 등록된 기호번호를 post방식으로 보냄 -->
						</td>
					</tr>
					<%
					}
					%>
				</form>
				<tr>
					<script>
						function check(obj) {
							//정규식으로 특수문자 판별  /[a-z0-9]| 영어 숫자도 포함시킬 수 있다
							var regExp = /\s|[0-9]|[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;

							//배열에서 하나씩 값을 비교
							if (regExp.test(obj.value)) {
								//값이 일치하면 문자를 삭제
								obj.value = obj.value.replace(regExp, '');
							}
						}
					</script>
					<form method="post" action="A02_huboadd.jsp">
						<%
						int newkiho = tupyodao.newKiho();   // 함수 호출하여 사전 부여된 기호번호를 가져옴
						%>
						<td width="100"><input type="number" value="<%=newkiho%>"
							name="kiho" readonly></td>
						<td width="300"><input type="text" name="name"
							pattern="^[ㄱ-ㅎ가-힣a-zA-Z0-9]*$" title="이름을 입력하세요."  value=""required  maxlength="15"></td>
						<!-- required:필수로 입력되게함 -->
						<td width="100"><input type="submit" value="등록"></td> <!--새로운 후보 추가 value로 사전 부여된 기호번호를 post방식으로 보냄  -->
					</form>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>
