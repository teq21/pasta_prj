<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./user/session.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta charset="utf-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>Dashboards Four | Notika - Notika Admin Template</title>
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
<link rel="stylesheet" href="css/bootstrap.min.css">
<!-- font awesome CSS
		============================================ -->
<link rel="stylesheet" href="css/font-awesome.min.css">
<!-- owl.carousel CSS
		============================================ -->
<link rel="stylesheet" href="css/owl.carousel.css">
<link rel="stylesheet" href="css/owl.theme.css">
<link rel="stylesheet" href="css/owl.transitions.css">
<!-- meanmenu CSS
		============================================ -->
<link rel="stylesheet" href="css/meanmenu/meanmenu.min.css">
<!-- animate CSS
		============================================ -->
<link rel="stylesheet" href="css/animate.css">
<!-- normalize CSS
		============================================ -->
<link rel="stylesheet" href="css/normalize.css">
<!-- mCustomScrollbar CSS
		============================================ -->
<link rel="stylesheet"
	href="css/scrollbar/jquery.mCustomScrollbar.min.css">
<!-- jvectormap CSS
		============================================ -->
<link rel="stylesheet" href="css/jvectormap/jquery-jvectormap-2.0.3.css">
<!-- Notika icon CSS
		============================================ -->
<link rel="stylesheet" href="css/notika-custom-icon.css">
<!-- wave CSS
		============================================ -->
<link rel="stylesheet" href="css/wave/waves.min.css">
<!-- main CSS
		============================================ -->
<link rel="stylesheet" href="css/main.css">
<!-- style CSS
		============================================ -->
<link rel="stylesheet" href="css/style.css">
<!-- responsive CSS
		============================================ -->
<link rel="stylesheet" href="css/responsive.css">
<!-- modernizr JS
		============================================ -->
<script src="js/vendor/modernizr-2.8.3.min.js"></script>
<style>
.invoice-wrap {
	padding: 300px; 
  text-align: center;
  
  padding-top:10em;
}
.a {color:grey;}
.b{    white-space: nowrap;
    font-size: 2em;
    font-weight: 700;
    margin: 0 2% 0 0;
    cursor: pointer;
    color: #50b8e0;}
.wrap{color:#00c292;    font-size: 4.5rem;
    }

.white {
    color: white;
    margin-left: 24px;
    font-weight: bold;
}

</style>
<script type="text/javascript">
//made by vipul mirajkar thevipulm.appspot.com
var TxtType = function(el, toRotate, period) {
        this.toRotate = toRotate;
        this.el = el;
        this.loopNum = 0;
        this.period = parseInt(period, 10) || 2000;
        this.txt = '';
        this.tick();
        this.isDeleting = false;
    };

    TxtType.prototype.tick = function() {
        var i = this.loopNum % this.toRotate.length;
        var fullTxt = this.toRotate[i];

        if (this.isDeleting) {
        this.txt = fullTxt.substring(0, this.txt.length - 1);
        } else {
        this.txt = fullTxt.substring(0, this.txt.length + 1);
        }

        this.el.innerHTML = '<span class="wrap">'+this.txt+'</span>';

        var that = this;
        var delta = 200 - Math.random() * 100;

        if (this.isDeleting) { delta /= 2; }

        if (!this.isDeleting && this.txt === fullTxt) {
        delta = this.period;
        this.isDeleting = true;
        } else if (this.isDeleting && this.txt === '') {
        this.isDeleting = false;
        this.loopNum++;
        delta = 500;
        }

        setTimeout(function() {
        that.tick();
        }, delta);
    };

    window.onload = function() {
        var elements = document.getElementsByClassName('typewrite');
        for (var i=0; i<elements.length; i++) {
            var toRotate = elements[i].getAttribute('data-type');
            var period = elements[i].getAttribute('data-period');
            if (toRotate) {
              new TxtType(elements[i], JSON.parse(toRotate), period);
            }
        }
        // INJECT CSS
        var css = document.createElement("style");
        css.type = "text/css";
        css.innerHTML = ".typewrite > .wrap { border-right: 0.08em solid #fff}";
        document.body.appendChild(css);
    };

</script>
</head>

<body>
	<!--[if lt IE 8]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
	<!-- 상단 로고 쪽   (원래는 header top area 임) -->
   <div class="header-top-area">
      <div class="container">
         <div class="row">
            <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
               <div class="logo-area">
                  <a href="#"><img src="/img/logo/dblogo.png" alt="" /></a>
               </div>
                  
            </div>
            <div class="area_gnb" style="margin-top: 25px;float:right">
                  <a href="/user/login_register.do" class="white"> 로그인 </a> 
                  <b class="white"> | </b> <a href="/user/myPage.do?user_no=<%=user_no %>"
                     class="white"> 마이페이지</a>
               </div>
         </div>
      </div>
   </div>
   <!-- 로고쪽 끝 -->
	<!-- Mobile Menu start -->
	<div class="mobile-menu-area">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="mobile-menu">
						<nav id="dropdown">
						<ul class="mobile-menu-nav">
							<li><a data-toggle="collapse" data-target="#Charts" href="#">Home</a>
								<ul class="collapse dropdown-header-top">
									<li><a href="index.html">Dashboard One</a></li>
									<li><a href="index-2.html">Dashboard Two</a></li>
									<li><a href="index-3.html">Dashboard Three</a></li>
									<li><a href="index-4.html">Dashboard Four</a></li>
									<li><a href="analytics.html">Analytics</a></li>
									<li><a href="widgets.html">Widgets</a></li>
								</ul></li>



							<li><a data-toggle="collapse" data-target="#demodepart"
								href="#">Tables</a>
								<ul id="demodepart" class="collapse dropdown-header-top">
									<li><a href="normal-table.html">Normal Table</a></li>
									<li><a href="data-table.html">Data Table</a></li>
								</ul></li>
							<li><a data-toggle="collapse" data-target="#demo" href="#">Forms</a>
								<ul id="demo" class="collapse dropdown-header-top">
									<li><a href="form-elements.html">Form Elements</a></li>
									<li><a href="form-components.html">Form Components</a></li>
									<li><a href="form-examples.html">Form Examples</a></li>
								</ul></li>
							<li><a data-toggle="collapse"
								data-target="#Miscellaneousmob" href="#">App views</a>
								<ul id="Miscellaneousmob" class="collapse dropdown-header-top">
									<li><a href="notification.html">Notifications</a></li>
									<li><a href="alert.html">Alerts</a></li>
									<li><a href="modals.html">Modals</a></li>
									<li><a href="buttons.html">Buttons</a></li>
									<li><a href="tabs.html">Tabs</a></li>
									<li><a href="accordion.html">Accordion</a></li>
									<li><a href="dialog.html">Dialogs</a></li>
									<li><a href="popovers.html">Popovers</a></li>
									<li><a href="tooltips.html">Tooltips</a></li>
									<li><a href="dropdown.html">Dropdowns</a></li>
								</ul></li>
							<li><a data-toggle="collapse" data-target="#Pagemob"
								href="#">Pages</a>
								<ul id="Pagemob" class="collapse dropdown-header-top">
									<li><a href="contact.html">Contact</a></li>
									<li><a href="invoice.html">Invoice</a></li>
									<li><a href="typography.html">Typography</a></li>
									<li><a href="color.html">Color</a></li>
									<li><a href="login-register.html">Login Register</a></li>
									<li><a href="404.html">404 Page</a></li>
								</ul></li>
						</ul>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Mobile Menu end -->
	<!-- Main Menu area start-->
	<div class="main-menu-area mg-tb-40">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<ul class="nav nav-tabs notika-menu-wrap menu-it-icon-pro">
						<li class="active"><a data-toggle="tab" href="#Home"><i
								class="notika-icon notika-house"></i> Home</a></li>


						<li><a data-toggle="tab" href="#Forms"><i
								class="notika-icon notika-form"></i> Forms</a></li>
						<li><a data-toggle="tab" href="#Appviews"><i
								class="notika-icon notika-app"></i> App views</a></li>
						<li><a data-toggle="tab" href="#Page"><i
								class="notika-icon notika-support"></i> Pages</a></li>
					</ul>
					<div class="tab-content custom-menu-content">
						<div id="Home"
							class="tab-pane active in notika-tab-menu-bg animated flipInX">
							<ul class="notika-main-menu-dropdown">
								<li><a href="index.html">Dashboard One</a></li>
								<li><a href="index-2.html">Dashboard Two</a></li>
								<li><a href="index-3.html">Dashboard Three</a></li>
								<li><a href="index-4.html">Dashboard Four</a></li>
								<li><a href="analytics.html">Analytics</a></li>
								<li><a href="widgets.html">Widgets</a></li>
							</ul>
						</div>
						<div id="mailbox"
							class="tab-pane notika-tab-menu-bg animated flipInX">
							<ul class="notika-main-menu-dropdown">
								<li><a href="inbox.html">Inbox</a></li>
								<li><a href="view-email.html">View Email</a></li>
								<li><a href="compose-email.html">Compose Email</a></li>
							</ul>
						</div>
						<div id="Interface"
							class="tab-pane notika-tab-menu-bg animated flipInX">
							<ul class="notika-main-menu-dropdown">
								<li><a href="animations.html">Animations</a></li>
								<li><a href="google-map.html">Google Map</a></li>
								<li><a href="data-map.html">Data Maps</a></li>
								<li><a href="code-editor.html">Code Editor</a></li>
								<li><a href="image-cropper.html">Images Cropper</a></li>
								<li><a href="wizard.html">Wizard</a></li>
							</ul>
						</div>
						<div id="Charts"
							class="tab-pane notika-tab-menu-bg animated flipInX">
							<ul class="notika-main-menu-dropdown">
								<li><a href="flot-charts.html">Flot Charts</a></li>
								<li><a href="bar-charts.html">Bar Charts</a></li>
								<li><a href="line-charts.html">Line Charts</a></li>
								<li><a href="area-charts.html">Area Charts</a></li>
							</ul>
						</div>
						<div id="Tables"
							class="tab-pane notika-tab-menu-bg animated flipInX">
							<ul class="notika-main-menu-dropdown">
								<li><a href="normal-table.html">Normal Table</a></li>
								<li><a href="data-table.html">Data Table</a></li>
							</ul>
						</div>
						<div id="Forms"
							class="tab-pane notika-tab-menu-bg animated flipInX">
							<ul class="notika-main-menu-dropdown">
								<li><a href="form-elements.html">Form Elements</a></li>
								<li><a href="form-components.html">Form Components</a></li>
								<li><a href="form-examples.html">Form Examples</a></li>
							</ul>
						</div>
						<div id="Appviews"
							class="tab-pane notika-tab-menu-bg animated flipInX">
							<ul class="notika-main-menu-dropdown">
								<li><a href="notification.html">Notifications</a></li>
								<li><a href="alert.html">Alerts</a></li>
								<li><a href="modals.html">Modals</a></li>
								<li><a href="buttons.html">Buttons</a></li>
								<li><a href="tabs.html">Tabs</a></li>
								<li><a href="accordion.html">Accordion</a></li>
								<li><a href="dialog.html">Dialogs</a></li>
								<li><a href="popovers.html">Popovers</a></li>
								<li><a href="tooltips.html">Tooltips</a></li>
								<li><a href="dropdown.html">Dropdowns</a></li>
							</ul>
						</div>
						<div id="Page"
							class="tab-pane notika-tab-menu-bg animated flipInX">
							<ul class="notika-main-menu-dropdown">
								<li><a href="contact.html">Contact</a></li>
								<li><a href="invoice.html">Invoice</a></li>
								<li><a href="typography.html">Typography</a></li>
								<li><a href="color.html">Color</a></li>
								<li><a href="login-register.html">Login Register</a></li>
								<li><a href="404.html">404 Page</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="invoice-wrap">
				
				<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<!--made by vipul mirajkar thevipulm.appspot.com-->
<div class="a">paas-ta 로 만들어가는 베리어프리 세상      <br>몸으로 익히는 수화를 체험해보세요</div>
<br>
<br>
<br>
<h1>
  <a href="" class="typewrite" data-period="2000" data-type='[ "하루에 수화 하나씩만   </br> 배우자!", "모션인식을 활용한 수화를 체험해보세요 " ]'>
    <span class="wrap"></span>
  </a>
</h1>

<br>
<br>
<P></P>
<div class="b" ><a href="/model.do">시작하기</a></div>
				
				
				
				
				
				</div>
				
			</div>
		</div>
	</div>






	<!-- Start Footer area-->
	<div class="footer-copyright-area">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="footer-copy-right">
						<p>
							Copyright © 2018 . All rights reserved. Template by <a
								href="https://colorlib.com">Colorlib</a>.
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End Footer area-->
	<!-- jquery
		============================================ -->
		
	<script src="js/vendor/jquery-1.12.4.min.js"></script>
	<!-- bootstrap JS
		============================================ -->
	<script src="js/bootstrap.min.js"></script>
	<!-- wow JS
		============================================ -->
	<script src="js/wow.min.js"></script>
	<!-- price-slider JS
		============================================ -->
	<script src="js/jquery-price-slider.js"></script>
	<!-- owl.carousel JS
		============================================ -->
	<script src="js/owl.carousel.min.js"></script>
	<!-- scrollUp JS
		============================================ -->
	<script src="js/jquery.scrollUp.min.js"></script>
	<!-- meanmenu JS
		============================================ -->
	<script src="js/meanmenu/jquery.meanmenu.js"></script>
	<!-- counterup JS
		============================================ -->
	<script src="js/counterup/jquery.counterup.min.js"></script>
	<script src="js/counterup/waypoints.min.js"></script>
	<script src="js/counterup/counterup-active.js"></script>
	<!-- mCustomScrollbar JS
		============================================ -->
	<script src="js/scrollbar/jquery.mCustomScrollbar.concat.min.js"></script>
	<!-- jvectormap JS
		============================================ -->
	<script src="js/jvectormap/jquery-jvectormap-2.0.2.min.js"></script>
	<script src="js/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
	<script src="js/jvectormap/jvectormap-active.js"></script>
	<!-- sparkline JS
		============================================ -->
	<script src="js/sparkline/jquery.sparkline.min.js"></script>
	<script src="js/sparkline/sparkline-active.js"></script>
	<!-- flot JS
		============================================ -->
	<script src="js/flot/jquery.flot.js"></script>
	<script src="js/flot/jquery.flot.resize.js"></script>
	<script src="js/flot/jquery.flot.pie.js"></script>
	<script src="js/flot/jquery.flot.tooltip.min.js"></script>
	<script src="js/flot/jquery.flot.orderBars.js"></script>
	<script src="js/flot/curvedLines.js"></script>
	<script src="js/flot/flot-active.js"></script>
	<!-- knob JS
		============================================ -->
	<script src="js/knob/jquery.knob.js"></script>
	<script src="js/knob/jquery.appear.js"></script>
	<script src="js/knob/knob-active.js"></script>
	<!--  wave JS
		============================================ -->
	<script src="js/wave/waves.min.js"></script>
	<script src="js/wave/wave-active.js"></script>
	<!--  Chat JS
		============================================ -->
	<script src="js/chat/moment.min.js"></script>
	<script src="js/chat/jquery.chat.js"></script>
	<!--  todo JS
		============================================ -->
	<script src="js/todo/jquery.todo.js"></script>
	<!-- plugins JS
		============================================ -->
	<script src="js/plugins.js"></script>
	<!-- main JS
		============================================ -->
	<script src="js/main.js"></script>
	<!-- tawk chat JS
		============================================ -->
	<script src="js/tawk-chat.js"></script>


</body>
</html>