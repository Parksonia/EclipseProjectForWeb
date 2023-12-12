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
  
        div{font-size: medium; font-family: 굴림;line-height:140%; display: inline-block;
        	 }
        a{text-decoration: none;}
        a:active{text-decoration-color: #e73db4;color: #e73db4;}
        a:hover{text-decoration-line: underline;}
    </style>

</head>
<body text="#000000" link="#1e90ff" vlink="#cccccc"> <!--link :방문하지 않은 하이퍼링크색상지정 alink :이미 방문한 하이퍼링크 색상지정-->
    <h4><b></b></h4> <!--표제설정-->
    <!--블록 태그: 항상 새 라인에서 시작하여 출력됨 -<div></div>
        인라인 태그: 블록 속에 삽입되어 블록의 일부가 됨 -<a></a>-->
    <!--&#9654; :특수문자 사용, text에 링크주소 설정 후 iframe 타겟팅함-->
    <div><a href="./hubo.jsp" target="top">&#9654;후보등록</a></div> 
    <div><a href="./tupyo.jsp" target="top">&#9654;투표</a></div>
    <div><a href="./result.jsp" target="top">&#9654;개표결과</a></div>
    <% //<div><a href="./selectAll.jsp" target="right">&#9654;테이블 전체 조회</a></div>
    //<div><a href="./inputForm1.html" target="right">&#9654;추가</a></div>
    //<div><a href="./inputForm2.html" target="right">&#9654;정정/삭제</a></div> %>
    
    
    
       
 <!--<div ><a href="./tag04.html" target="right">&#9654;이미지 맵을 처리하는 태그</a></div>
    <div ><a href="./tag05.html" target="right">&#9654;목록을 정리해 주는 태그</a></div> -->

</body>
</html>