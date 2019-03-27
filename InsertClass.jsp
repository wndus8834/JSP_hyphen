<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="userClass.userClassDTO" %> 
<%@ page import="userClass.userClassDAO" %>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="userScore.userScoreDTO" %>
<%@ page import="userScore.userScoreDAO" %>

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
</head>
<body>
<%
	String userID=null;
	String subjYear="전체";
	String subjSemester="전체";
	String subjMain="전체";
	String search="";
	int pageNumber=0;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
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
	if(request.getParameter("subjYear")!=null){
		subjYear=request.getParameter("subjYear");
	}
	if(request.getParameter("subjSemester")!=null){
		subjSemester=request.getParameter("subjSemester");
	}
	if(request.getParameter("subjMain")!=null){
		subjMain=request.getParameter("subjMain");
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
	
	UserDTO user = new UserDAO().getUser(userID);
	

	double refinementScore=0.0;//교양점수
	double culturalReqScore=0.0;//교필점수
	double majorSelectScore=0.0;//전선점수
	double majorReqScore=0.0;//전필점수
	
	double neceCultur=0.0;//필수 교양 퍼센트
	double allCultural=0.0;//전체 교양 퍼센트
	double neceMajor=0.0;//전공 필수 퍼센트
	double allMajor=0.0;//전체 전공 퍼센트
	double allGradu=0.0;//졸업 현황 퍼센트
	
    boolean cultureReqSatisfy=false;
    boolean majorReqSatisfy=false;
    boolean graduPossible=false;
	
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
			 <li class="nav-item"><!-- active는 현재 위치한 페이지에 넣으면 된다./현재 위치가 파란색으로 표시된다. -->
				<a class="nav-link active" href="InsertClass.jsp">수강 과목 등록</a>
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
		</ul>
	</div>
	</nav><!-- 상단바 -->
	
	<section class="container"><!-- 반응형; 특정한 요소가 알아서 작아지게 하는데 도움을 준다. -->
		<!-- get방식; 사용자가 서버에 데이터 전달하도록, mt-3;위쪽으로 3만큼 마진을 준다. -->
		<form method="get" action="./InsertClass.jsp" class="form-inline mt-3">
			<input name="search" type="text" class="form-control mx-1 mt-2" placeholder="과목명을 입력하세요.">
			<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
		</form>
		
		
		<div class="container">
		<div class="row">
			<table class="table mx-2 mt-4" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color:#eeeeee; text-align: center;">년도</th>
						<th style="background-color:#eeeeee; text-align: center;">학기</th>
						<th style="background-color:#eeeeee; text-align: center;">과목 코드</th>
						<th style="background-color:#eeeeee; text-align: center;">과목명</th>
						<th style="background-color:#eeeeee; text-align: center;">이수 구분</th>
						<th style="background-color:#eeeeee; text-align: center;">학점</th>
						<th style="background-color:#eeeeee; text-align: center;">성적등급</th>
						<th style="background-color:#eeeeee; text-align: center;">수정</th>
						<th style="background-color:#eeeeee; text-align: center;">등록 취소</th>
					</tr>
				</thead>
				<tbody>
             <%
	   			ArrayList<userClassDTO> list=new ArrayList<userClassDTO>();
    	   			
            	list=new userClassDAO().getListClassUser(search, user.getUserID()); 
	   			if(list != null)
	   				for(int i=0; i < list.size(); i++){
	   					userClassDTO sub = list.get(i);
	   		%>
				 	<tr>
				 		<td><%= sub.getSubjYear()%></td>
				 		<td><%= sub.getSubjSemester()%></td>
				 		<td><%= sub.getSubjCode()%></td>
				 		<td><%= sub.getSubjName()%></td>
				 		<td><%= sub.getSubjMain()%></td>
				 		<td><%= sub.getGrade()%></td>
				 		<td><%= sub.getScore()%></td>
				 		<td><button class="checkBtn btn btn-outline-primary my-2 my-sm-0" type="submit">수정</button></td>
				 		<td><button class="checkBtn1 btn btn-outline-danger my-2 my-sm-0" type="submit">삭제</button></td>
				 	</tr>
	        <%			
	   				}
	   			
	   			ArrayList<userClassDTO> list2=new ArrayList<userClassDTO>();
	   			list2=new userClassDAO().getListClassUser2(user.getUserID()); 
	   			if(list2 != null)
	   				for(int i=0; i < list2.size(); i++){
	   					userClassDTO sub2 = list2.get(i);
	        			if(!sub2.getScore().equals("F") && !sub2.getScore().equals("N")){
	        					if(sub2.getSubjMain().equals("전필")){
	        						majorReqScore += Double.parseDouble(sub2.getGrade());
	           					}
						        else if(sub2.getSubjMain().equals("전선")){
						        	majorSelectScore += Double.parseDouble(sub2.getGrade());
						        }
						        else if(sub2.getSubjMain().equals("교필")){
							        culturalReqScore += Double.parseDouble(sub2.getGrade());
						        }
						        else if(sub2.getSubjMain().equals("교선")){
							        refinementScore += Double.parseDouble(sub2.getGrade()); 
						        }
	        			}
	   				}

	   			int result= new userScoreDAO().search(user.getUserID());// System.out.println(result); 
	   			
	   			if(result==1){
		   			int result1 = new userScoreDAO().update(user.getUserID(), String.valueOf(refinementScore), String.valueOf(culturalReqScore), String.valueOf(majorSelectScore),String.valueOf(majorReqScore));
	   			} else{
	   				int result2 = new userScoreDAO().Add(user.getUserID(), String.valueOf(refinementScore), String.valueOf(culturalReqScore), String.valueOf(majorSelectScore),String.valueOf(majorReqScore));
	   			}  

	   		%>
				</tbody>
			</table>
		</div>
		<div class="row">
            <div class="col-12">
            
            <a class="btn btn-primary float-right ml-2" data-toggle="modal" href="#Modal_upload">Excel 업로드</a>
            
            </div>
         </div>
		</div>
		
		  	  
    
    
	</section>
	

<%
	if(allCultural<100 || neceCultur<100){  
		cultureReqSatisfy=false;
	}else{
		cultureReqSatisfy=true;
	}
	
	if(allMajor < 100 || neceMajor<100){//총전공
	    majorReqSatisfy=false;
	 }else{
	    majorReqSatisfy=true;
	 }
	
	int gradu=0;
	if(cultureReqSatisfy==true && majorReqSatisfy==true && allGradu>100){
		graduPossible=true;
		gradu=new UserDAO().setGraduTrue(user.getUserID()); 
	}else{
		graduPossible=false;
		gradu=new UserDAO().setGraduFalse(user.getUserID());
	}	
	
	int resultCheck = new userScoreDAO().updateCheck(user.getUserID(), cultureReqSatisfy, majorReqSatisfy, graduPossible);
	
	if(resultCheck==-1){
	   int result2 = new userScoreDAO().AddCheck(user.getUserID(), cultureReqSatisfy, majorReqSatisfy, graduPossible);
	}
	
%>
     
   <script>
      // 버튼 클릭시 Row 값 가져오기
      $(".checkBtn").click(function(){ 
         var str = "";
          var tdArr = new Array();    // 배열 선언
          var checkBtn = $(this);
          
           //checkBtn.parent() : checkBtn의 부모는 <td>이다.
           //checkBtn.parent().parent() : <td>의 부모이므로 <tr>이다.
          var tr = checkBtn.parent().parent();
          var td = tr.children();
           
          console.log("클릭한 Row의 모든 데이터 : "+tr.text());
          
          var subjYear = td.eq(0).text();
          var subjSemester = td.eq(1).text(); 
          var subjCode = td.eq(2).text(); 
          var subjName = td.eq(3).text();  
          var subjMain = td.eq(4).text(); 
          var grade = td.eq(5).text();
          var score = td.eq(6).text();  
          
          
         
          document.getElementById("subjyear").value=subjYear;
          document.getElementById("subjsemester").value=subjSemester;
          document.getElementById("subjcode").value=subjCode;
          document.getElementById("subjname").value=subjName;
          document.getElementById("subjmain").value=subjMain;
          document.getElementById("userscore").value=score;
          document.getElementById("usergrade").value=grade;
          
          $('#exampleModal').modal("show");
      });
   </script>  
     
   
 <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
      <div class="modal-dialog">
         <div class="modal-content"> 
            <div class="modal-header">
               <h5 class="modla-title" id="modal">등록하기</h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="Close"> 
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body"> 
               <form action="./userClassUpdate" method="post">
               		<div class="form-group">
						<label>개설년도</label>
						<select name="subjyear" id="subjyear" class="form-control mx-1 mt-2">
							<option value="" disabled>-- 년도를 선택해주세요. --</option>
							<option value="2011">2011</option>
							<option value="2012">2012</option>
							<option value="2013">2013</option>
							<option value="2014">2014</option>
							<option value="2015">2015</option>
							<option value="2016">2016</option>
							<option value="2017">2017</option>
							<option value="2018">2018</option>
							<option value="2019">2019</option>
							<option value="2020">2020</option>
							<option value="2021">2021</option>
							<option value="2022">2022</option>
							<option value="2023">2023</option>
						</select>
					</div>
               		<div class="form-group">
						<label>개설학기</label>
						<select  name="subjsemester" id="subjsemester" class="form-control mx-1 mt-2">
							<option value="" disabled>-- 학기를 선택해주세요. --</option>
							<option value="1학기">1학기</option>
							<option value="여름학기">여름학기</option>
							<option value="2학기">2학기</option>
							<option value="겨울학기">겨울학기</option>
						</select>
					</div>
               		<div class="form-group">
						<label>이수구분</label>
						<select  name="subjmain" id="subjmain" class="form-control mx-1 mt-2">
							<option value="" disabled>-- 이수구분을 선택해주세요. --</option>
							<option value="전필">전필</option>
							<option value="전선">전선</option>
							<option value="전탐">전탐</option>
							<option value="교필">교필</option>
							<option value="교선">교선</option>
							<option value="기타">기타</option>
						</select>
					</div>
					<div class="form-group">
						<label>과목코드</label>
						<input type="text" name="subjcode" id="subjcode" class="form-control" placeholder="과목코드 입력란">
					</div>
					<div class="form-group">
						<label>과목명</label>
						<input type="text" name="subjname" id="subjname" class="form-control" placeholder="과목명 입력란">
					</div>
                     
					<div class="form-group">
						<label>학점</label>
						<input type="text" name="usergrade" id="usergrade" class="form-control" placeholder="과목코드 입력란">
					</div>
					
            		<div class="form-group">
						<label>성적등급</label>
						<select  name="userscore" id="userscore" class="form-control mx-1 mt-2">
							<option value="" disabled selected>-- 성적을 선택해주세요. --</option>
							<option value="A+">A+</option>
							<option value="A0">A0</option>
							<option value="B+">B+</option>
							<option value="B0">B0</option>
							<option value="C+">C+</option>
							<option value="C0">C0</option>
							<option value="D+">D+</option>
							<option value="D0">D0</option>
							<option value="F">F</option>
							<option value="P">P</option>
							<option value="N">N</option>
						</select>
					</div> 
						<input type="hidden" name="userID" value="<%= user.getUserID() %>">
                  <div class="modal-footer">
                     <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                     <button type="submit" class="btn btn-primary">등록하기</button>
                  </div>
               </form>
            </div>
         </div>
      </div>
   </div>
   
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
               <form action="./userClassAdd?userID=<%= user.getUserID() %>" method="post" enctype="multipart/form-data">
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

	       var subjYear = td.eq(0).text();
	       var subjSemester = td.eq(1).text();
	       var subjCode = td.eq(2).text();

           document.getElementById("checkId").value=subjYear;
           document.getElementById("checkId2").value=subjSemester;
           document.getElementById("checkId3").value=subjCode;
	       $('#checkModal').modal("show");
	    
	   });
   </script>  
       
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
					<form  action="./userClassDel" method="post">
					<label>삭제를 진행하시겠습니까?</label>
						<input type="hidden" name="checkId" id="checkId"class="form-control">
						<input type="hidden" name="checkId2" id="checkId2"class="form-control">
						<input type="hidden" name="checkId3" id="checkId3"class="form-control">
						<input type="hidden" name="checkId4" value="<%= user.getUserID() %>">
						<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				<button type="submit" class="btn btn-danger">삭제하기</button></div>
					</form>
					</div>
				</div>
			</div>
		</div>
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