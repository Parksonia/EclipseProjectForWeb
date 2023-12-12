<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*, javax.sql.*,java.io.*,java.util.*, 
java.text.*, com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
	String path="\\image"; 
	String savePath = request.getServletContext().getRealPath(path);
    int sizeLimit = 100*1024*1024;		//100MB 제한
	
	
    try{
    MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit,"UTF-8",new DefaultFileRenamePolicy() );
    
    
    String filename = multi.getFilesystemName("file");

    //String title = multi.getParameter("file"); 

 
	out.println(filename);   
     
    }catch(Exception e){
    	
    	e.printStackTrace();
    }
%>	
</body>
</html>