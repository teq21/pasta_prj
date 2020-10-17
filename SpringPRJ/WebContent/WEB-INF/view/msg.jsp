<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="poly.util.CmmUtil" %>
    <%@page import="poly.dto.UserInfoDTO" %>
    
    <%
   
    
    //CONTROLLER부터 전달받은 회원정보입력화면으로 부터 입력받은 데이터
    
    UserInfoDTO pDTO=(UserInfoDTO)request.getAttribute("pDTO");
    
    //controller부터 전달받은 데이터
    String msg=CmmUtil.nvl(pDTO.getUser_name());
    
    
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입을 축하드립니다 </title>
<script type="text/javascript" > 
            alert("<%=msg%> 님 가입 축하합니다.");
            document.location.href="index.do";
 </script>
</head>
<body>
<%-- <%=CmmUtil.nvl(pDTO.getUser_name()) %>님의 회원가입을 축하드립니다. --%>
</body>
</html>