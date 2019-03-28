<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
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
<%
	String userID=null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	boolean adminChecked = new UserDAO().getAdminChecked(userID);
	

	if(userID==null){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href='userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	UserDTO user = new UserDAO().getUser(userID);
%>
	

   <!-- bootstrap에서 제공하는 api - navbar -->
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
			
<%
	if(adminChecked==false){
%>
			 <li class="nav-item">
				<a class="nav-link" href="InsertClass.jsp">수강 과목 등록</a>
		</li>
<%		
	}
%>
            
	         <li class="nav-item dropdown"><!-- 눌렀을때 아래쪽으로 목록 나오게 하는 것 -->
	            <!-- 한번 눌렀을때 요소가 나오고 다시 누르면 사라진다. -->
	            <a class="nav-link active dropdown-toggle" id="dropdown" data-toggle="dropdown">
	            	   회원 관리
	            </a>
	            <!-- 실질적으로 회원들이 눌렀을때 나오는 정보 -->
	            <div class="dropdown-menu" aria-labelledby="dropdown">
	               <a class="dropdown-item active" href="userModify.jsp">내등록정보</a>
	               <a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
	            </div>
	         </li>
<%
	if(adminChecked==true){
%>
			 <li class="nav-item dropdown"><!-- active는 현재 위치한 페이지에 넣으면 된다./현재 위치가 파란색으로 표시된다. -->
           <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
                관리자
            </a>
            <!-- 실질적으로 회원들이 눌렀을때 나오는 정보 -->
            <div class="dropdown-menu" aria-labelledby="dropdown">
               <a class="dropdown-item" href="adminStudent.jsp">관리자 학생 관리</a>
               <a class="dropdown-item" href="adminPlus.jsp">관리자 추가</a>
            </div>
      </li>

<%		
	}
%>
         
		</ul>
	</div>
	</nav><!-- 상단바 -->

	<section class="container mt-3" style="max-width: 560px;">
		<h4><회원정보 수정></h4><br>
		<form method="post" action="./userUpdate">
			<div class="form-group">
				<label>아이디</label>
				<h5><%= user.getUserID() %></h5>
				<input type="hidden" name="userID" value="<%= user.getUserID() %>">
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
				<label>학과</label>
				<select name="userDepart" id="userDepart" class="form-control">
					<option value="" disabled  <% if((user.getUserDepart()).equals("")) out.println("selected"); %>>-- 학과를 선택해주세요. --</option>
					<option value="인문융합 자율학부" <% if((user.getUserDepart()).equals("인문융합 자율학부")) out.println("selected"); %>>인문융합 자율학부</option>
					<option value="1" <% if((user.getUserDepart()).equals("사회융합 자율학부")) out.println("selected"); %>>사회융합 자율학부</option>
					<option value="사회융합 자율학부" <% if((user.getUserDepart()).equals("미디어컨텐츠융합 자율학부")) out.println("selected"); %>>미디어컨텐츠융합 자율학부</option>
					<option value="IT융합 자율학부" <% if((user.getUserDepart()).equals("IT융합 자율학부")) out.println("selected"); %>>IT융합 자율학부</option>
					<option value="신학과" <% if((user.getUserDepart()).equals("신학과")) out.println("selected"); %>>신학과</option>
					<option value="영어학과" <% if((user.getUserDepart()).equals("영어학과")) out.println("selected"); %>>영어학과</option>
					<option value="일어일본학과" <% if((user.getUserDepart()).equals("일어일본학과")) out.println("selected"); %>>일어일본학과</option>
					<option value="중어중국학과" <% if((user.getUserDepart()).equals("중어중국학과")) out.println("selected"); %>>중어중국학과</option>
					<option value="사회복지학과" <% if((user.getUserDepart()).equals("사회복지학과")) out.println("selected"); %>>사회복지학과</option>
					<option value="사회과학부" <% if((user.getUserDepart()).equals("사회과학부")) out.println("selected"); %>>사회과학부</option>
					<option value="신문방송학과" <% if((user.getUserDepart()).equals("신문방송학과")) out.println("selected"); %>>신문방송학과</option>
					<option value="경영학부" <% if((user.getUserDepart()).equals("경영학부")) out.println("selected"); %>>경영학부</option>
					<option value="디지털컨텐츠학과" <% if((user.getUserDepart()).equals("디지털컨텐츠학과")) out.println("selected"); %>>디지털컨텐츠학과</option>
					<option value="컴퓨터공학과" <% if((user.getUserDepart()).equals("컴퓨터공학과")) out.println("selected"); %>>컴퓨터공학과</option>
					<option value="소프트웨어공학과" <% if((user.getUserDepart()).equals("소프트웨어공학과")) out.println("selected"); %>>소프트웨어공학과</option>
					<option value="정보통신공학과" <% if((user.getUserDepart()).equals("정보통신공학과")) out.println("selected"); %>>정보통신공학과</option>
					<option value="글로컬IT학과" <% if((user.getUserDepart()).equals("글로컬IT학과")) out.println("selected"); %>>글로컬IT학과</option>
				</select>
			</div>
			<div class="form-group">
				<label>학년</label>
				<select name="userGrade" id="userGrade" class="form-control">
					<option value="" disabled   <% if((user.getUserGrade()).equals("")) out.println("selected"); %>>-- 학년을 선택해주세요. --</option>
					<option value="1" <% if((user.getUserGrade()).equals("1")) out.println("selected"); %>>1학년</option>
					<option value="2" <% if((user.getUserGrade()).equals("2")) out.println("selected"); %>>2학년</option>
					<option value="3" <% if((user.getUserGrade()).equals("3")) out.println("selected"); %>>3학년</option>
					<option value="4" <% if((user.getUserGrade()).equals("4")) out.println("selected"); %>>4학년</option>
				</select>
			</div>
			<div class="form-group">
				<label>성별</label>
				<select name="person" id="person" class="form-control"> 
					<option value="" disabled   <% if((user.getPerson()).equals("")) out.println("selected"); %>>-- 학년을 선택해주세요. --</option>
					<option value="남" <% if((user.getPerson()).equals("남")) out.println("selected"); %>>남</option>
					<option value="여" <% if((user.getPerson()).equals("여")) out.println("selected"); %>>여</option>
				</select>
			</div>
			<div class="form-group">
				<label>이름</label>
				<input type="text" name="userName" class="form-control" value="<%= user.getUserName() %>"placeholder="실명을 입력해주세요.">
			</div>
			<div class="form-group">
				<label>이메일</label>
				<input type="email" name="userEmail" class="form-control" value="<%= user.getUserEmail() %>"placeholder="이메일을 입력해주세요.">
			</div>
			<div class="form-group">
				<label>휴대폰 번호</label>
				<input type="text" name="userPhone" class="form-control" onblur="chk_tel(this.value,this);" value="<%= user.getUserPhone() %>"placeholder="(-없이)휴대폰 번호를 입력해주세요.">
			</div>
			
			<div class="row">
				<div class="col-12"><input type="submit" class="btn btn-primary float-right" value="회원정보 수정"></div>
			</div>
			
		</form>
	</section>




	
	<br>
	<!-- 가장 아래쪽에 들어가는 내용 -->
	<footer class="bg-dark mt-4 p-3 text-center fixed-bottom" style="color: #FFFFFF;">
	<!-- 저작권 표시 -->
		Copyright &copy; 2018 HADA All Rights Reserved.
	</footer>
	
	<!-- 제이쿼리 자바스크립트 추가하기 -->
	<script src="./js/jquery.min.js"></script>
	<!-- 파퍼 자바스크립트 추가하기 -->
	<script src="./js/pooper.js"></script>
	<!-- 부트스트랩 자바스크립트 추가하기 -->
	<script src="./js/bootstrap.min.js"></script>

</body>
</html>