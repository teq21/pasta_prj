<%@page import="poly.dto.UserInfoDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../user/session.jsp" %>
<%
	UserInfoDTO uDTO = (UserInfoDTO)request.getAttribute("uDTO");
	//UserDTO uDTO = (UserDTO)request.getAttribute("uDTO");
	//String userTypeKor = "일반 사용자";
%>
<%
	if(uDTO == null) {
		uDTO = new UserInfoDTO();
	}
%>

<!DOCTYPE html>
<html class="no-js" lang="ko">
<head>
<%if(CmmUtil.nvl(user_no).equals("")){ %>
<script>
alert("로그인이 필요합니다.");
location.href = "/index.do";
</script>
<%}%>
<meta charset="utf-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>마이페이지</title>
<style>
.head {
	text-align: center;
}

.myPageTable {
	text-align: center;
	width: 1000px;
	height: 300px;
	margin: auto;
	font-size: 18px;
}

.mytd {
	width: 300px;
	background-color: #F2F2F2;
}

.myButton {
	text-align: center;
}

#oddButton {
	background-color: #F2F2F2;
}

* {
	font-family: "Spoqa Han Sans", sans-serif;
}

.white {
    color: white;
    margin-left: 24px;
    font-weight: bold;
}
</style>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- favicon
		============================================ -->
<link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico">
<!-- Google Fonts
		============================================ -->
<link
	href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,700,900"
	rel="stylesheet">
<!-- Bootstrap CSS
		============================================ -->
<link rel="stylesheet" href="/css/bootstrap.min.css">
<!-- font awesome CSS
		============================================ -->
<link rel="stylesheet" href="/css/font-awesome.min.css">
<!-- owl.carousel CSS
		============================================ -->
<link rel="stylesheet" href="/css/owl.carousel.css">
<link rel="stylesheet" href="/css/owl.theme.css">
<link rel="stylesheet" href="/css/owl.transitions.css">
<!-- meanmenu CSS
		============================================ -->
<link rel="stylesheet" href="/css/meanmenu/meanmenu.min.css">
<!-- animate CSS
		============================================ -->
<link rel="stylesheet" href="/css/animate.css">
<!-- normalize CSS
		============================================ -->
<link rel="stylesheet" href="/css/normalize.css">
<!-- mCustomScrollbar CSS
		============================================ -->
<link rel="stylesheet"
	href="/css/scrollbar/jquery.mCustomScrollbar.min.css">
<!-- Notika icon CSS
		============================================ -->
<link rel="stylesheet" href="/css/notika-custom-icon.css">
<!-- wave CSS
		============================================ -->
<link rel="stylesheet" href="/css/wave/waves.min.css">
<!-- main CSS
		============================================ -->
<link rel="stylesheet" href="/css/main.css">
<!-- style CSS
		============================================ -->
<link rel="stylesheet" href="/css/style.css">
<!-- responsive CSS
		============================================ -->
<link rel="stylesheet" href="/css/responsive.css">
<!-- modernizr JS
		============================================ -->
<script src="js/vendor/modernizr-2.8.3.min.js"></script>
</head>

<body>
	<!--[if lt IE 8]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
	<!-- 로고, 세션 적용한 상단 헤더 영역 시작 -->
   <div class="header-top-area">
      <div class="container">
         <div class="row">
            <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
               <div class="logo-area">
                  <a href="/index.do"><img src="/img/logo/dblogo.png" alt="" /></a>
               </div>
            </div>
            <div class="area_gnb" style="margin-top: 25px; float:right">
            	<%if(user_type.equals("1") && state.equals("0")) { %>
            	<b class="white"><%=user_name %>님, 환영합니다!</b>
            	<a href="user/logout.do" class="white">로그아웃</a>
            	<b class="white"> | </b> <a href="/user/myPage.do"
                     class="white"> 마이페이지</a>
                <%} else {%>
            	<a href="/user/login_register.do" class="white"> 로그인 </a> 
            	<b class="white"> | </b> <a href="/user/myPage.do"
                     class="white"> 마이페이지</a>
                <%} %>
               </div>
         </div>
      </div>
   </div>
   <!-- 로고, 세션 적용한 상단 헤더 영역 끝 -->
	
	<!--네비게이션바 시작 (원래는 main menu area 임)  -->
   <div class="main-menu-area mg-tb-40" id="ksb">
      <div class="container">                    
         <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
               <ul class="nav nav-tabs notika-menu-wrap menu-it-icon-pro" id="x">
                  <li><a data-toggle="tab" onclick="location.href='/index.do'"; style="cursor: pointer;"><i
                        class="notika-icon notika-house" style="font-weight:1000;"></i> Home</a></li>
                  <li><a data-toggle="tab" href="#mailbox"><i
                        class="notika-icon notika-search" style="font-weight:1000;"></i> 수화사전</a></li>
                  <li><a data-toggle="tab" onclick="location.href='/quiz.do'"; style="cursor: pointer;"><i
                        class="notika-icon notika-edit" style="font-weight:1000;"></i> 문제풀이</a></li>
                  <li><a data-toggle="tab" onclick="location.href='/study/studyList.do'"; style="cursor: pointer;" ><i
                          class="notika-icon notika-menus" style="font-weight:1000;"></i> 학습게시판</a></li>
                  <li class="active"><a data-toggle="tab" onclick="location.href='/map.do'"; style="cursor: pointer;"><i
                        class="notika-icon notika-next" style="font-weight:1000;"></i> 맵</a></li>
                  <li><a data-toggle="tab" onclick="location.href='/notice/noticeList.do'"; style="cursor: pointer;"><i
                        class="notika-icon notika-form" style="font-weight:1000;"></i>공지사항</a></li>
                 
               </ul>
               <div class="tab-content custom-menu-content">
                  <div id="Home"
                     class="tab-pane in notika-tab-menu-bg animated flipInX">
                   
                  </div>
                  <div id="mailbox"
                     class="tab-pane notika-tab-menu-bg animated flipInX">
                     <ul class="notika-main-menu-dropdown">
                     <li><a href="inbox.html"></a></li>
                        <li><a onclick="location.href='/signBook/signBookList.do'"; style="cursor: pointer;">한글 수화</a></li>
                        <li><a onclick="location.href='/EsignBookList.do'"; style="cursor: pointer;">영어 수화</a></li>
                        
                     </ul>
                  </div>
                  <div id="Interface"
                     class="tab-pane notika-tab-menu-bg animated flipInX">
                  </div>
                  <div id="Charts"
                     class="tab-pane notika-tab-menu-bg animated flipInX">
                  </div>
                  <div id="Tables"
                     class="tab-pane active notika-tab-menu-bg animated flipInX">
                  </div>
                  <div id="Forms"
                     class="tab-pane notika-tab-menu-bg animated flipInX">
                  </div>
                  <div id="Appviews"
                     class="tab-pane notika-tab-menu-bg animated flipInX">
                  </div>
                  <div id="Page"
                     class="tab-pane notika-tab-menu-bg animated flipInX">
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
   <!--네비게이션바 끝 (원래는 main menu area 임)  -->
	
	<!-- 제목 영역-->
	<div class="breadcomb-area">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="breadcomb-list"
						style="background: #fff; box-shadow: 0 6px 10px rgba(0, 0, 0, .08), 0 0 6px rgba(0, 0, 0, .05); transition: .3s transform cubic-bezier(.155, 1.105, .295, 1.12), .3s box-shadow, .3s -webkit-transform cubic-bezier(.155, 1.105, .295, 1.12); cursor: pointer;">

						<div class="row head">
							<h2>마이페이지</h2>
						</div>

					</div>
					<br>
					<!-- 내용(표) 영역 -->
					<div class="breadcomb-list"
						style="background: #fff; box-shadow: 0 6px 10px rgba(0, 0, 0, .08), 0 0 6px rgba(0, 0, 0, .05); transition: .3s transform cubic-bezier(.155, 1.105, .295, 1.12), .3s box-shadow, .3s -webkit-transform cubic-bezier(.155, 1.105, .295, 1.12); cursor: pointer;">
						<div class="row">
							<table class="myPageTable" border=1>
								<tbody>
									<tr>
										<td class="mytd">이름</td>
										<td><%=CmmUtil.nvl(uDTO.getUser_name()) %></td>
									</tr>
									<tr>
										<td class="mytd">이메일</td>
										<td><%=CmmUtil.nvl(uDTO.getEmail()) %></td>
									</tr>
									<tr>
										<td class="mytd">가입일</td>
										<td><%=CmmUtil.nvl(uDTO.getReg_dt()) %></td>
									</tr>
									<tr>
										<td class="mytd">수화 경험</td>
										<td><%=CmmUtil.nvl(uDTO.getHave_sign()) %></td>
									</tr>
									<tr>
										<td class="mytd">휴대폰 번호</td>
										<td><%=CmmUtil.nvl(uDTO.getPhone()) %></td>
									</tr>
								</tbody>
							</table>
							<br>
							
							<div class="myButton">
								<button onclick="location.href='/index.do'" id="oddButton"
									class="btn btn-default btn-icon-notika waves-effect">메인으로</button>
								<button onclick="location.href='/user/editMyPage.do'" class="btn btn-default btn-icon-notika waves-effect">회원정보
									수정</button>
								<button id="oddButton" onclick="location.href='/user/deleteUserInfo.do'"
									class="btn btn-default btn-icon-notika waves-effect">회원탈퇴</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Breadcomb area End-->
	<!-- Contact area Start-->
	<div class="contact-area">
		<div class="container"></div>
	</div>
	<!-- Contact area End-->
	<!-- Start Footer area-->
	<div class="footer-copyright-area">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="footer-copy-right">
						<p>Copyright © 2020 . All rights reserved. Template by Colorlib. Team FOMARD.</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End Footer area-->
	<!-- jquery
		============================================ -->
	<script src="/js/vendor/jquery-1.12.4.min.js"></script>
	<!-- bootstrap JS
		============================================ -->
	<script src="/js/bootstrap.min.js"></script>
	<!-- wow JS
		============================================ -->
	<script src="/js/wow.min.js"></script>
	<!-- price-slider JS
		============================================ -->
	<script src="/js/jquery-price-slider.js"></script>
	<!-- owl.carousel JS
		============================================ -->
	<script src="/js/owl.carousel.min.js"></script>
	<!-- scrollUp JS
		============================================ -->
	<script src="/js/jquery.scrollUp.min.js"></script>
	<!-- meanmenu JS
		============================================ -->
	<script src="/js/meanmenu/jquery.meanmenu.js"></script>
	<!-- counterup JS
		============================================ -->
	<script src="/js/counterup/jquery.counterup.min.js"></script>
	<script src="/js/counterup/waypoints.min.js"></script>
	<script src="/js/counterup/counterup-active.js"></script>
	<!-- mCustomScrollbar JS
		============================================ -->
	<script src="/js/scrollbar/jquery.mCustomScrollbar.concat.min.js"></script>
	<!-- sparkline JS
		============================================ -->
	<script src="/js/sparkline/jquery.sparkline.min.js"></script>
	<script src="/js/sparkline/sparkline-active.js"></script>
	<!-- flot JS
		============================================ -->
	<script src="/js/flot/jquery.flot.js"></script>
	<script src="/js/flot/jquery.flot.resize.js"></script>
	<script src="/js/flot/flot-active.js"></script>
	<!-- knob JS
		============================================ -->
	<script src="/js/knob/jquery.knob.js"></script>
	<script src="/js/knob/jquery.appear.js"></script>
	<script src="/js/knob/knob-active.js"></script>
	<!--  wave JS
		============================================ -->
	<script src="/js/wave/waves.min.js"></script>
	<script src="/js/wave/wave-active.js"></script>
	<!--  Chat JS
		============================================ -->
	<script src="/js/chat/jquery.chat.js"></script>
	<!--  todo JS
		============================================ -->
	<script src="/js/todo/jquery.todo.js"></script>
	<!-- plugins JS
		============================================ -->
	<script src="/js/plugins.js"></script>
	<!-- main JS
		============================================ -->
	<script src="/js/main.js"></script>
</body>

</html>