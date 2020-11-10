<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="poly.dto.QuizDTO"%>

<%
	QuizDTO rDTO = (QuizDTO) request.getAttribute("rDTO");
%>
<!DOCTYPE html>
<html>
<head>
<script>
window.onload = function () {

var chart = new CanvasJS.Chart("chartContainer", {
	title: {
		text: "Temperature of Each Boiler"
	},
	axisY: {
		title: "Temperature (°C)",
		includeZero: true,
		suffix: " °C"
	},
	data: [{
		type: "column",	
		yValueFormatString: "#,### °C",
		indexLabel: "{y}",
		dataPoints: [
			{ label: "boiler1", y: 206 },
			{ label: "boiler2", y: 163 },
			{ label: "boiler3", y: 154 },
			{ label: "boiler4", y: 176 },
			{ label: "boiler5", y: 184 },
			{ label: "boiler6", y: 122 }
		]
	}]
});

function updateChart() {
	var boilerColor, deltaY, yVal;
	var dps = chart.options.data[0].dataPoints;
	for (var i = 0; i < dps.length; i++) {
		deltaY = Math.round(2 + Math.random() *(-2-2));
		yVal = deltaY + dps[i].y > 0 ? dps[i].y + deltaY : 0;
		boilerColor = yVal > 200 ? "#FF2500" : yVal >= 170 ? "#FF6000" : yVal < 170 ? "#6B8E23 " : null;
		dps[i] = {label: "Boiler "+(i+1) , y: yVal, color: boilerColor};
	}
	chart.options.data[0].dataPoints = dps; 
	chart.render();
};
updateChart();

setInterval(function() {updateChart()}, 500);

}
</script>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<meta charset="utf-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<title>Dashboard One | Notika - Notika Admin Template</title>
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
<!-- Bootstrap CSS
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
<!-- jvectormap CSS
		============================================ -->
<link rel="stylesheet"
	href="/css/jvectormap/jquery-jvectormap-2.0.3.css">
<!-- notika icon CSS
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
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>
<script
	src="https://github.com/nagix/chartjs-plugin-streaming/releases/download/v1.5.0/chartjs-plugin-streaming.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@1.3.1/dist/tf.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@teachablemachine/pose@0.8/dist/teachablemachine-pose.min.js"></script>
<script type="text/javascript">

//===================================================
//documet get ready 
//===================================================
  $( document ).ready( function() {
	init();	
	sss();
	 // $ ('.div1').hide();
	// $ ('.div2').hide();
	 //$ ('.div3').hide();
	 $ ('#myChart').hide();
	 //$ ('#cha').hide(); 
});  

  let model, webcam, ctx, labelContainer, maxPredictions;

  const URL= "<%=rDTO.getTm_path()%>";

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
  webcam = new tmPose.Webcam(400, size, flip); // width, height, flip
  await webcam.setup(); // request access to the webcam
  await webcam.play();
  window.requestAnimationFrame(loop);

  // append/get elements to the DOM
  const canvas = document.getElementById("canvas");
  canvas.width = 400; canvas.height = size;
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
  // finally draw the poses
  drawPose(pose);
}

async function getPredictValue1() {
  // Prediction #1: run input through posenet
  // estimatePose can take in an image, video or canvas html element
  const { pose, posenetOutput } = await model.estimatePose(webcam.canvas);
  // Prediction 2: run input through teachable machine classification model
  const prediction = await model.predict(posenetOutput);
  var test = prediction[0].probability.toFixed(2);
  return test;
}

async function getPredictValue2() {
  // Prediction #1: run input through posenet
  // estimatePose can take in an image, video or canvas html element
  const { pose, posenetOutput } = await model.estimatePose(webcam.canvas);
  // Prediction 2: run input through teachable machine classification model
  const prediction = await model.predict(posenetOutput);
  var test = prediction[1].probability.toFixed(2);
  return test;
}

async function getPredictValue3() {
	  // Prediction #1: run input through posenet
	  // estimatePose can take in an image, video or canvas html element
	  const { pose, posenetOutput } = await model.estimatePose(webcam.canvas);
	  // Prediction 2: run input through teachable machine classification model
	  const prediction = await model.predict(posenetOutput);
	  var test = prediction[2].probability.toFixed(2);
	  return test;
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

//그래프 그리기 
//===================================================
var chartColors = {
		red: 'rgb(255, 99, 132)',
		orange: 'rgb(255, 159, 64)',
		yellow: 'rgb(255, 205, 86)',
		green: 'rgb(75, 192, 192)',
		blue: 'rgb(54, 162, 235)',
		purple: 'rgb(153, 102, 255)',
		grey: 'rgb(201, 203, 207)'
	};


async function onRefresh(chart) {
	
	const a = await getPredictValue1();
	const b = await getPredictValue2();
	const c = await getPredictValue3();
	console.log(a);
	if(a>0.9){
		await $ ('.div1').show();
		
	}
	if(b>0.9){
		await $ ('.div2').show();
		
	}
	if(c>0.9){
		await $ ('.div3').show();
		await $ ('#cha').show();
	}
		
}

var color = Chart.helpers.color;
var config = {
	type: 'line',
	data: {
		datasets: [{
			label: 'Dataset 1',
			backgroundColor: color(chartColors.blue).alpha(0.5).rgbString(),
			borderColor: chartColors.blue,
			fill: false,
			lineTension: 0,
			borderDash: [8, 4],
			data: []
		}, {
			label: 'Dataset 2',
			backgroundColor: color(chartColors.red).alpha(0.5).rgbString(),
			borderColor: chartColors.red,
			fill: false,
			cubicInterpolationMode: 'monotone',
			data: []
		}]
	},
	options: {
		title: {
			display: true,
			text: 'Line chart (hotizontal scroll) sample'
		},
		scales: {
			xAxes: [{
				type: 'time'
			}],
			yAxes: [{
				scaleLabel: {
					display: true,
					labelString: 'value'
				}
			}]
		},
		tooltips: {
			mode: 'nearest',
			intersect: false
		},
		hover: {
			mode: 'nearest',
			intersect: false
		},
		plugins: {
			streaming: {
				duration: 6000,
				refresh: 200,
				delay: 50,
				onRefresh: onRefresh
			}
		}
	}
};

window.onload = function() {
	var ctx = document.getElementById('myChart').getContext('2d');
	window.myChart = new Chart(ctx, config);
	
};

/* let today=new Date();
var date= today.getDate(); 
if(date==13){
	var URL = "./my_model2/";
}else{
var URL = "./my_model/";
} */
function sss() {

	var chart = new CanvasJS.Chart("chartContainer", {
		title: {
			text: "bar graph"
		},
		axisY: {
			title: "정확치",
			includeZero: true,
		},
		data: [{
			type: "column",	
			yValueFormatString: "#,### %",
			dataPoints: [
				{ label: "boiler1", y: 100 },
				{ label: "boiler2", y: 100 },
				{ label: "boiler3", y: 100 }
			]
		}]
	});

	async function updateChart() {
		const d = await getPredictValue1();
		const e = await getPredictValue2();
		const f = await getPredictValue3();
		var boilerColor, deltaY, yVal;
		
		
		var dps = chart.options.data[0].dataPoints;
		
		for (var i = 0; i < dps.length; i++) {
			deltaY = d*100;
			yVal = deltaY;
			
			var deltaY2 = e*100;
			var yVal2 = deltaY2;
			
			var deltaY3 = f*100;
			var yVal3 = deltaY3;			
			
			boilerColor = "#4ca791";
			boilerColor2 = "#00c292";
			boilerColor3 = "#3c763d";
			dps[0] = {label: "단어1 ", y: yVal, color: boilerColor};
			dps[1] = {label: "단어2 ", y: yVal2, color: boilerColor2};
			dps[2] = {label: "단어3 ", y: yVal3, color: boilerColor3};
		}
		chart.options.data[0].dataPoints = dps; 
		chart.render();
	};
	updateChart();

	setInterval(function() {updateChart()}, 700);

	}


</script>

<style>

.dummy-positioning {
	-webkit-box-align: center;
	align-items: center;
	-webkit-box-pack: center;
	justify-content: center;
}

.success-icon {
	display: inline-block;
	width: 4em;
	height: 4em;
	font-size: 20px;
	border-radius: 50%;
	border: 4px solid #96df8f;
	background-color: #fff;
	position: relative;
	overflow: hidden;
	-webkit-transform-origin: center;
	transform-origin: center;
	-webkit-animation: showSuccess 180ms ease-in-out;
	animation: showSuccess 180ms ease-in-out;
	-webkit-transform: scale(1);
	transform: scale(1);
}

.success-icon__tip, .success-icon__long {
	display: block;
	position: absolute;
	height: 4px;
	background-color: #96df8f;
	border-radius: 10px;
}

.success-icon__tip {
	width: 2.4em;
	top: 2.15em;
	left: 1.4em;
	-webkit-transform: rotate(45deg);
	transform: rotate(45deg);
	-webkit-animation: tipInPlace 300ms ease-in-out;
	animation: tipInPlace 300ms ease-in-out;
	-webkit-animation-fill-mode: forwards;
	animation-fill-mode: forwards;
	-webkit-animation-delay: 180ms;
	animation-delay: 180ms;
	visibility: hidden;
}

.success-icon__long {
	width: 4em;
	-webkit-transform: rotate(-45deg);
	transform: rotate(-45deg);
	top: 1.85em;
	left: 2.75em;
	-webkit-animation: longInPlace 140ms ease-in-out;
	animation: longInPlace 140ms ease-in-out;
	-webkit-animation-fill-mode: forwards;
	animation-fill-mode: forwards;
	visibility: hidden;
	-webkit-animation-delay: 440ms;
	animation-delay: 440ms;
}

@
-webkit-keyframes showSuccess {from { -webkit-transform:scale(0);
	transform: scale(0);
}

to {
	-webkit-transform: scale(1);
	transform: scale(1);
}

}
@
keyframes showSuccess {from { -webkit-transform:scale(0);
	transform: scale(0);
}

to {
	-webkit-transform: scale(1);
	transform: scale(1);
}

}
@
-webkit-keyframes tipInPlace {from { width:0em;
	top: 0em;
	left: -0.8em;
}

to {
	width: 1.2em;
	top: 2.15em;
	left: 0.7em;
	visibility: visible;
}

}
@
keyframes tipInPlace {from { width:0em;
	top: 0em;
	left: -0.8em;
}

to {
	width: 1.2em;
	top: 2.15em;
	left: 0.7em;
	visibility: visible;
}

}
@
-webkit-keyframes longInPlace {from { width:0em;
	top: 2.55em;
	left: 1.6em;
}

to {
	width: 2em;
	top: 1.85em;
	left: 1.375em;
	visibility: visible;
}

}
@
keyframes longInPlace {from { width:0em;
	top: 2.55em;
	left: 1.6em;
}

to {
	width: 2em;
	top: 1.85em;
	left: 1.375em;
	visibility: visible;
}

//
답에 대한 css
  .textRevealContainer {
	position: absolute;
	left: 50%;
	top: 50%;
	transform: translate(-50%, -50%);
	font-family: "Comic Sans MS", cursive, sans-serif;
	font-size: 1.5em; /*adjust according to your need*/
	text-align: center; /*in case you write multiline text*/
}

.textReveal {
	overflow: hidden;
	animation: textRevealAnim 2s ease 0.5s forwards;
}

.textReveal>div {
	padding: 8px 16px;
	transform: translateX(100%);
	border-left: 2px solid red;
	overflow: hidden;
	animation: textRevealAnim 2s ease 0.5s forwards, borderOpacityAnim 2s
		ease 0.5s forwards;
}

.textReveal>div>div {
	transform: translateX(-100%);
	animation: textRevealAnim 2s ease 0.5s forwards;
}

@
keyframes textRevealAnim {to { transform:translateX(0);
	
}

}
@
keyframes borderOpacityAnim { 50% {
	border-left: 2px solid red;
}

100%
{
border-left
:
 
2
px
 
solid
 
transparent
;

  
}
}
.textReveal.x50 {
	transform: translateX(-50%);
}

.textReveal.x100 {
	transform: translateX(-100%);
}

.textReveal.zoom>div {
	transform: translateX(100%) scale(0.5, 0.5);
}

.textReveal.rotateY {
	perspective: 100px; /*adjust according to your need*/
}

.textReveal.rotateY>div {
	transform: translateX(100%) rotateY(20deg);
}

.textReveal.color>div>div {
	background: linear-gradient(to right, red, red 45%, orange 45%, orange 55%, red 55%,
		red);
	-webkit-text-fill-color: transparent;
	-webkit-background-clip: text;
	background-size: 300%;
	animation: textRevealAnim 2s ease 0.5s forwards, bgShiftAnim 3s ease
		0.5s forwards;
}

@
keyframes bgShiftAnim {to { background-position:100%;
	
}
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
												<div class="progress-bar wow fadeInLeft" data-progress="93%"
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
								<li><a data-toggle="collapse" data-target="#Charts"
									href="#">Home</a>
									<ul class="collapse dropdown-header-top">
										<li><a href="index.html">Dashboard One</a></li>
										<li><a href="index-2.html">Dashboard Two</a></li>
										<li><a href="index-3.html">Dashboard Three</a></li>
										<li><a href="index-4.html">Dashboard Four</a></li>
										<li><a href="analytics.html">Analytics</a></li>
										<li><a href="widgets.html">Widgets</a></li>
									</ul></li>
								<li><a data-toggle="collapse" data-target="#demoevent"
									href="#">Email</a>
									<ul id="demoevent" class="collapse dropdown-header-top">
										<li><a href="inbox.html">Inbox</a></li>
										<li><a href="view-email.html">View Email</a></li>
										<li><a href="compose-email.html">Compose Email</a></li>
									</ul></li>
								<li><a data-toggle="collapse" data-target="#democrou"
									href="#">Interface</a>
									<ul id="democrou" class="collapse dropdown-header-top">
										<li><a href="animations.html">Animations</a></li>
										<li><a href="google-map.html">Google Map</a></li>
										<li><a href="data-map.html">Data Maps</a></li>
										<li><a href="code-editor.html">Code Editor</a></li>
										<li><a href="image-cropper.html">Images Cropper</a></li>
										<li><a href="wizard.html">Wizard</a></li>
									</ul></li>
								<li><a data-toggle="collapse" data-target="#demolibra"
									href="#">Charts</a>
									<ul id="demolibra" class="collapse dropdown-header-top">
										<li><a href="flot-charts.html">Flot Charts</a></li>
										<li><a href="bar-charts.html">Bar Charts</a></li>
										<li><a href="line-charts.html">Line Charts</a></li>
										<li><a href="area-charts.html">Area Charts</a></li>
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
						<li><a data-toggle="tab" href="#mailbox"><i
								class="notika-icon notika-mail"></i> Email</a></li>
						<li><a data-toggle="tab" href="#Interface"><i
								class="notika-icon notika-edit"></i> Interface</a></li>
						<li><a data-toggle="tab" href="#Charts"><i
								class="notika-icon notika-bar-chart"></i> Charts</a></li>
						<li><a data-toggle="tab" href="#Tables"><i
								class="notika-icon notika-windows"></i> Tables</a></li>
						<li><a data-toggle="tab" href="#Forms"><i
								class="notika-icon notika-form"></i> Forms</a></li>
						<li><a data-toggle="tab" href="#Appviews"><i
								class="notika-icon notika-app"></i> App views</a></li>
						<li><a data-toggle="tab" href="#Page"><i
								class="notika-icon notika-support"></i> Pages</a></li>
					</ul>
					<div class="tab-content custom-menu-content">
						<div id="Home"
							class="tab-pane in active notika-tab-menu-bg animated flipInX">
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
	<!-- Start Sale Statistic area-->
	<div class="breadcomb-area">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="breadcomb-list" style="border: 3px solid #00C292;">
						<div class="row" style="text-align: center;">
							<h3>문장 "<%=rDTO.getSign_name()%>"을(를) 모션인식으로 맞춰보세요</h3>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



	<div class="step3">
		<div class="container">
			<div class="row">
				<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12" id="a">
					<div class="data-map-single"
						style="text-align: center; margin: 0auto; border: 3px solid #00C292;">

						<h4>모션인식을 통해 수화를 직접해보세요</h4>
						<hr>
						<br>
						<br>
						<canvas id="canvas"></canvas>
					</div>
				</div>
				<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
					<div class="data-map-single sm-res-mg-t-30"
						style="height: 535.2px; text-align: center; margin: 0auto; border: 3px solid #00C292;">
						<h4>맞춘 문장이 하나씩 드러납니다</h4>
						<hr>
						
						<div class="textRevealContainer">
							<div class="textReveal rotateY" >
							<div id="chartContainer" style="height: 340px; width: 100;"></div><br>
								<div class="div1" style="float: left;margin-left: 100px;">
									<h1><%=rDTO.getDiv_one()%></h1>
								</div>
								<div class="div2" style="float: left;padding-left: 40px;">
									<h1>
										<%=rDTO.getDiv_two()%></h1>
								</div>
								<div class="div3" style="float: left;padding-left: 40px;">
									<h1><%=rDTO.getDiv_three()%></h1>
								</div>
							</div>
							
						</div>
						<br><br>
							<button id="cha" style="margin-top:10px;"
								class="btn btn-default btn-icon-notika waves-effect"
								OnClick="location.href ='/quiz/type2.do'">
								<i class="notika-icon notika-right-arrow">다른문제 풀러가기</i>
							</button>
						
					</div>
				</div>
			</div>
		</div>
	</div>

	<!--step3 끝-->


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
	<!-- jvectormap JS
		============================================ -->
	<script src="/js/jvectormap/jquery-jvectormap-2.0.2.min.js"></script>
	<script src="/js/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
	<script src="/js/jvectormap/jvectormap-active.js"></script>
	<!-- sparkline JS
		============================================ -->
	<script src="js/sparkline/jquery.sparkline.min.js"></script>
	<script src="/js/sparkline/sparkline-active.js"></script>
	<!-- sparkline JS
		============================================ -->
	<script src="/js/flot/jquery.flot.js"></script>
	<script src="/js/flot/jquery.flot.resize.js"></script>
	<script src="/js/flot/curvedLines.js"></script>
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
	<!--  todo JS
		============================================ -->
	<script src="/js/todo/jquery.todo.js"></script>
	<!-- plugins JS
		============================================ -->
	<script src="/js/plugins.js"></script>
	<!--  Chat JS
		============================================ -->
	<script src="/js/chat/moment.min.js"></script>
	<script src="/js/chat/jquery.chat.js"></script>
	<!-- main JS
		============================================ -->
	<script src="/js/main.js"></script>
	<!-- tawk chat JS
		============================================ -->
	<script src="/js/tawk-chat.js"></script>
</body>
</html>