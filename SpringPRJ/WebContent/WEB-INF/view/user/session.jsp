<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String user_no = CmmUtil.nvl((String)session.getAttribute("user_no"));
	String user_type = CmmUtil.nvl((String)session.getAttribute("user_type"));
	String state = CmmUtil.nvl((String)session.getAttribute("state"));
	String user_name = CmmUtil.nvl((String)session.getAttribute("user_name"));
%>

<!--
<%if(CmmUtil.nvl(user_no).equals("")){ %>
<script>
alert("세션이 만료되었습니다.");
location.href = "/user/login_register.do";
</script>
<%}%>
-->
