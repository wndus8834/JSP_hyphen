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
	<script type="text/javascript">

	function passwordCheckFunction(){
		console.log(';;;');
		var userPassword1 = $('#userPassword').val();
		var userPassword2 = $('#userPassword1').val();
		if(userPassword1 != userPassword2){
			$('#passwordCheckMessage').html('비밀번호가 서로 일치하지 않습니다.');
		}else{
			$('#passwordCheckMessage').html('');
		}
	}
	</script>
	
<script language="javascript"> 
 function chk_tel(str, field){ 
  var str; 
  str = checkDigit(str); 
  len = str.length; 
  
  if(len==8){ 
  if(str.substring(0,2)==02){ 
    error_numbr(str, field); 
  }else{ 
    field.value  = phone_format(1,str); 
  }  
  }else if(len==9){ 
  if(str.substring(0,2)==02){ 
    field.value = phone_format(2,str); 
  }else{ 
    error_numbr(str, field); 
  } 
  }else if(len==10){ 
  if(str.substring(0,2)==02){ 
    field.value = phone_format(2,str); 
  }else{ 
    field.value = phone_format(3,str); 
  } 
  }else if(len==11){ 
  if(str.substring(0,2)==02){ 
    error_numbr(str, field); 
  }else{ 
    field.value  = phone_format(3,str); 
  } 
  }else{ 
  error_numbr(str, field); 
  } 
 } 
 function checkDigit(num){ 
  var Digit = "1234567890"; 
  var string = num; 
  var len = string.length 
  var retVal = ""; 
  for (i = 0; i < len; i++){ 
  if (Digit.indexOf(string.substring(i, i+1)) >= 0){ 
    retVal = retVal + string.substring(i, i+1); 
  } 
  } 
  return retVal; 
 } 
 function phone_format(type, num){ 
  if(type==1){ 
  return num.replace(/([0-9]{4})([0-9]{4})/,"$1-$2"); 
  }else if(type==2){ 
  return num.replace(/([0-9]{2})([0-9]+)([0-9]{4})/,"$1-$2-$3"); 
  }else{ 
  return num.replace(/(^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3"); 
  } 
 } 
 function error_numbr(str, field){ 
  alert("정상적인 번호가 아닙니다."); 
  field.value = ""; 
  field.focus(); 
  return; 
 } 
  
</script> 
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top"> <!-- bg-light;배경이 하얗게 보인다. -->
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
				<a class="nav-link active" href="userJoin.jsp">회원가입</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="userLogin.jsp">로그인</a>
			</li>
		</ul>
	</div>
	</nav><!-- 상단바 -->

	<!-- 반응형; 특정한 요소가 알아서 작아지게 하는데 도움을 준다. -->
	<!-- mt-3; 위쪽으로 3만큼 마진을 준다.(네비게이션과 폼의 거리; 맨 윗 창과 로그인 형식의 거리) -->
	<section class="container mt-3" style="max-width: 560px;">
		<form method="post" action="./userButtonJoin">
			<div class="form-group">
				<label>아이디</label>
				<input type="text" name="userID" id="userID" class="form-control" placeholder="학번을 입력해주세요."><!-- form control; 입력 양식이 들어갈 수 있도록 -->
			</div>
			<div class="form-group">
				<label>비밀번호</label>
				<input type="password" name="userPassword"  id="userPassword"onkeyup="passwordCheckFunction();" maxLength="20" class="form-control">
			</div>
			<div class="form-group">
				<label>비밀번호 확인</label>
				<input type="password" name="userPassword1" id="userPassword1" onkeyup="passwordCheckFunction();"  maxLength="20" class="form-control">
			</div>
			<h5 style="color: red;" id="passwordCheckMessage"></h5>
			
			<div class="form-group">
				<label>학년</label>
				<select name="userGrade" id="userGrade" class="form-control">
					<option value="" disabled selected>-- 학년을 선택해주세요. --</option>
					<option value="1">1학년</option>
					<option value="2">2학년</option>
					<option value="3">3학년</option>
					<option value="4">4학년</option>
				</select>
			</div>
			<div class="form-group">
				<label>학과</label>
				<select name="userDepart" id="userDepart" class="form-control">
					<option value="" disabled selected>-- 학과를 선택해주세요. --</option>
							<option value="인문융합 자율학부">인문융합 자율학부</option>
							<option value="사회융합 자율학부">사회융합 자율학부</option>
							<option value="미디어컨텐츠융합 자율학부">미디어컨텐츠융합 자율학부</option>
							<option value="IT융합 자율학부">IT융합 자율학부</option>
							<option value="신학과">신학과</option>
							<option value="영어학과">영어학과</option>
							<option value="일어일본학과">일어일본학과</option>
							<option value="중어중국학과">중어중국학과</option>
							<option value="사회복지학과">사회복지학과</option>
							<option value="사회과학부">사회과학부</option>
							<option value="신문방송학과">신문방송학과</option>
							<option value="경영학부">경영학부</option>
							<option value="디지털컨텐츠학과">디지털컨텐츠학과</option>
							<option value="컴퓨터공학과">컴퓨터공학과</option>
							<option value="소프트웨어공학과">소프트웨어공학과</option>
							<option value="정보통신공학과">정보통신공학과</option>
							<option value="글로컬IT학과">글로컬IT학과</option>
				</select>
			</div>
			<div class="form-group">
				<label>이름</label>
				<input type="text" name="userName" id="userName" class="form-control" placeholder="실명을 입력해주세요.">
			</div>
			<div class="form-group">
				<label>이메일</label>
				<input type="email" name="userEmail" id="userEmail" class="form-control" placeholder="이메일을 입력해주세요.">
			</div>
			<div class="form-group">
				<label>휴대폰 번호</label>
				<input type="text" name="userPhone" id="userPhone" class="form-control"onblur="chk_tel(this.value,this);" placeholder="(-없이)휴대폰 번호를 입력해주세요.">
			</div>
			
			<div class="form-group">
				<label>성별</label><br>
				<div class="form-check form-check-inline">
				  <input class="form-check-input" type="radio" name="person" id="person" value="남" checked>
				  <label class="form-check-label" for="inlineRadio1">남</label>
				</div>
				<div class="form-check form-check-inline">
				  <input class="form-check-input" type="radio" name="person" id="person" value="여">
				  <label class="form-check-label" for="inlineRadio2">여</label>
				</div>
			</div>
			
			<div class="row">
				<div class="col-12"><input type="submit" class="btn btn-primary float-right" value="회원가입"></div>
			</div>
			
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