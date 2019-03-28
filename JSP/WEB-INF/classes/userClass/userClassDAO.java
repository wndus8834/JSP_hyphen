package userClass;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class userClassDAO {
	public ArrayList<userClassDTO> getListClassUser(String search, String userID) {
		ArrayList<userClassDTO> list = null;
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String SQL="";
		
		
		try {
			SQL="SELECT subjYear, subjSemester , subjCode, userID, subjName, subjMain, score , grade FROM class WHERE CONCAT(subjName) LIKE ?  AND userID=? ORDER BY subjYear ASC ";
			conn=DatabaseUtil.getConnection();
			pstmt=conn.prepareStatement(SQL); 
			pstmt.setString(1, "%" + search + "%");
			pstmt.setString(2, userID);
			rs = pstmt. executeQuery();
			list = new ArrayList<userClassDTO>();
			while(rs.next()) {
				userClassDTO depart = new userClassDTO();
				depart.setSubjYear(rs.getString("subjYear"));
				depart.setSubjSemester(rs.getString("subjSemester"));
				depart.setSubjCode(rs.getString("subjCode"));
				depart.setUserID(rs.getString("userID"));
				depart.setSubjName(rs.getString("subjName"));
				depart.setSubjMain(rs.getString("subjMain"));
				depart.setScore(rs.getString("score"));
				depart.setGrade(rs.getString("grade"));
				list.add(depart);
			}
		} catch(Exception e){
			e.printStackTrace();
		} finally { //醫낅즺瑜� �븳 �썑�뿉�뒗 �젒洹쇳븳 �옄�썝�쓣 �빐�젣�빐 二쇱뼱�빞 �븳�떎.
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return list;//�쉶�썝媛��엯 �떎�뙣
	}
	
	public ArrayList<userClassDTO> getListClassUser2(String userID) {
		ArrayList<userClassDTO> list = null;
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String SQL="";
		
		
		try {
			SQL="SELECT subjYear, subjSemester , subjCode, userID, subjName, subjMain, score , grade FROM class WHERE userID=? ORDER BY subjYear ASC";
			conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt. executeQuery();
			list = new ArrayList<userClassDTO>();
			while(rs.next()) {
				userClassDTO depart = new userClassDTO();
				depart.setSubjYear(rs.getString("subjYear"));
				depart.setSubjSemester(rs.getString("subjSemester"));
				depart.setSubjCode(rs.getString("subjCode"));
				depart.setUserID(rs.getString("userID"));
				depart.setSubjName(rs.getString("subjName"));
				depart.setSubjMain(rs.getString("subjMain"));
				depart.setScore(rs.getString("score"));
				depart.setGrade(rs.getString("grade"));
				list.add(depart);
			}
		} catch(Exception e){
			e.printStackTrace();
		} finally { //醫낅즺瑜� �븳 �썑�뿉�뒗 �젒洹쇳븳 �옄�썝�쓣 �빐�젣�빐 二쇱뼱�빞 �븳�떎.
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return list;//�쉶�썝媛��엯 �떎�뙣
	}
	

	public int Add(String subjYear, String subjSemester, String subjCode, String userID, String subjName, String subjMain, String score, String grade) {
	      String SQL="INSERT INTO class (subjYear, subjSemester, subjCode, userID, subjName, subjMain, score, grade) VALUES (?,?,?,?,?,?,?,?)";
	      Connection conn=null;
	      PreparedStatement pstmt=null;
	      ResultSet rs=null;
	      try {
	         conn=DatabaseUtil.getConnection();//DB 접근; 안정적으로 접근하기 위해 따로 모듈화를 해주었다.
	         pstmt=conn.prepareStatement(SQL);
	         pstmt.setString(1, subjYear);//sql문 안에 있는 ?(물음표)에 사용자가 입력한 값을 set시킨다.
	         pstmt.setString(2, subjSemester);
	         pstmt.setString(3, subjCode);
	         pstmt.setString(4, userID);
	         pstmt.setString(5, subjName);
	         pstmt.setString(6, subjMain);
	         pstmt.setString(7, score);
	         pstmt.setString(8, grade);
	         return pstmt.executeUpdate();
	      } catch(Exception e){
	         e.printStackTrace();
	      } finally { //종료를 한 후에는 접근한 자원을 해제해 주어야 한다.
	         try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
	         try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
	         try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
	      }
	      return -1;
	   }
	
	public int delClass(String subjYear,String subjSemester, String subjCode, String userID) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String SQL="DELETE FROM class WHERE subjYear=? AND subjSemester=? AND subjCode=? AND userID=? ";
		try {
			conn=DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, subjYear);
			pstmt.setString(2, subjSemester);
			pstmt.setString(3, subjCode);
			pstmt.setString(4, userID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return -1;
	}
	public int update(String subjYear, String subjSemester, String subjCode, String userID, String subjName, String subjMain, String score, String grade) {
		String SQL="UPDATE class SET subjName=?, subjMain=?, score=?, grade=? WHERE userID=? AND subjCode=? AND subjYear=? AND subjSemester=?";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();//DB �젒洹�; �븞�젙�쟻�쑝濡� �젒洹쇳븯湲� �쐞�빐 �뵲濡� 紐⑤뱢�솕瑜� �빐二쇱뿀�떎.
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, subjName);
			pstmt.setString(2, subjMain);
			pstmt.setString(3, score);
			pstmt.setString(4, grade);
			pstmt.setString(5, userID);
			pstmt.setString(6, subjCode);
			pstmt.setString(7, subjYear);
			pstmt.setString(8, subjSemester);
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		} finally { //醫낅즺瑜� �븳 �썑�뿉�뒗 �젒洹쇳븳 �옄�썝�쓣 �빐�젣�빐 二쇱뼱�빞 �븳�떎.
			try {if(conn!=null) conn.close();} catch(Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch(Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch(Exception e) {e.printStackTrace();}
		}
		return -1;//�쉶�썝媛��엯 �떎�뙣
	}
}
