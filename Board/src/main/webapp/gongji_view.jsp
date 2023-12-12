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
int id = Integer.parseInt(request.getParameter("key"));
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>gongji_view</title>
<style>
.container {
    width: 800px;
    height: 100px;
    margin: auto;
    padding: 20px;
}

table {
    border-collapse: collapse;
}

.container td {
    border: 1px solid;
    padding: 8px;
}

.button table {
	border-collapse: collapse;
}

.button td {
	border: 0px;
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

</style>

<script>
function submitForm(mode){
    if(mode == "write"){
        fm.action = "gongji_write.jsp";
    } else if(mode == "delete"){
        fm.action = "gongji_delete.jsp";
    }
    fm.submit();
}
</script>

</head>
<body>
    <div class="container">
        <form method="post" name="fm">
            <table>
                <%
                GongjiItemDao gongjiitemdao = new GongjiItemImpl();
                List<GongjiItem> gongji = gongjiitemdao.GongjiOneView(id);   // 작성 글 번호를 보냄 
                
                for(GongjiItem g: gongji){
					
                %>
                <tr>
                    <td width="100" style="font-weight: bold;">번호</td>
                    <td width="700"><%=g.getId()%></td>
                </tr>
                <tr>
                    <td width="100" style="font-weight: bold;">제목</td>
                    <td width="700"><%=g.getTitle()%></td>
                </tr>
                <tr>
                    <td width="100" style="font-weight: bold;">일자</td>
                    <td width="700"><%=g.getDate()%></td>
                </tr>
                    <tr>
                    <td width="100" style="font-weight: bold;">조회수</td>
                    <td width="700"><%=g.getViewcnt()%></td>
                                                            
                </tr>
                <tr>
                    <td width="100" style="font-weight: bold;">내용</td>
                    <td width="700"><textarea style="width:700px; height:250px;" name=content rows="600" cols="70"readonly><%=g.getContent()%></textarea></td>
                                                            
                </tr>
                   <tr>
                    <td width="100" style="font-weight: bold;">원글</td>
                    <td width="700"><%=g.getRootid()%></td>
                                                            
                </tr>
                   <tr>
                    <td width="100" style="font-weight: bold;">댓글수준</td>
                    <td width="700"><%=g.getRelevel()%></td>
                                                            
                </tr>
                   <tr>
                    <td width="100" style="font-weight: bold;">댓글내순서</td>
                    <td width="700"><%=g.getRecnt()%></td>
                                                            
                </tr>
              
               
            </table>
            <div class="button">
                <table>
                    <tr>
                        <td width="600"></td>
                        <td><input type="button" value="목록" onclick="location.href='gongji_list.jsp'"></td>
                        <td><input type="button" value="수정" onclick="location.href='gongji_update.jsp?key=<%=g.getId()%>&rootid=<%=g.getRootid()%>&relevel=<%=g.getRelevel()%>&recnt=<%=g.getRecnt()%>'"></td>
                        <td><input type ="button" value="댓글" onclick="location.href='gongji_reinsert.jsp?key=<%=g.getId()%>&rootid=<%=g.getRootid()%>&relevel=<%=g.getRelevel()%>&recnt=<%=g.getRecnt()%>'"></td> <!-- 댓글 -->
                        <td><input type ="button" value="삭제" onclick="location.href='gongji_delete.jsp?key=<%=g.getId()%>&rootid=<%=g.getRootid()%>&relevel=<%=g.getRelevel()%>&recnt=<%=g.getRecnt()%>'"></td>  <!-- 삭제 -->
                    </tr>
                </table>
            </div>
            <%
            }
            %>
        </form>
    </div>
</body>
</html>
