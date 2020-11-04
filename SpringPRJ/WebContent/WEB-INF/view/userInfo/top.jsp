<%@ page import="static poly.util.CmmUtil.nvl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String user_name = nvl((String) session.getAttribute("user_name"));
%>
<nav class="navbar" style="background-color: gray;">
	<!-- start Top Search -->
	<div class="top-search">
		<div class="input-group">
			<span class="input-group-addon"><i class="fa fa-search"></i></span> 
			<input type="text" class="form-contorl" placeholder="serach"> 
			<span class="input-group-addon close-search" onClick="JavaScript:serch();"><i class="fa fa-times">검색</i></span>
		</div>

	</div>
	<!-- End Top Search -->

	<div class="container">
		<!-- Start Attribute Navigation -->
		<div class="attr-nav">
			<ul>
				<li>
					<% if (user_name.isEmpty()) { %> 		
						<a href="/user/userLogin.do" style="color: #2b2b2b;"> Sign in </a> <%
 					} else {
 					%> <a href="/user/logOut.do" style="color: #2b2b2b;"><%=user_name%>님 Sign Out</a> <%
 					} %>

				</li>
			</ul>
		</div>
		<!-- End Attribute Navigation -->
	</div>

</nav>