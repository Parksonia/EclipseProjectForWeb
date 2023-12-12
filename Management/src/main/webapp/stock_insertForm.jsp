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
<title>Stock_List</title>
<style>
.container {
	width: 800px;
	height: 100px;
	margin: auto;
	padding: 20px;
}
table {
	width: 100%;
	border-collapse: collapse;
}

table, th, td {
	border: 1px solid black;
}

th, td {
	padding: 10px;
	text-align: center;
}

th {
	background-color: #f2f2f2;
}

.button {
	margin-top: 20px;
	border: 0px;
	border-collapse: collapse;
	width: 800px;
}
.button table{ 
	border :0px;
}

.button td {
	border: 0px;
}

.button input[type="submit"] {
	background-color: #4CAF50;
	border: none;
	color: white;
	padding: 10px 20px;
	text-align: center;
	text-decoration: none;
	font-size: 14px;
	cursor: pointer;
}

.button input[type="submit"]:hover {
	background-color: #45a049;
}

.button a {
	text-decoration: none;
	color: inherit;
}

.button a:hover {
	text-decoration: underline;
}

</style>
</head>
<body>
	<!--
		이미지 업로드 방법 1   // 이미지파일 쪼개기
		<script>
		function imageToBase64 (t) {  
			var reader = new FileReader();
			reader.readAsDataURL(t.files[0]);
			reader.onload = function (e) {
				document.getElementById('img').src = e.target.result;
				document.getElementById('pic_addr').value = e.target.result;
			}
		}
	</script>
	  -->

	<script>
		// 업로드 사진 미리보기 기능 + 이미지 파일만 가능하도록 함 

		 function isImageFile(fileName) { //파일 확장자 제한하기 위해 파일이름 받아와서 확장자 확인
		       var extension = fileName.substring(fileName.lastIndexOf('.') + 1); // . 기준으로 자른 뒤 확장자명 담기
		       var allowedExtensions = ["jpg", "jpeg", "png", "gif"]; //이미지 확장자로만 제한
		       return allowedExtensions.some(function (allowedExtension) {
		         return extension.toLowerCase() === allowedExtension.toLowerCase(); //대소문자 구분 안함
		       });
		   }	  
		  function readURL(input) { //파일 업로드할 때 설정
		       
			  if (input.files && input.files[0]) { //파일이 선택되었는지 확인
		         var file = input.files[0]; //업로드한 파일
		         var fileName = file.name; //해당 파일 이름

		         if (isImageFile(fileName)) { //해당 파일 이름이 유효할 경우
		           var imgInput = document.getElementById('preview'); //img 태그 요소 id로 찾아오기
		           imgInput.value = fileName; //입력창에 파일 이름 넣기
		           imgInput.readOnly = true; //입력값 읽기만 가능하도록 설정
		           imgInput.required = true; //입력값 필수값으로 설정

		           var reader = new FileReader(); //파일 읽기위한 객체
		           reader.onload = function(e) { //파일 읽어서 데이터 가져오기
		             document.getElementById('preview').src = e.target.result;
		           }; //파일 업로드 했을 때 미리보기 띄우기 -> img태그에서 해당 파일 보여주기
		           reader.readAsDataURL(file);
		         } else {
		           alert("이미지 파일(jpg, jpeg, png, gif)만 업로드할 수 있습니다."); //이미지 파일이 아니면 알림창 띄우기
		           input.value = ""; //입력값 초기화
		           document.getElementById('preview').src = ""; //img태그 미리보기 사진 소스도 초기화
		         }
		       } else { // 사진 선택이 안됐다면
		         document.getElementById('preview').src = ""; //파일 업로드 전까지 미리보기 사진 소스 없음
		         document.getElementById('preview').value = null; // Set the value to null if no image is selected
		       }
		     }

	  
	</script>

	<%
	StockItemDao stockitemdao = new StockItemDaoImpl();
	String today = stockitemdao.getDate();
	%>

	<div class="container">
		<form method="post" action='stock_insert.jsp'enctype="multipart/form-data">
			
			<h3 style="text-align :center;">(주)트와이스 재고 현황-상품신규</h3>
			<hr width=800>
			<table>
				<tbody>
					<tr>
						<td><b>상품번호</b></td>
						<td><input type='text' name=productid  pattern="^[0-9]*$" minlength="13" maxlength="13"
							 style="width: 200px; text-align: center;" required></td>
					</tr>
					<tr>
						<td><b>상품명</b></td>

						<!-- pattern="^[ㄱ-ㅎ가-힣a-zA-Z0-9]*$" pattern="[A-Za-z0-9\uAC00-\uD7A3\s]" -->
						<!-- 스페이스바 등록 안되게  -->
						<td><input type='text' name=name size=30 maxlength=30
							pattern="^[ㄱ-ㅎ가-힣a-zA-Z0-9\s]*$" 
							style="width: 200px; text-align: center;"required></td>
					</tr>
					<tr>
						<td><b>재고현황</b></td>
						<td><input type='number' name=cnt min=0 max=100 
							 style="width: 200px; text-align: center;"required></td>
					</tr>
					<tr>
						<td><b>상품등록일</b></td>
						<td><%=today%></td>
					</tr>
					<tr>
						<td><b>재고등록일</b></td>
						<td><%=today%></td>
					</tr>

					<tr>
						<td><b>상품설명</b></td>
						<td><textarea name=description
								style="width: 100%; height: 100px;" maxlength="155000"required></textarea></td>
					</tr>
					<tr>
						<td><b>상품사진</b></td>
						<td style="width: 600px; height: 400px;"><img
							style="max-width: 100%; max-height: 100%;" id="preview" /> <input
							type="file" name=file onchange="readURL(this)"></td>
					</tr>
				</tbody>
			</table>
			<!-- 
				이미지 업로드 방법 1 
				<img id="img" src="" alt="" width=800px><br> 
				<input type ="file" onchange="imageToBase64(this)"><br>
				<input type="text" name=img id="pic_addr" value=""></td> -->
			<div class="button">
				<table>
					<tr>
						<td width="650"></td>
						<td><input type="submit" value="취소"
							onclick="location.href='stock_itemlist.jsp'"></td>
						<td><input type="submit" value="완료"></td>
						<!-- name value들을 다 보내야함!=>int productid, String name, int cnt, String description-->
					</tr>
				</table>
			</div>
		</form>
	</div>
</body>
</html>
