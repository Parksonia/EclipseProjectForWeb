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
	border-collapse: collapse;
	width: 100%;
}

.container table, th, td {
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
}

.button table {
	border: none;
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

.current-page {
	color: red;
	font-weight: bold;
}
</style>
<%
int startNumber = 1; //시작 페이지
int countPerPage = 5; //페이지출력 행의 수 
int currentPage = 1; //현재페이지를 1페이지로 초기화

try {
	currentPage = Integer.parseInt(request.getParameter("from"));
	// request에서 'from' 파라미터 값을 가져와 현재 페이지로 설정
	countPerPage = Integer.parseInt(request.getParameter("cnt"));
} catch (Exception e) {
	currentPage = 1;
	countPerPage = 5;
}
%>
</head>
<body>
	<div class="container">
		<h3 style="text-align: center;">(주)트와이스 재고 현황-전체</h3>

		<hr width=800>
		
		<table>
			<tr>
				<th>상품번호</th>
				<th>상품명</th>
				<th>재고수량</th>
				<th>재고파악일</th>
				<th>상품등록일</th>
			</tr>
			<%
		try {
			StockItemDao stockitemdao = new StockItemDaoImpl();
			List<StockItem> listall = stockitemdao.stocklistAll(); // 함수 호출해서 리스트 저장
			StockItemService stockitemservice = new StockItemServiceImpl(); //pagination 클래스 사용하기 위한 객체 생성

			Pagination pagination = stockitemservice.getPagination(currentPage, countPerPage); //(페이지시작번호,한 화면에 몇개의 행)
		%>
			
			
			<%
			//페이지 설정
			int cPage = pagination.getC(); //현재페이지 설정
			startNumber = (cPage - 1) * countPerPage; //시작을 설정
			int totalCount = stockitemdao.totalCount(); //총 데이터 개수
			int endPage = 0; //최종페이지

			if (totalCount % countPerPage == 0) { //나머지가 없다면 
				endPage = totalCount / countPerPage;
			} else {
				endPage = (totalCount / countPerPage) + 1; //나머지 출력이 있으면 페이지 +1
			}
			int startPage = ((currentPage - 1) / 10) * 10 + 1;

			if (totalCount == 0) {
				out.println("<h2>등록된 상품이 없습니다.</h2>");
				return;
			}
			%>

			<tbody>
				<%
				for (int i = startNumber; i < startNumber + countPerPage; i++) { // 전체 리스트 출력
					if (i > totalCount - 1)
						break;
				%>
				<tr>
					<td width="100">
						<p>
							<a href="stock_oneview.jsp?id=<%=listall.get(i).getProductId()%>"><%=listall.get(i).getProductId()%></a>
						</p>
					</td>
					<td width="300">
						<p>
							<a href="stock_oneview.jsp?id=<%=listall.get(i).getProductId()%>"><%=listall.get(i).getProductName()%></a>
						</p>
					</td>
					<td width="100">
						<p><%=listall.get(i).getStockCnt()%></p>
					</td>
					<td width="100">
						<p><%=listall.get(i).getCheckdate()%></p>
					</td>
					<td width="100">
						<p><%=listall.get(i).getInputdate()%></p>
					</td>
				</tr>
				<%
				}
				%>
			</tbody>

		<div style="text-align: center; margin-top: 10px;">
			<%
			// << 버튼 과  < 버튼 클릭시 
			if (pagination.getPp() == -1) { //Pp가 -1이라면 (1부터 10까지는 앞의 페이지가 없어서 <<을 출력하지 않음)

			} else {
			%>
			<a
				href="stock_itemlist.jsp?from=<%=pagination.getPp()%>&cnt=<%=countPerPage%>">&lt;&lt;</a>
			<!-- 제일 처음으로 이동하는 링크 -->
			<a
				href="stock_itemlist.jsp?from=<%=startPage - 1%>&cnt=<%=countPerPage%>">&lt;</a>
			<!-- 이전 그룹으로 이동하는 링크 -->
			<%
			}

			//페이지 출력
			for (int i = pagination.getS(); i < pagination.getS() + 10; i++) {
			if (((i - 1) * countPerPage) > totalCount) {
				break;
			}
			%>
			<span> <a
				href="stock_itemlist.jsp?from=<%=i%>&cnt=<%=countPerPage%>"
				<%if (i == currentPage) {%> class="current-page" <%}%>> <%=i%>
			</a>
			</span>
			<!-- 현재 페이지를 강조하여 표시 -->
			<%
			}
			// >> 버튼과 >버튼 클릭시 
			if (pagination.getNn() == -1) {

			} else {
			%>
			<a
				href="stock_itemlist.jsp?from=<%=pagination.getN()%>&cnt=<%=countPerPage%>">&gt;</a>
			<!-- 다음 그룹으로 이동하는 링크 -->
			<a
				href="stock_itemlist.jsp?from=<%=endPage + 1%>&cnt=<%=countPerPage%>"
				<%if (pagination.getNn() == currentPage) {%> class="current-page"
				<%}%>> &gt;&gt; </a>

			<!-- 제일 마지막 페이지로 가는 링크 -->
			<%
			}
			%>
			
		</div>
		
		<div class="button">
			<table>
				<tr>
					<td width="650"></td>
					<td><input type="button" value="신규등록"
						onclick="location.href='stock_insertForm.jsp'"></td>
				</tr>
		</div>


	</div>
	<%
	} catch (Exception e) {

	}
	%>
	
</body>
</html>
