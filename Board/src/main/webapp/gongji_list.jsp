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
request.setCharacterEncoding("UTF-8"); //한글처리
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>gonji_list</title>
<style>
.container {
	width: 800px;
	height: 100px;
	margin: auto;
	padding: 20px;
}

.container table {
	border-collapse: collapse;
	width: 100%;
	table-layout: fixed;
}

table thead td {
	text-align: center;
}

.container td {
	border: 1px solid;
	padding: 8px;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
	"
}

.button table {
	border-collapse: collapse;
}

.button td {
	border: 0px;
	padding: 8px;
	height: 50px;
}

.button input[type="button"] {
	padding: 8px 16px;
	background-color: #4CAF50;
	color: white;
	border: none;
	cursor: pointer;
	font-size: 14px;
}

.button input[type="button"]:hover {
	background-color: #45a049;
}

.current-page {
	color: red;
	font-weight: bold;
}
</style>

<%
int startNumber=1; //시작 페이지
int countPerPage=20; //페이지출력 행의 수 
int currentPage = 1; //현재페이지를 1페이지로 초기화


try {
   currentPage = Integer.parseInt(request.getParameter("from"));
   // request에서 'from' 파라미터 값을 가져와 현재 페이지로 설정
   countPerPage = Integer.parseInt(request.getParameter("cnt"));
} catch (Exception e) {
   currentPage = 1;
   countPerPage = 20;
}

%>
</head>
<body>
	<div class="container">
		<table>
		<% 	
		
		try{

			GongjiItemDao gongiitemdao = new GongjiItemImpl();
			//gongiitemdao.insertgongjilist(); // insert 까지 

			List<GongjiItem> list = gongiitemdao.GonjiListAll();  // 날짜 오늘 날짜인 경우 new 표시 되야함 
			
			GongjiItemService gonjiitemservice = new GongjiItemServiceImpl(); 
			Pagination pagination =gonjiitemservice.getPagination(currentPage, countPerPage);
			%>
	
			<thead>
				<tr>
					<!--조회수 추가해야함  -->
					<td width="100">번호</td>
					<td width="500">제목</td>
					<td width="100">조회수</td>
					<td width="100">등록일</td>
				</tr>
			</thead>
				<%
				
			      //페이지 설정
			      int cPage = pagination.getC(); //현재페이지 설정
			      startNumber  = (cPage - 1) * countPerPage; //시작을 설정
			      int totalCount = gongiitemdao.totalCount(); //총 데이터 개수
			      	
			      int endPage = 0; //최종페이지
					
			      if (totalCount % countPerPage == 0) { //나머지가 없다면 
			         endPage = totalCount / countPerPage;
			      } else {
			         endPage = (totalCount / countPerPage) + 1;  //나머지 출력이 있으면 페이지 +1
			      }      
			      int startPage = ((currentPage - 1) / 10) * 10 + 1;
					
			   	 %>
							
				
			<% 			
				for(GongjiItem i : list){
							
				%>
					<tr>
					<td width="100"><%=i.getId()%></td>
					
					<td width="500">
						<% 											
					if(i.getRelevel()>0) { // 댓글의 경우 들여쓰기, 댓글 아이콘 추가
					%> <%
					for(int j=0; j<i.getRelevel();j++){
					%> &nbsp&nbsp <% 							
					}
						%> <img src=./arrow.png></img> <%
							} 							
							if(i.getStatus()==-1){
								
								%> <%=i.getTitle()%> <% 
							}else{
							%> <a href="gongji_view.jsp?key=<%=i.getId()%>"><%=i.getTitle()%></a>
						<%
							}
							
					String insertdate = String.valueOf(i.getDate()); // 오늘 날짜 스트링으로 받기 		
					String today = gongiitemdao.getDate();
					if(insertdate.equals(today)){						
					%> <img src=./new.png></img> <%
					}					
					%>
					</td>

					<% 									
					%>
					<td width="100"><%=i.getViewcnt()%></td>
					<td width="100"><%=i.getDate()%></td>
				</tr>
				
				<%							
				}
				%>
		
		</table>


				<div style="text-align: center; margin-top: 10px;">
					<%
      // << 버튼 과  < 버튼 클릭시 
      if (pagination.getPp() == -1) { //Pp가 -1이라면 (1부터 10까지는 앞의 페이지가 없어서 <<을 출력하지 않음)

      } else {
      %>
					<a
						href="gongji_list.jsp?from=<%=pagination.getPp()%>&cnt=<%=countPerPage%>">&lt;&lt;</a>
					<!-- 제일 처음으로 이동하는 링크 -->
					<a
						href="gongji_list.jsp?from=<%=startPage-1%>&cnt=<%=countPerPage%>">&lt;</a>
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
						href="gongji_list.jsp?from=<%=i%>&cnt=<%=countPerPage%>"
						<% if ( i == currentPage) { %> class="current-page" <% } %>> <%=i%>
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
						href="gongji_list.jsp?from=<%=pagination.getN()%>&cnt=<%=countPerPage%>">&gt;</a>
					<!-- 다음 그룹으로 이동하는 링크 -->
					<a href="gongji_list.jsp?from=<%=endPage+1%>&cnt=<%=countPerPage%>"
						<% if(pagination.getNn() == currentPage) { %> class="current-page"
						<% } %>> &gt;&gt; </a>

					<!-- 제일 마지막 페이지로 가는 링크 -->
					<%
      }
      %>
      
				</div>

		<div class="button">
			<form method="post">
				<table>
					<tr>
						<td>
						<td width="650"></td>
						<td><input type="button" value="신규"
							onclick="location.href='gongji_insert.jsp'"></td>
					</tr>
				</table>
			</form>
		</div>
	<% 
	}catch(Exception e){
	
	}
		%>
	</div>
</body>
</html>