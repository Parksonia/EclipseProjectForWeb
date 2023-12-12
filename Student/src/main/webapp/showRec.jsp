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
request.setCharacterEncoding("UTF-8");
%>
<%
// 한글처리
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Show Rec</title>
<style>
table td p {
	text-align: center;
}
 input[type="number"] {
	width: 150px;
}
</style>
</head>
<body>
	<%
	//insert 쿼리문작성하기
	%>
	<%
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://192.168.23.64:33060/kopo15", "root", "5150");//DriverManager.getConnection->mysql 데이터베이스에 연결하기 위한 connection객체생성 
		Statement stmt = con.createStatement();

		String name = "", studentid = "", kor = "", eng = "", mat = ""; //string으로 변수 선언
		int searchid = Integer.parseInt(request.getParameter("searchid"));// post에서 받아옴

		ResultSet rset = stmt.executeQuery("select * from studenttable where studentid=" + searchid + ";");

		// select 로 조회 된 값 하나씩 읽어오기
		while (rset.next()) {

			name = rset.getString(2); // 이름은 2번째임	
			//데이터는 int임 형변환 유의! string으로 변환해줘야함 
			studentid = Integer.toString(rset.getInt(1));
			kor = Integer.toString(rset.getInt(3));
			eng = Integer.toString(rset.getInt(4));
			mat = Integer.toString(rset.getInt(5));
		}
		rset.close();
		stmt.close();
		con.close();
	%>

	<h2>성적 조회 후 정정/삭제</h2>
	<!-- post방식으로 데이터 보냄 -->
	<form method='post' action='showRec.jsp'>
		<table cellspacing=1 width=400 border=0>
			<%
			if (studentid.length() == 0) {

				name = "존재하지않습니다";
			%>
			<%
			} else {
			%>
			<tr>
				<td width=100><p>조회 학번</p></td>
				<td width=200><p>
						<input type="number" min="209901" max="300000" name="searchid"
							maxlength="6" placeholder="ex)209901~300000" value='' required>
					</p></td>
				<td width=100><input type="submit" value="조회"></td>
			</tr>
		</table>
	</form>
	<%
	}
	%>
	<form method='post' name='form'>
		<table cellspacing=1 width=400 border=1>
			<script>
			<!--특수 기호 입력 방지-->
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
			<tr>
				<td width=100><p>이름</p></td>
				<td width=300><p>
						<input type='text' name='u.name' maxlength="10"
							onkeyup="check(this)" placeholder="한글/영어만 입력하세요" required
							value='<%=name%>'>  <!-- onkeypress : space 한칸 입력 가능 주의 -->
					</p></td>
			</tr>

			<tr>
				<td width=100><p>학번</p></td>
				<td width=300><p>
						<input type='text' name='u.studentid' value='<%=studentid%>'
							readonly>
					</p></td>
			</tr>
			<tr>
				<td width=100><p>국어</p></td>
				<td width=300><p>
						<input type='text' pattern="^(?:100|[1-9][0-9]?|0)$" name='u.kor'
							value='<%=kor%>' title="0에서 100사이 숫자를 입력하세요." required>
					</p></td>
			</tr>

			<tr>
				<td width=100><p>영어</p></td>
				<td width=300><p>
						<input type='text' pattern="^(?:100|[1-9][0-9]?|0)$" name='u.eng'
							value='<%=eng%>' title="0에서 100사이 숫자를 입력하세요." required>
					</p></td>
			</tr>
			<tr>
				<td width=100><p>수학</p></td>
				<td width=300><p>
						<input type='text' pattern="^(?:100|[1-9][0-9]?|0)$" name='u.mat'
							value='<%=mat%>' title="0에서 100사이 숫자를 입력하세요." required>
					</p></td>
			</tr>
		</table>
		<%
		if (studentid.length() != 0) {
		%>
		<table cellsapcing=1 width=400 border=0>
			<tr>
				<td width=100></td>
				<td width=100><p>
						<input type="submit" value="수정"
							onclick="javascript: form.action='updateDB.jsp';" />
					</p></td>
				<td width=100><p>
						<input type="submit" value="삭제"
							onclick="javascript: form.action='deleteDB.jsp';" />
					</p></td>
				<td width=100><p>
						<a href="./inputForm2.jsp"> <input type="button" value="뒤로가기"></a>
					</p></td>
			</tr>
		</table>
		<%
		} else if (studentid.length() == 0) {
		%>
		<table cellsapcing=1 width=400 border=0>
			<tr>
				<td width=200></td>
				<td width=100><p>
						<a href="./inputForm2.jsp"> <input type="button" value="뒤로가기"></a>
					</p></td>
			</tr>

			<%
			} else {
			}
			%>
			</form>
			<%
			} catch (Exception e) {
			%>
			<h2>Error</h2>
			<%
			}
			%>
		
</body>
</html>
</body>
</html>