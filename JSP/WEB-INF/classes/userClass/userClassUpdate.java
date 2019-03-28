package userClass;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class userClassUpdate
 */
@WebServlet("/userClassUpdate")
public class userClassUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 request.setCharacterEncoding ("UTF-8");
	     response.setContentType ("text/html;charset=UTF-8");
         String subjYear = request.getParameter ("subjyear");
         String subjSemester = request.getParameter ("subjsemester");
         String subjCode = request.getParameter ("subjcode");
         String subjName = request.getParameter ("subjname");
         String subjMain = request.getParameter ("subjmain");
         String score = request.getParameter ("userscore");
         String grade = request.getParameter ("usergrade");
         String userID = request.getParameter ("userID");
         
         if (subjYear == null || subjSemester == null || subjMain == null || subjName.equals ("") || subjCode.equals ("") || score == null) {
            PrintWriter script = response.getWriter ();
            script.println ("<script>");
            script.println ("alert('입력이 안 된 사항이 있습니다.');");
            script.println ("history.back();");
            script.println ("</script>");
            script.close ();
            return;
         }
         
         int result = new userClassDAO ().update (subjYear, subjSemester, subjCode, userID, subjName, subjMain, score, grade);
         
         if (result == -1) {
            PrintWriter script = response.getWriter ();
            script.println ("<script>");
            script.println ("alert('이미 존재합니다.');");
            script.println ("history.back();");
            script.println ("</script>");
            script.close ();
            return;
         } else {
            PrintWriter script = response.getWriter ();
            script.println ("<script>");
            script.println ("alert('등록이 성공되었습니다.');");
            script.println ("location.href='InsertClass.jsp';");//사용자가 회원가입을 하자마자 인증을 받을 수 있도록 페이지로 이동시킨다.
            script.println ("</script>");
            script.close ();
            return;
         }
	}

}
