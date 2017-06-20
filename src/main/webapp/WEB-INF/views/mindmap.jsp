<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONValue"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- 추가됨 -->
<!-- ContextPath 선언 -->
<% String cp = request.getContextPath(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Ik ben</title>

<!-- for Fullpage -->
    <link rel="stylesheet" type="text/css" href="<%=cp%>/resources/fullpage/css/jquery.fullPage.css" />
    <link rel="stylesheet" type="text/css" href="<%=cp%>/resources/fullpage/css/examples.css" />
    <!--[if IE]>
        <script type="text/javascript">
             var console = { log: function() {} };
        </script>
    <![endif]-->
	
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.9.1/jquery-ui.min.js"></script>

    <script type="text/javascript" src="<%=cp%>/resources/fullpage/js/jquery.fullPage.js"></script>
    <script type="text/javascript" src="<%=cp%>/resources/fullpage/js/examples.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $('#fullpage').fullpage({
              sectionsColor: ['ffffff', '#4BBFC3', '#7BAABE', 'whitesmoke', '#ccddff', '#5390FF', '#5390FF'],
              anchors: ['firstPage', 'secondPage', '3rdPage', '4thpage', '5thpage', '6thpage', '7thpage'],
              menu: '#menu',
            });
        });
        /* 이미지를 배열을 이용해 넣고 싶었다 */
        <%--  sectionsImage : ['<%=cp%>/resources/fullpage/js/examples.js', '#4BBFC3', '#7BAABE', 'whitesmoke', '#ccddff'], --%><%-- '<%=cp%>/resources/fullpage/js/examples.js' --%>
    </script>
    
<!-- for RotatingWord -->
	<link href='http://fonts.googleapis.com/css?family=Bree+Serif|Open+Sans+Condensed:700,300,300italic' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" type="text/css" href="<%=cp%>/resources/RotatingWords/css/demo.css" />
	<link rel="stylesheet" type="text/css" href="<%=cp%>/resources/RotatingWords/css/style.css" />
	<script src="<%=cp%>/resources/RotatingWords/js/modernizr.custom.72111.js"></script>
	<style>
	.no-cssanimations .rw-wrapper .rw-sentence span:first-child {
		opacity: 1;
	}
	</style>
	<!--[if lt IE 9]> 
			<style>
				.rw-wrapper{ display: none; } 
				.rw-sentence-IE{ display: block;  }
			</style>
	<![endif]-->
		
<!-- for blog category ui -->
		<link rel="stylesheet" type="text/css" href="<%=cp%>/resources/Transitions/css/normalize.css" />
		<link rel="stylesheet" type="text/css" href="<%=cp%>/resources/Transitions/css/demo.css" />
		<link rel="stylesheet" type="text/css" href="<%=cp%>/resources/Transitions/css/icons.css" />
		<link rel="stylesheet" type="text/css" href="<%=cp%>/resources/Transitions/css/component.css" />
		<script src="<%=cp%>/resources/Transitions/js/modernizr.custom.js"></script>

<!-- for metro -->
    <link href="<%=cp%>/resources/metro/css/metro.css" rel="stylesheet">
    <link href="<%=cp%>/resources/metro/css/metro-icons.css" rel="stylesheet">
    <link href="<%=cp%>/resources/metro/css/metro-responsive.css" rel="stylesheet">

    <%-- <script src="<%=cp%>/resources/metro/js/jquery-2.1.3.min.js"></script> --%>
    <script src="<%=cp%>/resources/metro/js/metro.js"></script>
	
<!-- for fontawesome -->
	<link href="<%=cp%>/resources/bootstrap/font-awesome/css/font-awesome.min.css" rel="stylesheet">

<!-- 내 css -->	
	<link href="<%=cp%>/resources/css/custom.css" rel="stylesheet">
	
<!-- 내 폰트 -->
	<link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
	
<!-- 내 스크립트 -->
<script type="text/javascript">
$(function() {
	// 캔버스 친구들
	var canvas = document.getElementById("canvas");
	var ctx = canvas.getContext("2d"); // 캔버스 객체 생성
	
	var mindmap = new Array();

	
	$.getJSON("<c:url value="/resources/json/mindmap.json"/>", function(json) {
	    // console.log(json); // this will show the info it in firebug console
	    for(var i in json.categories){
	    	mindmap[i]=json.categories[i];
        }
	    //console.log(mindmap[3].name);
	    
	    mindmapReder();
	});

	function mindmapReder(){
		// 캔버스 지우기
		ctx.clearRect(0, 0, canvas.width, canvas.height);
		
		ctx.font="30px Noto Sans KR";
		// 그냥 글씨
		ctx.fillStyle = 'white';
		
		//xy 값 지정
		for (var i = 0; i < mindmap.length; i++) {
			if(mindmap[i].parent == mindmap[i].id){
				
				mindmap[i].locX = 100; /* canvas.width/2 */
				mindmap[i].locY = canvas.height/2;
			}
			else{
				for (var j = 0; j < mindmap.length; j++) {
					if(mindmap[i].parent == mindmap[j].id){
						mindmap[i].locX = mindmap[j].locX+200;
						mindmap[i].locY = (mindmap[j].locY)/2;
						
						for (var x = 0; x < mindmap.length; x++) {
							//if(엄마가 같으면 id가 큰게 한단계 내려감)
							if(mindmap[i].parent == mindmap[x].parent){
								if(mindmap[i].id > mindmap[x].id){
									mindmap[i].locY = mindmap[i].locY+100;
								}
							}
						}
						
					}
				}
			}
		}
		
		// 그리기
		for (var i = 0; i < mindmap.length; i++) {
			//ctx.fillText(mindmap[i].name,mindmap[i].locX,mindmap[i].locY); // x, y
			ctx.fillText(mindmap[i].locX+" , "+mindmap[i].locY,mindmap[i].locX,mindmap[i].locY); // x, y
		}	
		
		// 부모 있으면 부모 - 자식 위치
		
		for (var i = 0; i < mindmap.length; i++) {
			if(mindmap[i].parent == mindmap[i].id){
				
			}
			else{
				for (var j = 0; j < mindmap.length; j++) {
					if(mindmap[i].parent == mindmap[j].id){
						
						ctx.lineWidth = 1;
				        ctx.beginPath();
				        ctx.moveTo(mindmap[j].locX,mindmap[j].locY);
				        ctx.lineTo(mindmap[i].locX,mindmap[i].locY);
				        ctx.strokeStyle = '#dddddd';
				        ctx.stroke();
						
					}
				}
			}
		}
		
		/* ctx.lineWidth = 1;
        ctx.beginPath();
        ctx.moveTo(50,canvas.height/2);
        ctx.lineTo(250,(canvas.height/2)/2);
        ctx.strokeStyle = '#dddddd';
        ctx.stroke();
		
		ctx.fillText('컴퓨터',250,(canvas.height/2)/2); // x, y 부모 y의 2 for 문 돌릴때 형제는 -20 식으로 */
	}
	
	function mindmapRederBack(){
		// 캔버스 지우기
		ctx.clearRect(0, 0, canvas.width, canvas.height);
		
		ctx.font="30px Noto Sans KR";
		// 그냥 글씨
		ctx.fillStyle = 'white';
		ctx.fillText('황인영',50,canvas.height/2); // x, y
		// 부모가 없는 거부터
		
		ctx.lineWidth = 1;
        ctx.beginPath();
        ctx.moveTo(50,canvas.height/2);
        ctx.lineTo(250,(canvas.height/2)/2);
        ctx.strokeStyle = '#dddddd';
        ctx.stroke();
		
		ctx.fillText('컴퓨터',250,(canvas.height/2)/2); // x, y 부모 y의 2 for 문 돌릴때 형제는 -20 식으로
	}
});
</script>

</head>
<body>
<div id="fullpage">
	<div class="section" id="section0">

	                <canvas id="canvas" width="1500" height="700" style="border: 1px solid black;"></canvas>
	</div>
</div> <!-- fullpage end -->
</body>
</html>