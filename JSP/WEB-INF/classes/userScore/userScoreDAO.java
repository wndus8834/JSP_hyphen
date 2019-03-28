package userScore;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

public class userScoreDAO {
	public int search(String userID) {
		String SQL="SELECT * FROM userscore WHERE userID = ?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				return 1;
			}else {
				return -1;
			}
		} catch(Exception e){
			e.printStackTrace();
		} finally { //醫낅즺瑜� �븳 �썑�뿉�뒗 �젒洹쇳븳 �옄�썝�쓣 �빐�젣�빐 二쇱뼱�빞 �븳�떎.
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return -2;//�쉶�썝媛��엯 �떎�뙣
	}
	public int update(String userID, String refinementScore, String culturalReqScore, String majorSelectScore, String majorReqScore) {
	      String SQL="UPDATE userscore SET refinementScore=?,culturalReqScore=?,majorSelectScore=?,majorReqScore=? WHERE userID=?";
	      Connection conn=null;
	      PreparedStatement pstmt=null;
	      ResultSet rs=null;
	      try {
	         conn=DatabaseUtil.getConnection();//DB 접근; 안정적으로 접근하기 위해 따로 모듈화를 해주었다.
	         pstmt=conn.prepareStatement(SQL);
	         pstmt.setString(1, refinementScore);
	         pstmt.setString(2, culturalReqScore);
	         pstmt.setString(3, majorSelectScore);
	         pstmt.setString(4, majorReqScore);
	         pstmt.setString(5, userID);//sql문 안에 있는 ?(물음표)에 사용자가 입력한 값을 set시킨다.
	         return pstmt.executeUpdate();
	      } catch(Exception e){
	         e.printStackTrace();
	      } finally { //종료를 한 후에는 접근한 자원을 해제해 주어야 한다.
	         try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
	         try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
	         try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
	      }
	      return -1;//회원가입 실패
	  }
	public int Add(String userID, String refinementScore, String culturalReqScore, String majorSelectScore, String majorReqScore) {
	      String SQL="INSERT INTO userscore(userID,refinementScore,culturalReqScore,majorSelectScore,majorReqScore) VALUES (?,?,?,?,?)";
	      Connection conn=null;
	      PreparedStatement pstmt=null;
	      ResultSet rs=null;
	      try {
	         conn=DatabaseUtil.getConnection();//DB 접근; 안정적으로 접근하기 위해 따로 모듈화를 해주었다.
	         pstmt=conn.prepareStatement(SQL);
	         pstmt.setString(1, userID);//sql문 안에 있는 ?(물음표)에 사용자가 입력한 값을 set시킨다.
	         pstmt.setString(2, refinementScore);
	         pstmt.setString(3, culturalReqScore);
	         pstmt.setString(4, majorSelectScore);
	         pstmt.setString(5, majorReqScore);
	         return pstmt.executeUpdate();
	      } catch(Exception e){
	         e.printStackTrace();
	      } finally { //종료를 한 후에는 접근한 자원을 해제해 주어야 한다.
	         try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
	         try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
	         try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
	      }
	      return -1;//회원가입 실패
	   }
	

	public int updateCheck(String userID, boolean cultureReqSatisfy, boolean majorReqSatisfy, boolean graduPossible) {
		      String SQL="UPDATE userscore SET cultureReqSatisfy=?,majorReqSatisfy=?,graduPossible=? WHERE userID=?";
		      Connection conn=null;
		      PreparedStatement pstmt=null;
		      ResultSet rs=null;
		      try {
		         conn=DatabaseUtil.getConnection();//DB 접근; 안정적으로 접근하기 위해 따로 모듈화를 해주었다.
		         pstmt=conn.prepareStatement(SQL);
		         pstmt.setBoolean(1, cultureReqSatisfy);
		         pstmt.setBoolean(2, majorReqSatisfy);
		         pstmt.setBoolean(3, graduPossible);
		         pstmt.setString(4, userID);//sql문 안에 있는 ?(물음표)에 사용자가 입력한 값을 set시킨다.
		         return pstmt.executeUpdate();
		      } catch(Exception e){
		         e.printStackTrace();
		      } finally { //종료를 한 후에는 접근한 자원을 해제해 주어야 한다.
		         try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
		         try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
		         try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		      }
		      return -1;//회원가입 실패
		  }
	public int AddCheck(String userID, boolean cultureReqSatisfy, boolean majorReqSatisfy, boolean graduPossible) {
	      String SQL="INSERT INTO userscore(userID,culturalReqScore,majorReqScore, graduPossible) VALUES (?,?,?,?)";
	      Connection conn=null;
	      PreparedStatement pstmt=null;
	      ResultSet rs=null;
	      try {
	         conn=DatabaseUtil.getConnection();//DB 접근; 안정적으로 접근하기 위해 따로 모듈화를 해주었다.
	         pstmt=conn.prepareStatement(SQL);
	         pstmt.setString(1, userID);//sql문 안에 있는 ?(물음표)에 사용자가 입력한 값을 set시킨다.
	         pstmt.setBoolean(2, cultureReqSatisfy);
	         pstmt.setBoolean(3, majorReqSatisfy);
	         pstmt.setBoolean(4, graduPossible);
	         return pstmt.executeUpdate();
	      } catch(Exception e){
	         e.printStackTrace();
	      } finally { //종료를 한 후에는 접근한 자원을 해제해 주어야 한다.
	         try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
	         try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
	         try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
	      }
	      return -1;//회원가입 실패
	   }
}
