<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.UserDTO" %>
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
   <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
<style>
.navbar-nav li:hover > ul.dropdown-menu {
    display: block;
}
.dropdown-submenu {
    position:relative;
}
.dropdown-submenu>.dropdown-menu {
    top:0;
    left:100%;
    margin-top:-6px;
}

/* rotate caret on hover */
.dropdown-menu > li > a:hover:after {
    text-decoration: underline;
    transform: rotate(-90deg);
} 
</style>
<script type="text/javascript">
   function delFunction(){
      UserDAO.delUser(request.getParmeter("userID"));
      //UserDAO.delUsesr("userID");
      String message="삭제되지 않았습니다.";
      if(result>0){
         message="삭제되었습니다.";
      }
   }
</script>
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
</head>
<body>
<%
   String search="";    //검색 학번  
	String userGrade="전체";  //검색 학년
   String userDepart="전체"; //검색 학과
   String getGradu="전체"; //졸업 충족 여부
   
   int pageNumber =0;
   String userID=null;
   
   if(session.getAttribute("userID")!=null){             //세션 userID
	      userID=(String)session.getAttribute("userID");
	   }
	   if(request.getParameter("search")!=null){             //검색으로 받아오는 학번
	      search=request.getParameter("search");
	   }
	   if(request.getParameter("userGrade")!=null){             //검색으로 받아오는 학년
	      userGrade=request.getParameter("userGrade");
	   }
	   if(request.getParameter("userDepart")!=null){             //검색으로 받아오는 학과
	      userDepart=request.getParameter("userDepart");
	   }
	   if(request.getParameter("getGradu")!=null){             //검색으로 받아오는 졸업 충족 여부
		   getGradu=request.getParameter("getGradu");
		}
   
   
   if(request.getParameter("pageNumber")!=null){         //페이징 처리
      try{//정수형으로 입력 안 했을 시에는 오류가 나기 때문에
         pageNumber=Integer.parseInt(request.getParameter("pageNumber"));
      } catch(Exception e){
         System.out.println("검색 페이지 번호 오류");
      }
   }
   if(userID==null){
      PrintWriter script=response.getWriter();
      script.println("<script>");
      script.println("alert('로그인을 해주세요.');");
      script.println("location.href='userLogin.jsp';");
      script.println("</script>");
      script.close();
      return;
   }
%>
  

<nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top">
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
         <li class="nav-item dropdown"><!-- 눌렀을때 아래쪽으로 목록 나오게 하는 것 -->
            <!-- 한번 눌렀을때 요소가 나오고 다시 누르면 사라진다. -->
            <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
                  회원 관리
            </a>
            <!-- 실질적으로 회원들이 눌렀을때 나오는 정보 -->
            <div class="dropdown-menu" aria-labelledby="dropdown">
               <a class="dropdown-item" href="userModify.jsp">내등록정보</a>
               <a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
            </div>
         </li>
           <li class="nav-item dropdown"><!-- active는 현재 위치한 페이지에 넣으면 된다./현재 위치가 파란색으로 표시된다. -->
           <a class="nav-link active dropdown-toggle" id="dropdown" data-toggle="dropdown">
                관리자
            </a>
            <!-- 실질적으로 회원들이 눌렀을때 나오는 정보 -->
            <div class="dropdown-menu" aria-labelledby="dropdown">
               <a class="dropdown-item active" href="adminStudent.jsp">관리자 학생 관리</a>
               <a class="dropdown-item" href="adminPlus.jsp">관리자 추가</a>
            </div>
      </li>
      </ul>
   </div>
   </nav><!-- 상단바 -->
   
   <section class="container"><!-- 반응형; 특정한 요소가 알아서 작아지게 하는데 도움을 준다. -->
      <!-- get방식; 사용자가 서버에 데이터 전달하도록, mt-3;위쪽으로 3만큼 마진을 준다. -->
      <form method="get" action="./adminStudent.jsp" class="form-inline mt-3">
         <select name="userGrade" class="form-control mx-1 mt-2">
            <option value="전체">학년</option>
             <option value="1">1학년</option>
	         <option value="2">2학년</option>
	         <option value="3">3학년</option>
	         <option value="4">4학년</option>
         </select>
         <select name="userDepart" class="form-control mx-1 mt-2">
            <option value="전체">학과</option>
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
         
         <select name="getGradu" class="form-control mx-1 mt-2">
            <option value="전체">졸업 충족 여부</option>
              <option value="충족">충족</option>
	         <option value="미충족">미충족</option>
         </select>
         <input type="text" name="search" class="form-control mx-1 mt-2" placeholder="학번을 입력하세요.">
         <button type="submit" class="btn btn-primary mx-1 mt-2">조회</button>
      </form>
      
      <div class="container">
      <div class="row">
         <table class="table mx-2 mt-4" style="text-align: center; border: 1px solid #dddddd">
            <thead>
               <tr>
                  <th style="background-color:#eeeeee; text-align: center;">학번</th>
                  <th style="background-color:#eeeeee; text-align: center;">비밀번호</th>
                  <th style="background-color:#eeeeee; text-align: center;">이름</th>
                  <th style="background-color:#eeeeee; text-align: center;">학년</th>
                  <th style="background-color:#eeeeee; text-align: center;">학과</th> 
                  <th style="background-color:#eeeeee; text-align: center;">졸업 충족 여부</th> 
                  <th style="background-color:#eeeeee; text-align: center;">정보 수정</th> 
                  <th style="background-color:#eeeeee; text-align: center;">회원 탈퇴</th>
                  
               </tr>
            </thead>
            <tbody>
            <%
            	String graduPrint=null;
               ArrayList<UserDTO> userList=new ArrayList<UserDTO>();
            	userList=new UserDAO().getListUser(search, pageNumber,userGrade, userDepart, getGradu);
               if(userList != null)
                  for(int i=0; i < userList.size(); i++){
                     UserDTO user = userList.get(i);
                     if(user.isGradu()==false){
                    	 graduPrint="미충족";
                     }else{
                    	 graduPrint="충족";
                     }
            %>
               <tr>
                  <td><%= user.getUserID() %></td>
                  <td><%= user.getUserPassword() %></td>
                  <td><%= user.getUserName() %></td>
                  <td><%= user.getUserGrade() %></td>
                  <td><%= user.getUserDepart() %></td>
                  <td><%= graduPrint %></td>
                  <td><button class="checkBtn btn btn-outline-primary my-2 my-sm-0" type="submit">수정</button></td>
                  <td><button class="checkBtn1 btn btn-outline-danger my-2 my-sm-0" type="submit">탈퇴</button></td>
               </tr>
                 
            <%
                  }
            %>
            </tbody>
         </table>
      </div>
      </div>
   </section>
   
   <ul class="pagination justify-content-center mt-3">
      <li class="page-item">
<%
   if(pageNumber <=0) {
%>
   <a class="page-link disabled">이전</a>
<%
   } else {
%>
   <a class="page-link" href="./adminStudent.jsp?search=<%= URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%= pageNumber -1 %>">이전</a>
<%
   }
%>
      </li>   
      <li>
<%
   if(userList.size()<5) { //강의평가가 6개 이상 존재한다면 다음 페이지가 존재한다는 것이기 때문에(한 페이지에 5개까지 보임)
%>
   <a class="page-link disabled">다음</a>
<%
   } else {
%>
   <a class="page-link" href="./adminStudent.jsp?search=<%= URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%= pageNumber +1 %>">다음</a>
<%
   }
%>
      </li>
   </ul>
   
   
   <script>
		// 버튼 클릭시 Row 값 가져오기
	   $(".checkBtn").click(function(){ 
	       
	       var str = ""
	       var tdArr = new Array();    // 배열 선언
	       var checkBtn = $(this);
	       
	       // checkBtn.parent() : checkBtn의 부모는 <td>이다.
	       // checkBtn.parent().parent() : <td>의 부모이므로 <tr>이다.
	       var tr = checkBtn.parent().parent();
	       var td = tr.children();
	       
	//       var subjName = td.eq(0).text();
	       var userID = td.eq(0).text();
	       var userPassword = td.eq(1).text();
	       var userName = td.eq(2).text();
	 //     var userGrade = td.eq(3).text();
	       var userDepart = td.eq(4).text();

           document.getElementById("userID").value=userID;
           document.getElementById("userPassword").value=userPassword;
           document.getElementById("userName").value=userName;
        //   document.getElementById("userGrade").value=userGrade;
           document.getElementById("userDepart").value=userDepart;
	       $('#Modal').modal("show");
	    
	   });
   </script>  
  
    
 <div class="modal fade" id="Modal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
      <div class="modal-dialog">
         <div class="modal-content"> 
            <div class="modal-header">
               <h5 class="modla-title" id="modal">등록하기</h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="Close"> 
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body"> 
		<form method="post" action="./userUpdate">
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
			
		<!-- 	<div class="form-group">
				<label>학년</label>
				<select name="userGrade" id="userGrade" class="form-control">
					<option value="" disabled>-- 학년을 선택해주세요. --</option>
					<option value="1">1학년</option>
					<option value="2">2학년</option>
					<option value="3">3학년</option>
					<option value="4">4학년</option>
				</select>
			</div> -->
			<div class="form-group">
				<label>학과</label>
				<select name="userDepart" id="userDepart" class="form-control">
					<option value="" disabled>-- 학과를 선택해주세요. --</option>
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
			<div class="modal-footer">
                     <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                     <button type="submit" class="btn btn-primary">수정하기</button>
             </div>
		</form>
            </div>
         </div>
      </div>
   </div>
  
   <script>
		// 버튼 클릭시 Row 값 가져오기
	   $(".checkBtn1").click(function(){ 
	       
	       var str = ""
	       var tdArr = new Array();    // 배열 선언
	       var checkBtn = $(this);
	       
	       // checkBtn.parent() : checkBtn의 부모는 <td>이다.
	       // checkBtn.parent().parent() : <td>의 부모이므로 <tr>이다.
	       var tr = checkBtn.parent().parent();
	       var td = tr.children();
	       
	//       var subjName = td.eq(0).text();
	       var userID = td.eq(0).text();
/*	       var userDepart = td.eq(2).text();
	       var userAdmission = td.eq(3).text();
	       var subjGrade = td.eq(4).text();
	       var subjSemester = td.eq(5).text();*/

           document.getElementById("checkId").value=userID;
	       $('#checkModal').modal("show");
	    
	   });
   </script>  
	
   <!-- modal 양식 -->
   <!-- 일반적으로 class는 modal fade를 쓴다. dialog는 모달 다이얼로그창 -->
   <!-- 위의 등록하기 버튼을 누르면 나온다. -->

   
  <div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog"><!-- 전반적으로 modal 창이다 라는 것을 알려준다. -->
         <div class="modal-content panel-info" id="checkType"> <!-- 모달 창이 들어가는 내용 -->
            <div class="modal-header panel-heading"> <!-- 모달의 제목 -->
               <h5 class="modla-title">알림</h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <!-- data-dismiss가 모달창 닫는거 -->
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
					<div class="modal-body" id="checkMessage">
					<form  action="./userDel" method="post">
					<label>탈퇴를 진행하시겠습니까?</label>
						<input type="hidden" name="checkId" id="checkId"class="form-control">
						<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				<button type="submit" class="btn btn-danger">탈퇴</button></div>
					</form>
					</div>
				</div>
			</div>
		</div>
   
   <!-- 제이쿼리 자바스크립트 추가하기 -->
   <script src="./js/jquery.min.js"></script>
   <!-- 파퍼 자바스크립트 추가하기 -->
   <script src="./js/pooper.js"></script>
   <!-- 부트스트랩 자바스크립트 추가하기 -->
   <script src="./js/bootstrap.min.js"></script>

</body>
</html>