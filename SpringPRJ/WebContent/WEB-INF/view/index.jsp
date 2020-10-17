<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String res = (String) request.getAttribute("result");
%>

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
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

<script
	src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@1.3.1/dist/tf.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@teachablemachine/pose@0.8/dist/teachablemachine-pose.min.js"></script>
<script type="text/javascript">

   
   let today=new Date();
var date= today.getDate(); 
if(date==13){
var URL = "./my_model2/";
}else{
	var URL = "./my_model/";
}
    let model, webcam, ctx, labelContainer, maxPredictions;
   
    async function init() {
        const modelURL = URL + "model.json";
        const metadataURL = URL + "metadata.json";

        // load the model and metadata
        // Refer to tmImage.loadFromFiles() in the API to support files from a file picker
        // Note: the pose library adds a tmPose object to your window (window.tmPose)
        model = await tmPose.load(modelURL, metadataURL);
        maxPredictions = model.getTotalClasses();

        // Convenience function to setup a webcam
        const size = 400;
        const flip = true; // whether to flip the webcam
        webcam = new tmPose.Webcam(size, size, flip); // width, height, flip
        await webcam.setup(); // request access to the webcam
        await webcam.play();
        window.requestAnimationFrame(loop);

        // append/get elements to the DOM
        const canvas = document.getElementById("canvas");
        canvas.width = size; canvas.height = size;
        ctx = canvas.getContext("2d");
        labelContainer = document.getElementById("label-container");
        for (let i = 0; i < maxPredictions; i++) { // and class labels
            labelContainer.appendChild(document.createElement("div"));
        }
    }

    async function loop(timestamp) {
        webcam.update(); // update the webcam frame
        await predict();
        window.requestAnimationFrame(loop);
    }

    async function predict() {
        // Prediction #1: run input through posenet
        // estimatePose can take in an image, video or canvas html element
        const { pose, posenetOutput } = await model.estimatePose(webcam.canvas);
        // Prediction 2: run input through teachable machine classification model
        const prediction = await model.predict(posenetOutput);

        for (let i = 0; i < maxPredictions; i++) {
            const classPrediction =
                prediction[i].className + ": " + prediction[i].probability.toFixed(2);
            labelContainer.childNodes[i].innerHTML = classPrediction;
        }

        // finally draw the poses
        drawPose(pose);
    }

    function drawPose(pose) {
        if (webcam.canvas) {
            ctx.drawImage(webcam.canvas, 0, 0);
            // draw the keypoints and skeleton
            if (pose) {
                const minPartConfidence = 0.5;
                tmPose.drawKeypoints(pose.keypoints, minPartConfidence, ctx);
                tmPose.drawSkeleton(pose.keypoints, minPartConfidence, ctx);
            }
        }
    }
    
</script>



<style>
.video {
	margin-left: 125px;
	margin-top: 40px;
}

.tm {
	margin-right: 20px;
	margin-top: 500px;
}

.view-mail-hd {
	height: 400px;
}
.a{margin-left: 380px;}
#canvas{margin-left: 125px;
}
</style>


</head>

<body>
	<!--[if lt IE 8]>
            <p class="browserupgrade">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
	<!-- Start Header Top Area -->
	<div class="header-top-area">
		<div class="container">
			<div class="row">
				<div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
					<div class="logo-area">
						<a href="#"><img src="img/logo/logo.png" alt="" /></a>
					</div>
				</div>
				<div class="col-lg-8 col-md-8 col-sm-12 col-xs-12">
					<div class="header-top-menu">
						<ul class="nav navbar-nav notika-top-nav">
							<li class="nav-item dropdown"><a href="#"
								data-toggle="dropdown" role="button" aria-expanded="false"
								class="nav-link dropdown-toggle"><span><i
										class="notika-icon notika-search"></i></span></a>
								<div role="menu"
									class="dropdown-menu search-dd animated flipInX">
									<div class="search-input">
										<i class="notika-icon notika-left-arrow"></i> <input
											type="text" />
									</div>
								</div></li>
							<li class="nav-item dropdown"><a href="#"
								data-toggle="dropdown" role="button" aria-expanded="false"
								class="nav-link dropdown-toggle"><span><i
										class="notika-icon notika-mail"></i></span></a>
								<div role="menu"
									class="dropdown-menu message-dd animated zoomIn">
									<div class="hd-mg-tt">
										<h2>Messages</h2>
									</div>
									<div class="hd-message-info">
										<a href="#">
											<div class="hd-message-sn">
												<div class="hd-message-img">
													<img src="img/post/1.jpg" alt="" />
												</div>
												<div class="hd-mg-ctn">
													<h3>David Belle</h3>
													<p>Cum sociis natoque penatibus et magnis dis
														parturient montes</p>
												</div>
											</div>
										</a> <a href="#">
											<div class="hd-message-sn">
												<div class="hd-message-img">
													<img src="img/post/2.jpg" alt="" />
												</div>
												<div class="hd-mg-ctn">
													<h3>Jonathan Morris</h3>
													<p>Cum sociis natoque penatibus et magnis dis
														parturient montes</p>
												</div>
											</div>
										</a> <a href="#">
											<div class="hd-message-sn">
												<div class="hd-message-img">
													<img src="img/post/4.jpg" alt="" />
												</div>
												<div class="hd-mg-ctn">
													<h3>Fredric Mitchell</h3>
													<p>Cum sociis natoque penatibus et magnis dis
														parturient montes</p>
												</div>
											</div>
										</a> <a href="#">
											<div class="hd-message-sn">
												<div class="hd-message-img">
													<img src="img/post/1.jpg" alt="" />
												</div>
												<div class="hd-mg-ctn">
													<h3>David Belle</h3>
													<p>Cum sociis natoque penatibus et magnis dis
														parturient montes</p>
												</div>
											</div>
										</a> <a href="#">
											<div class="hd-message-sn">
												<div class="hd-message-img">
													<img src="img/post/2.jpg" alt="" />
												</div>
												<div class="hd-mg-ctn">
													<h3>Glenn Jecobs</h3>
													<p>Cum sociis natoque penatibus et magnis dis
														parturient montes</p>
												</div>
											</div>
										</a>
									</div>
									<div class="hd-mg-va">
										<a href="#">View All</a>
									</div>
								</div></li>
							<li class="nav-item nc-al"><a href="#"
								data-toggle="dropdown" role="button" aria-expanded="false"
								class="nav-link dropdown-toggle"><span><i
										class="notika-icon notika-alarm"></i></span>
									<div class="spinner4 spinner-4"></div>
									<div class="ntd-ctn">
										<span>3</span>
									</div></a>
								<div role="menu"
									class="dropdown-menu message-dd notification-dd animated zoomIn">
									<div class="hd-mg-tt">
										<h2>Notification</h2>
									</div>
									<div class="hd-message-info">
										<a href="#">
											<div class="hd-message-sn">
												<div class="hd-message-img">
													<img src="img/post/1.jpg" alt="" />
												</div>
												<div class="hd-mg-ctn">
													<h3>David Belle</h3>
													<p>Cum sociis natoque penatibus et magnis dis
														parturient montes</p>
												</div>
											</div>
										</a> <a href="#">
											<div class="hd-message-sn">
												<div class="hd-message-img">
													<img src="img/post/2.jpg" alt="" />
												</div>
												<div class="hd-mg-ctn">
													<h3>Jonathan Morris</h3>
													<p>Cum sociis natoque penatibus et magnis dis
														parturient montes</p>
												</div>
											</div>
										</a> <a href="#">
											<div class="hd-message-sn">
												<div class="hd-message-img">
													<img src="img/post/4.jpg" alt="" />
												</div>
												<div class="hd-mg-ctn">
													<h3>Fredric Mitchell</h3>
													<p>Cum sociis natoque penatibus et magnis dis
														parturient montes</p>
												</div>
											</div>
										</a> <a href="#">
											<div class="hd-message-sn">
												<div class="hd-message-img">
													<img src="img/post/1.jpg" alt="" />
												</div>
												<div class="hd-mg-ctn">
													<h3>David Belle</h3>
													<p>Cum sociis natoque penatibus et magnis dis
														parturient montes</p>
												</div>
											</div>
										</a> <a href="#">
											<div class="hd-message-sn">
												<div class="hd-message-img">
													<img src="img/post/2.jpg" alt="" />
												</div>
												<div class="hd-mg-ctn">
													<h3>Glenn Jecobs</h3>
													<p>Cum sociis natoque penatibus et magnis dis
														parturient montes</p>
												</div>
											</div>
										</a>
									</div>
									<div class="hd-mg-va">
										<a href="#">View All</a>
									</div>
								</div></li>
							<li class="nav-item"><a href="#" data-toggle="dropdown"
								role="button" aria-expanded="false"
								class="nav-link dropdown-toggle"><span><i
										class="notika-icon notika-menus"></i></span>
									<div class="spinner4 spinner-4"></div>
									<div class="ntd-ctn">
										<span>2</span>
									</div></a>
								<div role="menu"
									class="dropdown-menu message-dd task-dd animated zoomIn">
									<div class="hd-mg-tt">
										<h2>Tasks</h2>
									</div>
									<div class="hd-message-info hd-task-info">
										<div class="skill">
											<div class="progress">
												<div class="lead-content">
													<p>HTML5 Validation Report</p>
												</div>
												<div class="progress-bar wow fadeInLeft" data-progress="95%"
													style="width: 95%;" data-wow-duration="1.5s"
													data-wow-delay="1.2s">
													<span>95%</span>
												</div>
											</div>
											<div class="progress">
												<div class="lead-content">
													<p>Google Chrome Extension</p>
												</div>
												<div class="progress-bar wow fadeInLeft" data-progress="85%"
													style="width: 85%;" data-wow-duration="1.5s"
													data-wow-delay="1.2s">
													<span>85%</span>
												</div>
											</div>
											<div class="progress">
												<div class="lead-content">
													<p>Social Internet Projects</p>
												</div>
												<div class="progress-bar wow fadeInLeft" data-progress="75%"
													style="width: 75%;" data-wow-duration="1.5s"
													data-wow-delay="1.2s">
													<span>75%</span>
												</div>
											</div>
											<div class="progress">
												<div class="lead-content">
													<p>Bootstrap Admin</p>
												</div>
												<div class="progress-bar wow fadeInLeft" data-progress="65%"
													style="width: 65%;" data-wow-duration="1.5s"
													data-wow-delay="1.2s">
													<span>65%</span>
												</div>
											</div>
											<div class="progress progress-bt">
												<div class="lead-content">
													<p>Youtube App</p>
												</div>
												<div class="progress-bar wow fadeInLeft" data-progress="55%"
													style="width: 55%;" data-wow-duration="1.5s"
													data-wow-delay="1.2s">
													<span>55%</span>
												</div>
											</div>
										</div>
										c
									</div>
									<div class="hd-mg-va">
										<a href="#">View All</a>
									</div>
								</div></li>
							<li class="nav-item"><a href="#" data-toggle="dropdown"
								role="button" aria-expanded="false"
								class="nav-link dropdown-toggle"><span><i
										class="notika-icon notika-chat"></i></span></a>
								<div role="menu"
									class="dropdown-menu message-dd chat-dd animated zoomIn">
									<div class="hd-mg-tt">
										<h2>Chat</h2>
									</div>
									<div class="search-people">
										<i class="notika-icon notika-left-arrow"></i> <input
											type="text" placeholder="Search People" />
									</div>
									<div class="hd-message-info">
										<a href="#">
											<div class="hd-message-sn">
												<div class="hd-message-img chat-img">
													<img src="img/post/1.jpg" alt="" />
													<div class="chat-avaible">
														<i class="notika-icon notika-dot"></i>
													</div>
												</div>
												<div class="hd-mg-ctn">
													<h3>David Belle</h3>
													<p>Available</p>
												</div>
											</div>
										</a> <a href="#">
											<div class="hd-message-sn">
												<div class="hd-message-img chat-img">
													<img src="img/post/2.jpg" alt="" />
												</div>
												<div class="hd-mg-ctn">
													<h3>Jonathan Morris</h3>
													<p>Last seen 3 hours ago</p>
												</div>
											</div>
										</a> <a href="#">
											<div class="hd-message-sn">
												<div class="hd-message-img chat-img">
													<img src="img/post/4.jpg" alt="" />
												</div>
												<div class="hd-mg-ctn">
													<h3>Fredric Mitchell</h3>
													<p>Last seen 2 minutes ago</p>
												</div>
											</div>
										</a> <a href="#">
											<div class="hd-message-sn">
												<div class="hd-message-img chat-img">
													<img src="img/post/1.jpg" alt="" />
													<div class="chat-avaible">
														<i class="notika-icon notika-dot"></i>
													</div>
												</div>
												<div class="hd-mg-ctn">
													<h3>David Belle</h3>
													<p>Available</p>
												</div>
											</div>
										</a> <a href="#">
											<div class="hd-message-sn">
												<div class="hd-message-img chat-img">
													<img src="img/post/2.jpg" alt="" />
													<div class="chat-avaible">
														<i class="notika-icon notika-dot"></i>
													</div>
												</div>
												<div class="hd-mg-ctn">
													<h3>Glenn Jecobs</h3>
													<p>Available</p>
												</div>
											</div>
										</a>
									</div>
									<div class="hd-mg-va">
										<a href="#">View All</a>
									</div>
								</div></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End Header Top Area -->
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
	<!-- Main Menu area End-->


	<div class="breadcomb-area">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="breadcomb-list">
						<div class="row">
							<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
								<div class="breadcomb-wp">
									<div class="breadcomb-icon">
										<i class="notika-icon notika-mail"></i>
									</div>
									<div>
										<h2>오늘의수화는 안녕하세요 입니다!</h2>

									</div>
								</div>
							</div>
							<div class="col-lg-6 col-md-6 col-sm-6 col-xs-3">
								<div class="breadcomb-report">
									<button data-toggle="tooltip" data-placement="left"
										title="Download Report" class="btn">
										<i class="notika-icon notika-sent"></i>
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Breadcomb area End-->
	<!-- Inbox area Start-->
	<div class="inbox-area">
		<div class="container">
			<div class="row">
				<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
					<div class="inbox-left-sd">
						<div class="compose-ml">
							<a class="btn" href="#">학습방법</a>
						</div>
						<div class="inbox-status">
							step1 : <br> <br> 웹캠에 자세를 잡으세요 <img
								src="images/sample.png">
						</div>
						<hr>
						<div class="inbox-status">
							step2 : <br> <br> 수화동영상을 따라하세요 <img
								src="images/unnamed.png">
						</div>
						<hr>
						<div class="inbox-status">
							step3:<br> <br> 모션인식을 통해 수화를 확인하세요
						</div>
					</div>
				</div>
				<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">
					<div class="view-mail-list sm-res-mg-t-30">
						
							<div class="video">
								<video src='<%=res%>' width='550' heigh='400' controls autoplay></video>
									</div>
									<br>
									<br>
									<br>
								<div class="a"><button type="button" onclick="init()"style="WIDTH: 40pt; HEIGHT: 20pt;">Start</button></div>
							<br>
									<br>
							<div>
								<canvas id="canvas" ></canvas>
							</div>
							<div id="label-container"></div>
						

							
								



						</div>
					</div>
				</div>
			</div>
		</div>
	
	
	<!-- Inbox area End-->




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