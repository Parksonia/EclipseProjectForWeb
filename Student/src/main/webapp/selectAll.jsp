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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

.container{
width:800px;
margin: 20px auto;
}
table {
	border-collapse: collapse;
	width: 100%;
}

thead td {
	border-bottom: 1px #444444;
	border: 1px solid #444444;
	text-align: center;
	background-color: #1e90ff;
	color: #f0f8ff;
}

td, tr {
	border: 1px solid;
	padding: 2px;
	width:auto;
}

.pagination {
    display: flex;
    justify-content: center;
	text-align: center;
	margin-top: 20px;
	background-color: #f0f8ff;
	padding: 10px;
}

.pagination a {
	margin: 0 5px;
	text-decoration: none;
	color: #000;
}

.pagination a:hover {
	color: #1e90ff;
}

span > a {
   text-decoration : none;
}

.current-page {
    color: red;
    font-weight: bold;
}

</style>
</style>
<%
int startNumber=1; //시작 페이지
int countPerPage=5; //페이지출력 행의 수 
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
	<% 
	//sellect all	
	//StudentItemDao(최상위 부모)의 객체 생성으로 다른 여러동작(메서드)사용할 수 있고,하나의 인터페이스로 여러객체를 동작할 수 있음 impl의 메서드 호출 가능하다
	//StudentItemDaoImpl 은 StudentItemDao의 구현 클래스다
	
	try{ // 입력된 학생이 있을 경우만 조회되게 함
	
	StudentItemDao studentItemDao = new StudentItemDaoImpl();

	List<StudentItem> studentlist = new ArrayList<StudentItem>();  // 함수 호출하여 반환되는 리스트를 저장하기 위한 리스트 변수 생성 
	studentlist = studentItemDao.selectAll(); //list생성 단위가 studentitem이라는 class이기때문에 getter로 불러와야함	

	StudentItemService studentItemService = new StudentItemServiceImpl(); //pagination 클래스 사용하기 위한 객체 생성

	Pagination pagination =studentItemService.getPagination(currentPage,countPerPage);  //(페이지시작번호,한 화면에 몇개의 행)
	

	%>

	<h2>전체조회</h2>
	<table>
		<thead>
			<tr>
				<td>번호</td>
				<td>이름</td>
				<td>국어</td>
				<td>영어</td>
				<td>수학</td>
				<td>총점</td>
				<td>평균</td>
				<td>등수</td>
			</tr>
		</thead>
		
		 <%
      //페이지 설정
      int cPage = pagination.getC(); //현재페이지 설정
      startNumber  = (cPage - 1) * countPerPage; //시작을 설정
      int total_cnt = studentItemDao.totalCount(); //총 데이터 갯수를 가져옴
      if (total_cnt == 0) { //총 데이터 갯수가 0이라면
      %>
      <h1>등록된 학생 정보가 없습니다.</h1>
      <%
      return;
      } 
      
      StudentItemDaoImpl studentItemDaoImpl = new StudentItemDaoImpl();
      int totalCount = studentItemDaoImpl.totalCount(); //총 데이터 개수
      int endPage = 0; //최종페이지

      if (totalCount % countPerPage == 0) { //나머지가 없다면 
         endPage = totalCount / countPerPage;
      } else {
         endPage = (totalCount / countPerPage) + 1;  //나머지 출력이 있으면 페이지 +1
      }
      
      int startPage = ((currentPage - 1) / 10) * 10 + 1;

		%>
		<tbody>
			<%
			 startNumber = (cPage-1)*countPerPage;  // 데이터 시작 번호 
			int totalcount = studentItemDao.totalCount();  //총 데이터 수 
		
			
			if(totalcount == 0){
				out.println("<h2>등록된 학생 정보가 없습니다.</h2>");			
				return;
			}
			
			//전체 학생을 리스트에 저장하여 한 행씩 가져와 테이블 생성하기
			for (int i = startNumber; i <startNumber+countPerPage;  i++) {  // 전체 학생 출력
				
				if(i >totalcount-1) break;
				
				int sum = (studentlist.get(i).getKor()+studentlist.get(i).getEng()+studentlist.get(i).getMat());  //국영수 총합 리스트에 저장된 값 불러오기 
				double avg = ((int) ((sum / 3.0) * 100)) / 100.0;
				int rank = studentItemDao.scoreRank(studentlist.get(i).getId());
				
				out.println("<tr><td>" + studentlist.get(i).getId() + "</td>");  //학번 
				out.println("<td><a href=./selectOne.jsp?student_id=" +studentlist.get(i).getId() + ">"  
				+ studentlist.get(i).getName() + "</a></td>"); //이름에 링크 걸고 학번 보내기 
				out.println("<td>" + studentlist.get(i).getKor() + "</td>");  // 국어점수
				out.println("<td>" + studentlist.get(i).getEng() + "</td>");  //영어점수
				out.println("<td>" + studentlist.get(i).getMat() + "</td>");  
				out.println("<td>" +sum+ "</td>");
				out.println("<td>" +avg+ "</td>");
				out.println("<td>" +rank+ "</td></tr>");
					
			}
			%>
		</tbody>
		</table>
		<table>
		<tfoot>
  <div style="text-align: center; margin-top: 10px;">
      <%
      // << 버튼 과  < 버튼 클릭시 
      if (pagination.getPp() == -1) { //Pp가 -1이라면 (1부터 10까지는 앞의 페이지가 없어서 <<을 출력하지 않음)

      } else {
      %>
      <a
         href="selectAll.jsp?from=<%=pagination.getPp()%>&cnt=<%=countPerPage%>">&lt;&lt;</a>
      <!-- 제일 처음으로 이동하는 링크 -->
      <a
         href="selectAll.jsp?from=<%=startPage -1%>&cnt=<%=countPerPage%>">&lt;</a>
      <!-- 이전 그룹으로 이동하는 링크 -->
      <%
      }

      //페이지 출력
      for (int i = pagination.getS(); i < pagination.getS() + 10; i++) {
      if (((i - 1) * countPerPage) > total_cnt) {
         break;
      }
      %>
      <span>
         <a href="selectAll.jsp?from=<%=i%>&cnt=<%=countPerPage%>" 
            <% if ( i == currentPage) { %>
               class="current-page"
            <% } %>
         >
            <%=i%>
         </a>
      </span>
      <!-- 현재 페이지를 강조하여 표시 -->
      <%
      }

      // >> 버튼과 >버튼 클릭시 
      if (pagination.getNn() == -1) {
      
      } else {
      %>
      <a href="selectAll.jsp?from=<%=pagination.getN()%>&cnt=<%=countPerPage%>">&gt;</a>
      <!-- 다음 그룹으로 이동하는 링크 -->
      <a href="selectAll.jsp?from=<%=endPage+1%>&cnt=<%=countPerPage%>" <% if (pagination.getNn() == currentPage) { %>
            class="current-page" <% } %> > &gt;&gt; </a>

      <!-- 제일 마지막 페이지로 가는 링크 -->
      <%
      }
      %>
   </div>
   <%
   } catch (Exception e) {
   %>
   
   <%
   }
   %>

		</tfoot>
		</table>
		</div>
</body>
</html>