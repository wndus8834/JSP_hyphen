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
   
   </head>
<body>
<%
   String userID=null;
   if(session.getAttribute("userID")!=null){
      userID=(String)session.getAttribute("userID");
   }
   boolean adminChecked=new UserDAO().getAdminChecked(userID);
	UserDTO user = new UserDAO().getUser(userID);
%>
   

   <nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top">
   <a class="navbar-brand" href="index.jsp">TERM</a> 
   <!-- 버튼을 누르면 navbar를 가진 요소가 보였다 안 보였다 함. 아래 div id에 정의함 -->
   <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
      <span class="navbar-toggler-icon"></span> <!-- navbar-toggler-icon; 작대기가 세줄 그어진 아이콘 -->
   </button>
   <div id="navbar" class="collapse navbar-collapse">
      <ul class="navbar-nav mr-auto nav-tabs">
<%
   if(userID==null){
%>
      <li class="nav-item"><!-- active는 현재 위치한 페이지에 넣으면 된다./현재 위치가 파란색으로 표시된다. -->
            <a class="nav-link active" href="index.jsp">메인</a>
         </li>
         <li class="nav-item">
            <a class="nav-link" href="userJoin.jsp">회원가입</a>
         </li>
         <li class="nav-item">
            <a class="nav-link" href="userLogin.jsp">로그인</a>
         </li>
<%
   } else {
%>
      <li class="nav-item">
            <a class="nav-link active" href="index.jsp">메인</a>
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
          
         <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">
                  회원 관리
            </a>
            <div class="dropdown-menu" aria-labelledby="dropdown">
               <a class="dropdown-item" href="userModify.jsp">내등록정보</a>
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
         
         
<%
   }
%>
      </ul>
   </div>
   </nav><!-- 상단바 -->
   
   
   
   <div class="modal fade" id="Modal_upload" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
      <div class="modal-dialog"><!-- 전반적으로 modal 창이다 라는 것을 알려준다. -->
         <div class="modal-content"> <!-- 모달 창이 들어가는 내용 -->
            <div class="modal-header"> <!-- 모달의 제목 -->
               <h5 class="modla-title" id="modal">등록하기</h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <!-- data-dismiss가 모달창 닫는거 -->
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body"> <!-- 모달의 내용 -->
               <!-- 사용자가 등록 버튼 눌렀을때 사용자의 평가 등록 요청 전달 -->
               <form action="./userJoin" method="post" enctype="multipart/form-data">
                     <div class="form-group">
                        <input type="file" name="file" />
               </div>
               <%-- <input type="hidden" name="userID" value="<%= user.getUserID() %>"> --%>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                     <button type="submit" class="btn btn-primary">등록하기</button>
                  </div>
               </form>
            </div>
         </div>
      </div>
   </div>
   
   <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
   <script src="js/bootstrap.min.js"></script> 
   
   <!-- 제이쿼리 자바스크립트 추가하기 -->
   <script src="./js/jquery.min.js"></script>
   <!-- 파퍼 자바스크립트 추가하기 -->
   <script src="./js/pooper.js"></script>
   <!-- 부트스트랩 자바스크립트 추가하기 -->
   <script src="./js/bootstrap.min.js"></script>
   
</body>
</html>