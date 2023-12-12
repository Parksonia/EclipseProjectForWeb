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
    margin: auto;
    padding: 20px;
}

table {
    border-collapse: collapse;
    width: 100%;
}

.container td, .container th {
    border: 1px solid;
    padding: 8px;
}

.container th {
    background-color: #f2f2f2;
}
.button td{
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
                    <td><b>번호</b></td>
                    <td><%=g.getId()%></td>
                </tr>
                <tr>
                    <td><b>제목</b></td>
                    <td><%=g.getTitle()%></td>
                </tr>
                <tr>
                    <td><b>일자</b></td>
                    <td><%=g.getDate()%></td>
                </tr>
                <tr>
                    <td><b>내용</b></td>
                    <td><%=g.getContent()%></td>
                    
                </tr>
            </table>
            <div class="button">
                <table>
                    <tr>
                        <td width="600"></td>
                        <td><input type="button" value="목록" onclick="location.href='gongji_list.jsp'"></td>
                        <td><input type="button" value="수정" onclick="location.href='gongji_update.jsp?key=<%=g.getId()%>'"></td>
                        <td><input type ="button" value="댓글" onclick="location.href='gongji_reinsert.jsp?key=<%=g.getId()%>'"></td>  <!-- 댓글 -->
                        <td><input type ="button" value="삭제" onclick="location.href='gongji_delete.jsp?key=<%=g.getId()%>'"></td>  <!-- 삭제 -->
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
