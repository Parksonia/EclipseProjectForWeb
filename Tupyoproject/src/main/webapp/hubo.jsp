
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Insert title here</title>
</head>
<body>

   <form method='post' action='hubo.jsp'> <!-- 아래 폼을 다 채우고 실행은 insertDB.jsp로 간다 -->
      <table cellspacing=1 width=400 border=0>
         <tr>
            <td width=300></td>
            <td width=100><input type="submit" value="추가"></input></td>
         </tr>
      </table>
      
      <table cellspacing=1 width=400 border=1>
         <tr>
            <td width=100><p align=center>이름</p></td>
            <td width=300><p align=center><input type='text' name='name' value=''></input</p></td>
         </tr>
         <tr>
            <td width=100><p align=center>학번</p></td>
            <td width=300><p align=center>자동부여</p></td> <!-- 학번은 자동으로 맨 뒷번호등으로 부여된다 -->
         </tr>
         <tr>
            <td width=100><p align=center>국어</p></td>
            <td width=300><p align=center><input type='number' min='0' max='100' name='kor' value=''></input</p></td>
         </tr>
         <tr>
            <td width=100><p align=center>영어</p></td>
            <td width=300><p align=center><input type='number' min='0' max='100'name='eng' value=''></input</p></td>
         </tr>
         <tr>
            <td width=100><p align=center>수학</p></td>
            <td width=300><p align=center><input type='number' min='0' max='100'name='mat' value=''></input</p></td>
         </tr>
      </table>
      
   </form>
   
</body>
</html>