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

}

th {
	background-color: #f2f2f2;
}

.button {
	margin-top: 20px;
	border: 0px;
	border-collapse: collapse;
}
.button table {
	border:0px;
}

.button td {
	border: 0px;
}

.button input[type="button"] {
	background-color: #4CAF50;
	border: none;
	color: white;
	padding: 10px 20px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 14px;
	cursor: pointer;
}

.button input[type="button"]:hover {
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
	<script>
		function submitForm(mode) {
			if (mode == "delete") {
				fm.action = "./stock_delete.jsp";

			} else if (mode == "update") {
				fm.action = "./stock_updateForm.jsp";
			}
			fm.submit();
		}
	</script>
	<%
	String id = request.getParameter("id");

	StockItemDao stockitemdao = new StockItemDaoImpl();
	List<StockItem> listone = stockitemdao.stocklistOne(id);
	%>

	<div class="container">
		<form method="post" name="fm">
			<h3 style= "text-align: center;">(주)트와이스 재고 현황-상품상세</h3>

			<hr width=800>
			<table>
				<tbody>
					<%
					for (StockItem i : listone) {
					%>
					<tr>
						<td><b>상품번호</b></td>
						<td><input type=hidden name=id value=<%=i.getProductId()%>><%=i.getProductId()%></td>
					</tr>
					<td><b>상품명</b></td>
					<td><%=i.getProductName()%></td>
					</tr>
					<td><b>재고현황</b></td>
					<td><%=i.getStockCnt()%></td>
					</tr>
					<td><b>상품등록일</b></td>
					<td><%=i.getInputdate()%></td>
					</tr>
					<td><b>재고등록일</b></td>
					<td><input type=hidden name=checkdate
						value=<%=i.getCheckdate()%>><%=i.getCheckdate()%></td>
					</tr>
					<td><b>상품설명</b></td>
					<td><textarea name=description
								style="width: 100%; height: 100px;" maxlength="155000" readonly><%=i.getDescription()%></textarea></td>
					</tr>
					<td><b>상품사진</b></td>
					<td style="width: 600px; height: 400px;"><img
						src="./image/<%=i.getImg()%>"
						style="max-width: 100%; max-height: 100%;"
						onError="this.src='./image/null.png'"></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
			<div class="button">
				<table>
					<tr>
						<td width="650"></td>

						<td><input type="button" value="목록"
							onclick="location.href='stock_itemlist.jsp'"></td>
						<td><input type="button" value="상품삭제"
							onclick="submitForm('delete')"></td>

						<td><input type="button" value="재고수정"
							onclick="submitForm('update')"></td>
						<!-- 함수 호출해서 post로 데이터 넘김 -->
					</tr>
				</table>
			</div>

		</form>
	</div>

</body>
</html>
