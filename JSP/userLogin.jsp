<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content_Type" content="text/html" charset="UTF-8">
	<!-- 반응형 웹, 자동형 웹 -->
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>TERM</title>
	<!-- 부트스트랩 CSS 추가하기 -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<!-- 커스텀 CSS 추가하기 -->
	<link rel="stylesheet" href="./css/custom.css">   
	</head>
<body>

   <!-- bootstrap에서 제공하는 api - navbar -->
   <nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top">  <!-- bg-light;배경이 하얗게 보인다. -->
	<!-- navbar-brand는 부트스틀랩 안에서 로고같은거 출력할때 사용하는거 -->
	<a class="navbar-brand" href="index.jsp">TERM</a> 
	<!-- 버튼을 누르면 navbar를 가진 요소가 보였다 안 보였다 함. 아래 div id에 정의함 -->
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
		<span class="navbar-toggler-icon"></span> <!-- navbar-toggler-icon; 작대기가 세줄 그어진 아이콘 -->
	</button>
	<div id="navbar" class="collapse navbar-collapse">
		<ul class="navbar-nav mr-auto nav-tabs">
			<li class="nav-item"><!-- active는 현재 위치한 페이지에 넣으면 된다./현재 위치가 파란색으로 표시된다. -->
				<a class="nav-link" href="index.jsp">메인</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="userJoin.jsp">회원가입</a>
			</li>
			<li class="nav-item">
				<a class="nav-link active" href="userLogin.jsp">로그인</a>
			</li>
		</ul>
	</div>
	</nav><!-- 상단바 -->
	<!-- 반응형; 특정한 요소가 알아서 작아지게 하는데 도움을 준다. -->
	<!-- mt-3; 위쪽으로 3만큼 마진을 준다.(네비게이션과 폼의 거리; 맨 윗 창과 로그인 형식의 거리) -->
	<section class="container mt-3" style="max-width: 560px;">
		<form method="post" action="./userLoginAction.jsp">
			<div class="form-group">
				<label>아이디</label>
				<input type="text" name="userID" class="form-control"><!-- form control; 입력 양식이 들어갈 수 있도록 -->
			</div>
			<div class="form-group">
				<label>비밀번호</label>
				<input type="password" name="userPassword" class="form-control">
			</div>
			<div>
				<input type="submit" class="btn btn-primary float-right mx-2" value="로그인">
			</div><br><br>
		</form>
	</section>
	
	
	<!-- 제이쿼리 자바스크립트 추가하기 -->
	<script src="./js/jquery.min.js"></script>
	<!-- 파퍼 자바스크립트 추가하기 -->
	<script src="./js/pooper.js"></script>
	<!-- 부트스트랩 자바스크립트 추가하기 -->
	<script src="./js/bootstrap.min.js"></script>

</body>
</html>