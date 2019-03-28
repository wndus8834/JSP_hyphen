<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.UserDTO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
   <%
      String userID=null;
      String search="";
      int pageNumber=0;
      if(session.getAttribute("userID")!=null){
         userID=(String)session.getAttribute("userID");
      }
      if(request.getParameter("search")!=null){
         search=request.getParameter("search");
      }
      if(request.getParameter("pageNumber")!=null){
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
<head>
   <style type="text/css">
   .checkBtn{
      background-color: white; /* Green */
       border: 2px solid #4CAF50;
       color: black;
       padding: 8px 8px;
       text-align: center;
       text-decoration: none;
       display: inline-block;
       font-size: 20px;
       border-radius: 6px;
       -webkit-transition-duration: 0.4s; /* Safari */
       transition-duration: 0.4s;
   }
   .checkBtn:hover{
      background-color: #4CAF50; /* Green */
       color: white;
   }
   </style>
   <meta http-equiv="Content_Type" content="text/html" charset="UTF-8">
   <!-- 반응형 웹, 자동형 웹 -->
   <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
   <title>TERM</title>
   <!-- 부트스트랩 CSS 추가하기 -->
   <link rel="stylesheet" href="./css/bootstrap.min.css">
   <!-- 커스텀 CSS 추가하기 -->
   <link rel="stylesheet" href="./css/custom.css">
   <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
   <script src="js/bootstrap.js"></script>
   
</head>
<body>

   

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
               <a class="dropdown-item" href="adminStudent.jsp">관리자 학생 관리</a>
               <a class="dropdown-item active" href="adminPlus.jsp">관리자 추가</a>
            </div>
      </li>
      </ul>
   </div>
   </nav>
   <!-- 상단바 --><!-- 상단바 -->
   
   
   <section class="container">
      <form method="get" action="./adminPlus.jsp" class="form-inline mt-3">
            <input type="text" name="search" class="form-control mx-1 mt-2" placeholder="교번을 입력하세요.">
         <button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
      </form>
      <div class="container">
         <table class="table  mx-2 mt-4 table-hover" style="text-align: center; border: 1px solid #dddddd">
            <thead>
               <tr>
                  <th style="background-color:#eeeeee; text-align: center;">학번</th>
                     <th style="background-color:#eeeeee; text-align: center;">이름</th>
                     <th style="background-color:#eeeeee; text-align: center;">관리자 권한 부여</th>
               </tr>
            </thead>
            <tbody>
            <%
               ArrayList<UserDTO> userList2=new ArrayList<UserDTO>();
               userList2=new UserDAO().getListAdmin(search, pageNumber); 
               if(userList2 != null)
                  for(int i=0; i < userList2.size(); i++){
                     UserDTO user = userList2.get(i);
            %>
               <tr>
                  <td><%= user.getUserID() %></td>
                  <td><%= user.getUserName() %></td>
                  <td><button class="checkBtn btn btn-outline-success my-2 my-sm-0" type="submit">권한 부여</button></td>
               </tr>
            <%
                  }
            %>
            </tbody>
         </table>
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
   <a class="page-link" href="./adminPlus.jsp?search=<%= URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%= pageNumber -1 %>">이전</a>
<%
   }
%>
      </li>   
      <li>
<%
   if(userList2.size()<5) { //강의평가가 6개 이상 존재한다면 다음 페이지가 존재한다는 것이기 때문에(한 페이지에 5개까지 보임)
%>
   <a class="page-link disabled">다음</a>
<%
   } else {
%>
   <a class="page-link" href="./adminPlus.jsp?search=<%= URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%= pageNumber +1 %>">다음</a>
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
          
          console.log("클릭한 Row의 모든 데이터 : "+tr.text());
          
          var userId = td.eq(0).text();
          var userName = td.eq(1).text();
                
          
          // 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
          td.each(function(i){    
              tdArr.push(td.eq(i).text());
          });
          
          console.log("배열에 담긴 값 : "+tdArr);
          

          str +=  "아이디 : <font color='red'>" + userId + "</font>" +
                  ", 이름 : <font color='red'>" + userName + "</font>";        
          
          $("#ex2_Result1").html(" * 클릭한 Row의 모든 데이터 = " + tr.text());        
          $("#ex2_Result2").html(str);
          
          $.ajax({
              type: "POST",
              url: './UserAdminPlus',
              data: {userID: userId},
              success: function(result){
                 if(!result){
                    $('#checkMessage').html('관리자 권한 부여가 실패했습니다..');
                    $('#checkType').attr('class', 'modal-content panel-warning');
                 }else{
                     $('#checkMessage').html('관리자 권한이 부여 되었습니다.');
                     $('#checkType').attr('class', 'modal-content panel-success');
                  }              
                 $('#checkModal').modal("show");
              }
           });
      });
   </script>  
   
  <div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog"><!-- 전반적으로 modal 창이다 라는 것을 알려준다. -->
         <div class="modal-content panel-info" id="checkType"> <!-- 모달 창이 들어가는 내용 -->
            <div class="modal-header panel-heading"> <!-- 모달의 제목 -->
               <h5 class="modla-title">등록하기</h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <!-- data-dismiss가 모달창 닫는거 -->
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
               <div class="modal-body" id="checkMessage">
               </div>
               
               <div class="modal-footer">
                  <button type="button"  onclick="window.location.reload()" class="btn btn-primary" data-dismiss="modal">확인</button>
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