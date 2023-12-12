<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>항목입니다.</title>
<style>
  
  <style>
body {
    font-family: 굴림;
    color: #000000;
}

div {
    font-size: medium;
    line-height: 140%;
    display: block;
    padding: 15px;
    border: 1px solid #ccc;
    margin-bottom: 30px;
    background-color: #f0f8ff;
}

a {
    text-decoration: none;
    color: #1e90ff;
}

a:active {
    text-decoration-color: #e73db4;
    color: #e73db4;
}

a:hover {
    text-decoration-line: underline;
}
hr {
    margin: 20px 0;
    border: none;
    border-top: 1px solid #ccc;
}
</style>
  	            <!-- div 항목에 스타일 효과(bgcolor 주어 박스 형태로 보이게함  -->
</head>
<body  link="#1e90ff" vlink="#cccccc"> <!--link :방문하지 않은 하이퍼링크색상지정 alink :이미 방문한 하이퍼링크 색상지정-->
   
    <!--블록 태그: 항상 새 라인에서 시작하여 출력됨 -<div></div>
        인라인 태그: 블록 속에 삽입되어 블록의 일부가 됨 -<a></a>-->
   
    <!--&#9654; :특수문자 사용, text에 링크주소 설정 후 iframe 타겟팅함-->
    <div><a href="./createTBL.jsp" target="right">&#9654;테이블 생성</a></div>   <!-- div에 링크를 두어 iframe name="right"이라고 정해진 위치에 링크가 이동됨 -->
    <div><a href="./dropTBL.jsp" target="right">&#9654;테이블 삭제</a></div>
    <div><a href="./insert.jsp" target="right">&#9654;테이블 값 넣기</a></div>
    <hr>
    <div><a href="./selectAll.jsp" target="right">&#9654;테이블 전체 조회</a></div>
    <div><a href="./inputForm1.jsp" target="right">&#9654;추가</a></div>
    <div><a href="./inputForm2.jsp" target="right">&#9654;정정/삭제</a></div>
    
    

</body>
</html>