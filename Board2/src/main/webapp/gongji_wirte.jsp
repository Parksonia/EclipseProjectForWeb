
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
request.setCharacterEncoding("UTF-8");   //한글처리
%>


<%
String title =request.getParameter("title");
String content =request.getParameter("content");
String key = request.getParameter("key"); // 처음 insert name=key(value='INSERT')/update name=key(value=id)
int rootid = Integer.parseInt(request.getParameter("rootid")); 
int relevel =Integer.parseInt(request.getParameter("relevel"));
int recnt =Integer.parseInt(request.getParameter("recnt"));
int viewcnt = Integer.parseInt(request.getParameter("viewcnt"));
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>gongji_write</title>
</head>
<body>

	<% 
	if (key.equals("INSERT")) {
  
		GongjiItemDao gongjiitemdao =new GongjiItemImpl(); //GongjiItem
		GongjiItem gongjiitem = new GongjiItem (); // setter로 저장 하고 get방식으로 데려온 값 null인지 확인
    
		 if(title !=null && title.trim().length() >0){
				
			 try{
				 
				 boolean success= gongjiitemdao.insertNewGongji(title,content,rootid,relevel,recnt,viewcnt); // title 이 null이 아니면 새로운 글 게시 후 업데이트 하기
			
				 if(success==true){ 
			 %>
				<script>
				alert("등록성공!"); window.location.href='./gongji_list.jsp';	  // 성공 시 다시 리스트로 돌아가기  
				</script>
			<%
				}else{
			%>
				<script>	
				alert("등록실패!"); window.location.href='./gongji_list.jsp';  // 실패 시 돌아갈 화면 링크 걸기 window 어쩌구 
				</script>
		
		
				<% }
		
				}catch(Exception e){
					
				}	
			
		 }
		 
	}else{	 		
			 int insertkey=Integer.parseInt(key);  // update의 key integer로 형변환 필요함 
			 
			GongjiItemDao gongjiitemdao =new GongjiItemImpl(); //GongjiItem
			
			try{
				
				 boolean success= gongjiitemdao.updateGongji(insertkey, title, content);
				 
				if(success==true){
					%>
					<script>
				alert("수정 성공!");	 window.location.href='./gongji_list.jsp';  // 성공 시 화면 링크 걸기 
				</script>
			<%
				}else{
			%>
				<script>	
				alert("수정 실패!");  window.location.href='./gongji_list.jsp';  // 실패 시 돌아갈 화면 링크 걸기 window 어쩌구 
				</script>
		
				<%				
				}
								
			}catch(Exception e){
							 			 
		 }
	}
%>




</body>
</html>